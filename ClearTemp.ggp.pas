{
  GeoGet 2
  www: http://geoget.ararat.cz/doku.php/user:skript:cleartemp

  Puvodni verze: ProKesTom, http://www.geocaching.cz/forum/viewthread.php?forum_id=20&thread_id=17432&pid=251781#post_251781
  Autor: mikrom, http://mikrom.cz

  Kategorie mazani (checkboxy v dialogu) se negeneruji staticky, ale nactou se za behu
  ze dvou INI souboru:
  - ClearTemp.definitions.ini - dodavane definice kategorii (sekce [Categories] + jednotlive
    sekce), format inspirovany CCleaner winapp2.ini (viz src/CCleaner_format.txt), popis
    klicu je primo v hlavicce tohoto souboru. Zahrnuje i Label_CS/Hint_CS pro cestinu.
  - ClearTemp.ini - per-uzivatelsky stav ([LastState]) a [Settings] Language=CS/prazdne,
    ktery rozhoduje jestli se pouzije Label_CS/Hint_CS nebo Label/Hint.

  Vyznam "dnu stari" (Days) u kategorie s DaysOptions:
  -2 pokud neni v databazi (jen pokud ma kategorie AllowNotInDatabase=True)
  -1 vse
  0 ... 999 stari ve dnech
}

uses
  ClearTemp, ClearTempConfirm;

var
  DatabaseIDList: TStringList;
  totalSize: integer;
  SettingsIni: TIniFile;      // ClearTemp.ini - per-uzivatelsky stav (LastState, Language)
  DefinitionsIni: TIniFile;   // ClearTemp.definitions.ini - dodavane definice kategorii
  CategoryCheckboxes: TStringList; // Strings = nazev sekce, Objects = TCheckBox
  CategoryCombos: TStringList;     // Strings = nazev sekce, Objects = TComboBox nebo nil
  DebugLog: TStringList;      // DEBUG - odstranit az bude IsInDatabase overene

function PluginCaption: string;
begin
  Result := _('Clear Temp');
end;

function PluginHint: string;
begin
  Result := _('Clear folders ggupdate, script_download, temp etc.');
end;

function PluginIcon: string;
begin
  Result := DecodeBase64('Qk02BQAAAAAAADYEAAAoAAAAEAAAABAAAAABAAgAAAAAAAAAAAASCwAAEgsAAAABAAAAAQAAeHh4/3p6ev97e3v/fHx8/85oRv/TbUv/1HBO/9lzUf/lf13/135g/9yOcv/qhGL/6oZl/+6IZv/rkXP/3AD//4CAgP+BgYH/jIyM/4+Pj/+ZmZn/m5ub/56env+fn5//oaGh/6mpqf+rq6v/uaio/7qvr/+zs7P/tra2/+6ghf/koov/7KuU/82+of/CsLD/0L6+/87ApP/Qwqb/0cOo/9PFqv/Ux6z/1ciu/9bJsP/XyrH/2Myz/9nNtP/azrX/7828/8bExP/Hx8f/yMjI/8nJyf/fzc3/0dHR/+/Wx//v2cv/7t7O/+/ezv/x08X/8tPG//PVxv/x183/89nP/+/d3f/w4NH/8OLT//Di1P/x49X/8uPV//Xg1f/x5Nb/8uTX//fj2//z5tn/8+fc//Tn3f/06N7/9Orf/+Hh4f/16uD/9ezi//bs4//27OT/9u7m//fu5f/38Oj/+fTu//r18P/69vH/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/w8PFgMCAgEBAQECAgMWDw8PDxhPNjMxHBsjJDVAFw8PDw8eGRUUEwMAEBIVGR0PDw8PIlQ6TFdOSkE6OVEiDw8PDyVUOkxYVUtBOjlRJQ8PDw8mVDpNPgRSRzo5USYPDw8PJ1Q6UAUJBgo4OVEnDw8PDyhUOk0/B1M3IEJRKA8PDw8pVEQ8WFVSRzBDUSkPDw8PKlREIUlWCDtBOVEqDw8PDytUOkYfDA4LSDlRKw8PDw8sVDpMWVYNPUE5USwPDw8PLVQ6TFdQUEU6OVEtDw8PDy5UOkxXTkpBOjlRLg8PDw8vVDpMV05KQTo5US8PDw8PNBkVFBMDABETFhoyDw8=');
