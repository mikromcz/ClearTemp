====== Předdefinované funkce ======
Tyto funkce lze použít ve [[:user:skripty|skriptech]] GeoGetu. Proměnné programu naleznete [[:user:skripty:variables|zde]].

===== Obecné funkce =====
<code delphi>function RunExec(Value: string): integer;</code>
  * Zavolá externí program a vrací jeho návratový kód.

<code delphi>function RunExecNoWait(Value: string): boolean;</code>
  * Zavolá externí program, ale nečeká na jeho ukončení. Spustí jej v novém vlákně. <sup>2.4.0</sup>

<code delphi>procedure RunShell(Value: string);</code>
  * Zavolá obsah přes shell operačního systému. Například pokud je **Value** URL adresa webové stránky, bude otevřena **ve výchozím** internetovém prohlížeči.

<code delphi>function BrowseURL(const URL: string): boolean</code>
  * Otevře odkaz v prohlížeči **definovaném v nastavení** GeoGetu.<sup>2.5.15</sup>

<code delphi>procedure Sleep(Value: integer);</code>
  * Počká definovaný počet milisekund.

<code delphi>function GetTick: longword;</code>
  * Vrací hodnotu interního čítače systému. Pokud ale systém umožňuje precizní měření času, funguje s přesností na jednotky milisekund! Rozdíl dvou hodnot se dá použít na měření uplynulého času. <sup>2.4.0</sup>

<code delphi>function HttpAsk(const Method, Url, UploadType, Upload: string; var Download: string): boolean;</code>
  * Provede HTTP/HTTPS dotaz na nějakou webovou stránku. **Method** je název HTTP metody, například 'GET', nebo 'POST'. **Url** je požadované URL. Může obsahovat i HTTP autorizační údaje. **UploadType** je případný MIME-type pro uploadovaná data. Pokud jej nechcete použít, použijte prázdný string. **Upload** obsahuje uploadovaná data. A **Download** obsahuje stáhnutá data. Funkce vrací //True//, pokud komunikace proběhla v pořádku.

<code delphi>function HttpAskUA(const Method, Url, UploadType, Upload, UserAgent: string; var Download: string): boolean;</code>
  * Provede HTTP/HTTPS dotaz na webovou stránku. Na rozdíl od ''HttpAsk()'' umožňuje nastavit hodnotu **User Agent**
  * <wrap tip>Hack:</wrap> funkci lze využít k zadávání i jiných parametrů než je **User Agent** do hlavičky HTTP/HTTPS požadavku
    * za hodnotu **User Agent** přidejte CRLF a  pak další parametr, který má být v hlavičce. Může jich být i několik, odělovačem je vždy CRLF
    * pokud nechcete **User Agent** zadávat, bude na začátku rovnou CRLF
    * tento postup pravděpodobně nebude účinný u parametrů, které GeoGet posílá automaticky
    * jako příklad muže být odeslání přihlašovacích údajů
<WRAP 92% right>
<code delphi>//běžně by se použilo
   Url:=https://uživatel:heslo@server.com/...;
//ale je také možné použít běžné Url a nastavit
   UserAgent:=CRLF+'Authorization uživatel heslo';
</code>
</WRAP>
<WRAP clear></WRAP>
    * :!: pokud volání webové stránky vrátí chybovou hodnotu, funkce se vrátí hodnotu ''false'', do návratové proměnné **Download** nepřepíše vrácený text a nebude možné zjisti podrobnosti o chybě ani její číslo (do verze <sup>2.11.5</sup>), od verze <sup>2.11.6</sup> je výsledný dokument vrácen vždy, pokud bylo něco posláno, i když funkce skončí chybou

<code delphi>HttpResultCode():integerl</code>
  * funkce vrací návratovou hodnotu z předchozího volání HttpAsk() nebo HttpAskUA() <sup>2.11.6</sup>

<code delphi>HttpResultHeaders():string;</code>
  * funkce vrací http hlavičku z předchozího volání HttpAsk() nebo HttpAskUA() <sup>2.11.6</sup>

<code delphi>function UDPAsk(target, port, value: AnsiString; timeout:integer): AnsiString;</code>
  * provede UPD dotaz a čeká ''timeout'' milisekund na odpověď, pokud nepřijde, vrací prázdný string <sup>2.9.13</sup>
  * funguje to jak na obecné UDP, tak i na multicasty
  * lze pouzit IPv4 i IPv6
  * target je string s IP adresou, nebo doménovým jménem
  * port je symbolický název portu nebo jeho číslo (proto je to string)
  * value jsou data, která budou odeslána
  * timeout je čas v milisekundách, který funkce čeká na odpověď

