{
  GeoGet 2
  www: http://geoget.ararat.cz/doku.php/user:skript:cleartemp

  Puvodni verze: ProKesTom, http://www.geocaching.cz/forum/viewthread.php?forum_id=20&thread_id=17432&pid=251781#post_251781
  Autor: mikrom, http://mikrom.cz
  Fórum: https://forum.geocaching.cz/t/clearcache-cleartemp-plugin-pro-mazani-nepotrebnych-souboru/16523
  Verze: 0.3.3

  Kategorie mazani (checkboxy v dialogu) se negeneruji staticky, ale nactou se za behu
  ze dvou INI souboru, slouceniych dohromady v DefinitionsIni (viz BuildMergedDefinitions):
  - ClearTemp.definitions.ini - dodavane definice kategorii (sekce [Categories] + jednotlive
    sekce), format inspirovany CCleaner winapp2.ini, popis klicu je primo v hlavicce
    tohoto souboru. Zahrnuje i Label_CS/Hint_CS pro cestinu.
  - ClearTemp.ini - per-uzivatelsky stav ([LastState]) a [Settings] Language=CS/prazdne.
    Muze take obsahovat vlastni/prepsane kategorie - pri sloucenani maji tyto polozky
    prednost pred ClearTemp.definitions.ini, takze aktualizace pluginu je nepřepíše.

  Kategorie se v dialogu rozdeluji do zalozek podle prefixu nazvu sekce: GeoGet* -> zalozka
  "GeoGet", Script* -> zalozka "Script", cokoliv jineho -> "Other" (viz TabNameForSection).

  Vyznam "dnu stari" (Days) u kategorie s DaysOptions (viz ResolveDays):
  -2 pokud neni v databazi (jen pokud ma kategorie AllowNotInDatabase=1)
  -1 vse (v combu prazdna hodnota, 0 nebo -1)
  1 ... N stari ve dnech
  cokoliv jineho (text, jine zaporne cislo) je neplatne a dialog se zobrazi znovu
}

uses
  ClearTemp, ClearTempConfirm;

const
  DAYS_ALL = -1;
  DAYS_NOT_IN_DB = -2;
  DAYS_INVALID = -3;

var
  DatabaseIDList: TStringList;      // Serazeny seznam kodu kesi z databaze (jen pokud je potreba -2)
  QueuedFiles: TStringList;         // Serazeny seznam souboru uz pridanych ke smazani - proti duplicitam z prekryvajicich se kategorii
  SweepFolders: TStringList;        // Adresare FileKeyN s priznakem REMOVESELF (zaskrtnute kategorie), bez duplicit
  totalSize: int64;
  IsCzech: boolean;                 // Vysledek CurrentLanguageIsCzech, nacteny jednou pri startu
  ScanCancelled: boolean;           // Uzivatel prerusil hledani (Cancel v busy dialogu)
  SettingsIni: TIniFile;            // ClearTemp.ini - Per-uzivatelsky stav (LastState, Language, pripadne vlastni kategorie)
  DefinitionsIni: TMemIniFile;      // Slouceni ClearTemp.definitions.ini + ClearTemp.ini (viz BuildMergedDefinitions)
  CategoryCheckboxes: TStringList;  // Strings = Nazev sekce, Objects = TCheckBox (TCheckBox.Tag = index v tomto seznamu)
  CategoryCombos: TStringList;      // Strings = Nazev sekce, Objects = TComboBox nebo nil
  CategoryTabSheets: TStringList;   // Strings = Nazev sekce, Objects = TTabSheet, do ktereho kategorie patri
  CategoryDays: TStringList;        // Vysledne Days kazde kategorie (index jako CategoryCheckboxes), '' = nezaskrtnuta
  TabInfo: TStringList;             // Strings = Zakladni nazev zalozky, Objects = TScrollBox zalozky (jeho Parent je TTabSheet);
                                    // TTabSheet.Tag = index v tomto seznamu, TScrollBox.Tag = Top dalsiho radku na zalozce

// ==============================================================================
//   Metadata pluginu (volana GeoGetem)
// ==============================================================================

function PluginCaption: string;
begin
  Result := 'Clear Temp';
end;

function PluginHint: string;
begin
  Result := _('Clear folders ggupdate, script_download, temp etc.');
end;

function PluginIcon: string;
begin
  Result := DecodeBase64('Qk02BQAAAAAAADYEAAAoAAAAEAAAABAAAAABAAgAAAAAAAAAAAASCwAAEgsAAAABAAAAAQAAeHh4/3p6ev97e3v/fHx8/85oRv/TbUv/1HBO/9lzUf/lf13/135g/9yOcv/qhGL/6oZl/+6IZv/rkXP/3AD//4CAgP+BgYH/jIyM/4+Pj/+ZmZn/m5ub/56env+fn5//oaGh/6mpqf+rq6v/uaio/7qvr/+zs7P/tra2/+6ghf/koov/7KuU/82+of/CsLD/0L6+/87ApP/Qwqb/0cOo/9PFqv/Ux6z/1ciu/9bJsP/XyrH/2Myz/9nNtP/azrX/7828/8bExP/Hx8f/yMjI/8nJyf/fzc3/0dHR/+/Wx//v2cv/7t7O/+/ezv/x08X/8tPG//PVxv/x183/89nP/+/d3f/w4NH/8OLT//Di1P/x49X/8uPV//Xg1f/x5Nb/8uTX//fj2//z5tn/8+fc//Tn3f/06N7/9Orf/+Hh4f/16uD/9ezi//bs4//27OT/9u7m//fu5f/38Oj/+fTu//r18P/69vH/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/w8PFgMCAgEBAQECAgMWDw8PDxhPNjMxHBsjJDVAFw8PDw8eGRUUEwMAEBIVGR0PDw8PIlQ6TFdOSkE6OVEiDw8PDyVUOkxYVUtBOjlRJQ8PDw8mVDpNPgRSRzo5USYPDw8PJ1Q6UAUJBgo4OVEnDw8PDyhUOk0/B1M3IEJRKA8PDw8pVEQ8WFVSRzBDUSkPDw8PKlREIUlWCDtBOVEqDw8PDytUOkYfDA4LSDlRKw8PDw8sVDpMWVYNPUE5USwPDw8PLVQ6TFdQUEU6OVEtDw8PDy5UOkxXTkpBOjlRLg8PDw8vVDpMV05KQTo5US8PDw8PNBkVFBMDABETFhoyDw8=');
