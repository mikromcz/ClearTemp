====== Dialogové formuláře ve skriptech (Forms) ======
Počínaje verzí Geogetu 2.2.0 lze vytvářet a používat ve skriptech vámi navržené dialogové formuláře. Zde se dozvíte, jak na to.

===== Co je to formulář? =====
Formulář je samostatné dialogové okno, na který lze umisťovat různé ovládací prvky. Tlačítka, nápisy, přepínátka, obrázky, atd. K dispozici je více jak dvacet různých prvků. Ze skriptu lze pak takový formulář naplnit hodnotami, zobrazit a posléze i zjistit, co na něm uživatel provedl.

Formulář je uložen v souboru s příponou //GFM//. Data v tomto souboru jsou ukládána v textové podobě, ale zasahování do jeho vnitřní struktury lze doporučit jen velmi zkušeným programátorům! Geoget obsahuje vizuální nástroje na vytváření i změny v těchto souborech.

===== Editace formulářů =====
Spusťte editor formulářů. Ukrývá se v editoru skriptů, kde je jako jeden z několika nástrojů. Okno editoru skriptů se skládá ze tří základních částí:
  * **Paleta** (vpravo nahoře) obsahuje prvky, které lze umístit na formulář.
  * **Designer** (vpravo dole) je oblast, které představuje navrhovaný formulář.
  * **Inspector** (vlevo) je nástroj, kde vidíte a měníte vlastnosti právě označeného prvku na Designeru.

Každý prvek na formuláři má své jméno, které vidíte v Inspectoru jako vlastnost 'Name'. Toto je klíčová vlastnost, protože přes toto jméno se posléze ze skriptu na prvek odkazujete. Nesmí tedy být v rámci formuláře duplicitní! I samotný formulář má své jméno. Ve skriptu nelze použít více formulářů se stejným jménem! Začněte tedy tím, že svůj formulář vhodně pojmenujte.

Nové prvky se umísťují na formulář tak, ze na Paletě kliknete na požadovaný prvek, a posléze kliknete do Designeru. Nový prvek se objeví v místě kliknutí. Pak si upravíte jeho velikost a vlastnosti. Některé prvky lze upravovat i přes specielní akce v menu na pravém tlačítku.

Až budete s podobou formuláře spokojeni, uložte jej do souboru.

===== Použití ve skriptu =====
Skript může začínat sekcí //uses//, ve které je vyjmenovaný seznam použitých modulů. Moduly mohou být dvojího druhu:
  * **Unita** je programový modul, třeba knihovna funkci. Obsahuje libovolné množství funkcí, procedur, nebo definici objektových tříd.
  * **Formulář** je definice předem připraveného formuláře. Formulář se zavede do paměti a vyrobí se instance jednotlivých ovládacích prvků, které se ve skriptu budou jevit jako speciálně pojmenované proměnné.

Moduly se specifikují //jménem bez přípony//! Geoget se nejprve snaží najít unitu s příponou PAS, a když neuspěje, pokusí se vyhledat formulář s příponou GFM.

Příklad:
<code delphi>uses
  unit1, unit2, myform;</code>

Po zavedení formuláře se automaticky vytvoří několik proměnných, každá pro jeden prvek na formuláři. I samotný formulář je prezentovaný jako proměnná s názvem formuláře a je typu //TForm//. Názvy jednotlivých prvků jsou prefixovány názvem formuláře, aby se zabránilo duplicitám při použití více různých formulářů. Takže pokud jste měli na formuláři prvek //Button1// a formulář se jmenuje //MyForm//, proměnná symbolizující tento prvek se bude jmenovat //MyForm_Button1//.

Přes tyto proměnné lze přistupovat k vlastnostem jednotlivých prvků a lze přes ně volat jejich metody. Lze také v kódu skriptu přivěsit obslužné rutiny na události prvku.

Příklad:
<code delphi>
procedure Kliknuti(Sender: TObject);
begin
  ShowMessage('Kliknuto!');
end;

procedure PluginStart;
begin
  testform_button1.caption := 'Ahoj!';
  testform_button1.OnClick := @Kliknuti;
  if TestForm.Showmodal = 1 then
    ShowMessage(testform_Edit1.text);
end;
</code>

<WRAP center round info 80%>
Některé prvky, jako třeba tlačítka, mají vlastnost //ModalResult//. Pokud je hodnota v této vlastnosti nenulová, kliknutí na takovýto ovládací prvek způsobí (po vykonání obslužných funkcí) uzavření formuláře a hodnota ze vlastnosti //ModalResult// bude předána jako výsledek metody //ShowModal//.
</WRAP>

Jako názornou ukázku možností formulářů a jejich obsluhy si prohlédněte makro PQDivide, které je součástí distribuce Geogetu.
===== Dokumentace =====
Jako dokumentaci k použitelným formulářovým prvkům můžete použít [[pascaldoc|dokumentaci od Delphi]]. Hledejte v nápovědě k VCL název prvku (TButton, TLabel, atd.) a dostanete se na seznam a popis jednotlivých vlastností, metod i událostí.

FIXME ''THtmlViewer'' -> http://geoget.klfree.net/ticket/318