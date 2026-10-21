# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

ClearTemp is a plugin for **GeoGet** (a Windows geocaching-management application). It scans GeoGet's data directory for temporary/stale files (update leftovers, script downloads, `*.old`/`*.log` files, offline cache/maps/incident pictures) and lets the user review and delete them, similar to a CCleaner "winapp2.ini" entry.

There is no build system, package manager, or test runner — this is a small set of source files that GeoGet loads and interprets directly. "Running" the plugin means installing it into a real GeoGet installation and invoking it from the GeoGet UI.

## File layout and roles

- `ClearTemp.meta.ini` — GIP package manifest: `description=`/`description_cs=`, `version=`, minimum GeoGet version (`ggversion=`), install entry point (`script=ClearTemp\ClearTemp.ggi.pas`), `[uninstall]` (`ClearTemp=` removes the whole folder). UTF-8 with BOM — read by GeoGet's plugin manager, not by script `TIniFile`, so the CP1250 rule below doesn't apply; leave its encoding alone.
- `ClearTemp.ggp.ini` — `[info]` `DefaultPluginGroup=`/`DefaultPluginGroup_cs=` (the Plugins-menu group). **Windows-1250** (has accented `Nástroje`) — same encoding rule as `ClearTemp.definitions.ini`.
- `ClearTemp.ggi.pas` — **install script**, runs once on install/update. Cleans up files from older plugin versions and shows `ClearTemp.changelog.txt`.
- `ClearTemp.ggp.pas` — **main plugin script**, the actual logic. Defines `PluginCaption`, `PluginHint`, `PluginIcon` (base64 BMP via `DecodeBase64`), `PluginFlags` (`nowork,notrans` — the plugin never writes to the DB, so no automatic transaction), `PluginStart` — the entry points GeoGet calls (no `PluginWork`; the plugin doesn't iterate over selected caches). Builds the options dialog's tabbed checkbox list dynamically from the merged definitions (see Core logic below) rather than hardcoding it. Organized into clearly divided sections (metadata / file helpers / category helpers / dialog building / `PluginStart`) — keep new functions in the matching section.
- `ClearTemp.gfm` / `ClearTempConfirm.gfm` — GeoGet **form definitions** (declarative UI, `GEOGETFORM` format). `ClearTemp.gfm` (`ClearTempOptions`) only declares static chrome (`Label1`, `buttonOk`/`buttonCancel`, an empty `pcCategories` `TPageControl`) — the per-category checkboxes/combos and their `TTabSheet`/`TScrollBox` pairs are created at runtime by `BuildOptionsForm`. `ClearTempConfirm.gfm` (`ClearTempConfirmDelete`) is the fully static results/confirmation dialog with the deletable-files list box. Controls declared in the `.gfm` files are referenced directly by name (`<FormName>_<ControlName>`) in `ClearTemp.ggp.pas` — the two are tightly coupled and must be edited together when adding/renaming a *static* control.
- `ClearTemp.definitions.ini` — **tracked, shipped** CCleaner-`winapp2.ini`-style cleanup category definitions (`[Categories]` order + one section per category — schema documented in the file's own header comment, summarized below).
- `ClearTemp.ini` — **git-ignored, per-user** runtime state: `[LastState]` (checked/combo state per category, written every run) and `[Settings]` `Language=`. Can also hold hand-added/overriding category sections (see Merged definitions). Not authoritative config — safe to delete to reset to defaults.
- `ClearTemp.changelog.txt` — shown to the user on install/update; update whenever behavior changes (mirrors the `version=` bump).
- `locale/CS/LC_MESSAGES/default.po` (+ compiled `default.mo`) — Czech gettext catalog for the plugin's **static** strings only (the `_(...)`-wrapped strings in `.ggp.pas`, and `Caption`/`Hint` in the `.gfm` files). Category `Label=`/`Hint=` text is **not** routed through gettext — see Localization below. Hand-maintained (no `dxgettext` tool run in this environment) — after adding/changing a `_(...)` string, add the entry to `default.po` and recompile `default.mo` yourself.
- `dev/` — git-ignored scratch folder; currently only the plugin icon source (`ClearTemp.png`).
- `README.md` — points to the canonical docs at https://www.geoget.cz/doku.php/user:skript:cleartemp.
- `.claude/skills/` (git-ignored) — `geoget-scripting` (GeoGet dialect gotchas + the wiki/API reference: functions, variables, forms, packaging, classes) and `ccleaner-ini-format` (the `winapp2.ini` format `ClearTemp.definitions.ini`'s schema is inspired by). Check `geoget-scripting` before assuming a Delphi function/class exists.

## Merged definitions (`BuildMergedDefinitions`)

At startup, `DefinitionsIni` is created as a `TMemIniFile` loaded directly from the shipped `ClearTemp.definitions.ini` (never flushed to disk — `UpdateFile` is never called, so the shipped file is never rewritten), then every section/key from `ClearTemp.ini` is written on top. (Before 0.3.3 it copied the shipped file key-by-key through a `TIniFile` into a scratch `TMemIniFile`; if Czech labels ever render garbled, `TMemIniFile`'s codepage handling is the first suspect.) Because the user file is written second, identical `[Section]`/`Key=` pairs in `ClearTemp.ini` win, so a user can add brand-new categories or override/patch a shipped one without a plugin update ever clobbering them (an update only replaces `ClearTemp.definitions.ini`). Everywhere else in the code that reads category definitions goes through `DefinitionsIni`, never the raw shipped file directly.

## Language notes (GeoGet Pascal dialect)

The `.pas` files are **not standard Delphi/FreePascal** — they're scripts interpreted by GeoGet's embedded engine (a Delphi subset; full list of differences and the API reference in the `geoget-scripting` skill). The ones that matter most here:

- `GEOGET_DATADIR`, `GEOGET_SCRIPTDIR`, `GEOGET_COMMONDATADIR`, `GEOGET_DB` — environment paths and the live geocache database handle. `GEOGET_DATADIR` is the per-profile data folder; `GEOGET_COMMONDATADIR` is the shared per-machine one (`%ProgramData%\GeoGet`).
- `GeoBusyCaption`, `GeoBusyKind`, `GeoBusyProgress`, `GeoBusyTest` — control the busy/progress dialog during long operations; `GeoBusyTest` is polled to detect cancellation. It never fires while a modal form is showing — long work must run after `ShowModal` returns (as the scan and the delete do here).
- `_( )` — gettext-style translation wrapper; every user-facing static string must be wrapped in this and added to `locale/CS/LC_MESSAGES/default.po`.
- Form controls are accessed as global identifiers named `<FormName>_<ControlName>`, not through an object/form instance.
- `RegexFind` / `RegexExtract` / `ReplaceString` / `FileList` / `DelTree` / `GetFileTime` / `GetFileSize` / `GetEnvir` / `DecodeBase64` are GeoGet script API functions, not Pascal RTL. Regex is PCRE.
- Event handlers are attached with `@`: `chk.OnClick := @OnCategoryClick;`.
- **`and`/`or` do not short-circuit** — both sides are always evaluated (confirmed: `(pattern = '') or RegexFind(pattern, …)` crashed on the empty pattern for `*.*` masks in 0.3.3 development). Use nested `if`s when the second operand is unsafe (empty regex, nil object) or expensive (`GeoBusyTest`).

## `ClearTemp.definitions.ini` category schema

Each category is one `[SectionName]`, listed with an order weight in `[Categories]`. Supported keys (authoritative description is in the file's own header comment):

- `Label=`/`Label_CS=` and `Hint=`/`Hint_CS=` — checkbox text, see Localization below.
- `DetectFile=` (or `DetectFile1..N=`) — row is hidden unless at least one resolves to an existing path. If no `DetectFile(N)` key is present, the row always shows.
- `Default=` — initial checked state before `[LastState]` exists. `1`/`0` preferred, `True`/`False`/`Yes` tolerated (via `ReadBoolLenient`).
- `DaysOptions=` — comma list → an editable "days old" combo; omit for a plain instant-delete checkbox.
- `AllowNotInDatabase=` — lets a resolved days value of `-2` mean "delete if no matching geocache exists in the DB" instead of an age check. If `DaysOptions=` is also omitted, the category always behaves as `-2`.
- `Warning=` — shown via `ShowMessage` the moment the user *checks* the category (fires on the `OnClick` transition, not on initial load). Env-var expanded like paths.
- `FileKey1..N=path|mask|flags` — `path` expanded by `ExpandPath`, `mask` is a simple glob, `flags` is empty (direct children only) or `RECURSE`/`REMOVESELF` to also walk subfolders (identical for matching; `REMOVESELF` additionally sweeps the folder empty afterward — see Core logic).
- `[Settings]` `EmptyFolderSweep1..N=` — optional unconditional empty-folder sweep, independent of what's checked.

This is a deliberately narrow subset of the CCleaner `winapp2.ini` format (`LangSecRef=`, registry `Detect=` not implemented) — extend `ClearTemp.ggp.pas`'s ini-reading code if a new key is genuinely needed.

**Path expansion (`ExpandVars`/`ExpandPath`)**: `%GEOGET_DATADIR%`/`%GEOGET_SCRIPTDIR%`/`%GEOGET_COMMONDATADIR%` are replaced directly. Any other `%NAME%` token is resolved via GeoGet's `GetEnvir(Name: string): string` (available since `ggversion=2.5.7`, already required) — so any real Windows environment variable works with no code changes. `ExpandPath` (= `ExpandVars(s, True)`, used for every path) returns `''` for the whole path if any variable is undefined — otherwise `%MISSING%\temp` would become `\temp`, the root of the current drive — and every consumer treats `''` as "skip". `Warning=` text uses `ExpandVars(s, False)`, which leaves unknown `%NAME%` tokens in place.

**Masks (`MaskToRegex`)**: built once per FileKey, not per file — `''`/`*`/`*.*` mean "everything", otherwise regex metacharacters are escaped, `*`/`?` become `[^\\]*`/`[^\\]` (never cross a folder boundary), and the result `(?i)(^|\\)<mask>$` is matched case-insensitively against the full path.

**Booleans are read via `ReadBoolLenient`, not `TIniFile.ReadBool` directly.** GeoGet's `TIniFile.ReadBool` reads through `ReadInteger`/`StrToIntDef` — a text value like `True` fails integer parsing and silently falls back to the default parameter with no error (this is exactly how `AllowNotInDatabase=True` on `[Attach]` once shipped broken, silently deleting everything instead of only orphans). `ReadBoolLenient(ini, section, key, default)` reads the raw string and accepts `1`/`True`/`Yes` (case-insensitive). Prefer `1`/`0` when authoring new entries. This also covers `[LastState]` `*_Checked` (read from `DefinitionsIni`, where `ClearTemp.ini` is merged) — don't reintroduce `SettingsIni.ReadBool`.

## Localization of category text

Category `Label=`/`Hint=` text is **not** translated via gettext — it's looked up directly by `LocalizedText`, which checks `ClearTemp.ini`'s `[Settings]` `Language=` (via `CurrentLanguageIsCzech`): `Label_CS=`/`Hint_CS=` is used when present unless `Language=` is set to something other than `CS` (including an explicit empty value), in which case it falls back to the English `Label=`/`Hint=`. Chosen because `dxgettext`-style tools can't extract from ini content. No auto-detection of GeoGet's own UI language — `Language=` is a plain user-editable setting, defaulting to `CS` when the key is absent entirely (an explicit `Language=` with no value forces English). (If auto-detection is ever wanted, GeoGet's `GetCurrentLanguage` returns e.g. `cs`/`cs_CZ`/`en` — compare only the first 2 chars.) A new language means adding another `_XX` suffix convention and extending `LocalizedText`, not touching `.po`/`.mo`.

## Tabs (`TabNameForSection`) and dynamic sizing

The options dialog groups categories into `TTabSheet`s by a prefix rule on the section name: `GeoGet*` → tab "GeoGet", `Script*` → tab "Script", anything else → tab "Other" (lazily created only if needed). This is a runtime convention, not ini-configurable. Each tab gets its own `TTabSheet` + `TScrollBox` (`Align = alClient`). Tab captions show a live checked-count (`"GeoGet (4)"`), updated by `UpdateTabCaption` on initial build and from `OnCategoryClick`.

Lookups use the controls' `Tag` field instead of searching lists: `TCheckBox.Tag` = the category's index in `CategoryCheckboxes`/`CategoryCombos`/`CategoryTabSheets`/`CategoryDays`; `TTabSheet.Tag` = the tab's index in `TabInfo` (whose Strings are the base tab names, Objects the tab's `TScrollBox`; the tab sheet is `scrollbox.Parent`); `TScrollBox.Tag` = the `Top` of the next free row on that tab. Keep these in sync if you add/reorder anything in `BuildOptionsForm`.

Numbered keys (`FileKey1..N`, `DetectFile1..N`, `[Settings]` `EmptyFolderSweep1..N`) are all read through `ReadNumberedKeys(section, prefix, list)`, which stops at the first missing number — use it for any new numbered key.

`ClearTempOptions`'s height (and `pcCategories`'s height, and the OK/Cancel button `Top`) are recalculated every time `BuildOptionsForm` runs, based on the *tallest* tab's content height, clamped to a sane minimum and an ~900px-tall maximum (see the constants in `BuildOptionsForm`). This exists because mouse-wheel scrolling does not work on a `TScrollBox` in this GeoGet script engine (confirmed broken by testing) — the dialog just grows tall enough that scrolling is rarely needed, instead of fixing wheel support directly.

## Core logic (`ClearTemp.ggp.pas`)

`PluginStart` only sets up/frees the globals and calls the steps below in order; each step is its own function.

1. Setup: `IsCzech` is cached once (`CurrentLanguageIsCzech`), `BuildMergedDefinitions` runs (see above), `lbDeleteFiles` is cleared (forms may survive between runs) and `totalSize` reset.
2. `BuildOptionsForm` reads `[Categories]` (via `LoadCategoryOrder`, sorted by weight), skips hidden sections (`CategoryIsVisible`), and for each remaining section creates/reuses its `TabNameForSection` tab, then a `TCheckBox` (+ `TComboBox` if `DaysOptions=`) — tracked in the index-aligned `CategoryCheckboxes`/`CategoryCombos`/`CategoryTabSheets` lists. Controls get **no `.Name`** (section names from `ClearTemp.ini` may not be valid component names). Initial state comes from `[LastState]` (read leniently from `DefinitionsIni`, where it's merged), falling back to `Default=`. Finishes by resizing the dialog and setting tab-caption counts.
3. `ShowOptionsDialog` shows the options dialog modally (`OnCategoryClick` enables/disables a category's combo, shows `Warning=` on check, refreshes the tab caption), then runs `ResolveDays` **once** per category into the index-aligned `CategoryDays` (`''` = unchecked). `ResolveDays` returns `DAYS_ALL` (-1: empty, `0` or `-1`), `DAYS_NOT_IN_DB` (-2, only if `AllowNotInDatabase=1`), a positive day threshold, or `DAYS_INVALID` (-3: anything else — text, other negatives, `-2` where not allowed). Any invalid value → message + the dialog is shown again (`repeat ... until`). Invalid input must never fall back to "delete all".
4. `SaveLastState` writes `[LastState]` for every category, checked or not.
5. `ScanCategories`: if any `CategoryDays` is -2, `LoadDatabaseIDs` fills `DatabaseIDList` from **every database in the data folder** — the open one via `GEOGET_DB` (matched by `GEOGET_DBNAME`), every other `*.db3` in `GEOGET_DATADIR` via its own `TSQLiteDatabase`, skipping dated backups (`name.YYYYMMDD.db3`) — then sets `Sorted := True` (binary-search `IndexOf`; linear search was files × caches, ~500k caches here). This is a safety requirement, not an optimization: `attach\` is shared by all databases, so checking only the open one would offer every attachment for deletion while e.g. `MHD.db3` is open. If any database can't be read (exception caught), a message is shown and all -2 categories are **skipped** rather than run against an incomplete list. Each `FileKeyN=` is parsed (`ParseFileKey`) and passed to `SearchFileKey`, which walks the tree (BFS via a `TStringList` queue, recursing only for `RECURSE`/`REMOVESELF`; folders detected by `IsFolderEntry`, not regex), matches `MaskToRegex`'s pattern, and applies the days rule (`-2` via `IsInDatabase` on the path **relative to the FileKey folder** (`RelativePath`), regex `GC[A-Z0-9]+|WM[A-Z0-9]+|OC[A-Z0-9]+`, first match only — never the full path, which may contain e.g. `C:\Users\WMAREK`). Polls `GeoBusyTest` every 50 entries; Cancel sets `ScanCancelled` and aborts the whole run. `REMOVESELF` paths are collected (deduplicated) into `SweepFolders`.
6. Matches are queued via `ProcessFile`, which skips paths already in the sorted `QueuedFiles` (overlapping categories, e.g. `*.old` RECURSE over DATADIR vs `\temp`), adds to the list box and accumulates `totalSize` (`int64`, via `FileSize64`, which corrects `GetFileSize`'s 32-bit wrap for 2–4 GB files).
7. `ConfirmDeletion` shows the confirmation dialog with all items pre-selected; the user can deselect before confirming.
8. `DeleteSelected` deletes the selected files (honoring `GeoBusyTest` cancellation) and returns the failure count; `SweepEmptyFolders` runs `DeleteEmptyFolders` on every `[Settings]` `EmptyFolderSweep1..N` path and every `SweepFolders` entry (collects all subfolders, then deletes empty ones deepest-first so nested empty chains go in one run; the start folder itself is kept). Failures are reported in one message at the end.

## Making changes

- New cleanup category: add a section to `ClearTemp.definitions.ini` (with an order weight in `[Categories]`) per the schema above — no `.gfm`/`.pas` changes needed unless it needs a new *kind* of key. Name it `GeoGet*`/`Script*` to land in one of those tabs; anything else lands in "Other".
- Personal one-off category: add it to `ClearTemp.ini` instead (per-user, git-ignored) — merges in via `BuildMergedDefinitions` without touching the shipped file.
- Version bump: update `version=` in `ClearTemp.meta.ini` and add an entry to `ClearTemp.changelog.txt`.

## Critical: `ClearTemp.definitions.ini` must stay Windows-1250 (ANSI), not UTF-8

GeoGet's `TIniFile` reads ini files using the Windows system codepage (CP1250 for Czech), not UTF-8 — confirmed by testing: accented `Label_CS=`/`Hint_CS=` values saved as UTF-8 (with or without BOM) rendered as garbage in GeoGet, and only worked once re-saved as Windows-1250 with no BOM. Unrelated to and unaffected by the gettext `.po`/`.mo` mechanism (that's UTF-8 and works fine) — specific to any accented text read via `TIniFile`.

**Consequence for tooling:** a plain UTF-8-based text editor round-trip (read-modify-write) will corrupt this file's Czech content — a UTF-8 decode of CP1250 bytes is lossy (invalid sequences become `U+FFFD`), and re-saving bakes in the corruption even in untouched lines. When editing Czech text in `ClearTemp.definitions.ini` programmatically, use an explicit CP1250-aware read/write (e.g. in PowerShell: `[System.IO.File]::ReadAllText($path, [System.Text.Encoding]::GetEncoding(1250))` / `WriteAllText(...)`), not a generic text-file edit. The same applies to `ClearTemp.ggp.ini` (also CP1250 with accented text). `ClearTemp.ini` and the `.gfm` files currently have no accented content and are UTF-8-safe as-is — but the moment accented text is added to *any* ini file read via `TIniFile`, the same CP1250 requirement applies. Not affected: `ClearTemp.meta.ini` (UTF-8 with BOM, read by the plugin manager) and `ClearTemp.changelog.txt` (UTF-8, shown via `FileToString`).
