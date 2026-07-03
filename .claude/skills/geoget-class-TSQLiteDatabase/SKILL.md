Class TSQLiteDatabase
=====================

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

`type TSQLiteDatabase = class(TObject)`

Description
-----------

Class for handling SQLite database

Hierarchy
---------

*   TObject
*   TSQLiteDatabase

Overview
--------

### Methods

[![Public](public.gif "Public")](legend.html)

`constructor **[Create](SQLiteWrap.TSQLiteDatabase.html#Create)**(const FileName: String);`

[![Public](public.gif "Public")](legend.html)

`destructor **[Destroy](SQLiteWrap.TSQLiteDatabase.html#Destroy)**; override;`

[![Public](public.gif "Public")](legend.html)

`procedure **[ExecSQL](SQLiteWrap.TSQLiteDatabase.html#ExecSQL)**(const SQL : String);`

[![Public](public.gif "Public")](legend.html)

`function **[GetTable](SQLiteWrap.TSQLiteDatabase.html#GetTable)**(const SQL: String; PrepareOnly: Boolean = false): [TSQLiteTable](SQLiteWrap.TSQLiteTable.html);`

[![Public](public.gif "Public")](legend.html)

`function **[GetTableValue](SQLiteWrap.TSQLiteDatabase.html#GetTableValue)**(const SQL: String): int64;`

[![Public](public.gif "Public")](legend.html)

`function **[GetTableString](SQLiteWrap.TSQLiteDatabase.html#GetTableString)**(const SQL: String): AnsiString;`

[![Public](public.gif "Public")](legend.html)

`procedure **[GetTableStrings](SQLiteWrap.TSQLiteDatabase.html#GetTableStrings)**(const SQL: String; const Value: TStrings);`

[![Public](public.gif "Public")](legend.html)

`function **[InTransaction](SQLiteWrap.TSQLiteDatabase.html#InTransaction)**: Boolean;`

[![Public](public.gif "Public")](legend.html)

`procedure **[Start](SQLiteWrap.TSQLiteDatabase.html#Start)**(const name:String; const param: String = '');`

[![Public](public.gif "Public")](legend.html)

`procedure **[Commit](SQLiteWrap.TSQLiteDatabase.html#Commit)**(const name:String);`

[![Public](public.gif "Public")](legend.html)

`procedure **[Rollback](SQLiteWrap.TSQLiteDatabase.html#Rollback)**(const name:String);`

[![Public](public.gif "Public")](legend.html)

`function **[LastInsertRowID](SQLiteWrap.TSQLiteDatabase.html#LastInsertRowID)**: int64;`

[![Public](public.gif "Public")](legend.html)

`function **[LastChangedRows](SQLiteWrap.TSQLiteDatabase.html#LastChangedRows)**: int64;`

[![Public](public.gif "Public")](legend.html)

`function **[TotalChanges](SQLiteWrap.TSQLiteDatabase.html#TotalChanges)**: int64;`

[![Public](public.gif "Public")](legend.html)

`procedure **[SetTimeout](SQLiteWrap.TSQLiteDatabase.html#SetTimeout)**(Value: integer);`

[![Public](public.gif "Public")](legend.html)

`function **[Version](SQLiteWrap.TSQLiteDatabase.html#Version)**: String;`

[![Public](public.gif "Public")](legend.html)

`procedure **[EnableLoadExtension](SQLiteWrap.TSQLiteDatabase.html#EnableLoadExtension)**(value: boolean);`

[![Public](public.gif "Public")](legend.html)

`procedure **[SetChunkSize](SQLiteWrap.TSQLiteDatabase.html#SetChunkSize)**(DatabaseName: ansistring; value: integer);`

[![Public](public.gif "Public")](legend.html)

`procedure **[AddCustomCollate](SQLiteWrap.TSQLiteDatabase.html#AddCustomCollate)**(name: String; xCompare: TCollateXCompare);`

[![Public](public.gif "Public")](legend.html)

`Procedure **[AddSystemCollate](SQLiteWrap.TSQLiteDatabase.html#AddSystemCollate)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[ParamsClear](SQLiteWrap.TSQLiteDatabase.html#ParamsClear)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[AddParamInt](SQLiteWrap.TSQLiteDatabase.html#AddParamInt)**(const name: String; value: int64);`

[![Public](public.gif "Public")](legend.html)

