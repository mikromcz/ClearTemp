====== Volání funkcí v DLL knihovnách ======
Ze [[user:skript|skriptů]] GeoGetu lze volat funkce v externích DLL knihovnách.

Ve skriptu lze nadeklarovat svojí funkci či proceduru, jejíž implementace není ve skriptu, ale v externí DLL knihovně. Externí DLL knihovnu lze připravit v libovolném programovacím jazyce, který umí překládat do standardní DLL knihovny.

Pokud chcete deklarovat funkci uloženou v DLL knihovně, napište za hlavičku funkce klíčová slovo **external** a za něj řetězec ve formátu: 'functionname@dllname callingconvention'

Překladač pak nebude hledat ve skriptu implementaci funkce a v případě potřeby zavolá příslušnou funkci v DLL knihovně.

<WRAP tip>Všimněte si v příkladech při deklaraci funkcí z knihovny klíčového slova **delayload** na konci deklarace každé knihovní funkce. Není sice nutné, ale pokud nebude uvedeno a dojde k nějaké chybě, GeoGet pravděpodobně ošklivě zhavaruje hned při spouštění pluginu. Pokud klíčové slovo uvedete, plugin bude pracovat až narazí na příslušnou funkci, tam napíše, že nelze funkci spustit (neuvede však jakou funkci, ale uvede kde) a relativně korektně se ukončí.</WRAP>

Příklad:

<code delphi>
function FindWindow(C1, C2: PChar): Longint; external 'FindWindowA@user32.dll stdcall delayload';
function ShowWindow(hWnd, nCmdShow: Longint): Integer; external 'ShowWindow@user32.dll stdcall delayload';
function SetWindowText(hWnd: Longint; Text: PChar): Longint; external 'SetWindowTextA@user32.dll stdcall delayload';

procedure something;
var
  i: longint;
  wnd: longint;
begin
  wnd := Findwindow('', 'Innerfuse Pascal Script III');
  SetWindowText(Wnd, 'This is DLL demo, it calls some windows user32 routines. This will hide this window for a few seconds');
  for i := 0 to 200000 do begin end;
  ShowWindow(Wnd, 0); // hide it
  for i := 0 to 200000 do begin end;
  SetWindowText(Wnd, 'Wasn''t that nice?');
  ShowWindow(Wnd, 5); // show it
  for i := 0 to 200000 do begin end;
  SetWindowText(Wnd, 'Innerfuse Pascal Script III');
end;
</code>

===== Vyzkoušené deklarace Windowsích funkcí z knihoven =====
<code delphi>
function GetShortPathName(lpszLongPath, lpszShortPath: PChar; cchBuffer: integer): integer; external 'GetShortPathNameA@Kernel32.dll stdcall delayload';
function GetShortPathNameLength(lpszLongPath: PChar; lpszShortPath, cchBuffer: integer): integer; external 'GetShortPathNameA@Kernel32.dll stdcall delayload';

function GetShortName(value: string): string;
var
  l: integer;
begin
  l := GetShortPathNameLength(value,0,0);
  SetLength(Result, l);
  l := GetShortPathName(value, Result, Length(Result));
  SetLength(Result, l);
end;
</code>



====== Vytvoření DLL knihovny pro použití v GeoGetu ======

Vytvoření knihovny v Delphi asi nebude dělat velké problémy, ale pro knihovnu vytvářenou v C++ je třeba si uvědomit odlišnosti mezi Delphi a C++. Jde zejména:

  * o dekorování jmen funkcí
  * o konvenci volání funkcí

Demonstrovat řešení budu na Microsoft Visual Studiu (já konkretně mám verzi 2010). U jiných verzí MSVC to bude podobné a analogie se najde jistě u jiných kompilátorů - když se ví, co hledat, je to jednodušší.

<WRAP tip>Pro použití knihovny je nutné, aby byla uložená tam, kde ji bude systém hledat, tedy na jednom z těchto míst:

  - v některém z vhodných systémových adresářů (např \Windows\SysWOW64)
  - v adresáři, který je uveden v systémové proměnné PATH (samozřejmě je možné tuto proměnnou upravit)
  - v adresáři, kde je exe soubor, který knihovnu používá (v našem případě GeoGet.exe)
  - v aktualním (pracovním) adresáři, zde bz to byl DATADIR
  - upravit impor funkce a doplnit jméno knihovny o relativní cestu (vůči DATADIR) k ní, např.
    ''function SoucetStr(s1,s2:PChar):PChar; external 'SoucetStr@.\script\jmeno_meho_pluginu\MojeKnihovna.dll cdecl delayload';''

Doporučoval bych některou z posledních tří možností.
</WRAP>

===== Dekorování jmen funkcí =====
Standardně C/C++ používá pro jména funkcí tzv. zdobení mebo dekorování. To znamená, že jméno funkce je obaleno nějakými znaky, které mj. linkeru slouží pro kontrolu typu funkce a počtu parametrů. Protože Delphi žádné zdobení nepoužívá, musíme zajistit, aby jména funkcí v knihovně byla shodná s tím, jak je máme pojmenované ve zdrojovém kódu. K tomu slouží DEF soubor použitý při linkování.