end;

function PluginFlags: string;
begin
  Result := 'nowork,notrans'; // nowork = neni PluginWork; notrans = plugin do databaze nezapisuje, neni duvod drzet transakci
end;

// ==============================================================================
//  Pomocne funkce: prace se soubory a cestami
// ==============================================================================

{
  True, pokud je polozka z FileList adresar (FileList vraci adresare s koncovym \)
}
function IsFolderEntry(entry: String): boolean;
begin
  Result := Copy(entry, Length(entry), 1) = '\';
end;

{
  Clean-up, smazani prazdnych podadresaru StartDir (StartDir samotny zustava).
  Nejdriv se (do sirky) posbiraji vsechny podadresare - rodic je v seznamu vzdy pred svymi
  potomky - a pak se projdou pozpatku: nejhlubsi prazdne slozky se smazou driv, nez se testuje
  jejich rodic. Diky tomu se v jednom behu smaze i cely retezec prazdnych slozek (a\b\c\).
}
procedure DeleteEmptyFolders(StartDir: string);
var
  Files, Folders: TStringList;
  i, n: Integer;
  folder: String;
begin
  if (StartDir = '') or not DirectoryExists(StartDir) then Exit;

  Files := TStringList.Create;
  Folders := TStringList.Create;
  try
    Folders.Add(StartDir);
    i := 0;
    while i < Folders.Count do
    begin
      Files.Clear;
      FileList(Folders[i], Files);
      for n := 0 to Files.Count - 1 do
        if IsFolderEntry(Files[n]) then Folders.Add(Files[n]);
      i := i + 1;
    end;

    for i := Folders.Count - 1 downto 1 do
    begin
      folder := Folders[i];
      Files.Clear;
      FileList(Copy(folder, 1, Length(folder) - 1), Files);
      if Files.Count = 0 then
      begin
        GeoBusyKind(ReplaceString(folder, GEOGET_DATADIR, ''));
        DelTree(folder);
      end;
    end;
  finally
    Files.Free;
    Folders.Free;
  end;
end;

{
  Vrati cast cesty za adresarem base (bez ohledu na velikost pismen); pokud cesta pod base
  nelezi, vrati celou cestu
}
function RelativePath(path, base: String): String;
begin
  if (base <> '') and (UpperCase(Copy(path, 1, Length(base))) = UpperCase(base)) then
    Result := Copy(path, Length(base) + 1, Length(path))
  else
    Result := path;
end;

{
  Testuje zda je kes v databazi. GCxxxx, WMxxxx, OCxxxx. Dostava cestu relativni k adresari
  FileKey (viz SearchFileKey), aby se kod nenasel omylem v ceste k datovemu adresari
  (napr. C:\Users\WMAREK\... nebo D:\OC2024\GeoGet\...)
}
function IsInDatabase(relPath: string): boolean;
var
  code: String;
  posLF, posCR, posBreak: Integer;
