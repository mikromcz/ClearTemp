Class TGeoLog
=============

[Description](#@Description)

[Hierarchy](#@Hierarchy)

Fields

[Methods](#@Methods)

[Properties](#@Properties)

Unit
----

[geo](geo.html)

Declaration
-----------

`type TGeoLog = class(Tobject)`

Description
-----------

Class for storing finder's logs

Hierarchy
---------

*   Tobject
*   TGeoLog

Overview
--------

### Methods

[![Public](public.gif "Public")](legend.html)

`constructor **[create](geo.TGeoLog.html#create)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[clear](geo.TGeoLog.html#clear)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[assign](geo.TGeoLog.html#assign)**(const value: [TGeoLog](geo.TGeoLog.html));`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadCurrent](geo.TGeoLog.html#LoadCurrent)**(const tab: [TSqlitetable](SQLiteWrap.TSQLiteTable.html));`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadCurrentLite](geo.TGeoLog.html#LoadCurrentLite)**(const tab: [TSqlitetable](SQLiteWrap.TSQLiteTable.html));`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadCurrentText](geo.TGeoLog.html#LoadCurrentText)**(const tab: [TSqlitetable](SQLiteWrap.TSQLiteTable.html));`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadByLogID](geo.TGeoLog.html#LoadByLogID)**(const value: string);`

[![Public](public.gif "Public")](legend.html)

`function **[LoadIfModified](geo.TGeoLog.html#LoadIfModified)**(const idlog: string; texthash: int64): boolean;`

[![Public](public.gif "Public")](legend.html)

`procedure **[Remove](geo.TGeoLog.html#Remove)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[SetDefault](geo.TGeoLog.html#SetDefault)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[Save](geo.TGeoLog.html#Save)**;`

[![Public](public.gif "Public")](legend.html)

`function **[IsMy](geo.TGeoLog.html#IsMy)**: boolean;`

### Properties

[![Public](public.gif "Public")](legend.html)

`property **[ID](geo.TGeoLog.html#ID)**: string read fid write fid;`

[![Public](public.gif "Public")](legend.html)

`property **[key](geo.TGeoLog.html#key)**: int64 read fkey write fkey;`

[![Public](public.gif "Public")](legend.html)

`property **[date](geo.TGeoLog.html#date)**: TdateTime read fdate write setdate;`

[![Public](public.gif "Public")](legend.html)

`property **[logtype](geo.TGeoLog.html#logtype)**: string read ftype write settype;`

[![Public](public.gif "Public")](legend.html)

`property **[finder](geo.TGeoLog.html#finder)**: string read ffinder write setfinder;`

[![Public](public.gif "Public")](legend.html)

`property **[text](geo.TGeoLog.html#text)**: string read ftext write settext;`

[![Public](public.gif "Public")](legend.html)

`property **[textHTML](geo.TGeoLog.html#textHTML)**: string read getloghtml;`

[![Public](public.gif "Public")](legend.html)

`property **[LogID](geo.TGeoLog.html#LogID)**: string read getlogid write setlogid;`

[![Public](public.gif "Public")](legend.html)

`property **[LogIDcode](geo.TGeoLog.html#LogIDcode)**: string read getlogidcode;`

[![Public](public.gif "Public")](legend.html)

`property **[FinderID](geo.TGeoLog.html#FinderID)**: string read fgsfinderid write setfinderid;`

[![Public](public.gif "Public")](legend.html)

`property **[Hash](geo.TGeoLog.html#Hash)**: int64 read fhash;`

[![Public](public.gif "Public")](legend.html)

`property **[Updated](geo.TGeoLog.html#Updated)**: TDateTime read fdtupdate write fdtupdate;`

Description
-----------

### Methods

[![Public](public.gif "Public")](legend.html)

`constructor **create**;`

constructor

[![Public](public.gif "Public")](legend.html)

`procedure **clear**;`

clear fields in memory

[![Public](public.gif "Public")](legend.html)

`procedure **assign**(const value: [TGeoLog](geo.TGeoLog.html));`

assign content to another instance

[![Public](public.gif "Public")](legend.html)

`procedure **LoadCurrent**(const tab: [TSqlitetable](SQLiteWrap.TSQLiteTable.html));`

Load from current row in database

[![Public](public.gif "Public")](legend.html)

`procedure **LoadCurrentLite**(const tab: [TSqlitetable](SQLiteWrap.TSQLiteTable.html));`

Load from current row in database without log text

[![Public](public.gif "Public")](legend.html)

`procedure **LoadCurrentText**(const tab: [TSqlitetable](SQLiteWrap.TSQLiteTable.html));`

Load logtext from current row in database

[![Public](public.gif "Public")](legend.html)

`procedure **LoadByLogID**(const value: string);`

Load by LogID

[![Public](public.gif "Public")](legend.html)

`function **LoadIfModified**(const idlog: string; texthash: int64): boolean;`

Load by LogID and return `True`, if log in database will be modified

[![Public](public.gif "Public")](legend.html)

`procedure **Remove**;`

remove this log from database

[![Public](public.gif "Public")](legend.html)

`procedure **SetDefault**;`

fill by default values

[![Public](public.gif "Public")](legend.html)

`procedure **Save**;`

Save current content to database

[![Public](public.gif "Public")](legend.html)

`function **IsMy**: boolean;`

your own log test

### Properties

[![Public](public.gif "Public")](legend.html)

`property **ID**: string read fid write fid;`

Associated geocache ID

[![Public](public.gif "Public")](legend.html)

`property **key**: int64 read fkey write fkey;`

Key in database

[![Public](public.gif "Public")](legend.html)

`property **date**: TdateTime read fdate write setdate;`

Date of log

[![Public](public.gif "Public")](legend.html)

`property **logtype**: string read ftype write settype;`

Log type

[![Public](public.gif "Public")](legend.html)

`property **finder**: string read ffinder write setfinder;`

Who wrote this log

[![Public](public.gif "Public")](legend.html)

`property **text**: string read ftext write settext;`

text of log

[![Public](public.gif "Public")](legend.html)

`property **textHTML**: string read getloghtml;`

text of log converted to HTML

[![Public](public.gif "Public")](legend.html)

`property **LogID**: string read getlogid write setlogid;`

LogID

[![Public](public.gif "Public")](legend.html)

`property **LogIDcode**: string read getlogidcode;`

LogID code (GLxxxx)

[![Public](public.gif "Public")](legend.html)

`property **FinderID**: string read fgsfinderid write setfinderid;`

ID of log author (may not be filled...)

[![Public](public.gif "Public")](legend.html)

`property **Hash**: int64 read fhash;`

32bit Murmur Hash of decompressed log Text

[![Public](public.gif "Public")](legend.html)

`property **Updated**: TDateTime read fdtupdate write fdtupdate;`

date and time of latest update

* * *

_Generated by [PasDoc 0.9.0](http://pasdoc.sourceforge.net/) on 2018-03-13 21:07:27_