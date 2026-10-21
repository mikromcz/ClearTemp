---
name: geoget-scripting
description: GeoGet script/plugin development reference — the GeoGet Pascal dialect (a Delphi subset interpreted by GeoGet), its built-in API functions (FileList, DelTree, RegexFind, GetEnvir, GeoBusy*, dialogs, gettext _()), predefined GEOGET_* variables, GFM forms, units/{$INCLUDE}/preprocessor, plugin entry points (PluginStart, PluginFlags, InstallWork), GIP packages and *.meta.ini, and the TGeo/TWpt/TSQLiteDatabase class API. Use when writing, editing or reviewing GeoGet *.ggp.pas, *.ggi.pas, *.gge/ggc/ggv/ggs scripts, *.gfm forms or *.meta.ini, or when unsure whether a Delphi feature/function exists in GeoGet scripts.
---

# GeoGet scripting

GeoGet scripts look like Delphi but run in GeoGet's own embedded interpreter. It implements a **subset** of Delphi plus a GeoGet-specific API. Don't assume a Delphi RTL/VCL function, class or language feature exists. Check `references/functions.md` and `references/classes.md` first, and if it isn't there, say so instead of guessing.

The reference pages are the official GeoGet wiki (mostly **Czech**) and the PasDoc class reference (English, generated 2018). Grep them by identifier, e.g. `grep -n "FileList" references/functions.md`. `references/` is git-ignored (third-party wiki content), so in a fresh clone it may be missing. Then fetch the online originals listed at the bottom instead.

## Dialect differences and gotchas

Marked **[wiki]** = documented on the GeoGet wiki; **[tested]** = found by testing in real plugins (ClearTemp), not documented anywhere.

**Language / runtime**
- Delphi subset. The wiki's suggested language reference is Delphi 2 help, but "scripts only do a subset of it". **[wiki]** `references/pascal-language.md`
- **No short-circuit evaluation of `and`/`or`.** Both sides are always evaluated. `if (pattern = '') or RegexFind(pattern, s)` still calls `RegexFind('')` and crashes ("A regular expression specified in RegEx is required"). Likewise `(x <> nil) and x.Foo` dereferences nil. Use nested `if`s, or a boolean variable set step by step, whenever the second operand is unsafe or expensive. **[tested]**
- `RegexFind`/`RegexExtract` with an **empty pattern** raise an exception instead of matching everything. **[tested]**
- Since GeoGet 2.8, `String` = `UnicodeString` (was `AnsiString`). Use `AnsiString` explicitly when working with raw memory: `TStream` data, DLL calls. **[wiki]** `references/upgrade-2.8.md`
- `TStringList.LoadFromFile`/`LoadFromStream` convert ANSI → Unicode unless the data starts with a BOM. To avoid it, read into an `AnsiString` and assign to `.Text`. **[wiki]**
- Regex engine is **PCRE** (since 2.8). Old TRegExpr modifiers `g`/`r` don't work. **[wiki]**
- Units (`uses foo`): resolved as `foo.pas` in the script's folder, then `script\lib`. If no `.pas` exists, `foo.gfm` is loaded as a form. Unit names can't contain a dot. `initialization`/`finalization` sections compile but **never run**. **[wiki]** `references/units-include.md` (it says "GGF" in one place; it means GFM.)
- `{$INCLUDE file}` pastes source text (one shared namespace, so watch for duplicate identifiers). `{$IFDEF GGVER_2.3.7}`/`GGVERM_2.3`/`GGVERF_2`/`WINE` are predefined. `{$V 2.3}` refuses to run on older GeoGet. **[wiki]** `references/preprocessor.md`
- Available non-GeoGet classes are limited to the list in `references/classes.md` (`TStringList`, `TIniFile`, streams, `TCollection`, …) plus the form controls. `TMemIniFile` also works even though it isn't listed. **[tested]**
- COM/OLE via `variant` **[wiki]** `references/com-objects.md`; external DLL functions via `external 'func@dll.dll stdcall'` **[wiki]** `references/dll.md`.