<code delphi>function FormatFloat(const Format: string; Value: extended): string;</code>
  * Převede floating-point číslo do textové podoby. Více viz [[http://delphi.about.com/library/rtl/blrtlFormatFloat.htm]].

<code delphi>function FlToStr(Value: extended): string;</code>
  * Převede floating-point číslo do textové podoby. Výsledek vždy obsahuje desetinnou tečku, lhostejno na nastavení systému.

<code delphi>function StrToFl(Value: string): extended;</code>
  * Převede floating-point číslo v textové podobě. Je jedno, jestli vstup obsahuje desetinou tečku nebo čárku.

<code delphi>function DateToInt(Value: TDateTime): string;</code>
  * Převede datum do formátu //yyyymmdd//.

<code delphi>function IntToDate(Value: string): TDateTime;</code>
  * Převede řetězec ve formátu //yyyymmdd// na datum.

<code delphi>function SrtmElevation(x, y: extended; srtmpath: string): integer;</code>
  * Pokusí se zjistit výšku bodu pomocí [[:download#srtm_vyskova_data|SRTM]] souborů v zadané cestě (musí končit zpětným lomítkem!). Pokud nelze zjistit výšku bodu, je vrácena výška //-32768//.

<code delphi> ParseWgsStr(const Value: string; var X, Y: extended): boolean;</code>
  * Převede souřadnice z ''Value'' na desetinný formát. Zvládá velké množství formátů souřadnic jako funkce CoordEdit().

<code delphi>procedure WGStoUTM(Lat, Lon: extended; Force33u: boolean; out Northing, Easting: extended; out Zone: integer; out ZoneChar: char);</code>
  * Převod souřadnic z WGS-84 do UTM.

<code delphi>procedure UTMtoWGS(Northing, Easting: extended; Zone: integer; Zonechar: char; out Lat, Lon: extended);</code>
  * Převod souřadnic z UTM do WGS-84. <sup>2.5.10</sup>

<code delphi>procedure UTMtoMCZ(Northing, Easting: extended; out North, East: string);</code>
  * Převod UTM souřadnic s vynucenou zónou U33 na souřadnicový systém používaný na serveru [[http://www.mapy.cz|mapy.cz]].

<code delphi>function FormatCoordNum(X, Y: extended): string;</code>
  * Převede souřadnice do textové podoby určené ke čtení člověkem (''N50°12.345' E015°12.345'''). Výstup je kódován v ANSI. [[user:skripty:functions#string|Pozor na význam Ansi!]]

<code delphi>function zCompress(const Value: string): string;</code>
  * Zkomprimovat předaná data pomocí knihovny //zlib//. Vhodné pro přímé zasahování do databáze GeoGetu (pro sloupce, které jsou tímto způsobem komprimovány). <sup>2.2.1</sup>

<code delphi>function zDecompress(const Value: string): string;</code>
  * Dekomprimovat data pomocí knihovny //zlib//. Vhodné pro přímé čtení dat z databáze GeoGetu. <sup>2.2.1</sup>

<code delphi>function ExpandEnvir(Value: string): string;</code>
  * Ve stringu **Value** nahrazuje sekvence %nazev_promenne% jejich hodnotami. <sup>2.5.7</sup>

<code delphi>function GetEnvir(Name: string): string;</code>
  * Dostává jen jméno proměnné a vrací její hodnotu. <sup>2.5.7</sup>

<code delphi>procedure ConsoleInfo(Value: string);</code>
  * Slouží na psaní do chybové konzole. <sup>2.3.7</sup>

<code delphi>procedure ConsoleError(Value: string);</code>
  * Slouží na psaní do chybové konzole. <sup>2.3.7</sup>

<code delphi>function PostMessage(hWnd: integer; Msg: integer; wParam: integer; lParam: integer): longbool;</code>
  * Obsluha systémových zpráv Windows. Funkce umožní skriptu obsluhovat libovolnou systémovou zprávu. :!: Použití této funkce vyžaduje znalosti na úrovni programování Windows API. <sup>2.2.6</sup>

<code delphi>function SendMessage(hWnd: integer; Msg: integer; wParam: integer; lParam: integer): integer;</code>
  * Odeslání zprávy do fronty systémových zpráv k obsluze systémem Windows. To umožňuje např. manipulaci s okny aplikací, nastavování vlastností ovládacím prvkům tam, kde k tomu není k dispozici odpovídající funkce v GeoGetím API. :!: Použití této funkce vyžaduje znalosti na úrovni programování Windows API. <sup>2.2.6</sup>

<code delphi>procedure GeoSetFilteredSearch(value: integer);</code>
  * Ovládání filtrovaného hledání (hodnota **1** jej zapíná, **0** jej vypíná). S tím souvisí proměnná ''Geoget_FilteredSearch''.<sup>2.9.1</sup>

<code delphi>GetListing(const value: TStrings; prefix: string);</code>
  * Metoda TGeo vygeneruje HTML listing a ještě u obrázků přepíše prefix.

<code delphi>SQLiteRegisterUDF(const value: TSQLiteDatabase);</code>
  * funkce pro SQL příkazy nad zadanou databází registruje funkce, které nejsou standardně použitelné, ale Geoget je používá
  * pro databázi otvíranou přímo Geogetem není volání potřeba, jen pro použití databáze jen v pluginu, pokud jsou takové funkce potřeba
  * jedná se např. o funkce:
    * komprese, dekomprese (zlib)
    * REGEXP v SQL

===== Funkce GC.Live =====

**Od verze 2.10 již GeoGet funkce GC.Live nepodporuje, proto některé byly převedeny a vnitřně používají GC.API a některé byly zrušeny.** Převedené funkce mohou mít funkčnost mírně pozměněnou v závislosti na možnostech GC.API.

<code delphi>function GcLiveGetLogs(const ID: string; Numlogs: integer; StopOnFound, Refine: boolean): integer;</code>
  * Stažení logů k bodu s ''ID''.<sup>2.6.2</sup>

<code delphi>procedure GcLiveUpdateStatus(const IDs: string)</code>
  * Aktualizovat stav. ''ID'' je jeden GC kód, ''IDs'' může být více kódů najednou, oddělené odřádkováním.<sup>2.6.2</sup>

<code delphi>procedure GcLiveUpdateListing(const IDs: string; Lite: boolean)</code>
  * Aktualizovat listing. ''ID'' je jeden GC kód, ''IDs'' může být více kódů najednou, oddělené odřádkováním.<sup>2.6.2</sup>

<code delphi>procedure GcLiveUpdateListing2(const IDs: string; mode:integer)</code>
  * Aktualizovat listing. ''ID'' je jeden GC kód, ''IDs'' může být více kódů najednou, oddělené odřádkováním.<sup>2.9.4</sup>
  * ''mode'' definuje režim získámí dat (0=FULL, 1=LITE, 2=SUMMARY)

<code delphi>procedure GCLiveGetListing(par: TGCLSearch)
  TGCLSearch = record
    cx: double;            //souřadnice středu kruhu (Latitude), v kterém budou keše vyhledávány
    cy: double;            //(Lognitude)
    cr: double;            //poloměr kruhu v km, hledani podle souradnic se vypne cr=0.
    islite: boolean;       //plný (false) nebo lite (true) listing !! od verze 2.9.2 nahrazeno položkou mode
    cachetypes: string;    //seznam typů keší (plné stringy používané na GC, oddělovač ''CRLF'')
    cachesizes: string;    //seznam požadovaných velikostí (plné stringy používané na GC, oddělovač ''CRLF'')
    available: integer;    //0=jen neaktivní, 1=jen aktivní, 2=aktivní i neaktivní
    archived: integer;     //0=jen nearchivované, 1=jen archivované, 2=archivované i nearchivované
    pmo: integer;          //0=jen nePMO, 1=jen PMO, 2=PMO i nePMO
    ignorelist: boolean;   //true=aplikovat nastavený ignorelist
    notfoundby: string;    //seznam nicků, které keš nesmějí mít nalezenou (oddělovačem je ''CRLF'')
    hiddenby: string;      //seznam nicků ownerů keší (oddělovačem je ''CRLF'')
    nothiddenby: string;   //seznam nicků, kteří nesmějí být ownery keší (oddělovačem je ''CRLF'')
    //od verze 2.9.2+:
    mode: integer;         //0=full, 1=lite, 2=summary
    country: string;       //seznam jmen států (oddělovačem je ''CRLF'')
    state: string;         //seznam jmen krajů (oddělovačem je ''CRLF'')
  end;</code>
  * Stáhne listingy keší, které odpovídají obsahu vstupní struktury. Nové keše (ty, které ještě nejsou v databázi) jsou do databáze doplněny, ostatní aktulizovány.<sup>2.6.4 - 2.9</sup>

<code delphi>function GCLiveGetUserLogs(const value: string): integer</code>
  * Stáhne všechny logy zadaného uživatele. Jméno uživatele musí být v UTF-8. <sup>2.6.4</sup>

<code delphi>function GCLiveUpdateUserLogs(const value: string): integer</code>
  * Aktualizuje logy zadaného uživatele. Pokud je zadaný uživatel shodný s uživatelem přihlášeným ke GC.Live, funkce akutalizuje jeho logy. To znamená, že stáhne logy, které jsou na serveru z doby pozdější než kdy byly naposledy načteny nebo aktualizovány. Pokud je zadaný uživatel jiný, je funkce shodná s ''GCLiveGetUserLogs''. Jméno uživatele musí být v UTF-8. <sup>2.7.9</sup>

<code delphi>function GCLiveSelectBookmark: string</code>
  * Vyvolá dialog na výběr bookmarku a pokud bude nějaký vybrán, je vrácen jeho GUID.<sup>2.7.2</sup>

<code delphi>function GCLiveAddToBookmark(const ids: string; guid: string)</code>
  * Přidá seznam GC kódů (oddělené odřádkováním) do bookmarku.<sup>2.7.2</sup>

<code delphi>procedure GCLiveLoadBookmark(guid: string)</code>
  * Zobrazí keše bookmarku do seznamu zobrazených keší. Keše musí být v databázi.<sup>2.7.2</sup>

<code delphi>procedure GCLiveImportBookmark(guid: string)</code>
  * Importuje keše z bookmarku do databáze. Keše, které již v databázi jsou, nejsou znovu importovány.<sup>2.7.2</sup>

<code delphi>function GCLiveGetBookmark(guid: string): string</code>
  * Vrací GC kódy obsažené v bookmarku, jednotlivé GC kódy jsou oddělené pomocí ''CRLF''.<sup>2.7.3</sup>

<hidden onHidden=":?: **Zobrazit nepodporované funkce GC.Live**" onVisible="Skrýt nepodporované funkce GC.Live">

<code delphi>function GCliveCall(DataFormat: integer; ApiFunction, ApiUrlParam, ApiData: string; var ApiResponse: string): integer</code>
  * Při volání se nikde neuvádí ''AccessToken''! Ani v URL parametrech, ani v ''ApiData''! Ten si GeoGet doplní sám. Pokud Token není, GeoGet sám vyvolá přihlášení. Při chybě sám ukáže chybový dialog, pro vybrané chybové kódy sám nabízí opakování operace, atd. prostě tak, jak to znáte z funkcí GeoGetu.
    * ''DataFormat'': 0-XML, 1-JSON
    * ''ApiFunction'': název APi funkce. Třeba ''GetAPILimits''
    * ''ApiUrlParam'': URL parametry pro volání (pro GET požadavky)
    * ''ApiData'': Odesílaný dokument. (pro POST) Musí být kódovaný dle ''DataFormat''!
    * ''ApiResponse'': odpověď serveru, bude opět kódovaná v ''DataFormat''.
    * ''Result'': z odpovědi vytáhnutý stavový kód odpovědi. 0=OK.
  * Popis možných APi funkcí: [[https://api.groundspeak.com/LiveV6/geocaching.svc/help]]
  * nebo trochu obecněji: [[http://application.globalcaching.eu/devdoc/namespace_globalcaching_application_1_1_utils_1_1_a_p_i.html]]
  * Priklad:<code delphi>var
  r: string;
  x: integer;
begin
  x := GCliveCall(0, 'GetAPILimits', '', '', r);
  showmessage(inttostr(x));
  stringtofile(r, 'gclive.txt');
end;</code>

<code delphi>procedure GCLiveDoSearch(const value: string; mode: integer);</code>
  * vyhledání keší pomocí GC.Live a jejich import do Geogetu ''ID''.<sup>2.9.7 - 2.9</sup>
  * ''value'' je JSON string s API dotazem pro ''SearchForGeocaches()'' (funkce GC.LIve API) vcetne IsLite parametru (i kdyz je to jeste v parametru ''mode''!). Geoget před voláním doplní do stringu ''token''
  * ''mode'' je 0=full, 1=lite, 2=summary
  * funkce sama načítá všechny stránky s kešemi voláním ''GetMoreGeocaches()'' (funkce GC.LIve API) a keše importuje do databáze

</hidden>
<html></html>


===== Funkce API GC =====
Pro volání jsou třeba parametry:
  * **ApiMethod** - HTTP metoda volání. Používá se GET, PUT, POST, DELETE.
  * **ApiUri** - část URL se specifikací volané funkce. Z bezpečnostních důvodů si Geoget sám doplňuje adresu serveru a první lomítko. tedy například "//v1/users//".
  * **ApiData** - Odesílaná data mimo URL.
  * **ApiDataMime** - označení druhu odesílaných dat podle standardu MIME.
  * **Apiresponse** - odpověď serveru

<code delphi>function GCliveRest(ApiMethod, ApiUri, ApiData, ApiDataMime: string; var ApiResponse: string): integer;</code>
  * vyvolání funkce API, vrací odpověď a hodnotu chybového stavu<sup>2.10</sup>

<code delphi>function GCliveRestPaged(ApiMethod, ApiUri, ApiData, ApiDataMime: string; PageSize: integer; var ApiResponse: string): integer;</code>
  * vyvolání funkce API, vrací odpověď a hodnotu chybového stavu<sup>2.10</sup>
  * automaticky stránkuje, všechny odpovědi vrací najednou

<code delphi>function GCLImportCachePaged(const value: string): integer;</code>
  * vyhledávání keší podle vlastních kritérií<sup>2.10</sup>
  * Volá funkci "v1/geocaches/search", vstupní hodnota jsou vyhledávací parametry, které se přidají na konec URL. (Nepoužívat parametry **take** a **skip**!)
  * importuje postupně každou vrácenou stránku s vyhledanými kešemi samostatně (ne najednou všechny stránky)

==== Parsování JSON odpovědi z API GC ====
<WRAP 97% right>
S API se komunikuje výhradně ve formátu JSON. Pro zpracování odpovědí existuje v GeoGetu parser, po jeho vložení

<code delphi>
uses simplejson;
</code>

je k dispozici objekt:

<code delphi>
type
  TSimpleJSon = class(TObject)
  public
    constructor create;
    procedure Free;
    function ParseString(value: AnsiString): Boolean;
    function AsString(path: string): String;
    function AsInteger(path: string): int64;
    function AsDouble(path: string): double;
    function AsArraySize(path: string): integer;
  end;
 </code>

Funkce asBoolean neexistuje, lze ji nahradit konstrukcí:

<code delphi>
  b:boolean;
  json:TSimpleJSON;
  ...
  b:=(json.AsInteger(path)=1);
</code>

K jednotlivým prvkům v objektu je pak přístup přes ''path'', např.:

<code delphi>
foo      // objekt
foo.list // vlastnost objektu
foo[123] // prvek pole objektu. Indexováno od nuly, počet prvků pole by mělo vrátit volání metody AsArraySize.
</code>

Pro jednodužší zpracování vrácených polí je rozumné vrácenému poli předřadit fiktivní jméno prvku a na něj se pak odkazovat.
<code delphi>
uses simplejson;
...
var rJson:TSimpleJSon;
...
if(GcLiveRest('GET',sRequest,'','',sJson)=200) then begin
  //predpokladejme, ze je vraceno pole '[{..},{..},...]', udelame z nej pole prvku 'root'
  sJson:='{root:'+sJson+'}';
  rJson:=TSimpleJson.Create();
  try
    if(rJson.ParseString(sJson)) then begin
      nLogs:=rJSon.AsArraySize('root');
      for i:=0 to nLogs-1 do begin //zpracujeme vsechny logy
        //odkazujeme se na prislusne pole prvku 'root[i]' a jeho vnorenou hodnotu 'geocacheCode'
        sGcId:=rJson.asString('root['+IntToStr(i)+'].geocacheCode');
        ...
      end;
    end;
  finally
    rJson.Free();
  end;
end;
</code>
</WRAP>
<WRAP clear></WRAP>


===== Převody data a času =====
<code delphi>function UTCtoLocal(Value: TDateTime): TDateTime;</code>
  * Konverze času z UTC do lokálního časového pásma počítače. Výpočet bere ohled na letní čas v aktuálním nastavení počítače.

<code delphi>function LocalToUTC(Value: TDateTime): TDateTime;</code>
  * Konverze času z lokálního časového pásma počítače do UTC. Výpočet bere ohled na letní čas v aktuálním nastavení počítače.

<code delphi>function UTCtoTimezone(Value: TDateTime; Timezone: string): TDateTime;</code>
  * Konverze času z UTC do časové zóny. Výpočet bere ohled na letní čas v zadané hodnotě ''Value''. <sup>2.7.4</sup>

<code delphi>function TimezoneToUTC(Value: TDateTime; Timezone: string): TDateTime;</code>
  * Konverze časové zóny do UTC. Výpočet bere ohled na letní čas v zadané hodnotě ''Value''. <sup>2.7.4</sup>

<code delphi>function GetTimeZoneByCoord(x, y: extended): string;</code>
  * Volá službu od Googlu (limit 2500 dotazů za den), která vrátí časovou zónu podle předaných souřadnic <sup>2.7.4</sup>

===== Práce s řetězci =====
==== Převody kódování ====
=== String ===
  * <wrap important>Od verze 2.8 je proměnná **string** kodovaná v UNICODE (UTF-16)</wrap> a pro převod z/do kódování UTF-8 se používá funkce ''AnsiToUtf()'' nebo ''UtfToAnsi()''. Ansi je ve jménech funkcí zachováno pro zpětnou kompatibilitu s předchozími verzemi GeoGetu.
  * <wrap important> Ansi</wrap> ve jméně funkcí tedy znamená spíš **string v nativním Geogetím kódování** (UNICODE) než //string v nativním Windows kódování//.
  * <wrap important> Utf</wrap> ve jméně funkcí tedy znamená UTF-8 a ne UNICODE nebo UTF-16

<code delphi>function UtfToAscii(Value: string): string;</code>
  * Provede odstranění diakritiky.

<code delphi>function UtfToGps(Value: string): string;</code>
  * Odstraní diakritiku, převede řetězec na velká písmena a propustí jen vybranou množinu speciálních symbolů tak, aby výsledný řetězec byl kompatibilní s nejúspornějším šestibitovým kódováním u GPS Garmin.

<code delphi>function UtfToAnsi(Value: string): string;</code>
  * Převede řetězec do ANSI kódování. [[user:skripty:functions#string|Pozor na význam Ansi!]]

<code delphi>function AnsiToOem(const Value: string): string;</code>
  * Konverze z ANSI do OEM kódové stránky příkazové řádky. [[user:skripty:functions#string|Pozor na význam Ansi!]]

<code delphi>function UtfToCharset(const Value, Charset: string): string;</code>
  * Převod z UTF-8 kódování do libovolného jiného.

<code delphi>function CharsetToUtf(const Value, Charset: string): string;</code>
  * Převod z libovolného kódování do UTF-8. <sup>2.2.2</sup>

<code delphi>function UnicodeBOM(const Charset: string): string;</code>
  * Vrací Byte Order Mark pro zvolené kódování. Pokud zvolené kódování nepoužívá BOM, je vrácen prázdný string.

<code delphi>function AnsiToUtf(const Value: string): string;</code>
  * Konverze z ANSI do UTF-8 kódové stránky. [[user:skripty:functions#string|Pozor na význam Ansi!]]

<code delphi>function IsUtf(const Value: AnsiString): boolean</code>
  * Testuje, zda je vstupní string kódován v UTF-8 kódování. <sup>2.7.7</sup>

==== Práce s texty ====
<code delphi>function IsValidID(Value: string): boolean;</code>
  * Testuje, jestli řetězec může být kód kešky/waypointu.

<code delphi>function IsValidGC(Value: string): boolean;</code>
  * Testuje, jestli řetězec může být kód kešky //(GCxxxx)//.

<code delphi>function IsValidWM(Value: string): boolean;</code>
  * Testuje, jestli řetězec může být kód waymarku //(WMxxxx)//.

<code delphi>function IsGuid(Value: string): boolean;</code>
  * Testuje, jestli řetězec je GUID.

<code delphi>function ReplaceString(Value, Search, Replace: string): string;</code>
  * Nahradí v řetězci všechny výskyty jednoto řetězce za druhý.

<code delphi>function Fetch(var Value: string; const Delimiter: string): string;</code>
  * //Ukousne// ze začátku ''Value'' kus řetězce až po nejbližší ''Delimiter''. Po ukousnutí je zbytek ''Value'' ještě zbaven koncových a počátečních bílých znaků (''Trim'').

<code delphi>function FetchBin(var Value: string; const Delimiter: string): string;</code>
  * //Ukousne// ze začátku ''Value'' kus řetězce až po nejbližší ''Delimiter''. Zbytek ''Value'' není zbaven počátečních a koncových bílých znaků (''Trim''). Vhodné pro zpracování binárních dat.

<code delphi>function SeparateLeft(const Value, Delimiter: string): string;</code>
  * Vrací část řetězce ''Value'' vlevo od zadaného separátoru (''Delimiter'').

<code delphi>function SeparateRight(const Value, Delimiter: string): string;</code>
  * Vrací část řetězce ''Value'' vpravo od zadaného separátoru (''Delimiter'').

<code delphi>function Rot13(Value: string): string;</code>
  * Provede ROT13 kódování.

<code delphi>function Reverse(Value: string): string;</code>
  * Obrátí obsah ''Value'' pozpátku.

<code delphi>function CData(Value: string): string;</code>
  * Používá se na zakódování dat pro XML element.

<code delphi>function QuoteStr(const Value: string; Quote: char): string;</code>
  * Zabalí řetězec do udaného znaku, a pokud se uvnitř ten znak vyskytuje, zdvojí jej.

<code delphi>function DecodeBase64(const Value: string): string;</code>
  * Dekóduje data v kódování BASE64.

<code delphi>function EncodeBase64(const Value: string): string;</code>
  * Zakóduje data do kódování BASE64.

<code delphi>function HtmlImg2Link(const Value: string): string;</code>
  * Nahradí všechny vložené HTML obrázky na odkazy.

<code delphi>function Html2Text(const Value: string): string;</code>
  * Převede HTML na prostý text.

<code delphi>function EncodeUrlElement(const Value: string): string;</code>
  * Zakóduje hodnotu tak, aby byla použitelná jako hodnota parametru v URL.

<code delphi>function CompareVer(ValueAsk, ValueCur: string): boolean;</code>
  * Metoda pro porovnávání verzí. Jako verze je předáván řetězec čísel oddělených tečkou, např. "2.1.4.1124". Metoda vrací //True//, pokud je ''ValueAsk'' > ''ValueCur''.

==== Převody entit ====
<code delphi>function HtmlEntityDecode(const Value: string): string;</code>
  * Dekóduje HTML entity na nativní znaky.

<code delphi>function HtmlEntityEncode(const Value: string): string;</code>
  * Zakóduje ne-ASCII znaky do HTML entit.

<code delphi>function HtmlEntityEncodeAll(const Value: string): string;</code>
  * Zakóduje ne-ASCII znaky a kritické znaky do HTML entit.

<code delphi>function XMLEntityDecode(const Value: string): string;</code>
  * Dekóduje XML entity na nativní znaky.

<code delphi>function XMLEntityEncode(const Value: string): string;</code>
  * Zakóduje kritické XML znaky na entity.

<code delphi>function MDtoHTML(value: string): string;</code>
  * Převede text zakódovaný v Markdown na HTML.<sup>2.9.5</sup>

<code delphi>function JSEntityDecode(const value: ansistring): ansistring;</code>
  * Dekóduje text zakódovaný do entit ve formátu \xxxx (unicode, css/javascript).<sup>2.9.9</sup>

<code delphi>function JSEntityEncode(const value: ansistring): ansistring;</code>
  * Zakóduje text do entit do formátu \xxxx (unicode, css/javascript).<sup>2.9.9</sup>

===== Práce s regulárním výrazy =====
Regulární výrazy používají [[https://regex.sorokin.engineer/en/latest/regular_expressions.html|syntaxi podobnou Perlu]].

<code delphi>function RegexFind(const ARegExpr, AInputStr: string): boolean;</code>
  * Zjišťuje, jestli zadaný string odpovídá předané ''ARegExpr'' masce.

<code delphi>function RegexExtract(const ARegExpr, AInputStr: string): string;</code>
  * Vrátí části řetězce, které odpovídají předané ''ARegExpr'' masce. <sup>2.2.4</sup>

<code delphi>function RegexReplace(const ARegExpr, AInputStr, AReplaceStr: string; AUseSubstitution: boolean): string;</code>
  * Vše co odpovídá ''RegExpr'' bude nahrazeno ''ReplaceStr''. Pokud je zapnuta substituce, pak ''ReplaceStr'' obsahuje masku pro nahrazení.

<code delphi>function RegexQuote(const AStr: string): string;</code>
  * Zakóduje speciální znaky v řetězci tak, aby nemohly kolidovat s regulárními výrazy.

<code delphi>function RegExSubstitute(const Expr, Value, Template: string): string;</code>
  * Funkce na získání konkrétního subexpression. <sup>2.4.2</sup>
  * Příklad: <code delphi>s:=RegexSubstitute('(?i)<a\s*href="(.*?)">(.*?)</a>','Text pred tagem<a href="url_adresa">jmeno odkazu</a> text za tagem','$2');</code> vrátí "//jmeno odkazu//".

<code delphi>function RegExSplit(const Expr, Value: string): string;</code>
  * //Rozřádkuje// ''Value'' podle regulárního výrazu. <sup>2.4.2</sup>

===== Práce se soubory =====
<code delphi>function RenameFile(const OldName, NewName: string): boolean;</code>
  * Přejmenuje soubor.

<code delphi>function CopyFile(const OldName, NewName: string): boolean;</code>
  * Zkopíruje soubor.

<code delphi>procedure shCopyFile(FromDir, ToDir: string);</code>
  * Zkopíruje soubory pomocí příkazu shellu. Kopírování by tedy mělo být úspěšné i na zařízení, která se nechovají úplně jako disky (např. připojený HTC telefon a Android 4.1+) <sup>2.7.7</sup>

<code delphi>procedure CopyTree(FromDir, ToDir: string);</code>
  * Zkopíruje složku včetně všech podsložek. <sup>2.5.0</sup>

<code delphi>function DeleteFile(const FileName: string): boolean;</code>
  * Vymaže soubor.

<code delphi>procedure DeleteFiles(Value: string);</code>
  * Vymaže soubory podle předané masky.

<code delphi>function FileExists(const FileName: string): boolean;</code>
  * Testuje zda soubor existuje.

<code delphi>function DirectoryExists(const Directory: string): boolean;</code>
  * Testuje zda adresář existuje.

<code delphi>function ForceDirectories(Dir: string): boolean;</code>
  * Vytvoří adresář.

<code delphi>function DelTree(const Path: string): boolean;</code>
  * Smaže všechny podsložky a soubory v daném adresáři. <sup>2.3.4</sup>

<code delphi>procedure StringToFile(Value, FileName: string);</code>
  * Uloží obsah řetězce do souboru.

<code delphi>function FileToString(filename: string): string;</code>
  * Načte obsah souboru do řetězce.

<code delphi>procedure FileList(Dir: string; const Value: TStrings);</code>
  * Naplní ''StringList'' seznamem souborů v adresáři. Jména podadresářů končí zpětným lomítkem.

<code delphi>function GetFileSize(Value: string): integer;</code>
  * Vrátí velikost souboru.

<code delphi>function GetFileTime(Value: string): TDateTime;</code>
  * Vrátí čas poslední modifikace souboru.

<code delphi>function FtpGetFile(const IP, Port, FileName, LocalFile, User, Pass: string): boolean;</code>
  * Stažení souboru z FTP (v pasivním režimu). <sup>2.5.0</sup>

<code delphi>function FtpPutFile(const IP, Port, FileName, LocalFile, User, Pass: string): boolean;</code>
  * Nahrání souboru na FTP (v pasivním režimu). <sup>2.5.0</sup>

===== Práce s disky =====
<code delphi>function DiskInDrive(Drive: char): boolean;</code>
  * Testuje zda je v jednotce ''Drive'' momentálně přítomen disk? Vhodné např. pro čtečky SD karet a podobně. <sup>2.3.4</sup>

<code delphi>function GetDriveTypeStr(const Drive: char): string;</code>
  * Vrátí typ dané jednotky. Možné hodnoty jsou: "//Unknown drive type//", "//Removable Drive//", "//Hard Disk//", "//Remote Drive//", "//CD-ROM//", "//RAM-Disk//". <sup>2.3.4</sup>

<code delphi>DiskName(Drive: Char): string;</code>
  * Vrátí jméno svazku (jméno partition)

===== Práce s databázemi =====
<code delphi>procedure GeoDBNames(const Value: TStrings);</code>
  * Naplní ''StringList'' seznamem všech databází (včetně záložních). <sup>2.2.5</sup>

<code delphi>procedure GeoDBSelect(Value: string);</code>
  * Zavře aktuální databázi a otevře databázi s udaným jménem. Pokud databáze neexistuje, vyrobí se nová. Stávající databáze ale nesmí mít spuštěnu transakci, jinak bude vyvolána výjimka a běh skriptu se zastaví! <sup>2.2.5</sup>
  * <wrap important></wrap> dojde k vymazání obsahu Busy dialogu


===== Práce s atributy =====
<code delphi>function AttributeToIcon(Value: string): string;</code>
  * Převede popisný text atributu (z PQ, z webu) na jméno ikony. //thorns!// -> //thorn-yes//. <sup>2.2.3</sup>

<code delphi>function AttributeIDToIcon(Value: string): string;</code>
  * Převede ID atributu (z PQ) na jméno ikony. //41// -> //stroller-yes//. <sup>2.2.3</sup>

<code delphi>function IconToAttributePQ(Value: string): string;</code>
  * Převede jméno ikony do jména atributu v PQ. Pokud je atribut "neobsažen", výsledek začíná znakem "-". //stroller-no// -> //-stroller accessible//. <sup>2.2.3</sup>

<code delphi>function IconToAttributeWEB(Value: string): string;</code>
  * Převede jméno ikony do jména atributu na webu. //stroller-no// -> //not stroller accessible//. <sup>2.2.3</sup>

<code delphi>function IconToAttributeID(Value: string): string;</code>
  * Převede jméno ikony do ID v PQ. Pokud je atribut "neobsažen", výsledek začíná znakem "-". //stroller-no// -> //-41//. <sup>2.2.3</sup>

===== Práce s instalačními balíčky =====
<code delphi>function GeoInstallScriptFile(const FileName: string): string;</code>
   * Nainstalovat skript z předaného //*.gip// balíčku. <sup>2.5.0</sup>

<code delphi>function GeoInstallScriptURL(const Url: string): string;</code>
   * Nainstalovat skript z dané URL. Soubor //*.gip// bude nejprve stažen a poté nainstalován. <sup>2.5.0</sup>
   * Není třeba dělat ručně v instalačním skriptu pro případné závislé skripty. GeoGet se o doinstalování závislostí postará sám (pokud je odkaz ke stažení v patřičném ''meta'' souboru definován).

<code delphi>function GeoGetPackages: string;</code>
   * Vrací pomocí ''CRLF'' oddělený seznam nainstalovaných balíčků (plné cesty k ''meta'' souborům). <sup>2.5.0</sup>

<code delphi>function GeoGetPackageVersion(PackageMeta: string): string;</code>
   * Vrací verzi nainstalovaného balíčku. Parametr ''PackageMeta'' je plná cesta k ''meta'' souboru. <sup>2.5.0</sup>

<code delphi>function GeoGetPackagePreviousVersion(PackageMeta: string): string;</code>
   * Vrací předchozí nainstalovanou verzi balíčku. <sup>2.5.0</sup>
   * :!: Tato funkce pracuje správně pouze v případě, že je spouštěna z těla metody ''InstallWork'' instalačního skriptu. V opačném případě vrací verzi aktuálně nainstalovanou.
   * Historie verzí balíčků je uchovávána v souboru ''plver.txt'' v datovém adresáři GeoGetu.
   * Parametrem ''PackageMeta'' může být plná cesta k ''meta'' souboru, ale i jen jeho název či název balíčku.

<code delphi>function GeoGetPackageUpdateVersion(PackageMeta: string): string;</code>
   * Vrací aktuální (nejvyšší) dostupnou verzi balíčku. Parametr ''PackageMeta'' je plná cesta k ''meta'' souboru. <sup>2.5.0</sup>

<code delphi>function GeoUpdatePackage(PackageMeta: string): string;</code>
   * Stáhnout a nainstalovat aktuální dostupnou verzi balíčku. Parametr ''PackageMeta'' je plná cesta k ''meta'' souboru. <sup>2.5.0</sup>

<code delphi>function GeoUninstallPackage(PackageMeta: string): boolean;</code>
   * Odinstalovat balíček. Parametr ''PackageMeta'' je plná cesta k ''meta'' souboru. <sup>2.5.0</sup>

<code delphi>procedure GeoReloadPlugins;</code>
   * Znovu načíst nainstalované pluginy (tedy prohledat adresář //skript//, znovu vykreslit menu a nástrojovou lištu s pluginy). <sup>2.5.0</sup>
   * Akce **není provedena ihned**, ale až po ukončení skriptu a návratu do prostředí GeoGetu.

<code delphi>procedure GeoRefreshHeaders;</code>
  * Znovu načte a uloží aktuální nastavení sloupců. <sup>2.5.12</sup>

===== Práce s menu pluginy a toolbarem plugin =====
   * Funkce umožňují ze skriptů konfigurovat zařazení pluginů do [[user:menu:pluginy|skupin]] a na [[user:menu:toolbary#plugin|toolbar]].
   * Parametr ''plugin'' je vždy plná cesta k ''GGP'' pluginu.
   * Po použití metod je vhodné vyvolat ještě ''refresh toolbaru i menu'' pomocí procedury ''GeoReloadPlugins''.

<code delphi>function GeoGetToolbar(Plugin: string): boolean;</code>
   * Vrací //True//, pokud je ''Plugin'' zařazen na toolbar.

<code delphi>procedure GeoSetToolbar(Plugin: string; Value: boolean);</code>
   * Zařadí či odstraní ''Plugin'' z toolbaru.

<code delphi>function GeoGetPluginGroup(Plugin: string): string;</code>
   * Vrátí skupinu menu, do které je ''Plugin'' zařazen.

<code delphi>function GeoGetDefaultGroup: string;</code>
   * Vrátí jméno výchozí skupiny, do které jsou automaticky zařazovány nově nainstalované pluginy.

<code delphi>procedure GeoSetPluginGroup(Plugin, Value: string);</code>
   * Zařadí ''Plugin'' do skupiny ''Value''.

<code delphi>function GeoListPluginGroups: string;</code>
   * Vrací pomocí ''CRLF'' oddělený seznam existujících skupin pluginů.

<code delphi>function GeoGetPopupMenu(plugin: string): boolean;</code>
   * Vrací //True//, pokud je ''Plugin'' zařazen do popup menu. <sup>2.8.8</sup>

<code delphi>procedure GeoSetPopupMenu(plugin: string; value: boolean;</code>
   * Zařadí ''Plugin'' do položky ''Value'' popup menu. <sup>2.8.8</sup>
===== Práce s tagy =====
<code delphi>procedure GeoTagDelCategory(Value: string);</code>
  * Odstraní z databáze celou kategorii tagů.

''TagCategories'', ''TagHaveCategory'', ''TagValues'', ''TagAdd'', ''TagReplace'', ''TagReplaceList'', ''TagDel'', ''TagClear'' metody třídy [[http://www.geoget.cz/help/geo.TGeo.html|TGeo]].

===== Práce s body =====

Všechny funkce této skupiny počítají hodnoty na elipsoidu WGS84.

<code delphi>procedure PointProject(const Px, Py, Angle, Distance: extended; out Nx, Ny: extended);</code>
  * Projektovat bod ''Nx'', ''Ny'', který je od zadaného výchozího bodu ''Px'', ''Py'' vzdálen ''Distance'' (v kilometrech) v azimutu ''Angle'' (ve stupních). <sup>2.2.3</sup>

<code delphi>function PointDistanceEx(X1, Y1, X2, Y2: extended; var Azimut: extended): extended;</code>
  * Vrátí vzdálenost (v kilometrech) mezi dvěma body. V proměnné ''Azimut'' bude uložen azimut dvou bodů (ve stupních). <sup>2.2.3</sup>

<code delphi>function PointDistance(X1, Y1, X2, Y2: extended): extended;</code>
  * Vrátí vzdálenost dvou bodů v kilometrech.

<code delphi>function PointAzimuth(X1, Y1, X2, Y2: extended): extended;</code>
  * Vrátí azimut dvou bodů ve stupních.

===== Práce s registry =====
Možnost použití tříd ''TRegistry'', ''TRegIniFile'' a ''TRegistryIniFile''. Pro třídu RootKey se používají tyto hodnoty: (např. ''reg.RootKey := $80000001;'') <sup>2.4.3</sup>
<code delphi>
HKEY_CLASSES_ROOT     = $80000000;
HKEY_CURRENT_USER     = $80000001;
HKEY_LOCAL_MACHINE    = $80000002;
HKEY_USERS            = $80000003;
HKEY_PERFORMANCE_DATA = $80000004;
HKEY_CURRENT_CONFIG   = $80000005;
HKEY_DYN_DATA         = $80000006;

KEY_READ              = 131097;</code>
  * RootKey klíčů v registru. <sup>2.5.0</sup>

Pro zápis do ''HKEY_LOCAL_MACHINE'' jsou běžně potřeba administrátorská práva. Pokud potřebujete z HKLM pouze číst, pak stačí objektu třídy ''TRegistry'' nastavit property ''Access'' na ''KEY_READ''. V opačném případě nelze z ''HKLM'' jako běžný uživatel ani číst.

===== Práce s obrázky =====
:!: Všechny následující funkce pro manipulaci s obrázky pracují s jejich textovou interpretací (''string'') na místo objektů třídy ''TImage'' nebo ''TBitmap''. Automaticky je rozpoznáno a podporováno mnoho grafických bitmapových formátů.

<code delphi>function ImageResize(const Value: string; Width, Height: integer; FixAspect, HiQuality: boolean): string;</code>
  * Změní velikost obrázku. ''Width'' a ''Height'' nové rozměry. Parametry ''FixAspect'' a ''HiQuality'' určují, zda má být při změně velikosti zachován poměr stran a zda má být použito kvalitnějšího (a pomalejšího a časově náročnějšího) módu konverze. Návratová hodnota je stringová reprezentace upraveného obrázku. <sup>2.4.0</sup>

<code delphi>function ImageRotate(const Value: string; Angle: double): string;</code>
  * Otočí obrázek o daný úhel. <sup>2.4.0</sup>

<code delphi>function ImageConvert(const Value: string; FileName: string): string;</code>
  * Převede obrázek do jiného formátu. Formát je zvolen automaticky dle předané přípony. <sup>2.4.0</sup>

<code delphi>procedure ImageInfo(const Value: string; out ImageType: string; out Width, Height, BPP: integer);</code>
  * ''ImageType'' vrací název druhu obrázku třeba //JPEG//. ''Width'' a ''Height'' je snad jasné. ''BPP'' je BitsPerPixel. <sup>2.5.6</sup>

<code delphi>procedure ImageGPSRead(const Value: string; out X, Y: extended);</code>
  * Do proměnných ''X'' a ''Y'' načte GPS souřadnice z EXIF v obrázku. //(X - Lat, Y - Lon)//. <sup>2.5.6</sup>

<code delphi>function ImageGPSWrite(const Value: string; X, Y: extended): string;</code>
  * Z proměnných ''X'' a ''Y'' zapíše GPS souřadnice do EXIF v obrázku. //(X - Lat, Y - Lon)//. <sup>2.5.6</sup>

<code delphi>function ImageMerge(const background, foreground: string; x, y: integer): string;</code>
  * Funkce spojí dva obrázky do jednoho. Do obrázku ''background'' (libovolného podporovaného typu) je na pozici ''[x,y]'' přenesen obrázek ''foregroung''. Výsledný obrázek je ve stejném formátu jako ''background''. Funkce má následující podmínky:
    * ''background'' nesmí mít nastavenou průhlednost v alfakanálu (PNG) ani v paletě (GIF)
    * ''background'' musí mít minimálně stejnou barevnou hloubku jako ''foreground''
    * ''foreground'' je není možné použít BMP truecolor (24bit). Je třeba použít formát s paletou (BMP 8bit, GIF, ...)nebo s alfakanálem (PNG, ...)
    * ''foregroung'' může mít průhlednost definovanou v alfakanálu (PNG), v paletě (GIF) nebo pokud není průhlednost definovaná a je použita paleta (BMP), pak se za průhlednou považuje barva FF00FF, kterou interpretují GPS Garmin jako průhlednou.
  * <sup>2.7.3</sup>

===== Práce se schránkou =====
<code delphi>function ClipboardReadText: string;</code>
  * Vrací obsah schránky. (Pracuje s nativními unicode stringy. Pro převod načteného textu do UTF-8 je nutno použít ''UtfToAnsi()''.  [[user:skripty:functions#string|Pozor na význam Ansi!]] <sup>2.8.3</sup>

<code delphi>procedure ClipboardWriteText(value: string);</code>
  * Vloží obsah ''value'' do schránky. Pracuje s nativními unicode stringy. Pokud je třeba do schránky zkopírovat UTF-8 string, musí se string napřed převést na na "falešný ansistring" funkcí ''UtfToAnsi()'' (viz [[user:skripty:functions#string|význam Ansi!]]) <sup>2.8.3</sup>

<code delphi>function ClipboardHasText: boolean;</code>
  * Vrací ''true'' pokud schránka obsahuje text. <sup>2.8.3</sup>

===== Ovládání referenčního bodu =====
<code delphi>procedure RefPointNames(const Value: TStrings);</code>
  * Naplní ''StringList'' seznamem uložených referenčních bodů.

<code delphi>function RefPointSet(Value: string; X, Y: extended): boolean;</code>
  * Uloží nový (nebo přepíše existující) referenční bod. Pokud funkce vrátí //True//, pak bod již existoval a byl přepsán.

<code delphi>function RefPointGet(Value: string; var X, Y: extended): boolean;</code>
  * Načte souřadnice referenčního bodu.

<code delphi>function RefPointDel(Value: string): boolean;</code>
  * Smaže uložený referenční bod.

<code delphi>function RefPointSelect(Value: string): boolean;</code>
  * Vybere uložený referenční bod.

<code delphi>function RefPointSelectTemp(Value: string; X, Y: extended): boolean;</code>
  * Vybere jako referenční bod požadované souřadnice a název, aniž by bylo nutné bod ukládat.

/*
<code delphi>function ReferencePoints: TStringList;</code>
  * Vrátí StringList se seznamem referenčních bodů. <sup>2.2.1</sup>
*/
<code delphi>function ReferencePointCoord(Name: string, var: X, Y: extended): boolean;</code>
  * Do proměnných ''X''' a ''Y''' dosadí souřadnice referenčního bodu se jménem ''Name''. Pokud se dosazení povede, vrátí ''true''. <sup>2.2.1</sup>

<code delphi>function AddReferencePoint(Name: string; X, Y: extended): boolean;</code>
  * Přidá do seznamu referenčních bodů nový bod se jménem ''Name'' a souřadnicemi ''X''' a ''Y''. Pokud se přidání povede, vrátí ''true''. <sup>2.2.1</sup>

<code delphi>function LoadReferencePoint(Name: string): boolean;</code>
  * Nastaví jako aktuální referenční bod v GeoGetu právě tento. Pokud se nastavení povede, vrátí ''true''. <sup>2.2.1</sup>

<code delphi>function EditReferencePoint(Name: string; NewX, NewY: extended): boolean;</code>
  * Upraví referenčnímu bodu s předaným jménem souřadnice na ''newX'' a ''newY''. Pokud se to povede, vrátí ''true''. <sup>2.2.1</sup>

<code delphi>function RemoveReferencePoint(Name: string): boolean;</code>
  * Odebere referenční bod. Pokud se to povede, vrátí ''true''. <sup>2.2.1</sup>

===== Dialogy =====
<code delphi>procedure ShowMessage(const Msg: string);</code>
  * Zobrazí uživateli zprávu.

<code delphi>procedure ShowLongMessage(const Caption: string; const Msg: string);</code>
  * Zobrazí uživateli dlouhou zprávu s posuvníkem. <sup>2.5.0</sup>

<code delphi>procedure ShowHTMLMessage(const Caption: string; const Msg: string);</code>
  * Zobrazí uživateli dlouhou zprávu s posuvníkem ale narozdíl od ''ShowLongMessage'' obsahuje jednoduchý HTML renderer, stejný, v jakém se zobrazují listingy. Takže řetězec může obsahovat HTML tagy.

<code delphi>procedure ShowHTMLMessageSize(const title, value: string; width, height: integer);</code>
  * Zobrazí uživateli dlouhou zprávu s posuvníkem ale narozdíl od ''ShowLongMessage'' obsahuje jednoduchý HTML renderer, stejný, v jakém se zobrazují listingy. Takže řetězec může obsahovat HTML tagy. ''width'' a ''height'' definuje velikost okna se zobrazenou zprávou. <sup>2.9.4</sup>

<code delphi>function InputBox(const ACaption, APrompt, ADefault: string): string;</code>
  * Zobrazí uživateli zprávu a vyzve uživatele k zadání řetězce. Pokud uživatel dialog stornuje, vrátí se ''ADefault''.

<code delphi>function SaveDlg(Title, InitialDir, Options, Filter: string; var FileName: string):boolean;</code>
  * Vyvolá standardní ''SaveDialog''.

<code delphi>function OpenDlg(Title, InitialDir, Options, Filter: string; var FileName: string):boolean;</code>
  * Vyvolá standardní ''OpenDialog''.

<code delphi>function SelectDir(InitialDir, Caption: string): string;</code>
  * Vyvolá standardní dialog na výběr složky. Pokud nebude složka vybrána, je vrácen prázdný řetězec.

<code delphi>function MessBox(Text, Caption: string; Flags: integer): integer;</code>
  * Vyvolá ''MessageBox''. Konstantou ve ''Flags'' se určuje, jaká tlačítka budou použita: //0// = OK, //1// = OK+Cancel, //2// = Abort+Retry+Ignore, //3// = Yes+No+Cancel, //4// = Yes+No, //5// = Retry+Cancel. Návratová hodnota určuje, jaké tlačítko bylo zmáčknuto: //1// = OK, //2// = Cancel, //3// = Abort, //4// = Retry, //5// = Ignore, //6// = Yes, //7// = No.

<code delphi>function CoordEdit(const Title, Caption: string; var X, Y: extended): boolean;</code>
  * Vyvolá dialog na editaci souřadnic.
===== Obsluha "busy" dialogu =====
<code delphi>procedure GeoBusyStart;</code>
  * Zobrazí "busy" dialog. Po skončení skriptu bude automaticky schován.

<code delphi>procedure GeoBusyCaption(Value: string);</code>
  * Nastaví nadpis "busy" dialogu.

<code delphi>procedure GeoBusyKind(Value: string);</code>
  * Nastaví účel "busy" dialogu.

<code delphi>procedure GeoBusyValue(Value: string);</code>
  * Nastaví hodnotu "busy" dialogu místo progressbaru.

<code delphi>procedure GeoBusyProgress(Value, Max: integer);</code>
  * Nastaví místo hodnoty progressbar.

<code delphi>function GeoBusyTest: boolean;</code>
  * Testuje, jestli uživatel stiskl tlačítko //Cancel//.
  * <wrap important>pokud je plugin realizován **modálním formulářem**</wrap>, je tlačítko v Busy dialogu neaktivní (i když se tak netváří) a ani skrytí formuláře jej nezaktivuje. Kliknutí na něj jen vyvolá chybové pípnutí, ale právě probíhající činnost pluginu nijak neovlivní
  * pokud je plugin realizován modálním formulářem a obsahuje funkci, která by měla být přerušitelná, je třeba
    * zacyklit zobrazení formuláře funkcí ''ShowModal()''
    * formulářový prvek, kterým aktivujete přerušitelnou funkci, musí mít nastavenou nenulovou hodnotu ''ModalResult'', tím dojde po volbě funkce k ukončení formuláře
    * návratovou hodnotu z funkce ''ShowModal()'' obsloužit spuštěním příslušné funkce a v ní testovat ''GeoBusyTest()''
    * (návratová hodnota 2 znamená uzavření formuláře uživatelem kliknutím na křížek v titulkovém pruhu formuláře)
    * znovu funkcí ''ShowModal()'' zobrazit formulář

===== Lokalizace =====
<code delphi>function _(const SzMsgId: string): string;</code>
   * Přeloží předaný ''string'' do právě používaného jazyka. Pomocí této funkce je třeba obalit jakýkoliv text v kódu makra, který chcete překládat.

<code delphi>procedure TextDomain(const SzDomain: string);</code>
   * Nastavit jinou doménu (výchozí je pojmenována //default//, jde v podstatě o jméno //*.mo// souboru s překladem).

<code delphi>function GetCurrentTextDomain: string;</code>
   * Vrátí právě používanou doménu (jméno //*.mo// souboru s překladem).

<code delphi>procedure BindTextDomain(const SzDomain: string; const SzDirectory: string);</code>
   * Přidat další možnou textovou doménu a určit složku (obvykle //Locale//), ve které se mají hledat další složky (CS, ... - podle jazyka) se soubory překladu //*.mo//.

<code delphi>procedure UseLanguage(LanguageCode: string);</code>
   * Změnit používaný jazyk na jiný. Jazykové kódy jsou například //cs// nebo //en//.

<code delphi>function GetCurrentLanguage: string;</code>
   * Zjistit právě používaný jazyk. Výsledkem je jazykový kód, například //cs//, //en//, nebo //cs_CZ//.
   * :!: protože vrácená hodnota se může na různých systémech trochu lišit, je vhodné použít jen první 2 znaky

<code delphi>procedure RetranslateComponent(AnObject: TComponent; const TextDomain:string);</code>
   * Opětovně přeložit komponentu formuláře. Lze předat i celý formulář.

<code delphi>function GetTranslatorNameAndEmail: widestring;</code>
   * Vrátí informace o překladateli - jméno a email.

===== Ovládání činností =====
<code delphi>procedure GeoStopWork;</code>
  * Nasimuluje stisk klávesy //Cancel//, tedy ''PluginWork'' již nebude voláno. <sup>2.2.1</sup>

<code delphi>procedure GeoAbort;</code>
  * Ukončí běh skriptu. <sup>2.2.1</sup>

<code delphi>procedure GeoImportFile(Value: string);</code>
  * Importuje data ze souboru do databáze. Umí importovat i archivy (ZIP, 7Z, ARJ, RAR). Funguje tak, že když narazí na archiv, tak si vygeneruje svůj podadresář v adresáři ''temp'', kam archiv rozbalí. Mělo by to pracovat i s archivy v archivech.

<code delphi>procedure GeoImportDir(Value: string);</code>
  * Importuje soubory ze složky do databáze. Jméno složky musí končit znakem "\"!  Jde soubor po souboru a na každý volá ''ImportFile''. Pokud je soubor archiv, tak viz. výše, rozbalí se do ''temp'' a obsah se naimportuje.

<code delphi>procedure GeoImportBegin;</code>
  * FIXME vynuluje statistiky o importu.

<code delphi>procedure GeoImportEnd;</code>
  * FIXME zobrazí okno s výsledkem importu. Pokud se funkce nepoužije, okno se nezobrazí.

<code delphi>procedure GeoImportPQ;</code>
  * Importuje GPX PQ v podadresari PQ.

<code delphi>procedure GeoDownImportPQ;</code>
  * Stáhne z e-mailu a posléze importuje GPX PQ.

<code delphi>procedure GeoExport(Exporter, FileName: string);</code>
  * Exportuje výpis za pomoci exportního skriptu ''Exporter'' do souboru ''FileName''.

<code delphi>procedure GeoListUpdateID(value: string);</code>
  * Aktualizace řádku v načteném seznamu. <sup>2.5.8</sup>

<code delphi>procedure GeoListUpdateAll;</code>
  * Refresh celého seznamu. <sup>2.5.8</sup>

<code delphi>procedure GeoListClear;</code>
  * Vymaže celý výpis.

<code delphi>procedure GeoListLoad;</code>
  * Naplní výpis podle právě platného filtru.

<code delphi>procedure GeoListLoadAdd;</code>
  * Přidá do výpisu záznamy podle právě platného filtru.

<code delphi>procedure GeoListLoadSub;</code>
  * Odebere z výpisu záznamy podle právě platného filtru.

<code delphi>procedure GeoFilterLoadFile(Value: string);</code>
  * Nahraje sadu filtrů ze souboru.

<code delphi>procedure GeoListFileAdd(Value: string);</code>
  * Přidá do výpisu záznamy podle uložené sady.

<code delphi>procedure GeoListFileSub(Value: string);</code>
  * Odebere z výpisu záznamy podle uložené sady.

<code delphi>procedure GeoListSave(Value: string);</code>
  * Uloží aktuální výpis jako sadu do souboru.

<code delphi>procedure GeoListByFileAdd(Value: string);</code>
  * Přidá do výpisu záznamy podle obsahu GPX nebo LOC souboru.

<code delphi>procedure GeoListByFileSub(Value: string);</code>
  * Odebere z výpisu záznamy podle obsahu GPX nebo LOC souboru.

===== Volání skriptu ze skriptu =====
<code delphi>procedure GeoCallGGP(FileName: string);</code>
  * Zavolá jiné makro typu [[user:skripty:ggp|GGP]].

<code delphi>procedure GeoCallGGC(FileName: string; const Geo: TGeo);</code>
  * Zavolá [[user:skripty:ggc|GGC]] makro pro předanou geocache.

<code delphi>procedure GeoExport(Exporter, FileName: string);</code>
  * Exportuje výpis za pomoci exportního skriptu ''Exporter'' ([[user:skripty:gge|GGE]]) do souboru ''FileName''.

===== Databáze států =====
<code delphi>function GetCountryID(Value: string): integer;</code>
  * Přeloží název státu na ''CountryID'' číslo. <sup>2.2.1</sup>

<code delphi>function GetCountryName(Value: string): string;</code>
  * Převede zkratku na název státu. <sup>2.2.3</sup>

<code delphi>function GetCountryAbbr(Value: string): string;</code>
  * Převede název státu na zkratku. <sup>2.2.3</sup>

<code delphi>function GetStateID(Value: string): integer;</code>
  * Přeloží název území ''StateID'' číslo. <sup>2.2.1</sup>

<code delphi>procedure GetCountryList(const List: TStrings);</code>
  * Naplní ''StringList'' seznamem známých států.

<code delphi>procedure GetStateList(Value: string; const List: TStrings);</code>
  * Naplní ''StringList'' seznamem známých území pro požadovaný stát.

<code delphi>procedure GetDBCountryList(const List: TStrings);</code>
  * Naplní ''StringList'' seznamem států vyskytujících se v databázi kešek.

<code delphi>procedure GetDBStateList(Value: string; const List: TStrings);</code>
  * Naplní ''StringList'' seznamem známých území pro požadovaný stát, podle výskytu v databázi kešek.

===== Řízení výjimek =====
Druhy výjimek jsou definovány následujícím výčtovým typem:

<code delphi>TIFException = (ErNoError, ErCannotImport, ErInvalidType, ErInternalError,
  ErInvalidHeader, ErInvalidOpcode, ErInvalidOpcodeParameter, ErNoMainProc,
  ErOutOfGlobalVarsRange, ErOutOfProcRange, ErOutOfRange, ErOutOfStackRange,
  ErTypeMismatch, ErUnexpectedEof, ErVersionError, ErDivideByZero, ErMathError,
  ErCouldNotCallProc, ErOutofRecordRange, ErOutOfMemory, ErException,
  ErNullPointerException, ErNullVariantError, ErInterfaceNotSupported, ErCustomError);</code>

Výjimky lze v kódu skriptu odchytit pomocí konstrukce:
<code delphi>
try
  //kód, který chceme chránit
except
  //zde budeme jen když nastala výjimka
end;
</code>

==== Vyvolávání výjimek ====
<code delphi>procedure RaiseLastException;</code>
  * Znovu vyvolá poslední výjimku. Například když jsme ji odchytili a usoudili jsme, ze výjimku chceme skutečně vyvolat.

<code delphi>procedure RaiseException(Ex: TIFException; Param: string);</code>
  * Uměle vyvolá požadovanou výjimku.

==== Informace o výjimce ====
<code delphi>function ExceptionType: TIFException;</code>
  * Vrací druh výjimky.

<code delphi>function ExceptionParam: string;</code>
  * Vrací parametry výjimky.

<code delphi>function ExceptionToString(er: TIFException; Param: string): string;</code>
  * Vygeneruje textovou chybovou hlášku z informací o výjimce.

===== Hashovací funkce =====
<code delphi>function Crc32(const Value: AnsiString): integer;</code>
  * Vrátí CRC32 součet předané hodnoty. <sup>2.5.6</sup>

<code delphi>function MD5(const Value: AnsiString): AnsiString;</code>
  * Vrátí MD5 předané hodnoty. <sup>2.5.6</sup>

<code delphi>function SHA1(const Value: AnsiString): AnsiString;</code>
  * Vrátí SHA1 předané hodnoty. <sup>2.5.6</sup>

<code delphi>function MurmurHash(const Value: string): cardinal;</code>
  * Vrátí MurmurHash předané hodnoty. <sup>2.5.6</sup>

<code delphi>function StrToHex(const Value: Ansistring): string;</code>
  * Převádí binární string lezoucí z MD5 nebo SHA1 do hexadecimální podoby. <sup>2.5.6</sup>

===== Matematické funkce =====
<code delphi>function ArcTan2(const Y, X: extended): extended;</code>
  * Calculates the arctangent angle and quadrant of a given number.
  * ArcTan2 calculates ArcTan(Y/X), and returns an angle in the correct quadrant. The values of X and Y must be between –2^64 and 2^64. In addition, the value of X can’t be 0. The return value will fall in the range from -Pi to Pi radians.

<code delphi>function Tan(const X: extended): extended;</code>
  * Returns the tangent of X.
  * Tan returns the tangent of X. Tan(X) = Sin(X) / Cos(X).

<code delphi>function Cotan(const X: extended): extended;</code>
  * Call Cotan to obtain the cotangent of X. The cotangent is calculated using the formula 1 / Tan(X).
  * Do not call Cotan with X = 0.

<code delphi>function Cot(const X: extended): extended;</code>
  * Calculates the cotangent of an angle.
  * Call Cot to obtain the cotangent of X. The cotangent is calculated using the formula 1 / Tan(X).

<code delphi>function TanH(const X: extended): extended;</code>
  * Returns the hyperbolic tangent of X.
  * TanH calculates the hyperbolic tangent of X.

<code delphi>function CotH(const X: extended): extended;</code>
  * Calculates the hyperbolic cotangent of an angle.
  * Call CotH to obtain the hyperbolic cotangent of X, where X is an angle in Radians.

===== Standardní funkce =====
<code delphi>
function IntToStr(I: longint): string;
function StrToInt(S: string): longint;
function StrToIntDef(S: string; Def: longint): longint;
function copy(S: string; IFrom, ICount: longint): string;
function pos(SubStr, S: string): longint;
procedure delete(var S: string; IFrom, ICount: longint);
procedure insert(S: string; var S2: string; IPos: longint);
function StrGet(var S: string; I: integer): char;
function StrGet2(S: string; I: integer): char;
procedure StrSet(C: char; I: integer; var S: string);
function AnsiUppercase(S: string): string;
function AnsiLowercase(S: string): string;
function Uppercase(S: string): string;
function Lowercase(S: string): string;
function Trim(S: string): string;
function Length(S: string): longint;
procedure SetLength(var S: string; L: longint);
function Sin(E: extended): extended;
function Cos(E: extended): extended;
function Tan(E: extended): extended;
function Cot(E: extended): extended;
function Sinh(E: extended): extended;
function Cosh(E: extended): extended;
function Tanh(E: extended): extended;
function Coth(E: extended): extended;
function ArcSin(E: extended): extended;
function ArcCos(E: extended): extended;
function ArcTan2(x, y: extended): extended;  //ArcTan2 calculates ArcTan(Y/X)
function ArcCot(E: extended): extended;
function ArcSinh(E: extended): extended;
function ArcCosh(E: extended): extended;
function ArcTanh(E: extended): extended;
function ArcCoth(E: extended): extended;
function Power(x, y: extended): extended;  //mocnina x^y
function Sqrt(E: extended): extended;
function Round(E: extended): longint;
function Trunc(E: extended): longint;
function Int(E: extended): extended;
function Frac(const X: extended): extended;
function Pi: extended;
function Abs(E: extended): extended;
function StrToFloat(S: string): extended;
function FloatToStr(E: extended): string;
function Padl(S: string; I: longInt): string;
function Padr(S: string; I: longInt): string;
function Padz(S: string; I: longInt): string;
function Replicate(C: char; I: longInt): string;
function StringOfChar(C: char; I: longInt): string;
function StrToInt64(S: string): int64;
function Int64ToStr(I: int64): string;
function EncodeDate(Year, Month, Day: word): TDateTime; //pro převod String -> Word je možno použít funkci ''StrToInt''
function EncodeTime(Hour, Min, Sec, MSec: word): TDateTime; //pro převod String -> Word je možno použít funkci ''StrToInt''
function TryEncodeDate(Year, Month, Day: word; var Date: TDateTime): boolean; //pro převod String -> Word je možno použít funkci ''StrToInt''
function TryEncodeTime(Hour, Min, Sec, MSec: word; var Time: TDateTime): boolean; //pro převod String -> Word je možno použít funkci ''StrToInt''
procedure DecodeDate(const DateTime: TDateTime; var Year, Month, Day: word); //pro převod String -> Word je možno použít funkci ''StrToInt''
procedure DecodeTime(const DateTime: TDateTime; var Hour, Min, Sec, MSec: word); //pro převod String -> Word je možno použít funkci ''StrToInt''
function DayOfWeek(const DateTime: TDateTime): word;
function Date: TDateTime;
function Time: TDateTime;
function Now: TDateTime;
function DateTimeToUnix(D: TDateTime): int64;
function UnixToDateTime(U: int64): TDateTime;
function DateToStr(D: TDateTime): string;
function StrToDate(const S: string): TDateTime;
function FormatDateTime(const FMT: string; D: TDateTime): string;
</code>