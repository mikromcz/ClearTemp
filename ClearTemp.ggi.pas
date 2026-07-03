{
  GeoGet 2
  www: http://geoget.ararat.cz/doku.php/user:skript:cleartemp

  Autor: mikrom, http://mikrom.cz
  Fórum: https://forum.geocaching.cz/t/clearcache-cleartemp-plugin-pro-mazani-nepotrebnych-souboru/16523
}

function InstallWork: String;
begin
  {uklid po starsich verzich}
  if FileExists(GEOGET_SCRIPTDIR+'\ClearTemp\ClearTempForm.gfm') then DeleteFile(GEOGET_SCRIPTDIR+'\ClearTemp\ClearTempForm.gfm');

  {changelog}
  if FileExists(GEOGET_SCRIPTDIR + '\ClearTemp\ClearTemp.changelog.txt') then ShowLongMessage('Changelog', FileToString(GEOGET_SCRIPTDIR + '\ClearTemp\ClearTemp.changelog.txt'));

  Result :='';  // probehlo bez chyby
end;
