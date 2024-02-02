function InstallWork: String;
begin
  {uklid po starsich verzich}
  if FileExists(GEOGET_SCRIPTDIR+'\ClearTemp\ClearTempForm.gfm') then DeleteFile(GEOGET_SCRIPTDIR+'\ClearTemp\ClearTempForm.gfm');

  {changelog}
  if FileExists(GEOGET_SCRIPTDIR + '\ClearTemp\ClearTemp.changelog.txt') then ShowLongMessage('Changelog', FileToString(GEOGET_SCRIPTDIR + '\ClearTemp\ClearTemp.changelog.txt'));

  Result :='';  // probehlo bez chyby
end;
