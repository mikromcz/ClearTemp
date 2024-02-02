{
  GeoGet 2
  www: http://geoget.ararat.cz/doku.php/user:skript:cleartemp
  
  Puvodni verze: ProKesTom, http://www.geocaching.cz/forum/viewthread.php?forum_id=20&thread_id=17432&pid=251781#post_251781
  Autor: mikrom, http://mikrom.cz
  
  -2 pokud neni v databazi
  -1 vse
  0 ... 999 stari ve dnech
}

uses
  ClearTemp, ClearTempConfirm;

var
  DatabaseIDList: TStringList;

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
  Result := DecodeBase64('Qk02BQAAAAAAADYEAAAoAAAAEAAAABAAAAABAAgAAAAAAAAAAAASCwAAEgsAAAABAAAAAQAAeHh4/3p6ev97e3v/fHx8/85oRv/TbUv/1HBO/9lzUf/lf13/135g/9yOcv/qhGL/6oZl/+6IZv/rkXP/3AD//4CAgP+BgYH/jIyM/4+Pj/+ZmZn/m5ub/56env+fn5//oaGh/6mpqf+rq6v/uaio/7qvr/+zs7P/tra2/+6ghf/koov/7KuU/82+of/CsLD/0L6+/87ApP/Qwqb/0cOo/9PFqv/Ux6z/1ciu/9bJsP/XyrH/2Myz/9nNtP/azrX/7828/8bExP/Hx8f/yMjI/8nJyf/fzc3/0dHR/+/Wx//v2cv/7t7O/+/ezv/x08X/8tPG//PVxv/x183/89nP/+/d3f/w4NH/8OLT//Di1P/x49X/8uPV//Xg1f/x5Nb/8uTX//fj2//z5tn/8+fc//Tn3f/06N7/9Orf/+Hh4f/16uD/9ezi//bs4//27OT/9u7m//fu5f/38Oj/+fTu//r18P/69vH/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/w8PFgMCAgEBAQECAgMWDw8PDxhPNjMxHBsjJDVAFw8PDw8eGRUUEwMAEBIVGR0PDw8PIlQ6TFdOSkE6OVEiDw8PDyVUOkxYVUtBOjlRJQ8PDw8mVDpNPgRSRzo5USYPDw8PJ1Q6UAUJBgo4OVEnDw8PDyhUOk0/B1M3IEJRKA8PDw8pVEQ8WFVSRzBDUSkPDw8PKlREIUlWCDtBOVEqDw8PDytUOkYfDA4LSDlRKw8PDw8sVDpMWVYNPUE5USwPDw8PLVQ6TFdQUEU6OVEtDw8PDy5UOkxXTkpBOjlRLg8PDw8vVDpMV05KQTo5US8PDw8PNBkVFBMDABETFhoyDw8=');
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
begin
  if DatabaseIDList.IndexOf(RegexExtract('GC[A-Z0-9]+|WM[A-Z0-9]+|OC[A-Z0-9]+',files)) = -1 then
    Result := false
  else
    Result := true;
end;

{obsluuje busy dialog a pridava do seznamu ke smazani}
procedure ProcessFile(files: string);
begin
  GeoBusyKind(ReplaceString(files,GEOGET_DATADIR,''));
  ClearTempConfirmDelete_lbDeleteFiles.Items.Add(files);
end;

{Hleda soubor v dadanem adresari (vcetne podslozek). vraci celou cestu k souboru}
procedure SearchFile(StartDir, FileName: String; Days: Integer);
var
   Files,Queue : TStringList;
   n : Integer;
begin
  if DirectoryExists(StartDir) then
  begin
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
            Queue.Add(Files[n])
          else
          begin
            if RegexFind('\.'+FileName+'$',Files[n]) then
            begin
              case Days of
                -2:   if not IsInDatabase(Files[n]) then ProcessFile(Files[n]); // pokud neexistuje v databazi odpovidajici kes, zadano [-2]
                -1:   ProcessFile(Files[n]); // pokud se nezada nic tak je to [-1] cili vse
                else  if (GetFileTime(Files[n]) <= (Now() - Days)) then ProcessFile(Files[n]); // starsi nez zadany pocet dni [0-99999]
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
end;

{zaskrtnuti checkboxu pokud se tam neco nastavilo}
procedure SetStatus(Sender: TObject);
begin
  ClearTempOptions_comboCache.Enabled := ClearTempOptions_cbOfflineCache.Checked;
  ClearTempOptions_comboMaps.Enabled := ClearTempOptions_cbOfflineMaps.Checked;
  ClearTempOptions_comboInc.Enabled := ClearTempOptions_cbOfflineInc.Checked;
end;

procedure PluginStart;
var
  i: Integer;
  options: TIniFile;
