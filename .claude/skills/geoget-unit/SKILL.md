====== Členění skriptu do více souborů ======
Složitější skripty lze pro přehlednost rozčlenit do více souborů. Existuje několik způsobů, jak toto provést:

===== Include =====
Lze použít direktivu překladače pro vložení obsahu souboru do zdrojového kódu. Jde o direktivu **{$I filename.pas}**. Obsah souboru se vloží přesně místo direktivy. Překladač skriptů si takto poskládá výslednou podobu zdrojového kódu skriptu a ten pak přeloží. Jméno souboru pro vkládaný obsah může být jakékoliv.

Výjimkou je vkládání souboru se jménem ** *.config.pas**, což je speciální soubor s konfigurací skriptu. V takovém případě bude vkládaný obsah generovaný dynamicky podle obsahu *.config.pas a *.default.pas.

Při vkládání souborů pamatujte na to, že výsledkem je jeden velký zdrojový kód, jako kdyby vše bylo napsáno v jednom souboru. Proto pozor na duplicity jmen funkcí, proměnných, a dalších identifikátorů!

===== Unit =====
Na začátku souboru se skriptem může být uveden příkaz **uses** s odkazem na závislé unity.

Unita je vlastně další samostatný skript obsahující funkce, procedury, proměnné, konstanty, nebo vlastní datové typy. Tyto skripty se překládají samostatně, těsně před překladem volajícího skriptu. Ke sloučení tak dochází až na úrovni přeloženého kódu. (Zatímco metoda Include slučuje už na úrovni zdrojového kódu.) Překladač tak při překladu volajícího skriptu už zná vše, co bylo obsahem unity.

Struktura unity byla navržena s velkým ohledem na kompatibilitu s unitami v Delphi, nicméně ve skriptech je celé problematika unit značně zjednodušena. Rozdělování unity na formální a implementační část je sice možné, ale ve skriptech to postrádá veškeré výhody. Stejně tak lze definovat initialization a finalization sekci, kód se přeloží, nicméně tyto sekce nebudou nikdy zavolány!

Pro psaní unit tak zcela stačí, když bude mít unita stejnou strukturu jako jakýkoliv jiný skript. Tedy prostý seznam potřebného kódu, bez jakýchkoliv hlaviček, formálních deklarací a patiček. Například:

<code delphi>
uses
  jina_unita, muj_form;
var
  global_cnt: integer;
function moje_funkce(value: string): string;
begin
  Result := value + ' ' + inttostr(global_cnt);
end;
</code>

Jméno unity, na které se odkazuje v **uses** sekci, musí splňovat syntaxi identifikátoru, tedy nemůže obsahovat tečku! Překladač vezme toto jméno, sám k němu přidá příponu **.pas**, a tím vznikne jméno souboru, které hledá. Unity jsou vyhledávány nejdříve v adresáři, ve kterém je volající skript, a když neuspěje, hledá ve \skript\lib adresáři.

Speciálním případem unity je GGF formulář. Pokud existuje soubor s názvem požadované unity a s příponou GGF, pak bude formulář načten a zpracován tak, aby se na něj skript mohl odkazovat.