**Ini files (`TIniFile`)**
- `TIniFile.ReadBool` goes through integer parsing: `Key=True` silently returns the *default*. Read the string and compare it yourself (accept `1`/`True`/`Yes`), and write `1`/`0`. **[tested]**
- `TIniFile` reads files in the Windows ANSI codepage (CP1250 on Czech systems), **not UTF-8**. A UTF-8 file (with or without BOM) shows accented text as garbage. Save ini files with accented text as Windows-1250 without a BOM, and never round-trip them through a UTF-8 editor/tool (it's lossy). In PowerShell use `[System.IO.File]::ReadAllText($p, [System.Text.Encoding]::GetEncoding(1250))` / `WriteAllText`. **[tested]**
- Exception: the package `*.meta.ini` is read by GeoGet's plugin manager, not by script `TIniFile`. A UTF-8-with-BOM `meta.ini` with Czech `description_cs=` works. **[tested]**

**Forms (`*.gfm`)** — `references/forms.md`
- Load a form with `uses MyForm` (no extension). Every control becomes a **global variable named `<FormName>_<ControlName>`**, and the form itself is a `TForm` global named `<FormName>`. There's no form instance to dereference. **[wiki]**
- Event handlers are assigned with `@`: `MyForm_Button1.OnClick := @MyHandler;` where `procedure MyHandler(Sender: TObject);`. **[wiki]**
- A non-zero `ModalResult` on a button closes the form, and `ShowModal` returns it. `2` = closed via the title-bar ✕. **[wiki]**
- GFM `Caption`/`Hint` texts are auto-translated by gettext. Strings in code need `_()`. **[wiki]**
- Controls can also be created at runtime (`TCheckBox.Create(parent)`, `TTabSheet`, `TScrollBox`, …) and positioned manually. **[tested]**
- Mouse-wheel scrolling does **not** work in a `TScrollBox`. Size the dialog so scrolling is rarely needed. **[tested]**

**Busy dialog** — `references/functions.md` "Obsluha busy dialogu"
- `GeoBusyStart`/`GeoBusyCaption`/`GeoBusyKind`/`GeoBusyProgress(Value, Max)`/`GeoBusyTest`.
- While a **modal form** is shown, the busy dialog's Cancel button does nothing (`GeoBusyTest` never becomes true). Close the form (via `ModalResult`), do the long work, poll `GeoBusyTest`, then `ShowModal` again if needed. **[wiki]**

**Localization** — `references/localization.md`
- `_('English text')` for every user-facing string. Catalog: `<plugin>\locale\<LANG>\LC_MESSAGES\default.po` → compiled `default.mo` (PoEdit). Write source strings in English, because the extraction tool chokes on non-ASCII. **[wiki]**
- `GetCurrentLanguage` returns e.g. `cs`, `en`, `cs_CZ`. Compare only the first 2 chars. `UseLanguage`, `TextDomain`, `BindTextDomain` exist. **[wiki]**

**Paths / variables** — `references/variables.md`
- `GEOGET_DATADIR`, `GEOGET_SCRIPTDIR`, `GEOGET_COMMONDATADIR`, `GEOGET_LOCALDATADIR` have **no** trailing `\`. `GEOGET_PROGPATH` **has** one. **[wiki]**
- `GEOGET_DB` is the open `TSQLiteDatabase`. `GC` is the current `TGeo` inside `PluginWork`. **[wiki]**
- `GetEnvir(Name)` reads Windows environment variables. **[wiki]**

## Script types and entry points

File suffix decides the type (`references/ggp-plugin.md`, `references/ggi-install.md`):

| Suffix | Purpose |
|---|---|
| `*.ggp.pas` | Plugin in the main window (Plugins menu / toolbar) |
| `*.ggc.pas` | Plugin in the listing window |
| `*.gge.pas` | Custom export format |
| `*.ggs.pas` | Startup automation |
| `*.ggv.pas` | Visualization (columns/icons in the main list) |
| `*.ggi.pas` | Install/uninstall script of a GIP package |
| `*.ggd.pas` | Download script (2.9.2+) |

**GGP**: `function PluginCaption: string;`, `PluginHint`, `PluginIcon` (binary 16×16 24-bit BMP data, typically `DecodeBase64('...')`), `PluginFlags` (comma list: `global`, `list`, `notrans`, `nowork`, `ghost`; neither `global` nor `list` = called per selected point), `procedure PluginStart;`, `PluginWork` (per point, data in `GC`), `PluginStop`. By default the run is wrapped in a DB transaction (`notrans` disables it).

**GGI**: `function InstallWork: string;` runs after files are copied into `DATADIR\script`. `function UninstallWork: string;` runs before deletion. Return `''` on success, or an error message (for uninstall, a non-empty result aborts).

## Packaging (GIP + meta.ini)

A `.gip` is a renamed `.zip` with a top-level `<Plugin>\` folder that is copied into `DATADIR\script`. `<Plugin>.meta.ini` sections (`references/gip-package.md`):
- `[info]` `description=`/`description_cs=`, `version=`, `ggversion=` (minimum GeoGet), optional `web=`/`webversion=`/`webupdate=` (default to the geoget.cz wiki, which is recommended), `DefaultPluginGroup=`/`DefaultPluginGroup_cs=`, `Parent=`.
- `[install]` `script=<Plugin>\<Plugin>.ggi.pas`
- `[dependency]` `LibName|1.2=url` or `LibName=` (auto-lookup)
- `[uninstall]` paths to delete, each **ending with `=`** (e.g. `<Plugin>=` removes the folder).
- User config: ship `*.default.pas`, never `*.config.pas`. GeoGet generates and merges the config itself.

## Reference index

| Need | File |
|---|---|
| Built-in functions: files, strings, regex, dialogs, busy, localization, registry, tags, GC.Live/API, hashing, math | `references/functions.md` |
| `GEOGET_*` and other predefined variables | `references/variables.md` |
| GFM forms usage | `references/forms.md` |
| Available RTL classes | `references/classes.md` |
| Units vs `{$INCLUDE}` | `references/units-include.md` |
| Preprocessor directives | `references/preprocessor.md` |
| GGP plugin entry points & flags | `references/ggp-plugin.md` |
| GGI install script | `references/ggi-install.md` |
| GIP package & `meta.ini` | `references/gip-package.md` |
| Script localization (gettext) | `references/localization.md` |
| 2.8 breaking changes (Unicode, PCRE, THtmlView, icons) | `references/upgrade-2.8.md` |
| COM/OLE, DLL calls | `references/com-objects.md`, `references/dll.md` |
| Geocache object model: `TGeo`, `TWpt`, `TGeoLog`, lists, `TGeoFilter`, `TGeoPolyDivider` | `references/api/T*.md`, `references/api/unit-geo.md` |
| SQLite: `TSQLiteDatabase`, `TSQLiteTable`, `ESQLiteException` | `references/api/TSQLite*.md`, `references/api/unit-sqlitewrap.md` |
| Column sets: `TColList`, `TColRec` | `references/api/TCol*.md` |

Online originals: https://www.geoget.cz/doku.php/user:skripty (wiki), http://www.geoget.cz/help/index.html (class reference).