begin
  {nacteni konfigurace ze souboru}
  if FileExists(GEOGET_SCRIPTDIR+'\ClearTemp\ClearTemp.ini') then
  begin
    options := TIniFile.Create(GEOGET_SCRIPTDIR+'\ClearTemp\ClearTemp.ini');
    try
      begin
        ClearTempOptions_cbGeoget.Checked       := options.ReadBool('LastState','cbGeoget',True);
        ClearTempOptions_cbScript.Checked       := options.ReadBool('LastState','cbScript',True);
        ClearTempOptions_cbTemp.Checked         := options.ReadBool('LastState','cbTemp',True);
        ClearTempOptions_cbPqTemp.Checked       := options.ReadBool('LastState','cbPqTemp',False);
        ClearTempOptions_cbOld.Checked          := options.ReadBool('LastState','cbOld',False);
        ClearTempOptions_cbLog.Checked          := options.ReadBool('LastState','cbLog',True);
        ClearTempOptions_cbOfflineCache.Checked := options.ReadBool('LastState','cbOfflineCache',False);
        ClearTempOptions_comboCache.Text        := options.ReadString('LastState','comboCache','0');
        ClearTempOptions_cbOfflineMaps.Checked  := options.ReadBool('LastState','cbOfflineMaps',False);
        ClearTempOptions_comboMaps.Text         := options.ReadString('LastState','comboMaps','90');
        ClearTempOptions_cbOfflineInc.Checked   := options.ReadBool('LastState','cbOfflineInc',False);
        ClearTempOptions_comboInc.Text          := options.ReadString('LastState','comboInc','90');
      end;
    finally
      options.Free;
    end;
  end;
  
  {zaskrtnuti checkboxu pokud se tam neco nastavilo}
  ClearTempOptions_comboCache.Enabled := ClearTempOptions_cbOfflineCache.Checked;
  ClearTempOptions_comboMaps.Enabled := ClearTempOptions_cbOfflineMaps.Checked;
  ClearTempOptions_comboInc.Enabled := ClearTempOptions_cbOfflineInc.Checked;
  ClearTempOptions_cbOfflineCache.OnClick := @SetStatus;
  ClearTempOptions_cbOfflineMaps.OnClick := @SetStatus;
  ClearTempOptions_cbOfflineInc.OnClick := @SetStatus;
  
  {dialog s nastavenim}
  ClearTempOptions.Caption := _('Clear Temp - Options');
  if ClearTempOptions.ShowModal <> 1 then Exit;

  {udelame si stringlist s kody kesi v databazi}
  if (ClearTempOptions_comboCache.Text = '-2') or (ClearTempOptions_comboMaps.Text = '-2') or (ClearTempOptions_comboInc.Text = '-2') then
  begin
    DatabaseIDList := TStringList.Create;
    GEOGET_DB.GetTableStrings('SELECT distinct id FROM geocache',DatabaseIDList);
  end;
  
  {definice co hledat - pripony, regularni vyrazy}
  GeoBusyCaption(_('Searching files'));
  if ClearTempOptions_cbGeoget.Checked       then SearchFile(GEOGET_DATADIR+'\ggupdate','.+',-1);
  if ClearTempOptions_cbScript.Checked       then SearchFile(GEOGET_DATADIR+'\script_download','.+',-1);
  if ClearTempOptions_cbTemp.Checked         then SearchFile(GEOGET_DATADIR+'\temp','.+',-1);
  if ClearTempOptions_cbPqTemp.Checked       then SearchFile(GEOGET_DATADIR+'\pq\temp','.+',-1);
  if ClearTempOptions_cbOld.Checked          then SearchFile(GEOGET_DATADIR,'old',-1);
  if ClearTempOptions_cbLog.Checked          then SearchFile(GEOGET_DATADIR,'log',-1);
  if ClearTempOptions_cbOfflineCache.Checked then SearchFile(GEOGET_DATADIR+'\offline\cache','.+',StrToInt(ClearTempOptions_comboCache.Text));
  if ClearTempOptions_cbOfflineMaps.Checked  then SearchFile(GEOGET_DATADIR+'\offline\maps','.+',StrToInt(ClearTempOptions_comboMaps.Text));
  if ClearTempOptions_cbOfflineInc.Checked   then SearchFile(GEOGET_DATADIR+'\offline\inc','.+',StrToInt(ClearTempOptions_comboInc.Text));
  
  //DatabaseIDList.Free;
  
  {ulozeni konfigurace do souboru}
  options := TIniFile.Create(GEOGET_SCRIPTDIR+'\ClearTemp\ClearTemp.ini');
  try
    begin
      options.WriteBool('LastState','cbGeoget',ClearTempOptions_cbGeoget.Checked);
      options.WriteBool('LastState','cbScript',ClearTempOptions_cbScript.Checked);
      options.WriteBool('LastState','cbTemp',ClearTempOptions_cbTemp.Checked);
      options.WriteBool('LastState','cbPqTemp',ClearTempOptions_cbPqTemp.Checked);
      options.WriteBool('LastState','cbOld',ClearTempOptions_cbOld.Checked);
      options.WriteBool('LastState','cbLog',ClearTempOptions_cbLog.Checked);
      options.WriteBool('LastState','cbOfflineCache',ClearTempOptions_cbOfflineCache.Checked);
      options.WriteString('LastState','comboCache',ClearTempOptions_comboCache.Text);
      options.WriteBool('LastState','cbOfflineMaps',ClearTempOptions_cbOfflineMaps.Checked);
      options.WriteString('LastState','comboMaps',ClearTempOptions_comboMaps.Text);
      options.WriteBool('LastState','cbOfflineInc',ClearTempOptions_cbOfflineInc.Checked);
      options.WriteString('LastState','comboInc',ClearTempOptions_comboInc.Text);
    end;
  finally
    options.Free;
  end;
  
  {oznaceni vsech v seznamu}
  for i := 0 to ClearTempConfirmDelete_lbDeleteFiles.Items.Count - 1 do
    ClearTempConfirmDelete_lbDeleteFiles.Selected[i] := True;
  
  {popisek s poctem nalezu}
  ClearTempConfirmDelete_lblCount.Caption := IntToStr(ClearTempConfirmDelete_lbDeleteFiles.Items.Count);
  
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
  
  {smazani prazdnych slozek}
  GeoBusyCaption(_('Clean up!'));
  DeleteEmptyFolders(GEOGET_DATADIR+'\offline');
end;
