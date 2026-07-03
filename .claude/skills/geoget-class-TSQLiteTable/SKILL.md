Class TSQLiteTable
==================

[Description](#@Description)

[Hierarchy](#@Hierarchy)

Fields

[Methods](#@Methods)

[Properties](#@Properties)

Unit
----

[SQLiteWrap](SQLiteWrap.html)

Declaration
-----------

`type TSQLiteTable = class(TObject)`

Description
-----------

Class for handling SQLite query result

Hierarchy
---------

*   TObject
*   TSQLiteTable

Overview
--------

### Methods

[![Public](public.gif "Public")](legend.html)

`constructor **[Create](SQLiteWrap.TSQLiteTable.html#Create)**(const DB: [TSQLiteDatabase](SQLiteWrap.TSQLiteDatabase.html); const SQL: String; PrepareOnly: Boolean = false);`

[![Public](public.gif "Public")](legend.html)

`destructor **[Destroy](SQLiteWrap.TSQLiteTable.html#Destroy)**; override;`

[![Public](public.gif "Public")](legend.html)

`function **[FieldAsInteger](SQLiteWrap.TSQLiteTable.html#FieldAsInteger)**(I: cardinal): int64;`

[![Public](public.gif "Public")](legend.html)

`function **[FieldAsBlob](SQLiteWrap.TSQLiteTable.html#FieldAsBlob)**(I: cardinal): TMemoryStream;`

[![Public](public.gif "Public")](legend.html)

`function **[FieldAsBlobPtr](SQLiteWrap.TSQLiteTable.html#FieldAsBlobPtr)**(I: cardinal; out iNumBytes: integer): Pointer;`

[![Public](public.gif "Public")](legend.html)

`function **[FieldAsBlobText](SQLiteWrap.TSQLiteTable.html#FieldAsBlobText)**(I: cardinal): AnsiString;`

[![Public](public.gif "Public")](legend.html)

`function **[FieldIsNull](SQLiteWrap.TSQLiteTable.html#FieldIsNull)**(I: cardinal): boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[FieldAsString](SQLiteWrap.TSQLiteTable.html#FieldAsString)**(I: cardinal): AnsiString;`

[![Public](public.gif "Public")](legend.html)

`function **[FieldAsDouble](SQLiteWrap.TSQLiteTable.html#FieldAsDouble)**(I: cardinal): double;`

[![Public](public.gif "Public")](legend.html)

`function **[Next](SQLiteWrap.TSQLiteTable.html#Next)**: boolean;`

[![Public](public.gif "Public")](legend.html)

`procedure **[ParamsClear](SQLiteWrap.TSQLiteTable.html#ParamsClear)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[Reset](SQLiteWrap.TSQLiteTable.html#Reset)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[AddParamInt](SQLiteWrap.TSQLiteTable.html#AddParamInt)**(const name: String; value: int64);`

[![Public](public.gif "Public")](legend.html)

`procedure **[AddParamFloat](SQLiteWrap.TSQLiteTable.html#AddParamFloat)**(const name: String; value: double);`

[![Public](public.gif "Public")](legend.html)

`procedure **[AddParamText](SQLiteWrap.TSQLiteTable.html#AddParamText)**(const name: String; const value: AnsiString);`

[![Public](public.gif "Public")](legend.html)

`procedure **[AddParamNull](SQLiteWrap.TSQLiteTable.html#AddParamNull)**(const name: String);`

[![Public](public.gif "Public")](legend.html)

`procedure **[AddParamBlobPtr](SQLiteWrap.TSQLiteTable.html#AddParamBlobPtr)**(const name: String; buffer: pointer; len: integer);`

[![Public](public.gif "Public")](legend.html)

`procedure **[AddParamBlobText](SQLiteWrap.TSQLiteTable.html#AddParamBlobText)**(const name: String; const value: AnsiString);`

[![Public](public.gif "Public")](legend.html)

`procedure **[AddParamBlob](SQLiteWrap.TSQLiteTable.html#AddParamBlob)**(const name: String; const value: TStream; len: integer);`

### Properties

[![Public](public.gif "Public")](legend.html)

`property **[Fields](SQLiteWrap.TSQLiteTable.html#Fields)**[I: cardinal]: AnsiString read GetFields;`

[![Public](public.gif "Public")](legend.html)

`property **[FieldByName](SQLiteWrap.TSQLiteTable.html#FieldByName)**[FieldName: String]: String read GetFieldByName;`

[![Public](public.gif "Public")](legend.html)

`property **[FieldIndex](SQLiteWrap.TSQLiteTable.html#FieldIndex)**[FieldName: String]: integer read GetFieldIndex;`

[![Public](public.gif "Public")](legend.html)

`property **[Columns](SQLiteWrap.TSQLiteTable.html#Columns)**[I: integer]: String read GetColumns;`

[![Public](public.gif "Public")](legend.html)

`property **[EOF](SQLiteWrap.TSQLiteTable.html#EOF)**: boolean read FEOF;`

[![Public](public.gif "Public")](legend.html)

`property **[ColCount](SQLiteWrap.TSQLiteTable.html#ColCount)**: cardinal read fColCount;`

[![Public](public.gif "Public")](legend.html)

`property **[Row](SQLiteWrap.TSQLiteTable.html#Row)**: cardinal read fRow;`

Description
-----------

### Methods

[![Public](public.gif "Public")](legend.html)

`constructor **Create**(const DB: [TSQLiteDatabase](SQLiteWrap.TSQLiteDatabase.html); const SQL: String; PrepareOnly: Boolean = false);`

Class constructor. Called internally by [TSQLiteDatabase](SQLiteWrap.TSQLiteDatabase.html)

[![Public](public.gif "Public")](legend.html)

`destructor **Destroy**; override;`

Class descructor. Call Free instead.

[![Public](public.gif "Public")](legend.html)

`function **FieldAsInteger**(I: cardinal): int64;`

Read field from current row as integer.

[![Public](public.gif "Public")](legend.html)

`function **FieldAsBlob**(I: cardinal): TMemoryStream;`

Read field from current row as blob to memory stream.

[![Public](public.gif "Public")](legend.html)

`function **FieldAsBlobPtr**(I: cardinal; out iNumBytes: integer): Pointer;`

Read field from current row as pointer to memory.

[![Public](public.gif "Public")](legend.html)

`function **FieldAsBlobText**(I: cardinal): AnsiString;`

Read field from current row as blob to AnsiString.

[![Public](public.gif "Public")](legend.html)

`function **FieldIsNull**(I: cardinal): boolean;`

Test if field from current row contains null value.

[![Public](public.gif "Public")](legend.html)

`function **FieldAsString**(I: cardinal): AnsiString;`

Read field from current row as string.

[![Public](public.gif "Public")](legend.html)

`function **FieldAsDouble**(I: cardinal): double;`

Read field from current row as floating-point.

[![Public](public.gif "Public")](legend.html)

`function **Next**: boolean;`

Go to next row.

[![Public](public.gif "Public")](legend.html)

`procedure **ParamsClear**;`

Reset all query params.

[![Public](public.gif "Public")](legend.html)

`procedure **Reset**;`

Reset current result set. After this you can set new query parameters values and call prepared query again by [Next](SQLiteWrap.TSQLiteTable.html#Next)

[![Public](public.gif "Public")](legend.html)

`procedure **AddParamInt**(const name: String; value: int64);`

Add named query parameter of integer type.

[![Public](public.gif "Public")](legend.html)

`procedure **AddParamFloat**(const name: String; value: double);`

Add named query parameter of floating-point type.

[![Public](public.gif "Public")](legend.html)

`procedure **AddParamText**(const name: String; const value: AnsiString);`

Add named query parameter of string or binary type.

[![Public](public.gif "Public")](legend.html)

`procedure **AddParamNull**(const name: String);`

Add named query parameter with null value.

[![Public](public.gif "Public")](legend.html)

`procedure **AddParamBlobPtr**(const name: String; buffer: pointer; len: integer);`

Add named query parameter of BLOB type from memory buffer.

[![Public](public.gif "Public")](legend.html)

`procedure **AddParamBlobText**(const name: String; const value: AnsiString);`

Add named query parameter of BLOB type from binary string.

[![Public](public.gif "Public")](legend.html)

`procedure **AddParamBlob**(const name: String; const value: TStream; len: integer);`

Add named query parameter of BLOB type from stream.

### Properties

[![Public](public.gif "Public")](legend.html)

`property **Fields**[I: cardinal]: AnsiString read GetFields;`

Return value of some field in current row.

[![Public](public.gif "Public")](legend.html)

`property **FieldByName**[FieldName: String]: String read GetFieldByName;`

Return value of named field in current row.

[![Public](public.gif "Public")](legend.html)

`property **FieldIndex**[FieldName: String]: integer read GetFieldIndex;`

Return index of some named field.

[![Public](public.gif "Public")](legend.html)

`property **Columns**[I: integer]: String read GetColumns;`

Return field type of some field.

[![Public](public.gif "Public")](legend.html)

`property **EOF**: boolean read FEOF;`

Indicate last row in result set.

[![Public](public.gif "Public")](legend.html)

`property **ColCount**: cardinal read fColCount;`

Return number of fields in row.

[![Public](public.gif "Public")](legend.html)

`property **Row**: cardinal read fRow;`

Number of current row.

* * *

_Generated by [PasDoc 0.9.0](http://pasdoc.sourceforge.net/) on 2018-03-13 21:07:28_