end;

function PluginFlags: string;
begin
  Result := 'toolbar';
end;

{Clean-up, smazani prazdnych adresaru}
procedure DeleteEmptyFolders(StartDir: string);
var
   Files,Queue,tmp: TStringList;
   n: Integer;
begin
  if DirectoryExists(StartDir) then
  begin
    Files := TStringList.Create;
    Queue := TStringList.Create;
    tmp := TStringList.Create;
    try
      Queue.Add(StartDir);
      while (Queue.Count > 0) do
      begin
        FileList(Queue[0],Files);
        Queue.Delete(0);
        for n := 0 to Files.Count - 1 do
        begin
          if RegexFind('\\$',Files[n]) then
          begin
            Queue.Add(Files[n]);
            FileList(copy(Files[n],0,Length(Files[n]) - 1),tmp);
            if tmp.Count = 0 then
            begin
              GeoBusyKind(ReplaceString(Files[n],GEOGET_DATADIR,''));
              DelTree(Files[n]);
            end;
          end;
        end;
      end;
    finally
      Queue.Free;
      Files.Free;
      tmp.Free;
    end;
  end;
end;

{testuje zda je kes v databazi. GCxxxx, WMxxxx, OCxxxx}
function IsInDatabase(files: string): boolean;
var
  code: String;
  foundStr: String;
  posLF, posCR, posBreak: Integer;
