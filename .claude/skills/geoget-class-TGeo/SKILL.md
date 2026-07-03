Class TGeo
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

`type TGeo = class(TObject)`

Description
-----------

Class for storing geocache informations

Hierarchy
---------

*   TObject
*   TGeo

Overview
--------

### Methods

[![Public](public.gif "Public")](legend.html)

`constructor **[create](geo.TGeo.html#create)**;`

[![Public](public.gif "Public")](legend.html)

`destructor **[Destroy](geo.TGeo.html#Destroy)**; override;`

[![Public](public.gif "Public")](legend.html)

`procedure **[clear](geo.TGeo.html#clear)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[assign](geo.TGeo.html#assign)**(const value: [TGeo](geo.TGeo.html));`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadCurrent](geo.TGeo.html#LoadCurrent)**(const tab: [TSqlitetable](SQLiteWrap.TSQLiteTable.html));`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadByKey](geo.TGeo.html#LoadByKey)**(const gkey: int64);`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadByGC](geo.TGeo.html#LoadByGC)**(const value: string);`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadByKeyGC](geo.TGeo.html#LoadByKeyGC)**(const gkey: int64; const value: string);`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadKeyByGC](geo.TGeo.html#LoadKeyByGC)**(const Value: string);`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadFoundByGC](geo.TGeo.html#LoadFoundByGC)**(const Value: string);`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadByLabID](geo.TGeo.html#LoadByLabID)**(const value, name: string);`

[![Public](public.gif "Public")](legend.html)

`procedure **[SetDefault](geo.TGeo.html#SetDefault)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[ChangeID](geo.TGeo.html#ChangeID)**(const value: string);`

[![Public](public.gif "Public")](legend.html)

`procedure **[UpdateFound](geo.TGeo.html#UpdateFound)**(value: TDateTime);`

[![Public](public.gif "Public")](legend.html)

`procedure **[UpdateFoundDate](geo.TGeo.html#UpdateFoundDate)**(value: TDateTime);`

[![Public](public.gif "Public")](legend.html)

`procedure **[UpdateLastFound](geo.TGeo.html#UpdateLastFound)**(value: TDateTime);`

[![Public](public.gif "Public")](legend.html)

`procedure **[UpdateComment](geo.TGeo.html#UpdateComment)**(value: string);`

[![Public](public.gif "Public")](legend.html)

`procedure **[UpdateBasicInfo](geo.TGeo.html#UpdateBasicInfo)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[Save](geo.TGeo.html#Save)**;`

[![Public](public.gif "Public")](legend.html)

`function **[UpdateListing](geo.TGeo.html#UpdateListing)**(const longdesc, shortdesc, hint: string; longdescflag, shortdescflag: integer): boolean;`

[![Public](public.gif "Public")](legend.html)

`procedure **[UpdateShortListing](geo.TGeo.html#UpdateShortListing)**(const shortdesc: string; shortdescflag: integer);`

[![Public](public.gif "Public")](legend.html)

`procedure **[UpdateLongListing](geo.TGeo.html#UpdateLongListing)**(const longdesc: string; longdescflag: integer);`

[![Public](public.gif "Public")](legend.html)

`function **[AddLog](geo.TGeo.html#AddLog)**: [TGeoLog](geo.TGeoLog.html);`

[![Public](public.gif "Public")](legend.html)

`procedure **[RemoveLogs](geo.TGeo.html#RemoveLogs)**;`

[![Public](public.gif "Public")](legend.html)

`function **[RefineLogs](geo.TGeo.html#RefineLogs)**(LeaveCount: integer; LeaveOwned, LeaveImportant: Boolean; LeaveUsers: string): integer;`

[![Public](public.gif "Public")](legend.html)

`procedure **[RemoveListing](geo.TGeo.html#RemoveListing)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[RemoveTags](geo.TGeo.html#RemoveTags)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[RemoveWaypoints](geo.TGeo.html#RemoveWaypoints)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[Remove](geo.TGeo.html#Remove)**;`

[![Public](public.gif "Public")](legend.html)

`function **[HaveFinal](geo.TGeo.html#HaveFinal)**: boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[HaveUserFinal](geo.TGeo.html#HaveUserFinal)**: boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[GetCoord](geo.TGeo.html#GetCoord)**: string;`

[![Public](public.gif "Public")](legend.html)

`function **[HaveWaypoint](geo.TGeo.html#HaveWaypoint)**: Boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[AttachmentDir](geo.TGeo.html#AttachmentDir)**: string;`

[![Public](public.gif "Public")](legend.html)

`function **[HaveAttachment](geo.TGeo.html#HaveAttachment)**: Boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[RTFAttachmentFile](geo.TGeo.html#RTFAttachmentFile)**: string;`

[![Public](public.gif "Public")](legend.html)

`function **[HaveRTFAttachment](geo.TGeo.html#HaveRTFAttachment)**: Boolean;`

[![Public](public.gif "Public")](legend.html)

`procedure **[OpenRTFAttachment](geo.TGeo.html#OpenRTFAttachment)**;`

[![Public](public.gif "Public")](legend.html)

`function **[HaveListing](geo.TGeo.html#HaveListing)**: boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[SimpleUrl](geo.TGeo.html#SimpleUrl)**: string;`

[![Public](public.gif "Public")](legend.html)

`function **[url](geo.TGeo.html#url)**: string;`

[![Public](public.gif "Public")](legend.html)

`function **[IsDisabled](geo.TGeo.html#IsDisabled)**: Boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[IsArchived](geo.TGeo.html#IsArchived)**: Boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[IsFound](geo.TGeo.html#IsFound)**:Boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[TypeID](geo.TGeo.html#TypeID)**: string;`

[![Public](public.gif "Public")](legend.html)

`function **[SizeID](geo.TGeo.html#SizeID)**: string;`

[![Public](public.gif "Public")](legend.html)

`function **[DiffID](geo.TGeo.html#DiffID)**: string;`

[![Public](public.gif "Public")](legend.html)

`function **[TerrID](geo.TGeo.html#TerrID)**: string;`

[![Public](public.gif "Public")](legend.html)

`function **[IDTag](geo.TGeo.html#IDTag)**: string;`

[![Public](public.gif "Public")](legend.html)

`function **[NameSplit](geo.TGeo.html#NameSplit)**: string;`

[![Public](public.gif "Public")](legend.html)

`function **[IsListed](geo.TGeo.html#IsListed)**: boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[IsSelected](geo.TGeo.html#IsSelected)**: boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[IsFiltered](geo.TGeo.html#IsFiltered)**: boolean;`

[![Public](public.gif "Public")](legend.html)

`procedure **[ListAdd](geo.TGeo.html#ListAdd)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[ListDel](geo.TGeo.html#ListDel)**;`

[![Public](public.gif "Public")](legend.html)

`function **[TagCategories](geo.TGeo.html#TagCategories)**: string;`

[![Public](public.gif "Public")](legend.html)

`function **[TagHaveCategory](geo.TGeo.html#TagHaveCategory)**(category: string): boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[TagValues](geo.TGeo.html#TagValues)**(Category: string): string;`

[![Public](public.gif "Public")](legend.html)

`procedure **[TagAdd](geo.TGeo.html#TagAdd)**(Category, value: string);`

[![Public](public.gif "Public")](legend.html)

`procedure **[TagReplace](geo.TGeo.html#TagReplace)**(Category, value: string);`

[![Public](public.gif "Public")](legend.html)

`procedure **[TagReplaceList](geo.TGeo.html#TagReplaceList)**(Category: string; const value: TStrings);`

[![Public](public.gif "Public")](legend.html)

`procedure **[TagDel](geo.TGeo.html#TagDel)**(Category, value: string);`

[![Public](public.gif "Public")](legend.html)

`procedure **[TagClear](geo.TGeo.html#TagClear)**(Category: string);`

[![Public](public.gif "Public")](legend.html)

`function **[TagCategoryLastUpdate](geo.TGeo.html#TagCategoryLastUpdate)**(Category: string): TDateTime;`

[![Public](public.gif "Public")](legend.html)

`function **[FindNear](geo.TGeo.html#FindNear)**(Distance: Integer): integer;`

[![Public](public.gif "Public")](legend.html)

`procedure **[TagInvalid](geo.TGeo.html#TagInvalid)**;`

[![Public](public.gif "Public")](legend.html)

`function **[IsEmptyCoord](geo.TGeo.html#IsEmptyCoord)**: boolean;`

[![Public](public.gif "Public")](legend.html)

`procedure **[CountryState](geo.TGeo.html#CountryState)**(xcountry, xstate: string);`

[![Public](public.gif "Public")](legend.html)

`function **[FinalWpt](geo.TGeo.html#FinalWpt)**: [TWpt](geo.TWpt.html);`

[![Public](public.gif "Public")](legend.html)

`procedure **[ShowListing](geo.TGeo.html#ShowListing)**;`

[![Public](public.gif "Public")](legend.html)

`function **[Family](geo.TGeo.html#Family)**: string;`

[![Public](public.gif "Public")](legend.html)

`procedure **[GetListing](geo.TGeo.html#GetListing)**(const value: TStrings; prefix: string);`

### Properties

[![Public](public.gif "Public")](legend.html)

`property **[Waypoints](geo.TGeo.html#Waypoints)**: [TWptList](geo.TWptList.html) read getWptList;`

[![Public](public.gif "Public")](legend.html)

`property **[Logs](geo.TGeo.html#Logs)**: [TGeoLogList](geo.TGeoLogList.html) read getLogList;`

[![Public](public.gif "Public")](legend.html)

`property **[NearGeo](geo.TGeo.html#NearGeo)**: [TGeoList](geo.TGeoList.html) read FNearest;`

[![Public](public.gif "Public")](legend.html)

`property **[Key](geo.TGeo.html#Key)**: int64 read fkey write FKey;`

[![Public](public.gif "Public")](legend.html)

`property **[ID](geo.TGeo.html#ID)**: String read fID write fID;`

[![Public](public.gif "Public")](legend.html)

`property **[Lat](geo.TGeo.html#Lat)**: String read fCoordx write setx;`

[![Public](public.gif "Public")](legend.html)

`property **[Lon](geo.TGeo.html#Lon)**: String read fCoordY write sety;`

[![Public](public.gif "Public")](legend.html)

`property **[CoordX](geo.TGeo.html#CoordX)**: String read fCoordx write setx;`

[![Public](public.gif "Public")](legend.html)

`property **[CoordY](geo.TGeo.html#CoordY)**: String read fCoordY write sety;`

[![Public](public.gif "Public")](legend.html)

`property **[LatNum](geo.TGeo.html#LatNum)**: extended read fxnum write setxnum;`

[![Public](public.gif "Public")](legend.html)

`property **[LonNum](geo.TGeo.html#LonNum)**: extended read fynum write setynum;`

[![Public](public.gif "Public")](legend.html)

`property **[CoordXNum](geo.TGeo.html#CoordXNum)**: extended read fxnum write setxnum;`

[![Public](public.gif "Public")](legend.html)

`property **[CoordYNum](geo.TGeo.html#CoordYNum)**: extended read fynum write setynum;`

[![Public](public.gif "Public")](legend.html)

`property **[CorrectedLat](geo.TGeo.html#CorrectedLat)**: String read getcorx;`

[![Public](public.gif "Public")](legend.html)

`property **[CorrectedLon](geo.TGeo.html#CorrectedLon)**: String read getcory;`

[![Public](public.gif "Public")](legend.html)

`property **[CorrectedCoordX](geo.TGeo.html#CorrectedCoordX)**: String read getcorx;`

[![Public](public.gif "Public")](legend.html)

`property **[CorrectedCoordY](geo.TGeo.html#CorrectedCoordY)**: String read getcory;`

[![Public](public.gif "Public")](legend.html)

`property **[CorrectedLatNum](geo.TGeo.html#CorrectedLatNum)**: extended read getcorxnum;`

[![Public](public.gif "Public")](legend.html)

`property **[CorrectedLonNum](geo.TGeo.html#CorrectedLonNum)**: extended read getcorynum;`

[![Public](public.gif "Public")](legend.html)

`property **[CorrectedCoordXNum](geo.TGeo.html#CorrectedCoordXNum)**: extended read getcorxnum;`

[![Public](public.gif "Public")](legend.html)

`property **[CorrectedCoordYNum](geo.TGeo.html#CorrectedCoordYNum)**: extended read getcorynum;`

[![Public](public.gif "Public")](legend.html)

`property **[GUID](geo.TGeo.html#GUID)**: String read fGUID write fGUID;`

[![Public](public.gif "Public")](legend.html)

`property **[Name](geo.TGeo.html#Name)**: String read fName write fName;`

[![Public](public.gif "Public")](legend.html)

`property **[Author](geo.TGeo.html#Author)**: String read fAuthor write SetAuthor;`

[![Public](public.gif "Public")](legend.html)

`property **[CacheType](geo.TGeo.html#CacheType)**: String read FcacheType write FCacheType;`

[![Public](public.gif "Public")](legend.html)

`property **[Size](geo.TGeo.html#Size)**: String read FcacheSize write FcacheSize;`

[![Public](public.gif "Public")](legend.html)

`property **[Difficulty](geo.TGeo.html#Difficulty)**: String read FDifficulty write FDifficulty;`

[![Public](public.gif "Public")](legend.html)

`property **[Terrain](geo.TGeo.html#Terrain)**: String read fTerrain write fTerrain;`

[![Public](public.gif "Public")](legend.html)

`property **[Comment](geo.TGeo.html#Comment)**: String read FComment;`

[![Public](public.gif "Public")](legend.html)

`property **[ShortDescription](geo.TGeo.html#ShortDescription)**: String read GetShortDesc;`

[![Public](public.gif "Public")](legend.html)

`property **[LongDescription](geo.TGeo.html#LongDescription)**: String read GetLongDesc;`

[![Public](public.gif "Public")](legend.html)

`property **[Hint](geo.TGeo.html#Hint)**: String read getHint;`

[![Public](public.gif "Public")](legend.html)

`property **[Hidden](geo.TGeo.html#Hidden)**: TDateTime read fdtHidden write fdthidden;`

[![Public](public.gif "Public")](legend.html)

`property **[LastFound](geo.TGeo.html#LastFound)**: TDateTime read fdtLast write fdtlast;`

[![Public](public.gif "Public")](legend.html)

`property **[Updated](geo.TGeo.html#Updated)**: TDateTime read fdtUpdate write fdtupdate;`

[![Public](public.gif "Public")](legend.html)

`property **[UpdatedList](geo.TGeo.html#UpdatedList)**: TDateTime read fdtUpdateList write fdtupdateList;`

[![Public](public.gif "Public")](legend.html)

`property **[Found](geo.TGeo.html#Found)**: TDateTime read fdtFound;`

[![Public](public.gif "Public")](legend.html)

`property **[FoundTime](geo.TGeo.html#FoundTime)**: TDateTime read fdtFoundTime;`

[![Public](public.gif "Public")](legend.html)

`property **[IsOwner](geo.TGeo.html#IsOwner)**: Boolean read fisowner;`

[![Public](public.gif "Public")](legend.html)

`property **[CacheStatus](geo.TGeo.html#CacheStatus)**: integer read fcachestatus write fCacheStatus;`

[![Public](public.gif "Public")](legend.html)

`property **[Country](geo.TGeo.html#Country)**: String read FCountry write fCountry;`

[![Public](public.gif "Public")](legend.html)

`property **[State](geo.TGeo.html#State)**: String read FState write fstate;`

[![Public](public.gif "Public")](legend.html)

`property **[CacheID](geo.TGeo.html#CacheID)**: String read GetCacheID write fcacheID;`

[![Public](public.gif "Public")](legend.html)

`property **[OwnerID](geo.TGeo.html#OwnerID)**: String read FOwnerID write FOwnerID;`

[![Public](public.gif "Public")](legend.html)

`property **[StatusName](geo.TGeo.html#StatusName)**: string read GetStatusStr;`

[![Public](public.gif "Public")](legend.html)

`property **[ListingHash](geo.TGeo.html#ListingHash)**: int64 read flistinghash;`

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

`procedure **assign**(const value: [TGeo](geo.TGeo.html));`

assign content to another instance

[![Public](public.gif "Public")](legend.html)

`procedure **LoadCurrent**(const tab: [TSqlitetable](SQLiteWrap.TSQLiteTable.html));`

Load from current row in database

[![Public](public.gif "Public")](legend.html)

`procedure **LoadByKey**(const gkey: int64);`

Load from database by a key

[![Public](public.gif "Public")](legend.html)

`procedure **LoadByGC**(const value: string);`

Load from database by a GC code

[![Public](public.gif "Public")](legend.html)

`procedure **LoadByKeyGC**(const gkey: int64; const value: string);`

Load from database by a key or by a GC code

[![Public](public.gif "Public")](legend.html)

`procedure **LoadKeyByGC**(const Value: string);`

Load key only - by a GC code

[![Public](public.gif "Public")](legend.html)

`procedure **LoadFoundByGC**(const Value: string);`

 

[![Public](public.gif "Public")](legend.html)

`procedure **LoadByLabID**(const value, name: string);`

Load form database by parent cache ID and LAB cache name

[![Public](public.gif "Public")](legend.html)

`procedure **SetDefault**;`

fill by default values

[![Public](public.gif "Public")](legend.html)

`procedure **ChangeID**(const value: string);`

Change ID of point

[![Public](public.gif "Public")](legend.html)

`procedure **UpdateFound**(value: TDateTime);`

save found date and time

[![Public](public.gif "Public")](legend.html)

`procedure **UpdateFoundDate**(value: TDateTime);`

save found date

[![Public](public.gif "Public")](legend.html)

`procedure **UpdateLastFound**(value: TDateTime);`

save LastFound date

[![Public](public.gif "Public")](legend.html)

`procedure **UpdateComment**(value: string);`

save user comment

[![Public](public.gif "Public")](legend.html)

`procedure **UpdateBasicInfo**;`

save basic point info

[![Public](public.gif "Public")](legend.html)

`procedure **Save**;`

Save current content to database

[![Public](public.gif "Public")](legend.html)

`function **UpdateListing**(const longdesc, shortdesc, hint: string; longdescflag, shortdescflag: integer): boolean;`

Save listing to database

[![Public](public.gif "Public")](legend.html)

`procedure **UpdateShortListing**(const shortdesc: string; shortdescflag: integer);`

Save just short listing to database

[![Public](public.gif "Public")](legend.html)

`procedure **UpdateLongListing**(const longdesc: string; longdescflag: integer);`

Save just long listing to database

[![Public](public.gif "Public")](legend.html)

`function **AddLog**: [TGeoLog](geo.TGeoLog.html);`

Add new log to database

[![Public](public.gif "Public")](legend.html)

`procedure **RemoveLogs**;`

Delete all current logs

[![Public](public.gif "Public")](legend.html)

`function **RefineLogs**(LeaveCount: integer; LeaveOwned, LeaveImportant: Boolean; LeaveUsers: string): integer;`

Do deletion in logs. Leave latest LeaveCount logs, additionally leave your ouwn logs and/or important logs

[![Public](public.gif "Public")](legend.html)

`procedure **RemoveListing**;`

Delete all listing informations

[![Public](public.gif "Public")](legend.html)

`procedure **RemoveTags**;`

Delete all tags

[![Public](public.gif "Public")](legend.html)

`procedure **RemoveWaypoints**;`

Delete all waypoints

[![Public](public.gif "Public")](legend.html)

`procedure **Remove**;`

Delete thic geocache form database, include all associated informations

[![Public](public.gif "Public")](legend.html)

`function **HaveFinal**: boolean;`

Have this geocache some final waypoint?

[![Public](public.gif "Public")](legend.html)

`function **HaveUserFinal**: boolean;`

Have this geocache some final waypoint defined by user?

[![Public](public.gif "Public")](legend.html)

`function **GetCoord**: string;`

Human readable coordinates

[![Public](public.gif "Public")](legend.html)

`function **HaveWaypoint**: Boolean;`

Have some waypoints?

[![Public](public.gif "Public")](legend.html)

`function **AttachmentDir**: string;`

directory for cache attachments

[![Public](public.gif "Public")](legend.html)

`function **HaveAttachment**: Boolean;`

Have some attachments?

[![Public](public.gif "Public")](legend.html)

`function **RTFAttachmentFile**: string;`

RTF attachment filename

[![Public](public.gif "Public")](legend.html)

`function **HaveRTFAttachment**: Boolean;`

Have RTF attachment?

[![Public](public.gif "Public")](legend.html)

`procedure **OpenRTFAttachment**;`

Open RTF attachment in external application

[![Public](public.gif "Public")](legend.html)

`function **HaveListing**: boolean;`

Have listing?

[![Public](public.gif "Public")](legend.html)

`function **SimpleUrl**: string;`

URL to geocaching web

[![Public](public.gif "Public")](legend.html)

`function **url**: string;`

URL to geocaching web

[![Public](public.gif "Public")](legend.html)

`function **IsDisabled**: Boolean;`

Is disabled?

[![Public](public.gif "Public")](legend.html)

`function **IsArchived**: Boolean;`

Is archived?

[![Public](public.gif "Public")](legend.html)

`function **IsFound**:Boolean;`

Is found by you?

[![Public](public.gif "Public")](legend.html)

`function **TypeID**: string;`

Short type identification (one char)

[![Public](public.gif "Public")](legend.html)

`function **SizeID**: string;`

Short size identification (one char)

[![Public](public.gif "Public")](legend.html)

`function **DiffID**: string;`

Short difficulty identification (one char)

[![Public](public.gif "Public")](legend.html)

`function **TerrID**: string;`

Short terrain identification (one char)

[![Public](public.gif "Public")](legend.html)

`function **IDTag**: string;`

Short ID tag in form like TM24

[![Public](public.gif "Public")](legend.html)

`function **NameSplit**: string;`

Helper for splitting into multiple directories

[![Public](public.gif "Public")](legend.html)

`function **IsListed**: boolean;`

is this cache displayed in geoget window?

[![Public](public.gif "Public")](legend.html)

`function **IsSelected**: boolean;`

is this cache displayed and selected in geoget window?

[![Public](public.gif "Public")](legend.html)

`function **IsFiltered**: boolean;`

Can this cache pass through filter?

[![Public](public.gif "Public")](legend.html)

`procedure **ListAdd**;`

Add to Geoget window

[![Public](public.gif "Public")](legend.html)

`procedure **ListDel**;`

Remove from Geoget window

[![Public](public.gif "Public")](legend.html)

`function **TagCategories**: string;`

set of associated tagh categories

[![Public](public.gif "Public")](legend.html)

`function **TagHaveCategory**(category: string): boolean;`

Is this tag category associated?

[![Public](public.gif "Public")](legend.html)

`function **TagValues**(Category: string): string;`

associated values withinthis tag category

[![Public](public.gif "Public")](legend.html)

`procedure **TagAdd**(Category, value: string);`

add tag

[![Public](public.gif "Public")](legend.html)

`procedure **TagReplace**(Category, value: string);`

add or replace tag

[![Public](public.gif "Public")](legend.html)

`procedure **TagReplaceList**(Category: string; const value: TStrings);`

add or replace set of tags

[![Public](public.gif "Public")](legend.html)

`procedure **TagDel**(Category, value: string);`

remove tag

[![Public](public.gif "Public")](legend.html)

`procedure **TagClear**(Category: string);`

Remove all associated tags in this category

[![Public](public.gif "Public")](legend.html)

`function **TagCategoryLastUpdate**(Category: string): TDateTime;`

Get timestamp of last tag modification

[![Public](public.gif "Public")](legend.html)

`function **FindNear**(Distance: Integer): integer;`

Search near geocaches within given distance

[![Public](public.gif "Public")](legend.html)

`procedure **TagInvalid**;`

Invalid cached tag informations. It forces to reload tag information next time.

[![Public](public.gif "Public")](legend.html)

`function **IsEmptyCoord**: boolean;`

Have empty coordinates?

[![Public](public.gif "Public")](legend.html)

`procedure **CountryState**(xcountry, xstate: string);`

Set country and state with content validation

[![Public](public.gif "Public")](legend.html)

`function **FinalWpt**: [TWpt](geo.TWpt.html);`

Get first final waypoint

[![Public](public.gif "Public")](legend.html)

`procedure **ShowListing**;`

Display Geoget window with listing

[![Public](public.gif "Public")](legend.html)

`function **Family**: string;`

Return family type (GC, WM, OC, OZ,...

[![Public](public.gif "Public")](legend.html)

`procedure **GetListing**(const value: TStrings; prefix: string);`

Generate HTML listing and convert links to local images to given prefix

### Properties

[![Public](public.gif "Public")](legend.html)

`property **Waypoints**: [TWptList](geo.TWptList.html) read getWptList;`

set of waypoints

[![Public](public.gif "Public")](legend.html)

`property **Logs**: [TGeoLogList](geo.TGeoLogList.html) read getLogList;`

set of logs

[![Public](public.gif "Public")](legend.html)

`property **NearGeo**: [TGeoList](geo.TGeoList.html) read FNearest;`

set of near geocaches (after [FindNear](geo.TGeo.html#FindNear) call)

[![Public](public.gif "Public")](legend.html)

`property **Key**: int64 read fkey write FKey;`

Database key

[![Public](public.gif "Public")](legend.html)

`property **ID**: String read fID write fID;`

Geocache ID

[![Public](public.gif "Public")](legend.html)

`property **Lat**: String read fCoordx write setx;`

Coordinates

[![Public](public.gif "Public")](legend.html)

`property **Lon**: String read fCoordY write sety;`

Coordinates

[![Public](public.gif "Public")](legend.html)

`property **CoordX**: String read fCoordx write setx;`

Coordinates

[![Public](public.gif "Public")](legend.html)

`property **CoordY**: String read fCoordY write sety;`

Coordinates

[![Public](public.gif "Public")](legend.html)

`property **LatNum**: extended read fxnum write setxnum;`

Coordinates

[![Public](public.gif "Public")](legend.html)

`property **LonNum**: extended read fynum write setynum;`

Coordinates

[![Public](public.gif "Public")](legend.html)

`property **CoordXNum**: extended read fxnum write setxnum;`

Coordinates

[![Public](public.gif "Public")](legend.html)

`property **CoordYNum**: extended read fynum write setynum;`

Coordinates

[![Public](public.gif "Public")](legend.html)

`property **CorrectedLat**: String read getcorx;`

Corrected Coordinates

[![Public](public.gif "Public")](legend.html)

`property **CorrectedLon**: String read getcory;`

Corrected Coordinates

[![Public](public.gif "Public")](legend.html)

`property **CorrectedCoordX**: String read getcorx;`

Corrected Coordinates

[![Public](public.gif "Public")](legend.html)

`property **CorrectedCoordY**: String read getcory;`

Corrected Coordinates

[![Public](public.gif "Public")](legend.html)

`property **CorrectedLatNum**: extended read getcorxnum;`

Corrected Coordinates

[![Public](public.gif "Public")](legend.html)

`property **CorrectedLonNum**: extended read getcorynum;`

Corrected Coordinates

[![Public](public.gif "Public")](legend.html)

`property **CorrectedCoordXNum**: extended read getcorxnum;`

Corrected Coordinates

[![Public](public.gif "Public")](legend.html)

`property **CorrectedCoordYNum**: extended read getcorynum;`

Corrected Coordinates

[![Public](public.gif "Public")](legend.html)

`property **GUID**: String read fGUID write fGUID;`

GUID

[![Public](public.gif "Public")](legend.html)

`property **Name**: String read fName write fName;`

Name of cache

[![Public](public.gif "Public")](legend.html)

`property **Author**: String read fAuthor write SetAuthor;`

Author of cache

[![Public](public.gif "Public")](legend.html)

`property **CacheType**: String read FcacheType write FCacheType;`

Type of cache

[![Public](public.gif "Public")](legend.html)

`property **Size**: String read FcacheSize write FcacheSize;`

Size of cache

[![Public](public.gif "Public")](legend.html)

`property **Difficulty**: String read FDifficulty write FDifficulty;`

Difficulty

[![Public](public.gif "Public")](legend.html)

`property **Terrain**: String read fTerrain write fTerrain;`

Terrain

[![Public](public.gif "Public")](legend.html)

`property **Comment**: String read FComment;`

User comment

[![Public](public.gif "Public")](legend.html)

`property **ShortDescription**: String read GetShortDesc;`

Listing short description

[![Public](public.gif "Public")](legend.html)

`property **LongDescription**: String read GetLongDesc;`

Listing long description

[![Public](public.gif "Public")](legend.html)

`property **Hint**: String read getHint;`

Listing hint

[![Public](public.gif "Public")](legend.html)

`property **Hidden**: TDateTime read fdtHidden write fdthidden;`

date of hidden

[![Public](public.gif "Public")](legend.html)

`property **LastFound**: TDateTime read fdtLast write fdtlast;`

date of last found (may not be allways used)

[![Public](public.gif "Public")](legend.html)

`property **Updated**: TDateTime read fdtUpdate write fdtupdate;`

date of last database update

[![Public](public.gif "Public")](legend.html)

`property **UpdatedList**: TDateTime read fdtUpdateList write fdtupdateList;`

date of last cache description database update

[![Public](public.gif "Public")](legend.html)

`property **Found**: TDateTime read fdtFound;`

date of your found

[![Public](public.gif "Public")](legend.html)

`property **FoundTime**: TDateTime read fdtFoundTime;`

time of your found

[![Public](public.gif "Public")](legend.html)

`property **IsOwner**: Boolean read fisowner;`

is it your own cache?

[![Public](public.gif "Public")](legend.html)

`property **CacheStatus**: integer read fcachestatus write fCacheStatus;`

cache status code

[![Public](public.gif "Public")](legend.html)

`property **Country**: String read FCountry write fCountry;`

Country

[![Public](public.gif "Public")](legend.html)

`property **State**: String read FState write fstate;`

State within a Country

[![Public](public.gif "Public")](legend.html)

`property **CacheID**: String read GetCacheID write fcacheID;`

CacheID in PQ

[![Public](public.gif "Public")](legend.html)

`property **OwnerID**: String read FOwnerID write FOwnerID;`

OwnerID in PQ

[![Public](public.gif "Public")](legend.html)

`property **StatusName**: string read GetStatusStr;`

cache status in human readable form

[![Public](public.gif "Public")](legend.html)

`property **ListingHash**: int64 read flistinghash;`

Murmu2 hash of shortdescription, longdescription and hint

* * *

_Generated by [PasDoc 0.9.0](http://pasdoc.sourceforge.net/) on 2018-03-13 21:07:27_