`procedure **[AddParamFloat](SQLiteWrap.TSQLiteDatabase.html#AddParamFloat)**(const name: String; value: double);`

[![Public](public.gif "Public")](legend.html)

`procedure **[AddParamText](SQLiteWrap.TSQLiteDatabase.html#AddParamText)**(const name: String; const value: AnsiString);`

[![Public](public.gif "Public")](legend.html)

`procedure **[AddParamNull](SQLiteWrap.TSQLiteDatabase.html#AddParamNull)**(const name: String);`

[![Public](public.gif "Public")](legend.html)

`procedure **[AddParamBlobPtr](SQLiteWrap.TSQLiteDatabase.html#AddParamBlobPtr)**(const name: String; buffer: pointer; len: integer);`

[![Public](public.gif "Public")](legend.html)

`procedure **[AddParamBlobText](SQLiteWrap.TSQLiteDatabase.html#AddParamBlobText)**(const name: String; const value: AnsiString);`

[![Public](public.gif "Public")](legend.html)

`procedure **[AddParamBlob](SQLiteWrap.TSQLiteDatabase.html#AddParamBlob)**(const name: String; const value: TStream; len: integer);`

[![Public](public.gif "Public")](legend.html)

`function **[DBLoadHandle](SQLiteWrap.TSQLiteDatabase.html#DBLoadHandle)**(SourceDB: TSQliteDB): integer;`

[![Public](public.gif "Public")](legend.html)

`function **[DBLoadFile](SQLiteWrap.TSQLiteDatabase.html#DBLoadFile)**(const FileName: String): integer;`

[![Public](public.gif "Public")](legend.html)

`function **[DBSaveHandle](SQLiteWrap.TSQLiteDatabase.html#DBSaveHandle)**(DestinationDB: TSQliteDB): integer;`

[![Public](public.gif "Public")](legend.html)

`function **[DBSaveFile](SQLiteWrap.TSQLiteDatabase.html#DBSaveFile)**(const FileName: String): integer;`

[![Public](public.gif "Public")](legend.html)

`function **[DBBackupHandle](SQLiteWrap.TSQLiteDatabase.html#DBBackupHandle)**(DestinationDB: TSQliteDB): integer;`

[![Public](public.gif "Public")](legend.html)

`function **[DBBackupFile](SQLiteWrap.TSQLiteDatabase.html#DBBackupFile)**(const FileName: String): integer;`

[![Public](public.gif "Public")](legend.html)

`procedure **[DbBackupStop](SQLiteWrap.TSQLiteDatabase.html#DbBackupStop)**;`

### Properties

[![Public](public.gif "Public")](legend.html)

`property **[DB](SQLiteWrap.TSQLiteDatabase.html#DB)**: TSQLiteDB read fDB;`

[![Public](public.gif "Public")](legend.html)

`property **[OnQuery](SQLiteWrap.TSQLiteDatabase.html#OnQuery)**: [THookQuery](SQLiteWrap.html#THookQuery) read FOnQuery write FOnQuery;`

Description
-----------

### Methods

[![Public](public.gif "Public")](legend.html)

`constructor **Create**(const FileName: String);`

Class constructor. Pass filename of database. If databas not exists, then new one is created. If you pass empty string as filename, then temporary database is created. If you pass ':memory:' as filename, then temporary database in memory is created.

Warning: Pass FileName as AnsiString (if you are not using Unicode Delphi version) or as UnicodeString (on Delphi 2009 and higher)!

[![Public](public.gif "Public")](legend.html)

`destructor **Destroy**; override;`

Class descructor. Call Free instead.

[![Public](public.gif "Public")](legend.html)

`procedure **ExecSQL**(const SQL : String);`

Run SQL command without result. You can call before functions AddParam\* for set query parameters.

[![Public](public.gif "Public")](legend.html)

`function **GetTable**(const SQL: String; PrepareOnly: Boolean = false): [TSQLiteTable](SQLiteWrap.TSQLiteTable.html);`

Run SQL command with result. You can call before functions AddParam\* for set query parameters. If you set PerpareOnly, then query is just prepared but first row is not fetched!

[![Public](public.gif "Public")](legend.html)

`function **GetTableValue**(const SQL: String): int64;`

Run SQL command and number from first field in first row is returned. You can call before functions AddParam\* for set query parameters.

[![Public](public.gif "Public")](legend.html)

`function **GetTableString**(const SQL: String): AnsiString;`

