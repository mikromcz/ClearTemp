====== Volání COM/OLE objektů ======
Ze skriptů Geogetu lze volat i libovolný COM nebo OLE objekt z počítače.

Pro tento účel lze ve skriptech používat proměnné typu //variant//, které jsou schopny v sobě držet libovolný datový typ včetně interfaců ke COM/OLE objektů.

===== Příklad =====
Následující kód ukazuje, jak lze ze skriptu používat Microsoft XML. V příkladu se otevře soubor my.gpx ve vašem datovém adresáři, vyberou se všechny názvy bodů, které soubor obsahuje, a prvních 20 se vypíše.

<code delphi>
procedure ReadXML;
var
  Document: variant;
  NodeList: variant;
  Root: variant;
  s: string;
  n: integer;
begin
  try
    Document := CreateOleObject('Microsoft.XMLDOM');
    try
      Document.Async := false;
      Document.ValidateOnParse := false;
      Document.ResolveExternals := false;
      Document.PreserveWhiteSpace := true;
      Document.Load('my.gpx');
      if Document.ParseError.ErrorCode <> 0 then
      begin
        ShowMessage('Parse Error line ' + inttostr(Document.ParseError.Line)
          + ', character ' + inttostr(Document.ParseError.LinePos) + CRLF
          + Document.ParseError.SrcText);
        exit;
      end;
      Root := Document.DocumentElement;
      NodeList := Root.SelectNodes('/gpx/wpt/name'); //XPath
      ShowMessage('Found: ' + IntToStr(NodeList.Length) + 'x');
      s := '';
      for n := 0 to NodeList.Length - 1 do
      begin
        if n >= 20 then break; //just first 20 records...
        s := S + CRLF + NodeList.Item[n].Text;
      end;
      ShowMessage(s);  //display result
    finally
      Document := varNull;
    end;
  except
    ShowMessage('Crashed?');
  end;
end;
</code>