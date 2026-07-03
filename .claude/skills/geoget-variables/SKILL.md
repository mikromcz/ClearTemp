====== Předdefinované proměnné ======
Tyto proměnné lze použít ve [[:user:skripty|skriptech]] GeoGetu.

===== Obecné proměnné =====
  * ''CRLF'' - řetězec obsahující odřádkování
  * ''GC'' - objekt třídy [[http://www.geoget.cz/help/geo.TGeo.html|TGeo]] popisující právě zpracovávanou geocache (waypoint je třídy [[http://www.geoget.cz/help/geo.TWpt.html|TWpt]])
  * ''GEOGET_COLUMNS'' - objekt třídy [[http://www.geoget.cz/help/geocol.TColList.html|TColList]] či [[http://www.geoget.cz/help/geocol.TColRec.html|TColRec]] obsahující právě používanou sadu sloupců.
  * ''GEOGET_DATADIR'' - cesta k datovému adresáři (cesta neobsahuje koncové ''\'')
  * ''GEOGET_LOCALDATADIR'' - cesta k datům, které jsou specifické pro lokální počítač a nemá smysl je kopírovat při přenosu GeoGetu nebo jeho dat na jiný počítač. (cesta neobsahuje koncové ''\'')
  * ''GEOGET_COMMONDATADIR'' - cesta k datům, které jsou společná pro všechny uživatele počítače nebo při několika používaných ''DATADIR'' jedním uživatelem. Například SRTM data. (cesta neobsahuje koncové ''\'')
  * ''GEOGET_DB'' - objekt třídy [[http://www.geoget.cz/help/SQLiteWrap.TSQLiteDatabase.html|TSQliteDatabase]] popisující otevřenou databázi GeoGetu
  * ''GEOGET_DBNAME'' - název právě používané databáze<sup>2.2.5</sup>
  * ''GEOGET_FILTEREDSEARCH'' -příznak filtrovaného hledání<sup>2.9.1</sup>
  * ''GEOGET_GUIFILTER'' - instance [[http://www.geoget.cz/help/GeoFilter.TGeoFilter.html|TGeoFilter]] užívaná k filtrování dat v GUI<sup>2.3.0</sup>
  * ''GEOGET_HTTPPORT'' - port, na kterém běží HTTP server pro zobrazení GeoGetí mapy<sup>2.10.0</sup>
  * ''GEOGET_HTTPREFERER'' - nastaví HTTP Referer podle potřeby<sup>2.2.2</sup>
  * ''GEOGET_HWND'' - handle formuláře GeoGetu
  * ''GEOGET_MAXCOUNT'' - orientační počet celkově zpracovávaných bodů u skriptů
  * ''GEOGET_OWNER'' - jméno uživatele na geocaching.com vyplněné v programu GeoGet
  * ''GEOGET_OWNERS'' - jména všech uživatelů vyplněných v programu GeoGet oddělených čárkou <sup>2.5.12</sup>
  * ''GEOGET_OWNERPREMIUM'' - boolean proměnná vrací true pokud je uživatel PM FIXME<sup>2.9.4</sup>
  * ''GEOGET_PROGPATH'' - cesta k adresáři s programem (cesta obsahuje koncové ''\'')<sup>2.2.2</sup>
  * ''GEOGET_PROXYHOST'' - adresa HTTP proxy serveru z konfigurace GeoGetu
  * ''GEOGET_PROXYPORT'' - TCP Port HTTP proxy serveru z konfigurace GeoGetu
  * ''GEOGET_PROXYUSER'' - přihlašovací jméno pro HTTP proxy server z konfigurace GeoGetu
  * ''GEOGET_PROXYPASS'' - přihlašovací heslo pro HTTP proxy server z konfigurace GeoGetu
  * ''GEOGET_REFNAME'' - jméno právě zvoleného referenčního bodu
  * ''GEOGET_REFX'' - souřadnice právě zvoleného referenčního bodu (Lat.)
  * ''GEOGET_REFY'' - souřadnice právě zvoleného referenčního bodu (Lon.)
  * ''GEOGET_SCRIPTDIR'' - cesta k adresáři se skripty (cesta neobsahuje koncové ''\'')
  * ''GEOGET_SCRIPTFULLNAME'' - jméno souboru s vykonávaným skriptem včetně plné cesty
  * ''GEOGET_SCRIPTFULLPATH'' - plná cesta k vykonávanému skriptu <sup>[[http://www.geocaching.cz/topic/33133-předdefinovaná-proměnná-cesta-do-složky-se-skriptem/?p=602919|forum]]</sup>
  * ''GEOGET_SCRIPTNAME'' - jméno souboru s vykonávaným skriptem
  * ''GEOGET_SCRIPTPARENT'' - obsahuje jméno a plnou cestu ke skriptu, ze kterého byl právě prováděný skript zavolán. Pokud byl skript zavolán primo z GeoGetu, pak je obsahem prázdný string <sup>2.7.7</sup>
  * ''GEOGET_SILENTINSTALL'' - true, pokud probíhá instalace balíčku v tichém režimu (vhodné pro instalaci přes balík EasyInstall)
  * ''GEOGET_VERSION'' - řetězec s verzí GeoGetu
  * ''GEOGET_VISBGCOLOR'' - vizualizační skripty - nastavuje barvu pozadí (např. ''clGreen'')
  * ''GEOGET_VISDATA'' - binární data obsahující obrázek pro vizualizační skript [[user:skripty:ggv|GGV]]
  * ''GEOGET_VISID'' - vizualizační skripty - ID právě zpracovávaného bodu
  * ''GEOGET_VISID2'' - vizualizační skripty - prefix právě zpracovávaného waypointu (prázdný při zpracování keše)
  * ''SCREEN'' - objekt třídy TScreen popisující obrazovku počítače (rozlišení apod.)