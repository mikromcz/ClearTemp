# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

ClearTemp is a plugin for **GeoGet** (a Windows geocaching-management application). It scans GeoGet's data directory for temporary/stale files (update leftovers, script downloads, `*.old`/`*.log` files, offline cache/maps/incident pictures) and lets the user review and delete them, similar to a CCleaner "winapp2.ini" entry.

There is no build system, package manager, or test runner — this is a small set of source files that GeoGet loads and interprets directly. "Running" the plugin means installing it into a real GeoGet installation and invoking it from the GeoGet UI.

## File layout and roles

- `ClearTemp.meta.ini` — plugin manifest: name, `version=`, minimum GeoGet version (`ggversion=`), install entry point (`script=ClearTemp\ClearTemp.ggi.pas`).
- `ClearTemp.ggi.pas` — **install script**, runs once on install/update. Cleans up files from older plugin versions and shows `ClearTemp.changelog.txt`.
- `ClearTemp.ggp.pas` — **main plugin script**, the actual logic. Defines `PluginCaption`, `PluginHint`, `PluginIcon`, `PluginFlags`, `PluginStart` — the entry points GeoGet calls. Builds the options dialog's tabbed checkbox list dynamically from the merged definitions (see Core logic below) rather than hardcoding it. Organized into clearly divided sections (metadata / file helpers / category helpers / dialog building / `PluginStart`) — keep new functions in the matching section.
- `ClearTemp.gfm` / `ClearTempConfirm.gfm` — GeoGet **form definitions** (declarative UI, `GEOGETFORM` format). `ClearTemp.gfm` (`ClearTempOptions`) only declares static chrome (`Label1`, `buttonOk`/`buttonCancel`, an empty `pcCategories` `TPageControl`) — the per-category checkboxes/combos and their `TTabSheet`/`TScrollBox` pairs are created at runtime by `BuildOptionsForm`. `ClearTempConfirm.gfm` (`ClearTempConfirmDelete`) is the fully static results/confirmation dialog with the deletable-files list box. Controls declared in the `.gfm` files are referenced directly by name (`<FormName>_<ControlName>`) in `ClearTemp.ggp.pas` — the two are tightly coupled and must be edited together when adding/renaming a *static* control.
- `ClearTemp.definitions.ini` — **tracked, shipped** CCleaner-`winapp2.ini`-style cleanup category definitions (`[Categories]` order + one section per category — schema documented in the file's own header comment, summarized below).
- `ClearTemp.ini` — **git-ignored, per-user** runtime state: `[LastState]` (checked/combo state per category, written every run) and `[Settings]` `Language=`. Can also hold hand-added/overriding category sections (see Merged definitions). Not authoritative config — safe to delete to reset to defaults.
- `ClearTemp.changelog.txt` — shown to the user on install/update; update whenever behavior changes (mirrors the `version=` bump).
- `locale/CS/LC_MESSAGES/default.po` (+ compiled `default.mo`) — Czech gettext catalog for the plugin's **static** strings only (the `_(...)`-wrapped strings in `.ggp.pas`, and `Caption`/`Hint` in the `.gfm` files). Category `Label=`/`Hint=` text is **not** routed through gettext — see Localization below. Hand-maintained (no `dxgettext` tool run in this environment) — after adding/changing a `_(...)` string, add the entry to `default.po` and recompile `default.mo` yourself.
- `src/` — reference/scratch material, git-ignored. Contains `CCleaner_format.txt` (docs for the `winapp2.ini` format `ClearTemp.definitions.ini`'s schema is inspired by) and the plugin icon.
- `README.md` — points to the canonical docs at https://www.geoget.cz/doku.php/user:skript:cleartemp.

## Merged definitions (`BuildMergedDefinitions`)

At startup, `DefinitionsIni` (a `TMemIniFile`, never flushed to disk — its backing path is just a scratch handle the constructor requires) is built by writing every section/key from the shipped `ClearTemp.definitions.ini` first, then every section/key from `ClearTemp.ini` on top. Because the user file is written second, identical `[Section]`/`Key=` pairs in `ClearTemp.ini` win, so a user can add brand-new categories or override/patch a shipped one without a plugin update ever clobbering them (an update only replaces `ClearTemp.definitions.ini`). Everywhere else in the code that reads category definitions goes through `DefinitionsIni`, never the raw shipped file directly.

## Language notes (GeoBasic / GeoGet Pascal dialect)

The `.pas` files are **not standard Delphi/FreePascal** — they're scripts interpreted by GeoGet's embedded engine:

- `GEOGET_DATADIR`, `GEOGET_SCRIPTDIR`, `GEOGET_COMMONDATADIR`, `GEOGET_DB` — environment paths and the live geocache database handle. `GEOGET_DATADIR` is the per-profile data folder; `GEOGET_COMMONDATADIR` is the shared per-machine one (`%ProgramData%\GeoGet`).
- `GeoBusyCaption`, `GeoBusyKind`, `GeoBusyProgress`, `GeoBusyTest` — control the busy/progress dialog during long operations; `GeoBusyTest` is polled to detect cancellation.
- `_( )` — gettext-style translation wrapper; every user-facing static string must be wrapped in this and added to `locale/CS/LC_MESSAGES/default.po`.
- Form controls are accessed as global identifiers named `<FormName>_<ControlName>`, not through an object/form instance.
- `RegexFind` / `RegexExtract` / `ReplaceString` / `FileList` / `DelTree` / `GetFileTime` / `GetFileSize` are GeoGet script API functions, not Pascal RTL.

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

**Path expansion (`ExpandPath`)**: `%GEOGET_DATADIR%`/`%GEOGET_SCRIPTDIR%`/`%GEOGET_COMMONDATADIR%` are replaced directly. Any other `%NAME%` token is resolved via GeoGet's `GetEnvir(Name: string): string` (available since `ggversion=2.5.7`, already required) — so any real Windows environment variable works with no code changes.

**Booleans are read via `ReadBoolLenient`, not `TIniFile.ReadBool` directly.** GeoGet's `TIniFile.ReadBool` reads through `ReadInteger`/`StrToIntDef` — a text value like `True` fails integer parsing and silently falls back to the default parameter with no error (this is exactly how `AllowNotInDatabase=True` on `[Attach]` once shipped broken, silently deleting everything instead of only orphans). `ReadBoolLenient(ini, section, key, default)` reads the raw string and accepts `1`/`True`/`Yes` (case-insensitive). Prefer `1`/`0` when authoring new entries.

## Localization of category text

Category `Label=`/`Hint=` text is **not** translated via gettext — it's looked up directly by `LocalizedText`, which checks `ClearTemp.ini`'s `[Settings]` `Language=` (via `CurrentLanguageIsCzech`): if `CS`, `Label_CS=`/`Hint_CS=` is used when present, otherwise it falls back to the English `Label=`/`Hint=`. Chosen because `dxgettext`-style tools can't extract from ini content. No auto-detection of GeoGet's own UI language — `Language=` is a plain user-editable setting, blank by default (English). A new language means adding another `_XX` suffix convention and extending `LocalizedText`, not touching `.po`/`.mo`.

## Tabs (`TabNameForSection`) and dynamic sizing

The options dialog groups categories into `TTabSheet`s by a prefix rule on the section name: `GeoGet*` → tab "GeoGet", `Script*` → tab "Script", anything else → tab "Other" (lazily created only if needed). This is a runtime convention, not ini-configurable. Each tab gets its own `TTabSheet` + `TScrollBox` (`Align = alClient`). Tab captions show a live checked-count (`"GeoGet (4)"`), updated by `UpdateTabCaption` on initial build and from `OnCategoryClick`.

`ClearTempOptions`'s height (and `pcCategories`'s height, and the OK/Cancel button `Top`) are recalculated every time `BuildOptionsForm` runs, based on the *tallest* tab's content height, clamped to a sane minimum and an ~900px-tall maximum (see the constants in `BuildOptionsForm`). This exists because mouse-wheel scrolling does not work on a `TScrollBox` in this GeoGet script engine (confirmed broken by testing) — the dialog just grows tall enough that scrolling is rarely needed, instead of fixing wheel support directly.

## Core logic (`ClearTemp.ggp.pas`)

1. `PluginStart` opens `SettingsIni`/`DefinitionsIni` and calls `BuildMergedDefinitions` (see above).
2. `BuildOptionsForm` reads `[Categories]` (via `LoadCategoryOrder`, sorted by weight), skips hidden sections (`CategoryIsVisible`), and for each remaining section creates/reuses its `TabNameForSection` tab, then a `TCheckBox` (+ `TComboBox` if `DaysOptions=`) — tracked in the index-aligned `CategoryCheckboxes`/`CategoryCombos`/`CategoryTabSheets` lists. Initial state comes from `SettingsIni`'s `[LastState]`, falling back to `Default=`. Finishes by resizing the dialog and setting tab-caption counts.
3. The options dialog is shown modally; `OnCategoryClick` enables/disables a category's combo, shows `Warning=` on check, refreshes the tab caption.
4. For every checked category, `ResolveDays` turns the combo text into `-1` (all — also produced by an empty value or an explicit `0`), `-2` (orphan check, only if `AllowNotInDatabase=1`), or a positive day threshold. If any resolves to `-2`, `DatabaseIDList` is loaded once from `GEOGET_DB`.
5. For every checked category, each `FileKeyN=` is parsed (`ParseFileKey`) and passed to `SearchFileKey`, which walks the directory tree (BFS via a `TStringList` queue, recursing only for `RECURSE`/`REMOVESELF`), matches the mask (`FileMatchesMask`), and applies the days rule (`-2` via `IsInDatabase`, regex `GC[A-Z0-9]+|WM[A-Z0-9]+|OC[A-Z0-9]+` against the filename, first match only). `REMOVESELF` paths are collected into `SweepFolders`.
6. Matches are queued via `ProcessFile` into the confirmation list box; `totalSize` accumulates. `[LastState]` is written back for every category, checked or not.
7. The confirmation dialog is shown with all items pre-selected; the user can deselect before confirming.
8. On confirm: selected files are deleted (honoring `GeoBusyTest` cancellation), then `DeleteEmptyFolders` runs on every `[Settings]` `EmptyFolderSweep1..N` path and every `SweepFolders` entry.

## Making changes

- New cleanup category: add a section to `ClearTemp.definitions.ini` (with an order weight in `[Categories]`) per the schema above — no `.gfm`/`.pas` changes needed unless it needs a new *kind* of key. Name it `GeoGet*`/`Script*` to land in one of those tabs; anything else lands in "Other".
- Personal one-off category: add it to `ClearTemp.ini` instead (per-user, git-ignored) — merges in via `BuildMergedDefinitions` without touching the shipped file.
- Version bump: update `version=` in `ClearTemp.meta.ini` and add an entry to `ClearTemp.changelog.txt`.

## Critical: `ClearTemp.definitions.ini` must stay Windows-1250 (ANSI), not UTF-8

GeoGet's `TIniFile` reads ini files using the Windows system codepage (CP1250 for Czech), not UTF-8 — confirmed by testing: accented `Label_CS=`/`Hint_CS=` values saved as UTF-8 (with or without BOM) rendered as garbage in GeoGet, and only worked once re-saved as Windows-1250 with no BOM. Unrelated to and unaffected by the gettext `.po`/`.mo` mechanism (that's UTF-8 and works fine) — specific to any accented text read via `TIniFile`.

**Consequence for tooling:** a plain UTF-8-based text editor round-trip (read-modify-write) will corrupt this file's Czech content — a UTF-8 decode of CP1250 bytes is lossy (invalid sequences become `U+FFFD`), and re-saving bakes in the corruption even in untouched lines. When editing Czech text in `ClearTemp.definitions.ini` programmatically, use an explicit CP1250-aware read/write (e.g. in PowerShell: `[System.IO.File]::ReadAllText($path, [System.Text.Encoding]::GetEncoding(1250))` / `WriteAllText(...)`), not a generic text-file edit. `ClearTemp.ini` and the `.gfm` files currently have no accented content and are UTF-8-safe as-is — but the moment accented text is added to *any* ini file read via `TIniFile`, the same CP1250 requirement applies.
