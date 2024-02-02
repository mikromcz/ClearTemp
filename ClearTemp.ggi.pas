function InstallWork: String;
begin
  Result := '';
  if FileExists(GEOGET_SCRIPTDIR+'\ClearTemp\ClearTempForm.gfm') then DeleteFile(GEOGET_SCRIPTDIR+'\ClearTemp\ClearTempForm.gfm');
end;