begin
  code := RegexExtract('GC[A-Z0-9]+|WM[A-Z0-9]+|OC[A-Z0-9]+', relPath);

  {
    RegexExtract muze vratit vice nalezenych shod spojenych znakem noveho radku (napr. kdyz
    se vzor GC/WM/OC nahodou objevi i v nazvu souboru, ne jen v adresarove strukture) -
    pouzijeme jen prvni nalezenou shodu, ktera odpovida adresari s kodem kese. Hledame
    nejdrivejsi vyskyt CR nebo LF, aby po oriznuti nezustal "zavlecen" znak CR pred LF.
  }
  posLF := Pos(#10, code);
  posCR := Pos(#13, code);
  if (posLF > 0) and ((posCR = 0) or (posLF < posCR)) then
    posBreak := posLF
  else
    posBreak := posCR;
  if posBreak > 0 then code := Copy(code, 1, posBreak - 1);
  code := Trim(code);

  // DatabaseIDList je serazeny (Sorted), IndexOf tedy hleda pulenim intervalu
  Result := DatabaseIDList.IndexOf(code) <> -1;
end;

{
  Velikost souboru jako int64. GetFileSize vraci jen integer, takze soubory 2-4 GB vychazeji
  zaporne - ty se prepocitaji zpet na spravnou kladnou hodnotu. Soubory nad 4 GB timto
  spravne zjistit nelze.
}
function FileSize64(fileName: String): int64;
var
  wrap: int64;
begin
  Result := GetFileSize(fileName);
  if Result < 0 then
  begin
    wrap := 65536;
    wrap := wrap * 65536;
    Result := Result + wrap;
  end;
end;

{
  Obsluhuje busy dialog a pridava do seznamu ke smazani nalezene soubory, pocita celkovou velikost.
  Soubor nalezeny vic kategoriemi (napr. *.old v \temp) se prida jen jednou.
}
procedure ProcessFile(fileName: string);
begin
  if QueuedFiles.IndexOf(fileName) <> -1 then Exit;
  QueuedFiles.Add(fileName);

  GeoBusyKind(ReplaceString(fileName, GEOGET_DATADIR, ''));
  ClearTempConfirmDelete_lbDeleteFiles.Items.Add(fileName);
  totalSize := totalSize + FileSize64(fileName);
end;

{
  Prevede jednoduchou masku (*.old, LastError.ggt, GeoPuzzle_*.html) na regex testovany proti
  cele ceste: '' = vse, jinak (?i)(^|\\)<maska>$. Specialni znaky regexu se escapuji, * a ?
  nepresahuji hranici adresare, (?i) protoze Windows nerozlisuje velikost pismen v nazvech.
  Vola se jednou pro kazdy FileKey, ne pro kazdy soubor.
}
function MaskToRegex(mask: String): String;
var
  i: Integer;
  ch: String;
begin
  Result := '';
  if (mask = '') or (mask = '*') or (mask = '*.*') then Exit;

  for i := 1 to Length(mask) do
  begin
    ch := Copy(mask, i, 1);
    if ch = '*' then Result := Result + '[^\\]*'
    else if ch = '?' then Result := Result + '[^\\]'
    else if Pos(ch, '\.^$|()[]{}+') > 0 then Result := Result + '\' + ch
    else Result := Result + ch;
  end;
  Result := '(?i)(^|\\)' + Result + '$';
end;

{
  Rozdeli seznam oddeleny carkou (napr. DaysOptions=7,14,30) do target
}
procedure SplitCommaList(s: String; target: TStrings);
var
  p: Integer;
  item: String;
begin
  while Length(s) > 0 do
  begin
    p := Pos(',', s);
    if p = 0 then
    begin
      item := Trim(s);
      s := '';
    end
    else
    begin
      item := Trim(Copy(s, 1, p - 1));
      s := Copy(s, p + 1, Length(s));
    end;
    if item <> '' then target.Add(item);
  end;
end;

{
  Expanduje %GEOGET_DATADIR%/%GEOGET_SCRIPTDIR%/%GEOGET_COMMONDATADIR% a pripadne dalsi
  %PROMENNE% (napr. %USERPROFILE%, %APPDATA%) pres GetEnvir - obecna promenna prostredi Windows.
  strict = True (cesty): pokud promenna neexistuje (GetEnvir vrati ''), vrati se cele '' - jinak
  by z %NEEXISTUJE%\temp vznikla cesta \temp do korene disku. Prazdna cesta se pak preskoci.
  strict = False (texty, napr. Warning=): neznama promenna zustane v textu beze zmeny.
}
function ExpandVars(s: String; strict: boolean): String;
var
  p1, p2, searchFrom: Integer;
  varName, varValue, before, after: String;
begin
  Result := s;
  Result := ReplaceString(Result, '%GEOGET_DATADIR%', GEOGET_DATADIR);
  Result := ReplaceString(Result, '%GEOGET_SCRIPTDIR%', GEOGET_SCRIPTDIR);
  Result := ReplaceString(Result, '%GEOGET_COMMONDATADIR%', GEOGET_COMMONDATADIR);

  searchFrom := 1;
  while True do
  begin
    p1 := Pos('%', Copy(Result, searchFrom, Length(Result)));
    if p1 = 0 then Break;
    p1 := searchFrom + p1 - 1;

    p2 := Pos('%', Copy(Result, p1 + 1, Length(Result)));
    if p2 = 0 then Break; // Osamocene % bez uzavirajiciho znaku - nechame beze zmeny
    p2 := p1 + p2;

    varName := Copy(Result, p1 + 1, p2 - p1 - 1);
    varValue := GetEnvir(varName);

    if varValue = '' then
    begin
      if strict then
      begin
        Result := '';
        Exit;
      end;
      searchFrom := p2 + 1; // %NAZEV% nechame v textu a hledame dal za nim
    end
    else
    begin
      before := Copy(Result, 1, p1 - 1);
      after := Copy(Result, p2 + 1, Length(Result));
      Result := before + varValue + after;
      searchFrom := Length(before) + Length(varValue) + 1;
    end;
  end;
end;

function ExpandPath(path: String): String;
begin
  Result := ExpandVars(path, True);
end;

{
  Rozdeli FileKeyN=path|mask|flags na jednotlive casti a expanduje promenne v ceste
}
procedure ParseFileKey(value: string; var path, mask, flags: string);
var
  p1, p2: integer;
begin
  path := '';
  mask := '';
  flags := '';

  p1 := Pos('|', value);
  if p1 = 0 then
  begin
    path := value;
  end
  else
  begin
    path := Copy(value, 1, p1 - 1);
    value := Copy(value, p1 + 1, Length(value));

    p2 := Pos('|', value);
    if p2 = 0 then
    begin
      mask := value;
    end
    else
    begin
      mask := Copy(value, 1, p2 - 1);
      flags := Copy(value, p2 + 1, Length(value));
    end;
  end;

  path := ExpandPath(path);
end;

{
  Hleda soubory v danem adresari (StartDir), volitelne vcetne podslozek (Recursive),
  podle jednoduche masky (Mask). Nalezene soubory se filtruji podle Days (-2 = neni
  v databazi, -1 = vse, 1..N = stari ve dnech - viz ResolveDays). Pri stisku Cancel
  v busy dialogu nastavi ScanCancelled a skonci.
}
procedure SearchFileKey(StartDir, Mask: String; Recursive: boolean; Days: Integer);
var
  Files, Queue: TStringList;
  n: Integer;
  pattern, entry: String;
  matches: boolean;
begin
  if StartDir = '' then Exit;
  if not DirectoryExists(StartDir) then Exit;

  pattern := MaskToRegex(Mask);
  Files := TStringList.Create;
  Queue := TStringList.Create;
  try
    Queue.Add(StartDir);
    while (Queue.Count > 0) and not ScanCancelled do
    begin
      Files.Clear;
      FileList(Queue[0], Files);
      Queue.Delete(0);
      for n := 0 to Files.Count - 1 do
      begin
        // Pozor: engine GeoGetu nezkracuje vyhodnoceni and/or - obe strany se vyhodnoti vzdy,
        // proto vnorene if misto "(n mod 50 = 0) and GeoBusyTest" / "(pattern = '') or RegexFind(...)"
        if n mod 50 = 0 then
          if GeoBusyTest then
          begin
            ScanCancelled := True;
            Break;
          end;
        GeoBusyProgress(n, Files.Count);

        entry := Files[n];
        if IsFolderEntry(entry) then
        begin
          if Recursive then Queue.Add(entry);
        end
        else
        begin
          matches := pattern = ''; // prazdny vzor = vse; RegexFind s prazdnym vzorem vyhodi vyjimku
          if not matches then matches := RegexFind(pattern, entry);
          if matches then
          begin
            case Days of
              DAYS_NOT_IN_DB: if not IsInDatabase(RelativePath(entry, StartDir)) then ProcessFile(entry); // Pokud neexistuje v databazi odpovidajici kes
              DAYS_ALL:       ProcessFile(entry); // vse
              else            if (GetFileTime(entry) <= (Now() - Days)) then ProcessFile(entry); // Starsi nez zadany pocet dni
            end;
          end;
        end;
      end;
    end;
  finally
    Queue.Free;
    Files.Free;
  end;
end;

// ==============================================================================
//  Pomocne funkce: kategorie - razeni, viditelnost, lokalizace
// ==============================================================================

{
  Doplni cislo nulami zleva na 6 mist, aby se dalo poradi kategorii razeni jako text (viz LoadCategoryOrder)
}
function ZeroPad(n: Integer): String;
var
  s: String;
begin
  s := IntToStr(n);
  while Length(s) < 6 do s := '0' + s;
  Result := s;
end;

{
  Nacte poradi kategorii ze sekce [Categories] (hodnota = vaha), serazene vzestupne do list
  (Strings = nazev sekce, Objects = nil). Pokud je v [Categories] definovana kategorie, ktera
  nema definovanou sekci, je ignorovana.
}
procedure LoadCategoryOrder(ini: TMemIniFile; list: TStringList);
var
  raw, sortable: TStringList;
  i, weight: Integer;
  key: String;
begin
  raw := TStringList.Create;
  sortable := TStringList.Create;
  try
    ini.ReadSection('Categories', raw);

    for i := 0 to raw.Count - 1 do
    begin
      weight := StrToIntDef(ini.ReadString('Categories', raw[i], '0'), 0);
      key := ZeroPad(weight) + '|' + raw[i];
      sortable.Add(key);
    end;
    sortable.Sort;

    for i := 0 to sortable.Count - 1 do
      list.Add(Copy(sortable[i], Pos('|', sortable[i]) + 1, Length(sortable[i])));
  finally
    raw.Free;
    sortable.Free;
  end;
end;

{
  Urci zalozku podle prefixu nazvu sekce - GeoGet* / Script* / jinak Other
}
function TabNameForSection(section: String): String;
begin
  if Copy(section, 1, 6) = 'GeoGet' then Result := 'GeoGet'
  else if Copy(section, 1, 6) = 'Script' then Result := 'Script'
  else Result := 'Other';
end;

{
  Tolerantni cteni boolean hodnoty z ini - akceptuje 1/0 i True/False, kdyby si nekdo splet konvenci
}
function ReadBoolLenient(ini: TMemIniFile; section, key: String; defaultValue: boolean): boolean;
var
  raw: String;
begin
  raw := UpperCase(Trim(ini.ReadString(section, key, '')));
  if raw = '' then
  begin
    Result := defaultValue;
    Exit;
  end;
  Result := (raw = '1') or (raw = 'TRUE') or (raw = 'YES');
end;

{
  Nacte do list hodnoty cislovanych klicu prefix1, prefix2, ... ze sekce v DefinitionsIni
  (napr. FileKey1..N, DetectFile1..N, EmptyFolderSweep1..N). Konci u prvniho chybejiciho
  nebo prazdneho cisla - FileKey1 + FileKey3 bez FileKey2 tedy nacte jen FileKey1.
}
procedure ReadNumberedKeys(section, prefix: String; list: TStrings);
var
  n: Integer;
  value: String;
begin
  list.Clear;
  n := 1;
  value := DefinitionsIni.ReadString(section, prefix + IntToStr(n), '');
  while value <> '' do
  begin
    list.Add(value);
    n := n + 1;
    value := DefinitionsIni.ReadString(section, prefix + IntToStr(n), '');
  end;
end;

{
  Zjisti, jestli se ma kategorie zobrazit - DetectFile nebo DetectFile1..N (staci aby existoval
  jeden z nich); pokud neni definovan zadny DetectFile(N), kategorie se zobrazi vzdy
}
function CategoryIsVisible(section: String): boolean;
var
  detects: TStringList;
  detectPath: String;
  i: Integer;
begin
  detects := TStringList.Create;
  try
    ReadNumberedKeys(section, 'DetectFile', detects);
    detectPath := DefinitionsIni.ReadString(section, 'DetectFile', '');
    if detectPath <> '' then detects.Insert(0, detectPath);

    Result := detects.Count = 0;
    for i := 0 to detects.Count - 1 do
    begin
      detectPath := ExpandPath(detects[i]);
      if (detectPath <> '') and (FileExists(detectPath) or DirectoryExists(detectPath)) then
      begin
        Result := True;
        Break;
      end;
    end;
  finally
    detects.Free;
  end;
end;

{
  True, pokud ClearTemp.ini [Settings] Language=CS - pak se pouzivaji Label_CS/Hint_CS
  z ClearTemp.definitions.ini, pokud existuji, jinak se pouzije Label/Hint.
  Vola se jednou v PluginStart, vysledek je v IsCzech (aby se ClearTemp.ini necetl
  z disku pro kazdy popisek).
}
function CurrentLanguageIsCzech: boolean;
begin
  Result := UpperCase(Trim(SettingsIni.ReadString('Settings', 'Language', 'CS'))) = 'CS';
end;

{
  Rozepise \n na skutecny zalom radku (CRLF); \\ pred tim ochranime jako doslovne zpetne
  lomitko, aby se necekane nerozlomil text obsahujici napr. cestu \network (zacina na \n)
}
function UnescapeText(s: String): String;
begin
  s := ReplaceString(s, '\\', #1);
  s := ReplaceString(s, '\n', CRLF);
  s := ReplaceString(s, #1, '\');
  Result := s;
end;

{
  Vrati Label/Hint/Warning (nebo jejich _CS variantu) z DefinitionsIni, bez gettext;
  \n v textu se rozepise na skutecny zalom radku (viz UnescapeText)
}
function LocalizedText(section, key: String): String;
var
  csValue: String;
begin
  if IsCzech then
  begin
    csValue := DefinitionsIni.ReadString(section, key + '_CS', '');
    if csValue <> '' then
    begin
      Result := UnescapeText(csValue);
      Exit;
    end;
  end;
  Result := UnescapeText(DefinitionsIni.ReadString(section, key, ''));
end;

// ==============================================================================
//  Sestaveni a obsluha dialogu (options + confirm)
// ==============================================================================

{
  Nastavi popisek zalozky na "zakladni nazev (pocet zaskrtnutych)"; zakladni nazev je v TabInfo
  na indexu tabsheet.Tag
}
procedure UpdateTabCaption(tabsheet: TTabSheet);
var
  i, count: Integer;
begin
  count := 0;
  for i := 0 to CategoryCheckboxes.Count - 1 do
    if (CategoryTabSheets.Objects[i] = TObject(tabsheet)) and TCheckBox(CategoryCheckboxes.Objects[i]).Checked then
      count := count + 1;
  tabsheet.Caption := TabInfo[tabsheet.Tag] + ' (' + IntToStr(count) + ')';
end;

{
  Povoli/zakaze combo se starim, zobrazi Warning= pri zaskrtnuti, aktualizuje popisek zalozky.
  Index kategorie je v Tag checkboxu (viz BuildOptionsForm), neni treba ho hledat.
}
procedure OnCategoryClick(sender: TObject);
var
  i: Integer;
  chk: TCheckBox;
  combo: TComboBox;
  warningText: String;
begin
  chk := TCheckBox(sender);
  i := chk.Tag;

  combo := TComboBox(CategoryCombos.Objects[i]);
  if combo <> nil then combo.Enabled := chk.Checked;

  if chk.Checked then
  begin
    warningText := LocalizedText(CategoryCheckboxes[i], 'Warning');
    if warningText <> '' then ShowMessage(ExpandVars(warningText, False));
  end;

  UpdateTabCaption(TTabSheet(CategoryTabSheets.Objects[i]));
end;

{
  Prevede bajty na text v MB se 2 desetinnymi misty (bez FormatFloat); int64, aby
  soucet nepretekl u vic nez 2 GB (offline mapy, dlazdice)
}
function FormatSizeMB(bytes: int64): String;
var
  wholeMB, fracMB, mb: int64;
  fracStr: String;
begin
  mb := 1024 * 1024;
  wholeMB := bytes div mb;
  fracMB := (bytes mod mb) * 100 div mb;
  fracStr := Int64ToStr(fracMB);
  if Length(fracStr) < 2 then fracStr := '0' + fracStr;
  Result := Int64ToStr(wholeMB) + '.' + fracStr;
end;

{
  Dvojklik na polozku v seznamu ke smazani otevre adresar, kde se soubor nachazi
}
procedure OnDeleteListDblClick(sender: TObject);
var
  filePath, folderPath: String;
  idx: Integer;
begin
  idx := ClearTempConfirmDelete_lbDeleteFiles.ItemIndex;
  if idx < 0 then Exit;

  filePath := ClearTempConfirmDelete_lbDeleteFiles.Items[idx];
  folderPath := RegexExtract('^.*\\', filePath);
  if (folderPath <> '') and DirectoryExists(folderPath) then
    RunShell(folderPath);
end;

{
  Prevede text v combu na vyslednou hodnotu Days, respektuje AllowNotInDatabase:
  prazdne / 0 / -1 = DAYS_ALL, kladne cislo = stari ve dnech, -2 = DAYS_NOT_IN_DB (jen pokud
  AllowNotInDatabase=1). Cokoliv jineho (text, jine zaporne cislo, -2 bez AllowNotInDatabase)
  je DAYS_INVALID - driv to znamenalo "smazat vse", coz je u preklepu nebezpecne.
}
function ResolveDays(section: String; combo: TComboBox): Integer;
var
  txt: String;
  val: Integer;
  allowNotInDb: boolean;
begin
  allowNotInDb := ReadBoolLenient(DefinitionsIni, section, 'AllowNotInDatabase', False);

  if combo = nil then
  begin
    // Bez DaysOptions: kategorie s AllowNotInDatabase resi jen osirele soubory, jinak vse
    if allowNotInDb then Result := DAYS_NOT_IN_DB else Result := DAYS_ALL;
    Exit;
  end;

  txt := Trim(combo.Text);
  if txt = '' then
  begin
    Result := DAYS_ALL;
    Exit;
  end;

  val := StrToIntDef(txt, DAYS_INVALID);
  if (val = 0) or (val = DAYS_ALL) then
    val := DAYS_ALL // 0 dni = bez casoveho omezeni, stejne jako prazdna hodnota
  else if val = DAYS_NOT_IN_DB then
  begin
    if not allowNotInDb then val := DAYS_INVALID;
  end
  else if val < 0 then
    val := DAYS_INVALID;
  Result := val;
end;

{
  Slouci ClearTemp.definitions.ini (dodavane) a ClearTemp.ini (uzivatelske pridavky/prepisy)
  do DefinitionsIni. Dodavany soubor se nacte primo jako TMemIniFile (cely najednou do pameti,
  nikdy se neuklada zpet - UpdateFile se nevola), pak se pres nej prepisou sekce/klice
  z ClearTemp.ini - stejna sekce+klic v ClearTemp.ini ma prednost pred dodavanou hodnotou
}
procedure BuildMergedDefinitions;
var
  sections, ident: TStringList;
  j, k: Integer;
begin
  DefinitionsIni := TMemIniFile.Create(GEOGET_SCRIPTDIR + '\ClearTemp\ClearTemp.definitions.ini');

  sections := TStringList.Create;
  ident := TStringList.Create;
  try
    SettingsIni.ReadSections(sections);
    for j := 0 to sections.Count - 1 do
    begin
      ident.Clear;
      SettingsIni.ReadSection(sections[j], ident);
      for k := 0 to ident.Count - 1 do
        DefinitionsIni.WriteString(sections[j], ident[k], SettingsIni.ReadString(sections[j], ident[k], ''));
    end;
  finally
    sections.Free;
    ident.Free;
  end;
end;

{
  Sestavi zalozky (podle prefixu nazvu sekce) a v nich checkboxy (+ combo dnu) kategorii
  podle definic v DefinitionsIni. Zalozky se znovu sestavuji pri kazdem otevreni dialogu,
  aby se zohlednily pripadne zmeny v definicich
}
procedure BuildOptionsForm;
var
  order: TStringList;
  i, top, tabIdx, maxTop, pageControlHeight: Integer;
  section, tabName, daysOptions, hintText, labelText, daysDefault: String;
  chk: TCheckBox;
  combo: TComboBox;
  checked: boolean;
  tabsheet: TTabSheet;
  scrollbox: TScrollBox;
begin
  // Smazani pripadnych zalozek z predchoziho spusteni pluginu - pokud se zmenil seznam kategorií,
  // jinak by zustaly prazdne zalozky
  while ClearTempOptions_pcCategories.ControlCount > 0 do
    ClearTempOptions_pcCategories.Controls[0].Free;

  order := TStringList.Create;
  try
    LoadCategoryOrder(DefinitionsIni, order);

    for i := 0 to order.Count - 1 do
    begin
      section := order[i];
      if not CategoryIsVisible(section) then Continue;

      tabName := TabNameForSection(section);
      tabIdx := TabInfo.IndexOf(tabName);
      if tabIdx = -1 then
      begin
        tabsheet := TTabSheet.Create(ClearTempOptions_pcCategories);
        tabsheet.Caption := tabName;
        tabsheet.PageControl := ClearTempOptions_pcCategories;
        tabsheet.Tag := TabInfo.Count; // index v TabInfo (viz UpdateTabCaption)

        scrollbox := TScrollBox.Create(tabsheet);
        scrollbox.Align := alClient;
        scrollbox.AutoScroll := True;
        scrollbox.Parent := tabsheet;
        scrollbox.Tag := 4; // Top prvniho radku

        TabInfo.AddObject(tabName, scrollbox);
        tabIdx := TabInfo.Count - 1;
      end;

      scrollbox := TScrollBox(TabInfo.Objects[tabIdx]);
      tabsheet := TTabSheet(scrollbox.Parent);
      top := scrollbox.Tag;

      daysOptions := DefinitionsIni.ReadString(section, 'DaysOptions', '');

      chk := TCheckBox.Create(scrollbox);
      chk.Parent := scrollbox;
      chk.Left := 5;
      chk.Top := top;
      if daysOptions <> '' then chk.Width := 305 else chk.Width := 360;
      chk.Height := 17;
      // Zamerne bez chk.Name - nazev sekce z ClearTemp.ini muze obsahovat mezeru, '-' nebo '.',
      // coz neni platne jmeno komponenty (vyjimka); kategorie se dohledavaji pres CategoryCheckboxes

      labelText := LocalizedText(section, 'Label');
      if labelText = '' then labelText := section;
      chk.Caption := labelText;

      hintText := LocalizedText(section, 'Hint');
      chk.ShowHint := (hintText <> '');
      chk.ParentShowHint := False;
      if hintText <> '' then chk.Hint := hintText;

      // [LastState] z ClearTemp.ini je slouceny i v DefinitionsIni - cteme tolerantne (ne TIniFile.ReadBool)
      checked := ReadBoolLenient(DefinitionsIni, 'LastState', section + '_Checked', ReadBoolLenient(DefinitionsIni, section, 'Default', False));
      chk.Checked := checked;
      chk.OnClick := @OnCategoryClick;
      chk.Tag := CategoryCheckboxes.Count; // index kategorie (viz OnCategoryClick)

      CategoryCheckboxes.AddObject(section, chk);
      CategoryTabSheets.AddObject(section, tabsheet);

      if daysOptions <> '' then
      begin
        combo := TComboBox.Create(scrollbox);
        combo.Parent := scrollbox;
        combo.Left := 315;
        combo.Top := top - 3;
        combo.Width := 50;
        combo.Height := 24;
        combo.ShowHint := True;
        combo.ParentShowHint := False;
        if ReadBoolLenient(DefinitionsIni, section, 'AllowNotInDatabase', False) then
          combo.Hint := _('Empty value or 0 delete all files,') + CRLF + _('-2 delete files which haven''t parent point in database')
        else
          combo.Hint := _('Empty value or 0 delete all files');
        SplitCommaList(daysOptions, combo.Items);

        daysDefault := DefinitionsIni.ReadString('LastState', section + '_Days', '');
        combo.Text := daysDefault;
        combo.Enabled := checked;

        CategoryCombos.AddObject(section, combo);
      end
      else
        CategoryCombos.AddObject(section, nil);

      scrollbox.Tag := top + 24;
    end;

    // Dynamicka vyska formulare podle nejvyssi zalozky, max cca 900px minus zbytek formulare
    maxTop := 4;
    for i := 0 to TabInfo.Count - 1 do
      if TScrollBox(TabInfo.Objects[i]).Tag > maxTop then maxTop := TScrollBox(TabInfo.Objects[i]).Tag;

    pageControlHeight := maxTop + 34; // Rezerva na zahlavi zalozek
    if pageControlHeight < 290 then pageControlHeight := 290;
    if pageControlHeight > 800 then pageControlHeight := 800; // 900 minus zbytek formulare

    ClearTempOptions_pcCategories.Height := pageControlHeight;
    ClearTempOptions.Height := 30 + pageControlHeight + 77;
    ClearTempOptions_buttonOk.Top := 30 + pageControlHeight + 10;
    ClearTempOptions_buttonCancel.Top := ClearTempOptions_buttonOk.Top;

    // Pocatecni popisky zalozek s poctem zaskrtnutych
    for i := 0 to TabInfo.Count - 1 do
      UpdateTabCaption(TTabSheet(TScrollBox(TabInfo.Objects[i]).Parent));
  finally
    order.Free;
  end;
end;

// ==============================================================================
//  Hlavni vstupni bod pluginu
// ==============================================================================

{
  Zobrazi dialog s nastavenim. Vysledne Days kazde kategorie se spocita jednou a ulozi do
  CategoryDays ('' = nezaskrtnuta). Pokud ma nektera zaskrtnuta kategorie neplatnou hodnotu
  dnu (viz ResolveDays), zobrazi se hlaseni a dialog znovu, aby ji uzivatel mohl opravit.
  False = uzivatel dialog zrusil.
}
function ShowOptionsDialog: boolean;
var
  i, days: Integer;
  chk: TCheckBox;
  combo: TComboBox;
  invalidMsg: String;
begin
  Result := False;
  ClearTempOptions.Caption := _('Clear Temp - Options');
  repeat
    if ClearTempOptions.ShowModal <> 1 then Exit;

    CategoryDays.Clear;
    invalidMsg := '';
    for i := 0 to CategoryCheckboxes.Count - 1 do
    begin
      chk := TCheckBox(CategoryCheckboxes.Objects[i]);
      combo := TComboBox(CategoryCombos.Objects[i]);
      if not chk.Checked then
      begin
        CategoryDays.Add('');
        Continue;
      end;

      days := ResolveDays(CategoryCheckboxes[i], combo);
      CategoryDays.Add(IntToStr(days));
      if (days = DAYS_INVALID) and (invalidMsg = '') then
      begin
        invalidMsg := _('Invalid "days old" value "%VALUE%" in category "%CATEGORY%".');
        invalidMsg := ReplaceString(invalidMsg, '%VALUE%', Trim(combo.Text));
        invalidMsg := ReplaceString(invalidMsg, '%CATEGORY%', chk.Caption);
      end;
    end;

    if invalidMsg <> '' then
      ShowMessage(invalidMsg + CRLF + _('Use a whole number of days, or leave it empty (or 0) to delete all files.'));
  until invalidMsg = '';
  Result := True;
end;

{
  Ulozi stav vsech kategorii (zaskrtnuti + text v combu dnu) do ClearTemp.ini [LastState]
}
procedure SaveLastState;
var
  i: Integer;
  combo: TComboBox;
begin
  for i := 0 to CategoryCheckboxes.Count - 1 do
  begin
    SettingsIni.WriteBool('LastState', CategoryCheckboxes[i] + '_Checked', TCheckBox(CategoryCheckboxes.Objects[i]).Checked);
    combo := TComboBox(CategoryCombos.Objects[i]);
    if combo <> nil then SettingsIni.WriteString('LastState', CategoryCheckboxes[i] + '_Days', combo.Text);
  end;
end;

{
  Nacte kody kesi ze VSECH databazi v datovem adresari do DatabaseIDList (serazeny - IndexOf
  v IsInDatabase pak hleda pulenim intervalu). Slozka attach\ je spolecna pro vsechny databaze,
  takze priloha je osirela jen tehdy, kdyz jeji kes neni v zadne z nich - kontrola jen otevrene
  databaze by napr. pri otevrene MHD.db3 nabidla ke smazani vsechny prilohy.
  Otevrena databaze se cte pres GEOGET_DB, ostatni *.db3 v GEOGET_DATADIR se otevrou zvlast;
  datovane zalohy (jmeno.RRRRMMDD.db3) se preskakuji.
  False = nekterou databazi se nepodarilo precist - osirele soubory se pak nehledaji vubec,
  protoze by mohly patrit kesim v neprectene databazi.
}
function LoadDatabaseIDs: boolean;
var
  files, ids: TStringList;
  i: Integer;
  fileName, dbName, failedDb: String;
  db: TSQLiteDatabase;
begin
  failedDb := '';
  DatabaseIDList := TStringList.Create;
  files := TStringList.Create;
  ids := TStringList.Create;
  try
    GeoBusyCaption(_('Reading caches from databases'));
    GeoBusyKind(GEOGET_DBNAME);
    GEOGET_DB.GetTableStrings('SELECT id FROM geocache', DatabaseIDList);

    FileList(GEOGET_DATADIR, files);
    for i := 0 to files.Count - 1 do
    begin
      fileName := files[i];
      if IsFolderEntry(fileName) then Continue;
      if not RegexFind('(?i)\.db3$', fileName) then Continue;
      if RegexFind('(?i)\.\d{8}\.db3$', fileName) then Continue; // datovana zaloha
      dbName := RegexExtract('[^\\]+$', fileName);
      dbName := Copy(dbName, 1, Length(dbName) - 4); // bez .db3
      if UpperCase(dbName) = UpperCase(GEOGET_DBNAME) then Continue; // otevrena databaze - uz nactena pres GEOGET_DB

      GeoBusyKind(dbName);
      try
        db := TSQLiteDatabase.Create(fileName);
        try
          ids.Clear;
          db.GetTableStrings('SELECT id FROM geocache', ids);
          DatabaseIDList.AddStrings(ids);
        finally
          db.Free;
        end;
      except
        if failedDb = '' then failedDb := dbName;
      end;
    end;

    DatabaseIDList.Sorted := True; // az po nacteni vseho - vkladani do serazeneho seznamu by bylo pomale
  finally
    files.Free;
    ids.Free;
  end;

  Result := failedDb = '';
  if not Result then
    ShowMessage(ReplaceString(_('Database "%DATABASE%" could not be read, so orphaned attachments will not be searched (they could belong to caches in that database).'), '%DATABASE%', failedDb));
end;

{
  Projde FileKeyN vsech zaskrtnutych kategorii a naplni seznam ke smazani (+ SweepFolders).
  False = uzivatel hledani prerusil (Cancel v busy dialogu).
}
function ScanCategories: boolean;
var
  i, n, days: Integer;
  path, mask, flags: String;
  orphanCheckOk, recursive: boolean;
  fileKeys: TStringList;
begin
  // Seznam kesi z databazi je potreba jen pokud nektera zaskrtnuta kategorie resi -2
  orphanCheckOk := True;
  if CategoryDays.IndexOf(IntToStr(DAYS_NOT_IN_DB)) <> -1 then
    orphanCheckOk := LoadDatabaseIDs;

  GeoBusyCaption(_('Searching files'));
  ScanCancelled := False;
  fileKeys := TStringList.Create;
  try
    for i := 0 to CategoryCheckboxes.Count - 1 do
    begin
      if CategoryDays[i] = '' then Continue;
      days := StrToInt(CategoryDays[i]);
      if days = DAYS_NOT_IN_DB then
        if not orphanCheckOk then Continue; // nektera databaze nesla precist - viz LoadDatabaseIDs

      ReadNumberedKeys(CategoryCheckboxes[i], 'FileKey', fileKeys);
      for n := 0 to fileKeys.Count - 1 do
      begin
        ParseFileKey(fileKeys[n], path, mask, flags);
        flags := UpperCase(Trim(flags));
        recursive := (flags = 'RECURSE') or (flags = 'REMOVESELF');
        SearchFileKey(path, mask, recursive, days);
        if ScanCancelled then Break;
        if (flags = 'REMOVESELF') and (path <> '') and (SweepFolders.IndexOf(path) = -1) then
          SweepFolders.Add(path);
      end;
      if ScanCancelled then Break;
    end;
  finally
    fileKeys.Free;
  end;
  Result := not ScanCancelled;
end;

{
  Zobrazi dialog s nalezenymi soubory (vsechny predem oznacene, uzivatel muze odznacit).
  True = uzivatel potvrdil smazani.
}
function ConfirmDeletion: boolean;
var
  i: Integer;
  resultsLabel: String;
begin
  for i := 0 to ClearTempConfirmDelete_lbDeleteFiles.Items.Count - 1 do
    ClearTempConfirmDelete_lbDeleteFiles.Selected[i] := True;

  resultsLabel := _('Found %COUNT% items with total size %SIZE% MB');
  resultsLabel := ReplaceString(resultsLabel, '%COUNT%', IntToStr(ClearTempConfirmDelete_lbDeleteFiles.Items.Count));
  resultsLabel := ReplaceString(resultsLabel, '%SIZE%', FormatSizeMB(totalSize));
  ClearTempConfirmDelete_lblResult.Caption := resultsLabel;

  ClearTempConfirmDelete.Caption := _('Clear Temp - Confirm results');
  Result := ClearTempConfirmDelete.ShowModal = 1;
end;

{
  Smaze oznacene soubory (Cancel v busy dialogu mazani prerusi). Vraci pocet souboru,
  ktere se smazat nepodarilo.
}
function DeleteSelected: Integer;
var
  i: Integer;
  fileName: String;
begin
  Result := 0;
  GeoBusyCaption(_('Deleting files'));
  for i := 0 to ClearTempConfirmDelete_lbDeleteFiles.Items.Count - 1 do
  begin
    if ClearTempConfirmDelete_lbDeleteFiles.Selected[i] then
    begin
      if GeoBusyTest then Break;
      fileName := ClearTempConfirmDelete_lbDeleteFiles.Items[i];
      GeoBusyKind(ReplaceString(fileName, GEOGET_DATADIR, ''));
      GeoBusyProgress(i, ClearTempConfirmDelete_lbDeleteFiles.Items.Count);
      if not DeleteFile(fileName) then Result := Result + 1;
    end;
  end;
end;

{
  Smazani prazdnych slozek - [Settings] EmptyFolderSweep1..N (vzdy) a adresare FileKeyN
  s priznakem REMOVESELF (jen zaskrtnute kategorie, viz SweepFolders)
}
procedure SweepEmptyFolders;
var
  i: Integer;
  sweepPaths: TStringList;
begin
  GeoBusyCaption(_('Clean up!'));
  sweepPaths := TStringList.Create;
  try
    ReadNumberedKeys('Settings', 'EmptyFolderSweep', sweepPaths);
    for i := 0 to sweepPaths.Count - 1 do
      DeleteEmptyFolders(ExpandPath(sweepPaths[i]));
  finally
    sweepPaths.Free;
  end;

  for i := 0 to SweepFolders.Count - 1 do
    DeleteEmptyFolders(SweepFolders[i]);
end;

procedure PluginStart;
var
  failed: Integer;
begin
  CategoryCheckboxes := TStringList.Create;
  CategoryCombos := TStringList.Create;
  CategoryTabSheets := TStringList.Create;
  CategoryDays := TStringList.Create;
  TabInfo := TStringList.Create;
  SweepFolders := TStringList.Create;
  QueuedFiles := TStringList.Create;
  QueuedFiles.Sorted := True; // IndexOf v ProcessFile hleda pulenim intervalu
  DatabaseIDList := nil;
  DefinitionsIni := nil;
  totalSize := 0;
  SettingsIni := TIniFile.Create(GEOGET_SCRIPTDIR + '\ClearTemp\ClearTemp.ini');
  try
    IsCzech := CurrentLanguageIsCzech;

    // Slouceni dodavanych definic s pripadnymi uzivatelskymi pridavky/prepisy
    BuildMergedDefinitions;

    // Formular muze zustat v pameti z predchoziho spusteni - seznam ke smazani zacina prazdny
    ClearTempConfirmDelete_lbDeleteFiles.Items.Clear;
    // Dvojklik v seznamu ke smazani otevre adresar se souborem
    ClearTempConfirmDelete_lbDeleteFiles.OnDblClick := @OnDeleteListDblClick;

    // Sestaveni dynamickeho seznamu kategorii podle definic v ClearTemp.definitions.ini a ClearTemp.ini
    BuildOptionsForm;

    if not ShowOptionsDialog then Exit;
    SaveLastState;
    if not ScanCategories then Exit;
    if not ConfirmDeletion then Exit;
    failed := DeleteSelected;
    SweepEmptyFolders;

    if failed > 0 then
      ShowMessage(ReplaceString(_('%COUNT% files could not be deleted (in use or access denied).'), '%COUNT%', IntToStr(failed)));
  finally
    if DatabaseIDList <> nil then
    begin
      DatabaseIDList.Free;
      DatabaseIDList := nil;
    end;
    CategoryCheckboxes.Free;
    CategoryCombos.Free;
    CategoryTabSheets.Free;
    CategoryDays.Free;
    TabInfo.Free;
    SweepFolders.Free;
    QueuedFiles.Free;
    SettingsIni.Free;
    if DefinitionsIni <> nil then DefinitionsIni.Free;
  end;
end;
