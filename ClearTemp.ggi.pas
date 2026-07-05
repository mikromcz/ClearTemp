{
  GeoGet 2
  www: http://geoget.ararat.cz/doku.php/user:skript:cleartemp

  Autor: mikrom, http://mikrom.cz
  Fórum: https://forum.geocaching.cz/t/clearcache-cleartemp-plugin-pro-mazani-nepotrebnych-souboru/16523
  Verze: 0.3.2

  Instalacni skript - spusti se jednou pri instalaci/aktualizaci pluginu (viz script=
  v ClearTemp.meta.ini). Uklizi soubory po starsich verzich a zobrazuje changelog.
}

// ==============================================================================
//   Hlavni vstupni bod instalace
// ==============================================================================

function InstallWork: String;
begin
  // Uklid po starsich verzich
  if FileExists(GEOGET_SCRIPTDIR+'\ClearTemp\ClearTempForm.gfm') then DeleteFile(GEOGET_SCRIPTDIR+'\ClearTemp\ClearTempForm.gfm');

  // Changelog
  if FileExists(GEOGET_SCRIPTDIR + '\ClearTemp\ClearTemp.changelog.txt') then ShowLongMessage('Changelog', FileToString(GEOGET_SCRIPTDIR + '\ClearTemp\ClearTemp.changelog.txt'));

  Result :='';  // Probehlo bez chyby
end;