Run SQL command and value from first field in first row is returned. You can call before functions AddParam\* for set query parameters.

[![Public](public.gif "Public")](legend.html)

`procedure **GetTableStrings**(const SQL: String; const Value: TStrings);`

Run SQL command and values from first field in each row is filled to stringlist. You can call before functions AddParam\* for set query parameters.

[![Public](public.gif "Public")](legend.html)

`function **InTransaction**: Boolean;`

Return `True` if database is in transaction state.

[![Public](public.gif "Public")](legend.html)

`procedure **Start**(const name:String; const param: String = '');`

Start transaction. You can modify transaction type by Param parameter. If you use non-empty Name parameter, then savepoint is used. Savepoint is named and can be nested.

[![Public](public.gif "Public")](legend.html)

`procedure **Commit**(const name:String);`

Commit transaction. If you use non-empty Name parameter, then savepoint is used. Savepoint is named and can be nested.

[![Public](public.gif "Public")](legend.html)

`procedure **Rollback**(const name:String);`

Rollback transaction. If you use non-empty Name parameter, then savepoint is used. Savepoint is named and can be nested.

[![Public](public.gif "Public")](legend.html)

`function **LastInsertRowID**: int64;`

Get ROWID of last inserted row.

[![Public](public.gif "Public")](legend.html)

`function **LastChangedRows**: int64;`

Return number of modified rows by last query.

[![Public](public.gif "Public")](legend.html)

`function **TotalChanges**: int64;`

Return number of modified rows starting by opened database connection.

[![Public](public.gif "Public")](legend.html)

`procedure **SetTimeout**(Value: integer);`

Set wait timeout. if database is locked, then it wait this timeout. If database is not released within this timeout, then error is returned.

[![Public](public.gif "Public")](legend.html)

`function **Version**: String;`

Return SQLite engine version.

[![Public](public.gif "Public")](legend.html)

`procedure **EnableLoadExtension**(value: boolean);`

Enable/disable suport for loaded extension libraries.

[![Public](public.gif "Public")](legend.html)

`procedure **SetChunkSize**(DatabaseName: ansistring; value: integer);`

Set chunk size for databaze file grow.

[![Public](public.gif "Public")](legend.html)

`procedure **AddCustomCollate**(name: String; xCompare: TCollateXCompare);`

Add custom sorting procedure as new Collate.

[![Public](public.gif "Public")](legend.html)

`Procedure **AddSystemCollate**;`

Add collate named SYSTEM for correct data sorting by user's locale

[![Public](public.gif "Public")](legend.html)

`procedure **ParamsClear**;`

Clear all query parameters.

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

Add named query parameter of BLOB type from the memory buffer.

[![Public](public.gif "Public")](legend.html)

`procedure **AddParamBlobText**(const name: String; const value: AnsiString);`

Add named query parameter of BLOB type from the binary string.

[![Public](public.gif "Public")](legend.html)

`procedure **AddParamBlob**(const name: String; const value: TStream; len: integer);`

Add named query parameter of BLOB type from the stream.

[![Public](public.gif "Public")](legend.html)

`function **DBLoadHandle**(SourceDB: TSQliteDB): integer;`

 

[![Public](public.gif "Public")](legend.html)

`function **DBLoadFile**(const FileName: String): integer;`

 

[![Public](public.gif "Public")](legend.html)

`function **DBSaveHandle**(DestinationDB: TSQliteDB): integer;`

 

[![Public](public.gif "Public")](legend.html)

`function **DBSaveFile**(const FileName: String): integer;`

 

[![Public](public.gif "Public")](legend.html)

`function **DBBackupHandle**(DestinationDB: TSQliteDB): integer;`

 

[![Public](public.gif "Public")](legend.html)

`function **DBBackupFile**(const FileName: String): integer;`

 

[![Public](public.gif "Public")](legend.html)

`procedure **DbBackupStop**;`

 

### Properties

[![Public](public.gif "Public")](legend.html)

`property **DB**: TSQLiteDB read fDB;`

SQLite database handler.

[![Public](public.gif "Public")](legend.html)

`property **OnQuery**: [THookQuery](SQLiteWrap.html#THookQuery) read FOnQuery write FOnQuery;`

Debug hook for log all called queries.

* * *

_Generated by [PasDoc 0.9.0](http://pasdoc.sourceforge.net/) on 2018-03-13 21:07:28_