Class TWpt
==========

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

`type TWpt = class(TObject)`

Description
-----------

Class for storing waypoint informations

Hierarchy
---------

*   TObject
*   TWpt

Overview
--------

### Methods

[![Public](public.gif "Public")](legend.html)

`constructor **[create](geo.TWpt.html#create)**;`

[![Public](public.gif "Public")](legend.html)

`destructor **[Destroy](geo.TWpt.html#Destroy)**; override;`

[![Public](public.gif "Public")](legend.html)

`procedure **[clear](geo.TWpt.html#clear)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[assign](geo.TWpt.html#assign)**(const value: [TWpt](geo.TWpt.html));`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadCurrent](geo.TWpt.html#LoadCurrent)**(const tab: [TSqlitetable](SQLiteWrap.TSQLiteTable.html));`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadByKey](geo.TWpt.html#LoadByKey)**(const gkey: int64);`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadByID](geo.TWpt.html#LoadByID)**(const value: string);`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadByIDEx](geo.TWpt.html#LoadByIDEx)**(const value, name: string);`

[![Public](public.gif "Public")](legend.html)

`procedure **[SetDefault](geo.TWpt.html#SetDefault)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[Save](geo.TWpt.html#Save)**;`

[![Public](public.gif "Public")](legend.html)

`function **[FullName](geo.TWpt.html#FullName)**: string;`

[![Public](public.gif "Public")](legend.html)

`function **[IsUserWaypoint](geo.TWpt.html#IsUserWaypoint)**: boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[IsWebWaypoint](geo.TWpt.html#IsWebWaypoint)**: boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[IsVisitedWaypoint](geo.TWpt.html#IsVisitedWaypoint)**: boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[IsFinal](geo.TWpt.html#IsFinal)**: boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[IsEmptyCoord](geo.TWpt.html#IsEmptyCoord)**: boolean;`

[![Public](public.gif "Public")](legend.html)

`procedure **[UpdateComment](geo.TWpt.html#UpdateComment)**(value: string);`

[![Public](public.gif "Public")](legend.html)

`procedure **[Remove](geo.TWpt.html#Remove)**;`

[![Public](public.gif "Public")](legend.html)

`function **[IsListed](geo.TWpt.html#IsListed)**: boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[IsSelected](geo.TWpt.html#IsSelected)**: boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[IsFiltered](geo.TWpt.html#IsFiltered)**: boolean;`

[![Public](public.gif "Public")](legend.html)

`procedure **[ListAdd](geo.TWpt.html#ListAdd)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[ListDel](geo.TWpt.html#ListDel)**;`

[![Public](public.gif "Public")](legend.html)

`function **[TypeID](geo.TWpt.html#TypeID)**: string;`

[![Public](public.gif "Public")](legend.html)

`function **[url](geo.TWpt.html#url)**: string;`

[![Public](public.gif "Public")](legend.html)

`function **[GetCoord](geo.TWpt.html#GetCoord)**: string;`

### Properties

[![Public](public.gif "Public")](legend.html)

`property **[Key](geo.TWpt.html#Key)**: int64 read fkey write fkey;`

[![Public](public.gif "Public")](legend.html)

`property **[ParentKey](geo.TWpt.html#ParentKey)**: int64 read getparentkey;`

[![Public](public.gif "Public")](legend.html)

`property **[ParentID](geo.TWpt.html#ParentID)**: string read fparentID write FParentID;`

[![Public](public.gif "Public")](legend.html)

`property **[ID](geo.TWpt.html#ID)**: string read GetWptID;`

[![Public](public.gif "Public")](legend.html)

`property **[ParentName](geo.TWpt.html#ParentName)**: string read GetParentName;`

[![Public](public.gif "Public")](legend.html)

`property **[ParentGeo](geo.TWpt.html#ParentGeo)**: [TGeo](geo.TGeo.html) read getparentgeo;`

[![Public](public.gif "Public")](legend.html)

`property **[Lat](geo.TWpt.html#Lat)**: String read fCoordx write SetX;`

[![Public](public.gif "Public")](legend.html)

`property **[Lon](geo.TWpt.html#Lon)**: String read fCoordY write Sety;`

[![Public](public.gif "Public")](legend.html)

`property **[CoordX](geo.TWpt.html#CoordX)**: String read fCoordx write SetX;`

[![Public](public.gif "Public")](legend.html)

`property **[CoordY](geo.TWpt.html#CoordY)**: String read fCoordY write SetY;`

[![Public](public.gif "Public")](legend.html)

`property **[LatNum](geo.TWpt.html#LatNum)**: extended read fxnum write SetXNum;`

[![Public](public.gif "Public")](legend.html)

`property **[LonNum](geo.TWpt.html#LonNum)**: extended read fynum write SetYNum;`

[![Public](public.gif "Public")](legend.html)

`property **[CoordXNum](geo.TWpt.html#CoordXNum)**: extended read fxnum write SetXnum;`

[![Public](public.gif "Public")](legend.html)

`property **[CoordYNum](geo.TWpt.html#CoordYNum)**: extended read fynum write SetYnum;`

[![Public](public.gif "Public")](legend.html)

`property **[Name](geo.TWpt.html#Name)**: String read fName write fname;`

[![Public](public.gif "Public")](legend.html)

`property **[Comment](geo.TWpt.html#Comment)**: String read FComment;`

[![Public](public.gif "Public")](legend.html)

`property **[Updated](geo.TWpt.html#Updated)**: TDateTime read fdtupdate write fdtupdate;`

[![Public](public.gif "Public")](legend.html)

`property **[GUID](geo.TWpt.html#GUID)**: String read fguid write fguid;`

[![Public](public.gif "Public")](legend.html)

`property **[PrefixID](geo.TWpt.html#PrefixID)**: String read fprefixid write fprefixid;`

[![Public](public.gif "Public")](legend.html)

`property **[Lookup](geo.TWpt.html#Lookup)**: String read flookup write flookup;`

[![Public](public.gif "Public")](legend.html)

`property **[WptType](geo.TWpt.html#WptType)**: String read fwpttype write fwpttype;`

[![Public](public.gif "Public")](legend.html)

`property **[Description](geo.TWpt.html#Description)**: String read fcmt write fcmt;`

[![Public](public.gif "Public")](legend.html)

`property **[Flags](geo.TWpt.html#Flags)**: int64 read fFlags write fFlags;`

Description
-----------

### Methods

[![Public](public.gif "Public")](legend.html)

`constructor **create**;`

constructor

[![Public](public.gif "Public")](legend.html)

`destructor **Destroy**; override;`

destructor

[![Public](public.gif "Public")](legend.html)

`procedure **clear**;`

clear fields in memory

[![Public](public.gif "Public")](legend.html)

`procedure **assign**(const value: [TWpt](geo.TWpt.html));`

assign content to another instance

[![Public](public.gif "Public")](legend.html)

`procedure **LoadCurrent**(const tab: [TSqlitetable](SQLiteWrap.TSQLiteTable.html));`

Load from current row in database

[![Public](public.gif "Public")](legend.html)

`procedure **LoadByKey**(const gkey: int64);`

Load form database by a key

[![Public](public.gif "Public")](legend.html)

`procedure **LoadByID**(const value: string);`

Load form database by waypoint ID

[![Public](public.gif "Public")](legend.html)

`procedure **LoadByIDEx**(const value, name: string);`

Load form database by waypoint ID or by name (for backward comatibility)

[![Public](public.gif "Public")](legend.html)

`procedure **SetDefault**;`

fill by default values

[![Public](public.gif "Public")](legend.html)

`procedure **Save**;`

Save current content to database

[![Public](public.gif "Public")](legend.html)

`function **FullName**: string;`

Full name fo waypoint (include parent geocache name)

[![Public](public.gif "Public")](legend.html)

`function **IsUserWaypoint**: boolean;`

Is this waypoint entered by user?

[![Public](public.gif "Public")](legend.html)

`function **IsWebWaypoint**: boolean;`

Is this waypoint created by the corrected coordinates or note on the web?

[![Public](public.gif "Public")](legend.html)

`function **IsVisitedWaypoint**: boolean;`

Is this waypoint visited?

[![Public](public.gif "Public")](legend.html)

`function **IsFinal**: boolean;`

Is this waypoint with final location?

[![Public](public.gif "Public")](legend.html)

`function **IsEmptyCoord**: boolean;`

Have empty coordinates?

[![Public](public.gif "Public")](legend.html)

`procedure **UpdateComment**(value: string);`

update user comment

[![Public](public.gif "Public")](legend.html)

`procedure **Remove**;`

remove this waypoint from database

[![Public](public.gif "Public")](legend.html)

`function **IsListed**: boolean;`

is this waypoint displayed in geoget window?

[![Public](public.gif "Public")](legend.html)

`function **IsSelected**: boolean;`

is this waypoint displayed and selected in geoget window?

[![Public](public.gif "Public")](legend.html)

`function **IsFiltered**: boolean;`

Can this waypoint pass through filter?

[![Public](public.gif "Public")](legend.html)

`procedure **ListAdd**;`

Add to Geoget window

[![Public](public.gif "Public")](legend.html)

`procedure **ListDel**;`

Remove from Geoget window

[![Public](public.gif "Public")](legend.html)

`function **TypeID**: string;`

Short description of waypoint type. (usually one char)

[![Public](public.gif "Public")](legend.html)

`function **url**: string;`

URL to geocaching web.

[![Public](public.gif "Public")](legend.html)

`function **GetCoord**: string;`

Human readable coordinates

### Properties

[![Public](public.gif "Public")](legend.html)

`property **Key**: int64 read fkey write fkey;`

database key

[![Public](public.gif "Public")](legend.html)

`property **ParentKey**: int64 read getparentkey;`

database key of parent geocache

[![Public](public.gif "Public")](legend.html)

`property **ParentID**: string read fparentID write FParentID;`

ID of parent cache

[![Public](public.gif "Public")](legend.html)

`property **ID**: string read GetWptID;`

Waypoint ID

[![Public](public.gif "Public")](legend.html)

`property **ParentName**: string read GetParentName;`

Name of parent geocache

[![Public](public.gif "Public")](legend.html)

`property **ParentGeo**: [TGeo](geo.TGeo.html) read getparentgeo;`

parent geocache class

[![Public](public.gif "Public")](legend.html)

`property **Lat**: String read fCoordx write SetX;`

Coordinates

[![Public](public.gif "Public")](legend.html)

`property **Lon**: String read fCoordY write Sety;`

Coordinates

[![Public](public.gif "Public")](legend.html)

`property **CoordX**: String read fCoordx write SetX;`

Coordinates

[![Public](public.gif "Public")](legend.html)

`property **CoordY**: String read fCoordY write SetY;`

Coordinates

[![Public](public.gif "Public")](legend.html)

`property **LatNum**: extended read fxnum write SetXNum;`

Coordinates

[![Public](public.gif "Public")](legend.html)

`property **LonNum**: extended read fynum write SetYNum;`

Coordinates

[![Public](public.gif "Public")](legend.html)

`property **CoordXNum**: extended read fxnum write SetXnum;`

Coordinates

[![Public](public.gif "Public")](legend.html)

`property **CoordYNum**: extended read fynum write SetYnum;`

Coordinates

[![Public](public.gif "Public")](legend.html)

`property **Name**: String read fName write fname;`

name

[![Public](public.gif "Public")](legend.html)

`property **Comment**: String read FComment;`

User comment

[![Public](public.gif "Public")](legend.html)

`property **Updated**: TDateTime read fdtupdate write fdtupdate;`

date and time of latest update

[![Public](public.gif "Public")](legend.html)

`property **GUID**: String read fguid write fguid;`

GUID

[![Public](public.gif "Public")](legend.html)

`property **PrefixID**: String read fprefixid write fprefixid;`

Two char ID prefix

[![Public](public.gif "Public")](legend.html)

`property **Lookup**: String read flookup write flookup;`

Lookup code (not available in all cases)

[![Public](public.gif "Public")](legend.html)

`property **WptType**: String read fwpttype write fwpttype;`

Type of waypoint

[![Public](public.gif "Public")](legend.html)

`property **Description**: String read fcmt write fcmt;`

Description of waypoint

[![Public](public.gif "Public")](legend.html)

`property **Flags**: int64 read fFlags write fFlags;`

Flags bit 0 - imported, bit 1 - from the web, bit 2 - visited

* * *

_Generated by [PasDoc 0.9.0](http://pasdoc.sourceforge.net/) on 2018-03-13 21:07:27_