Napřed tedy vytvoříme soubor ''MojeKnihovna.def'':

<code>
LIBRARY   MojeKnihovna
EXPORTS
    SoucetInt  @1
    SoucetStr  @2
</code>

a přikážeme jeho použití: ''Configuration Properties --> Linker --> Input --> Module Definition File'', kde nastavíme hodnotu ''$(ProjectDir)\MojeKnihovna.def''

Pochopitelně je potřeba také funkce správně exportovat, např.

<code C++>

#define LIB_EXPORT __declspec(dllexport)
#define LIB_IMPORT __declspec(dllimport)

LIB_EXPORT LPCSTR SoucetStr(LPCSTR s1, LPCSTR s2){
	CString sa,sb;
	sa=CString(s1);	sb=CString(s2);
	sa=sa+sb;
	return(sa);
};

LIB_EXPORT int SoucetInt(int i1,int i2){
	return(i1+i2);
};
</code>

Pokud by mely být funkce použité ve vlastní aplikaci C/C++, musí být naopak z knihovny správně importované:

<code C++>

LIB_IMPORT LPCSTR SoucetStr(LPCSTR s1, LPCSTR s2);
LIB_IMPORT int SoucetInt(int i1,int i2);
</code>



===== Konvence volání funkcí =====
Když máme správně pojmenované funkce v knihovně, můžeme se vrhnout na jejich volání.
Implicitní volání v C/C++ je typu ''cdecl'', zatimco v Delphi je to ''stdcall''. Je tedy potřeba uvést do souladu knihovnu s pluginem. Jsou 2 cesty:

  * přizpůsobit plugin
  * přizpůsobit knihovnu

==== Přizpůsobení pluginu ====
Tato cesta mi připadá výrazně jednodušší a nemá navíc žádný další vliv na přípanou C/C++ aplikaci, která by táké tuto knihovnu používala. Řešení spočívá pouze v tom, že překladači pluginu přikážeme typ ''cdecl'' místo ''stdcall''. Nic víc v tom není.

<code delphi>
function SoucetInt(i1,i2: integer): integer; external 'SoucetInt@MojeKnihovna.dll cdecl delayload';
function SoucetStr(s1,s2: PChar): PChar; external 'SoucetStr@MojeKnihovna.dll cdecl delayload';
</code>

==== Přizpůsobení knihovny ====
Pro přizpůsobení knihovny je třeba změnit implicitní nastavení kompilátoru:

''Configuration Properties --> C/C++ --> Advanced --> Calling Convetion'' na hodnotu ''__stdcall (/Gz)''

a v souladu s ním deklarovat funkce v pluginu:

<code delphi>
function SoucetInt(i1,i2: integer): integer; external 'SoucetInt@MojeKnihovna.dll stdcall delayload';
function SoucetStr(s1,s2: PChar): PChar; external 'SoucetStr@MojeKnihovna.dll stdcall delayload';
</code>

Pokud takto změníte volací konvenci a knihovnu použijete také ve své vlastní aplikaci vytvořené v C/C++, je na to třeba pamatovat a knihovní funkce použít správně.



===== Přebírání parametru typu string z DLL knihovny =====

<WRAP important>U návratových hodnot typu ''string'' (''ansistring'') je problém s uvolněním paměti při ukončení pluginu. Zřejmě se nějak pere správa paměti v Geogetu a ve scriptengine. Vhodné řešení spočívá v úpravě knihovních funkcí a jejich volání tak, aby ve skutečnosti nebyl vracen typ ''string'', ale nejaký ordinarní typ proměnné.</WRAP>

  * knihovní funkce má navíc 2 parametry: adresu textového bufferu a jeho alokovanou velikost
  * místo aby funkce vracela string, zápíše string do bufferu a vrátí počet zapsaných znaků

Takže s ohledem na výše řečené bude plugin obsahovat něco takovéhoto:

<code delphi>
//deklarace knihovní funkce
function SoucetStr(s1,s2,sBuffer: PChar; iMaxLen:integer): integer; external 'SoucetStr@MojeKnihovna.dll stdcall delayload';
...

//volání a převzetí vráceného textu
const MAX_BUFR_LENGTH=256;

var sBuffer:ansistring; // !! pokud pouzijete string misto ansistring,
                        // !! bude na konci sBuffer obsahovat prazdny text,
                        // !! protoze 1. byt znaku bude mit hodnotu 0
                        // !! a to bude chapano jako konec textu
    iLen:integer;
begin
  ...
  SetLength(sBuffer,MAX_BUFR_LENGTH);
  iLen:=SoucetStr('12345','abcde',sBuffer,MAX_BUFR_LENGTH);
  SetLength(sBuffer,iLen);
  ...
end;
</code>

a funkce v DLL knihovně může vypadat třeba nějak takto:

<code C++>
LIB_EXPORT int SoucetStr(LPCSTR s1, LPCSTR s2, LPSTR sBuffer, int iMaxLen){
  CString cs=CString(s1)+CString(s2);
  strcpy_s(sBuffer,iMaxLen,cs);
  return(strlen(sBuffer));
}
</code>