begin
  code := RegexExtract('GC[A-Z0-9]+|WM[A-Z0-9]+|OC[A-Z0-9]+',files);

  {RegexExtract muze vratit vice nalezenych shod spojenych znakem noveho radku (napr. kdyz
   se vzor GC/WM/OC nahodou objevi i v nazvu souboru, ne jen v adresarove strukture) -
   pouzijeme jen prvni nalezenou shodu, ktera odpovida adresari s kodem kese. Hledame
   nejdrivejsi vyskyt CR nebo LF, aby po oriznuti nezustal "zavlecen" znak CR pred LF.}
  posLF := Pos(#10, code);
  posCR := Pos(#13, code);
  if (posLF > 0) and ((posCR = 0) or (posLF < posCR)) then
    posBreak := posLF
  else
    posBreak := posCR;
  if posBreak > 0 then code := Copy(code, 1, posBreak - 1);
  code := Trim(code);

  if DatabaseIDList.IndexOf(code) = -1 then
    Result := false
  else
    Result := true;

  {DEBUG - odstranit az bude IsInDatabase overene}
  if DebugLog <> nil then
  begin
    if Result then foundStr := '1' else foundStr := '0';
    DebugLog.Add(files + ' | code=[' + code + '] | found=' + foundStr);
  end;
  {/DEBUG}
end;

{obsluuje busy dialog a pridava do seznamu ke smazani}
procedure ProcessFile(files: string);
begin
  GeoBusyKind(ReplaceString(files,GEOGET_DATADIR,''));
  ClearTempConfirmDelete_lbDeleteFiles.Items.Add(files);
  totalSize := totalSize + GetFileSize(files);
end;

{otestuje jestli jmeno souboru odpovida jednoduche masce (*.*, *.old, presne jmeno)}
function FileMatchesMask(fileName, mask: string): boolean;
var
  pattern, justName: string;
begin
  if (mask = '*.*') or (mask = '*') or (mask = '') then
  begin
    Result := true;
    Exit;
  end;

  justName := RegexExtract('[^\\]+$', fileName);
  pattern := ReplaceString(mask, '.', '\.');
  pattern := ReplaceString(pattern, '*', '.*');
  pattern := ReplaceString(pattern, '?', '.');
  Result := RegexFind('^' + pattern + '$', justName);
end;

{rozdeli seznam oddeleny carkou (napr. DaysOptions=7,14,30) do target}
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

{rozdeli FileKeyN=path|mask|flags na jednotlive casti a expanduje promenne v ceste}
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

  path := ReplaceString(path, '%GEOGET_DATADIR%', GEOGET_DATADIR);
  path := ReplaceString(path, '%GEOGET_SCRIPTDIR%', GEOGET_SCRIPTDIR);
  path := ReplaceString(path, '%GEOGET_COMMONDATADIR%', GEOGET_COMMONDATADIR);
end;

{Hleda soubory v danem adresari (StartDir), volitelne vcetne podslozek (Recursive),
 podle jednoduche masky (Mask). Nalezene soubory se filtruji podle Days stejne
 jako drive (-2 = neni v databazi, -1 = vse, 0..N = stari ve dnech).}
procedure SearchFileKey(StartDir, Mask: String; Recursive: boolean; Days: Integer);
var
   Files,Queue: TStringList;
   n: Integer;
begin
  if not DirectoryExists(StartDir) then Exit;

  Files := TStringList.Create;
  Queue := TStringList.Create;
  try
    Queue.Add(StartDir);
    while (Queue.Count > 0) do
    begin
      FileList(Queue[0],Files);
      Queue.Delete(0);
      for n := 0 to Files.Count - 1 do
      begin
        GeoBusyProgress(n,Files.Count);
        if RegexFind('\\$',Files[n]) then
        begin
          if Recursive then Queue.Add(Files[n]);
        end
        else
        begin
          if FileMatchesMask(Files[n], Mask) then
          begin
            case Days of
              -2:   if not IsInDatabase(Files[n]) then ProcessFile(Files[n]); // pokud neexistuje v databazi odpovidajici kes
              -1:   ProcessFile(Files[n]); // vse
              else  if (GetFileTime(Files[n]) <= (Now() - Days)) then ProcessFile(Files[n]); // starsi nez zadany pocet dni
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

{doplni cislo nulami zleva na 6 mist, aby se dalo poradi kategorii razeni jako text}
function ZeroPad(n: Integer): String;
var
  s: String;
begin
  s := IntToStr(n);
  while Length(s) < 6 do s := '0' + s;
  Result := s;
end;

{nacte poradi kategorii ze sekce [Categories] (hodnota = vaha), serazene vzestupne}
procedure LoadCategoryOrder(ini: TIniFile; list: TStringList);
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

{povoli/zakaze combo se starim podle stavu prislusneho checkboxu}
procedure OnCategoryClick(sender: TObject);
var
  i: Integer;
  combo: TComboBox;
begin
  for i := 0 to CategoryCheckboxes.Count - 1 do
  begin
    if CategoryCheckboxes.Objects[i] = TObject(sender) then
    begin
      combo := TComboBox(CategoryCombos.Objects[i]);
      if combo <> nil then combo.Enabled := TCheckBox(sender).Checked;
      Break;
    end;
  end;
end;

{true, pokud ClearTemp.ini [Settings] Language=CS - pak se pouzivaji Label_CS/Hint_CS}
function CurrentLanguageIsCzech: boolean;
begin
  Result := UpperCase(Trim(SettingsIni.ReadString('Settings', 'Language', ''))) = 'CS';
end;

{vrati Label/Hint (nebo jejich _CS variantu) z ClearTemp.definitions.ini, bez gettext}
function LocalizedText(section, key: String): String;
var
  csValue: String;
begin
  if CurrentLanguageIsCzech then
  begin
    csValue := DefinitionsIni.ReadString(section, key + '_CS', '');
    if csValue <> '' then
    begin
      Result := csValue;
      Exit;
    end;
  end;
  Result := DefinitionsIni.ReadString(section, key, '');
end;

{prevede bajty na text v MB se 2 desetinnymi misty (bez FormatFloat)}
function FormatSizeMB(bytes: Integer): String;
var
  wholeMB, fracMB: Integer;
  fracStr: String;
begin
  wholeMB := bytes div (1024*1024);
  fracMB := (bytes mod (1024*1024)) * 100 div (1024*1024);
  fracStr := IntToStr(fracMB);
  if Length(fracStr) < 2 then fracStr := '0' + fracStr;
  Result := IntToStr(wholeMB) + '.' + fracStr;
end;

{dvojklik na polozku v seznamu ke smazani otevre adresar, kde se soubor nachazi}
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

{prevede text v combu na vyslednou hodnotu Days, respektuje AllowNotInDatabase}
function ResolveDays(section: String; combo: TComboBox): Integer;
var
  txt: String;
  val: Integer;
  allowNotInDb: boolean;
begin
  allowNotInDb := DefinitionsIni.ReadBool(section, 'AllowNotInDatabase', False);

  if combo = nil then
  begin
    {bez DaysOptions: kategorie s AllowNotInDatabase resi jen osirele soubory, jinak vse}
    if allowNotInDb then Result := -2 else Result := -1;
    Exit;
  end;

  txt := Trim(combo.Text);
  if txt = '' then
  begin
    Result := -1;
    Exit;
  end;

  val := StrToIntDef(txt, -1);
  if (val = -2) and not allowNotInDb then val := -1;
  Result := val;
end;

{sestavi seznam kategorii z ClearTemp.definitions.ini a vytvori pro ne checkboxy (+ combo dnu) ve scrollCategories}
procedure BuildOptionsForm;
var
  order: TStringList;
  i, top: Integer;
  section, detectFile, daysOptions, hintText, labelText, daysDefault: String;
  chk: TCheckBox;
  combo: TComboBox;
  checked: boolean;
begin
  {smazani pripadnych checkboxu/combo z predchoziho spusteni pluginu}
  while ClearTempOptions_scrollCategories.ControlCount > 0 do
    ClearTempOptions_scrollCategories.Controls[0].Free;

  order := TStringList.Create;
  try
    LoadCategoryOrder(DefinitionsIni, order);

    top := 4;
    for i := 0 to order.Count - 1 do
    begin
      section := order[i];

      detectFile := DefinitionsIni.ReadString(section, 'DetectFile', '');
      detectFile := ReplaceString(detectFile, '%GEOGET_DATADIR%', GEOGET_DATADIR);
      detectFile := ReplaceString(detectFile, '%GEOGET_SCRIPTDIR%', GEOGET_SCRIPTDIR);
      detectFile := ReplaceString(detectFile, '%GEOGET_COMMONDATADIR%', GEOGET_COMMONDATADIR);
      if (detectFile <> '') and not FileExists(detectFile) and not DirectoryExists(detectFile) then Continue;

      daysOptions := DefinitionsIni.ReadString(section, 'DaysOptions', '');

      chk := TCheckBox.Create(ClearTempOptions_scrollCategories);
      chk.Parent := ClearTempOptions_scrollCategories;
      chk.Left := 5;
      chk.Top := top;
      if daysOptions <> '' then chk.Width := 215 else chk.Width := 290;
      chk.Height := 17;
      chk.Name := 'chk_' + section;

      labelText := LocalizedText(section, 'Label');
      if labelText = '' then labelText := section;
      chk.Caption := labelText;

      hintText := LocalizedText(section, 'Hint');
      chk.ShowHint := (hintText <> '');
      chk.ParentShowHint := False;
      if hintText <> '' then chk.Hint := hintText;

      checked := SettingsIni.ReadBool('LastState', section + '_Checked', DefinitionsIni.ReadBool(section, 'Default', False));
      chk.Checked := checked;
      chk.OnClick := @OnCategoryClick;

      CategoryCheckboxes.AddObject(section, chk);

      if daysOptions <> '' then
      begin
        combo := TComboBox.Create(ClearTempOptions_scrollCategories);
        combo.Parent := ClearTempOptions_scrollCategories;
        combo.Name := 'combo_' + section;
        combo.Left := 305;
        combo.Top := top - 3;
        combo.Width := 50;
        combo.Height := 24;
        combo.ShowHint := True;
        combo.ParentShowHint := False;
        combo.Hint := _('Empty value delete all files,') + CRLF + _('-2 delete files which haven''t parent point in database');
        SplitCommaList(daysOptions, combo.Items);

        daysDefault := SettingsIni.ReadString('LastState', section + '_Days', '');
        combo.Text := daysDefault;
        combo.Enabled := checked;

        CategoryCombos.AddObject(section, combo);
      end
      else
        CategoryCombos.AddObject(section, nil);

      top := top + 24;
    end;
  finally
    order.Free;
  end;
end;

procedure PluginStart;
var
  i, n, days: Integer;
  section, mask, path, flags, fileKeyValue, sweepPath, resultsLabel: String;
  needDatabaseList, recursive: boolean;
  chk: TCheckBox;
  combo: TComboBox;
  SweepFolders: TStringList;
begin
  CategoryCheckboxes := TStringList.Create;
  CategoryCombos := TStringList.Create;
  SweepFolders := TStringList.Create;
  DatabaseIDList := nil;
  DebugLog := nil;
  SettingsIni := TIniFile.Create(GEOGET_SCRIPTDIR + '\ClearTemp\ClearTemp.ini');
  DefinitionsIni := TIniFile.Create(GEOGET_SCRIPTDIR + '\ClearTemp\ClearTemp.definitions.ini');
  try
    {dvojklik v seznamu ke smazani otevre adresar se souborem}
    ClearTempConfirmDelete_lbDeleteFiles.OnDblClick := @OnDeleteListDblClick;

    {sestaveni dynamickeho seznamu kategorii}
    BuildOptionsForm;

    {dialog s nastavenim}
    ClearTempOptions.Caption := _('Clear Temp - Options');
    if ClearTempOptions.ShowModal <> 1 then Exit;

    {zjisti, jestli je potreba databaze kesi (nektera zaskrtnuta kategorie resi -2)}
    needDatabaseList := False;
    for i := 0 to CategoryCheckboxes.Count - 1 do
    begin
      chk := TCheckBox(CategoryCheckboxes.Objects[i]);
      if not chk.Checked then Continue;
      combo := TComboBox(CategoryCombos.Objects[i]);
      if ResolveDays(CategoryCheckboxes[i], combo) = -2 then needDatabaseList := True;
    end;

    if needDatabaseList then
    begin
      DatabaseIDList := TStringList.Create;
      GEOGET_DB.GetTableStrings('SELECT distinct id FROM geocache', DatabaseIDList);

      {DEBUG - odstranit az bude IsInDatabase overene}
      DebugLog := TStringList.Create;
      {/DEBUG}
    end;

    {hledani souboru + ulozeni stavu vsech kategorii do ClearTemp.ini}
    GeoBusyCaption(_('Searching files'));
    for i := 0 to CategoryCheckboxes.Count - 1 do
    begin
      chk := TCheckBox(CategoryCheckboxes.Objects[i]);
      combo := TComboBox(CategoryCombos.Objects[i]);
      section := CategoryCheckboxes[i];

      SettingsIni.WriteBool('LastState', section + '_Checked', chk.Checked);
      if combo <> nil then SettingsIni.WriteString('LastState', section + '_Days', combo.Text);

      if not chk.Checked then Continue;

      days := ResolveDays(section, combo);

      n := 1;
      fileKeyValue := DefinitionsIni.ReadString(section, 'FileKey' + IntToStr(n), '');
      while fileKeyValue <> '' do
      begin
        ParseFileKey(fileKeyValue, path, mask, flags);
        recursive := (UpperCase(flags) = 'RECURSE') or (UpperCase(flags) = 'REMOVESELF');
        SearchFileKey(path, mask, recursive, days);
        if UpperCase(flags) = 'REMOVESELF' then SweepFolders.Add(path);

        n := n + 1;
        fileKeyValue := DefinitionsIni.ReadString(section, 'FileKey' + IntToStr(n), '');
      end;
    end;

    {oznaceni vsech v seznamu}
    for i := 0 to ClearTempConfirmDelete_lbDeleteFiles.Items.Count - 1 do
      ClearTempConfirmDelete_lbDeleteFiles.Selected[i] := True;

    {popisek s poctem nalezu}
    resultsLabel := _('Found %COUNT% items with total size %SIZE% MB');
    resultsLabel := ReplaceString(resultsLabel,'%COUNT%',IntToStr(ClearTempConfirmDelete_lbDeleteFiles.Items.Count));
    resultsLabel := ReplaceString(resultsLabel,'%SIZE%',FormatSizeMB(totalSize));
    ClearTempConfirmDelete_lblResult.Caption := resultsLabel;

    {dialog s vysledky}
    ClearTempConfirmDelete.Caption := _('Clear Temp - Confirm results');
    if ClearTempConfirmDelete.ShowModal <> 1 then Exit;

    {smazani oznacenych}
    GeoBusyCaption(_('Deleting files'));
    for i := 0 to ClearTempConfirmDelete_lbDeleteFiles.Items.Count - 1 do
    begin
      if ClearTempConfirmDelete_lbDeleteFiles.Selected[i] then
      begin
        if GeoBusyTest then Break;
        GeoBusyKind(ReplaceString(ClearTempConfirmDelete_lbDeleteFiles.Items[i],GEOGET_DATADIR,''));
        GeoBusyProgress(i,ClearTempConfirmDelete_lbDeleteFiles.Items.Count);
        DeleteFile(ClearTempConfirmDelete_lbDeleteFiles.Items[i]);
      end;
    end;

    {smazani prazdnych slozek - cesty jsou definovany v ClearTemp.definitions.ini [Settings] EmptyFolderSweep1..N}
    GeoBusyCaption(_('Clean up!'));
    n := 1;
    sweepPath := DefinitionsIni.ReadString('Settings', 'EmptyFolderSweep' + IntToStr(n), '');
    while sweepPath <> '' do
    begin
      sweepPath := ReplaceString(sweepPath, '%GEOGET_DATADIR%', GEOGET_DATADIR);
      sweepPath := ReplaceString(sweepPath, '%GEOGET_SCRIPTDIR%', GEOGET_SCRIPTDIR);
      sweepPath := ReplaceString(sweepPath, '%GEOGET_COMMONDATADIR%', GEOGET_COMMONDATADIR);
      DeleteEmptyFolders(sweepPath);

      n := n + 1;
      sweepPath := DefinitionsIni.ReadString('Settings', 'EmptyFolderSweep' + IntToStr(n), '');
    end;

    {smazani prazdnych slozek pro FileKeyN s priznakem REMOVESELF (jen zaskrtnute kategorie)}
    for i := 0 to SweepFolders.Count - 1 do
      DeleteEmptyFolders(SweepFolders[i]);
  finally
    if DatabaseIDList <> nil then
    begin
      DatabaseIDList.Free;
      DatabaseIDList := nil;
    end;
    {DEBUG - odstranit az bude IsInDatabase overene}
    if DebugLog <> nil then
    begin
      DebugLog.Free;
      DebugLog := nil;
    end;
    {/DEBUG}
    CategoryCheckboxes.Free;
    CategoryCombos.Free;
    SweepFolders.Free;
    SettingsIni.Free;
    DefinitionsIni.Free;
  end;
end;
