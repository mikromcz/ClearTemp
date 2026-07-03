# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

ClearTemp is a plugin for **GeoGet** (a Windows geocaching-management application). It scans GeoGet's data directory for temporary/stale files (update leftovers, script downloads, `*.old`/`*.log` files, offline cache/maps/incident pictures) and lets the user review and delete them, similar to a CCleaner "winapp2.ini" entry.

There is no build system, package manager, or test runner — this is a small set of source files that GeoGet loads and interprets directly. There is nothing to `npm install`, compile, or unit-test; "running" the plugin means installing it into a real GeoGet installation and invoking it from the GeoGet UI.

## File layout and roles

- `ClearTemp.meta.ini` — plugin manifest: name, version (`version=`), minimum GeoGet version (`ggversion=`), and the install entry point (`script=ClearTemp\ClearTemp.ggi.pas`).
- `ClearTemp.ggi.pas` — **install script** (`.ggi.pas`), runs once when the plugin is installed/updated. Cleans up files from older plugin versions and shows `ClearTemp.changelog.txt` to the user.
- `ClearTemp.ggp.pas` — **main plugin script** (`.ggp.pas`), the actual logic. Defines `PluginCaption`, `PluginHint`, `PluginIcon`, `PluginFlags`, and `PluginStart` — the entry points GeoGet calls. Builds the options dialog's tabbed checkbox list dynamically from the merged definitions (see Core logic below) rather than hardcoding it.
- `ClearTemp.gfm` / `ClearTempConfirm.gfm` — GeoGet **form definitions** (Pascal-like declarative UI, `GEOGETFORM` format). `ClearTemp.gfm` is the options dialog (`ClearTempOptions`) — it now only declares the static chrome (`Label1`, `buttonOk`/`buttonCancel`, and an empty `pcCategories` `TPageControl` container); the per-category checkboxes/combos (and the `TTabSheet`/`TScrollBox` pairs that hold them) are created at runtime by `BuildOptionsForm` in `ClearTemp.ggp.pas`. `ClearTempConfirm.gfm` is the generic results/confirmation dialog (`ClearTempConfirmDelete`) with the deletable-files list box — unchanged, still fully static. Controls declared in the `.gfm` files (e.g. `ClearTempOptions_pcCategories`, `ClearTempOptions_buttonOk`, `ClearTempConfirmDelete_lbDeleteFiles`) are referenced directly by name in `ClearTemp.ggp.pas` — the `.gfm` files and the `.ggp.pas` file are tightly coupled and must be edited together when adding/renaming a *static* control.
- `ClearTemp.definitions.ini` — **tracked, shipped** CCleaner-`winapp2.ini`-style cleanup category definitions (`[Categories]` order + one section per category — see the format documented in the file's own header comment).
- `ClearTemp.ini` — **git-ignored, per-user** runtime state: `[LastState]` (checked/combo state per category, written by `PluginStart` every run) and `[Settings]` `Language=` (see Localization below), read/written via `SettingsIni`. It can *also* hold hand-added or overriding category sections — see Merged definitions below. Don't treat `[LastState]`/`[Settings]` as authoritative config — that part is regenerated automatically and safe to delete to reset to defaults.

## Merged definitions (`BuildMergedDefinitions`)

At startup, `DefinitionsIni` (a `TMemIniFile`, never flushed to disk — its backing path `ClearTemp\definitions.merged.tmp.ini` is just a scratch handle Delphi's constructor requires) is built by writing every section/key from the shipped `ClearTemp.definitions.ini` first, then every section/key from `ClearTemp.ini` on top — same technique as `src/SolveHelper.ggp.pas`'s `LoadAllInisInMemory`. Because the user file is written second, identical `[Section]`/`Key=` pairs in `ClearTemp.ini` win, so a user can add brand-new categories or override/patch a shipped one in `ClearTemp.ini` without a plugin update ever clobbering them (a plugin update only replaces `ClearTemp.definitions.ini`). Everywhere else in the code that reads category definitions goes through `DefinitionsIni`, never the raw `ClearTemp.definitions.ini` file directly.
- `ClearTemp.changelog.txt` — human-readable changelog shown to the user on install/update; update this whenever behavior changes (mirrors the `version=` bump in `ClearTemp.meta.ini`).
- `locale/CS/LC_MESSAGES/default.po` (+ compiled `default.mo`) — Czech translation catalog (gettext) for the plugin's **static** strings only (dialog captions, `PluginHint`, etc. — the source strings wrapped in `_(...)` in `.ggp.pas` and the `Caption`/`Hint` values in the `.gfm` files). Category `Label=`/`Hint=` text from `ClearTemp.definitions.ini` is **not** routed through gettext — see Localization below.
- `src/` — reference/scratch material, git-ignored (see `.gitignore`); not part of the shipped plugin. Contains `CCleaner_format.txt` (docs for CCleaner's `winapp2.ini` format that `ClearTemp.definitions.ini`'s schema is inspired by) and the plugin icon.
- `README.md` — points to the canonical online docs at https://www.geoget.cz/doku.php/user:skript:cleartemp.

## Language notes (GeoBasic / GeoGet Pascal dialect)

The `.pas` files are **not standard Delphi/FreePascal** — they're scripts interpreted by GeoGet's embedded engine, using GeoGet-specific globals and built-ins:

- `GEOGET_DATADIR`, `GEOGET_SCRIPTDIR`, `GEOGET_COMMONDATADIR`, `GEOGET_DB` — environment paths and the live geocache database handle. `GEOGET_DATADIR` is the per-profile data folder; `GEOGET_COMMONDATADIR` is the shared per-machine one (`%ProgramData%\GeoGet`) — distinct locations, both expanded in `ClearTemp.definitions.ini` paths.
- `GeoBusyCaption`, `GeoBusyKind`, `GeoBusyProgress`, `GeoBusyTest` — control the busy/progress dialog shown during long operations; `GeoBusyTest` is polled to detect user cancellation.
- `_( )` — gettext-style translation wrapper; every user-facing string must be wrapped in this and added to `locale/CS/LC_MESSAGES/default.po`.
- Form controls are accessed as global identifiers named `<FormName>_<ControlName>` (e.g. `ClearTempOptions_cbGeoget`), not through an object/form instance — this is how `.ggp.pas` reaches into the `.gfm`-defined UI.
- `RegexFind` / `RegexExtract` / `ReplaceString` / `FileList` / `DelTree` / `GetFileTime` / `GetFileSize` are GeoGet script API functions, not Pascal RTL.

## `ClearTemp.definitions.ini` category schema

Each category is one `[SectionName]`, listed with an order weight in `[Categories]`. Supported keys (see the file's own header comment for the authoritative description):

- `Label=`/`Label_CS=` and `Hint=`/`Hint_CS=` — checkbox text, see Localization below.
- `DetectFile=` — row is hidden entirely if this path doesn't exist. `DetectFile1=`/`DetectFile2=`/`...N=` is also supported (`[GeoGetLast]` uses this — three unrelated leftover files, any one of which justifies showing the row): the row shows if **any** `DetectFile`/`DetectFileN` resolves to an existing path. If no `DetectFile(N)` key is present at all, the row always shows.
- `Default=` — initial checked state before any `[LastState]` exists. Accepts `1`/`0` (preferred — matches what GeoGet's own `WriteBool` round-trips, see below) or `True`/`False`/`Yes` (tolerated via `ReadBoolLenient`, case-insensitive).
- `DaysOptions=` — comma list → an editable "days old" combo next to the checkbox; omit for a plain instant-delete checkbox.
- `AllowNotInDatabase=` — same `1`/`0`/`True`/`False` tolerance as `Default=`. Lets a resolved days value of `-2` mean "delete if no matching geocache exists in the DB" instead of an age check — if `DaysOptions=` is also omitted, the category always behaves as `-2`.
- `Warning=` — optional. If set, shown via `ShowMessage` the moment the user *checks* that category's checkbox (not shown again on uncheck/recheck within the same dialog session beyond that — it fires from the `OnClick` transition, not on initial load). Env-var expanded like paths.
- `FileKey1..N=path|mask|flags` — `path` is expanded by `ExpandPath` (see below), `mask` is a simple glob (`*.*`, `*.ext`, `name*.ext`, or an exact filename), `flags` is empty (direct children of `path` only) or `RECURSE`/`REMOVESELF` to also walk subfolders (both are treated identically for *matching*; see the `REMOVESELF` folder-sweep behavior in Core logic below for the actual difference).
- `[Settings]` `EmptyFolderSweep1..N=` — optional, same numbered-key convention as `FileKey`. Currently unused (the `REMOVESELF` mechanism below covers the categories that need it) but still supported if you want an unconditional sweep independent of what's checked.

This is a deliberately narrow subset of the CCleaner `winapp2.ini` format (`LangSecRef=`, registry `Detect=` are not implemented) — extend `ClearTemp.ggp.pas`'s ini-reading code if a new key is genuinely needed.

**Path expansion (`ExpandPath`)**: `%GEOGET_DATADIR%`/`%GEOGET_SCRIPTDIR%`/`%GEOGET_COMMONDATADIR%` are replaced directly (GeoGet script globals, not real environment variables). Any other `%NAME%` token found afterward (e.g. `%USERPROFILE%`, `%APPDATA%` — used by `[ScriptGeoKuk]`) is resolved generically via GeoGet's `GetEnvir(Name: string): string` function (confirmed available since `ggversion=2.5.7`, which this plugin already requires) — so any real Windows environment variable works without further code changes.

**Booleans are read via `ReadBoolLenient`, not `TIniFile.ReadBool` directly.** GeoGet's `TIniFile.ReadBool` is a classic Delphi-style implementation that reads the value through `ReadInteger`/`StrToIntDef` — a text value like `True` fails integer parsing and silently falls back to the call's default parameter, with no error. This is exactly how `AllowNotInDatabase=True` on `[Attach]` shipped broken (silently behaved as "delete everything" instead of "delete only orphans"), and it will happen again for anything read via plain `ReadBool`. `ReadBoolLenient(ini, section, key, default)` reads the raw string itself and accepts `1`/`True`/`Yes` (case-insensitive) as true — safe against this pitfall regardless of which convention gets typed into the ini. Prefer `1`/`0` when authoring new entries (it's what `[LastState]`'s own `WriteBool` round-trips), but `True`/`False` won't silently break anymore either.

## Localization of category text

Category `Label=`/`Hint=` text is **not** translated via gettext/`_()` — it's looked up directly by `LocalizedText` (in `ClearTemp.ggp.pas`), which checks `ClearTemp.ini`'s `[Settings]` `Language=` (via `CurrentLanguageIsCzech`): if it's `CS`, `Label_CS=`/`Hint_CS=` is used when present, otherwise it always falls back to the English `Label=`/`Hint=`. This is a deliberate Kodi-`addon.xml`-style alternative to gettext for this one file, chosen because dxgettext can't extract from ini content anyway. There's no auto-detection of GeoGet's own UI language — `Language=` is a plain user-editable setting in `ClearTemp.ini`, blank by default (English). Adding a new language later means adding another `_XX` suffix convention and extending `LocalizedText`, not touching `.po`/`.mo`.

## Tabs (`TabNameForSection`) and dynamic sizing

The options dialog groups categories into `TTabSheet`s by a simple prefix rule on the section name: `GeoGet*` → tab "GeoGet", `Script*` → tab "Script", anything else → tab "Other" (lazily created only if actually needed). This isn't ini-configurable — it's a runtime convention, chosen because the category names in `ClearTemp.definitions.ini` already consistently follow it. Each tab gets its own `TTabSheet` + `TScrollBox` (`Align = alClient`), built the same way `src/SolveHelper.ggp.pas`'s `MakeForm` builds its tabs. Tab captions show a live checked-count (`"GeoGet (4)"`), updated by `UpdateTabCaption` both on initial build and from `OnCategoryClick`.

`ClearTempOptions`'s height (and `pcCategories`'s height, and the OK/Cancel button `Top`) are recalculated every time `BuildOptionsForm` runs, based on the *tallest* tab's content height, clamped to a sane minimum and an ~900px-tall maximum — see the constants in `BuildOptionsForm`. This exists because mouse-wheel scrolling does not work on a `TScrollBox` in this GeoGet script engine (confirmed broken — see the two commented-out, abandoned attempts in `src/SolveHelper.ggp.pas` under "Prvni/Druhy pokus o Mouse scrolling"), so the dialog just grows tall enough that scrolling is rarely needed instead of trying to fix wheel support directly.

## Core logic (`ClearTemp.ggp.pas`)

1. `PluginStart` opens `SettingsIni` (`ClearTemp.ini`) and `DefinitionsIni` (an in-memory `TMemIniFile`), then calls `BuildMergedDefinitions` to populate `DefinitionsIni` — see Merged definitions above.
2. `BuildOptionsForm` reads `[Categories]` (via `LoadCategoryOrder`, sorted by weight), skips any section `CategoryIsVisible` says should be hidden, and for each remaining section creates (or reuses) a `TabNameForSection`-determined tab, then a `TCheckBox` (+ `TComboBox` if `DaysOptions=` is present) inside that tab's scrollbox — tracked in the parallel `CategoryCheckboxes`/`CategoryCombos`/`CategoryTabSheets` lists (index-aligned, section name ↔ control ↔ owning tab). Initial checked/combo state comes from `SettingsIni`'s `[LastState]`, falling back to `DefinitionsIni`'s `Default=` (via `ReadBoolLenient`). Finishes by resizing the dialog (see Tabs above) and setting initial tab-caption counts.
3. The options dialog (`ClearTempOptions`) is shown modally. `OnCategoryClick` enables/disables a category's combo, shows `Warning=` (if any) the moment a box gets checked, and refreshes the owning tab's caption count.
4. For every checked category, `ResolveDays` turns the combo text (or the category's implicit default when there's no combo) into `-1` (all), `-2` (orphan check, only honored if `AllowNotInDatabase=1`), or an integer day threshold. If any resolves to `-2`, `DatabaseIDList` is loaded once from `GEOGET_DB`.
5. For every checked category, each `FileKeyN=` is parsed by `ParseFileKey` (path/mask/flags, path expanded by `ExpandPath`) and passed to `SearchFileKey`, which walks the directory tree (BFS via a queue of `TStringList`, recursing only if the flag was `RECURSE`/`REMOVESELF`) matching files against the mask (`FileMatchesMask`) and applying the resolved days rule — `-2` via `IsInDatabase` (regex `GC[A-Z0-9]+|WM[A-Z0-9]+|OC[A-Z0-9]+` against the filename, taking only the first match since the regex can find spurious matches inside filenames too). Every `FileKeyN` flagged `REMOVESELF` has its path collected into `SweepFolders`.
6. Matches are queued via `ProcessFile` into the confirmation list box and `totalSize` is accumulated. `[LastState]` (checked + combo text, per section) is written back to `SettingsIni` for every category, checked or not.
7. The confirmation dialog (`ClearTempConfirmDelete`) is shown with all items pre-selected; the user can deselect individual items before confirming.
8. On confirm, selected files are deleted one by one (honoring `GeoBusyTest` cancellation), then `DeleteEmptyFolders` runs on every `[Settings]` `EmptyFolderSweep1..N` path (unconditional, if any are configured) and every path collected into `SweepFolders` (i.e. every `REMOVESELF`-flagged `FileKey` belonging to a checked category).

## Making changes

- When adding a new cleanup category: add a section to `ClearTemp.definitions.ini` (with an order weight in `[Categories]`) following the schema above, including `Label_CS=`/`Hint_CS=` if you want Czech coverage — no `.gfm`/`.pas` changes needed unless the category needs a new *kind* of key the parser doesn't support yet. Name it `GeoGet*`/`Script*` if you want it grouped into one of those two tabs; anything else lands in "Other".
- Alternatively, add a new/overriding category section directly to `ClearTemp.ini` (per-user, git-ignored) — it'll merge in via `BuildMergedDefinitions` without touching the shipped file, so it survives a plugin update. This is the mechanism to use for a personal one-off category you don't want to commit.
- When bumping the plugin version: update `version=` in `ClearTemp.meta.ini` and add an entry to `ClearTemp.changelog.txt`.
- `ClearTemp.definitions.ini` is the tracked/shipped file — that's what to edit for category changes meant to ship. `ClearTemp.ini` is git-ignored per-user state (`[LastState]` + `Language=` + optional user categories); don't expect it to show up in `git status`.

## Critical: `ClearTemp.definitions.ini` must stay Windows-1250 (ANSI), not UTF-8

GeoGet's `TIniFile` reads ini files using the Windows system codepage (CP1250 for Czech), not UTF-8 — confirmed by testing: accented `Label_CS=`/`Hint_CS=` values saved as UTF-8 (with or without BOM) rendered as garbage inside GeoGet, and only worked once the file was re-saved as Windows-1250 with no BOM. This is unrelated to and unaffected-by the gettext `.po`/`.mo` mechanism (that's UTF-8 and works fine) — it's specific to any accented text that goes through `TIniFile`.

**Consequence for tooling:** a plain UTF-8-based text editor round-trip (read-modify-write) will corrupt this file's Czech content, because a UTF-8 decode of CP1250 bytes is lossy (invalid sequences become `U+FFFD`) — once that happens the original bytes are unrecoverable and re-saving bakes in the corruption, even in lines that weren't touched. When editing Czech text in `ClearTemp.definitions.ini` programmatically, use an explicit CP1250-aware read/write (e.g. in PowerShell: `[System.IO.File]::ReadAllText($path, [System.Text.Encoding]::GetEncoding(1250))` / `WriteAllText($path, $newText, [System.Text.Encoding]::GetEncoding(1250))`), not a generic text-file edit. `ClearTemp.ini` and the `.gfm` files currently have no accented content and are UTF-8-safe as-is — but the moment accented text is added to *any* ini file read via `TIniFile`, the same CP1250 requirement applies.
