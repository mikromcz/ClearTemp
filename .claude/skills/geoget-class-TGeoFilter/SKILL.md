Class TGeoFilter
================

[Description](#@Description)

[Hierarchy](#@Hierarchy)

Fields

[Methods](#@Methods)

[Properties](#@Properties)

Unit
----

[GeoFilter](GeoFilter.html)

Declaration
-----------

`type TGeoFilter = class(TObject)`

Description
-----------

Classes for handling of data filtering

Note: tri-state integer in properties meaning: 0 - must not be 1 - must be 2 - is ignored

Hierarchy
---------

*   TObject
*   TGeoFilter

Overview
--------

### Methods

[![Public](public.gif "Public")](legend.html)

`constructor **[create](GeoFilter.TGeoFilter.html#create)**;`

[![Public](public.gif "Public")](legend.html)

`destructor **[Destroy](GeoFilter.TGeoFilter.html#Destroy)**; override;`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadDefault](GeoFilter.TGeoFilter.html#LoadDefault)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadFromFile](GeoFilter.TGeoFilter.html#LoadFromFile)**(value: string);`

[![Public](public.gif "Public")](legend.html)

`procedure **[SaveToFile](GeoFilter.TGeoFilter.html#SaveToFile)**(value: string);`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadFromName](GeoFilter.TGeoFilter.html#LoadFromName)**(value: string);`

[![Public](public.gif "Public")](legend.html)

`procedure **[SaveToName](GeoFilter.TGeoFilter.html#SaveToName)**(value: string);`

[![Public](public.gif "Public")](legend.html)

`procedure **[LoadFromGUI](GeoFilter.TGeoFilter.html#LoadFromGUI)**;`

[![Public](public.gif "Public")](legend.html)

`procedure **[SaveToGUI](GeoFilter.TGeoFilter.html#SaveToGUI)**;`

[![Public](public.gif "Public")](legend.html)

`function **[FilterGeo](GeoFilter.TGeoFilter.html#FilterGeo)**(const value: [TGeo](geo.TGeo.html)): boolean;`

[![Public](public.gif "Public")](legend.html)

`function **[FilterWpt](GeoFilter.TGeoFilter.html#FilterWpt)**(const value: [TWpt](geo.TWpt.html)): boolean;`

### Properties

[![Public](public.gif "Public")](legend.html)

`property **[TypeNames](GeoFilter.TGeoFilter.html#TypeNames)**: Tstringlist read FTypeNames;`

[![Public](public.gif "Public")](legend.html)

`property **[Container](GeoFilter.TGeoFilter.html#Container)**: TStringlist read FContainer;`

[![Public](public.gif "Public")](legend.html)

`property **[Terrain](GeoFilter.TGeoFilter.html#Terrain)**: TStringlist read FTerrain;`

[![Public](public.gif "Public")](legend.html)

`property **[Difficulty](GeoFilter.TGeoFilter.html#Difficulty)**: TStringlist read FDifficulty;`

[![Public](public.gif "Public")](legend.html)

`property **[WIgnoreNames](GeoFilter.TGeoFilter.html#WIgnoreNames)**: TStringList read FWIgnoreNames;`

[![Public](public.gif "Public")](legend.html)

`property **[WptNames](GeoFilter.TGeoFilter.html#WptNames)**: Tstringlist read FWptNames;`

[![Public](public.gif "Public")](legend.html)

`property **[PolyName](GeoFilter.TGeoFilter.html#PolyName)**: tstringlist read fpolyname;`

[![Public](public.gif "Public")](legend.html)

`property **[RouteName](GeoFilter.TGeoFilter.html#RouteName)**: tstringlist read froutename;`

[![Public](public.gif "Public")](legend.html)

`property **[PointsName](GeoFilter.TGeoFilter.html#PointsName)**: tstringlist read fpointsname;`

[![Public](public.gif "Public")](legend.html)

`property **[TagHave](GeoFilter.TGeoFilter.html#TagHave)**: tstringlist read ftaghave;`

[![Public](public.gif "Public")](legend.html)

`property **[TagNotHave](GeoFilter.TGeoFilter.html#TagNotHave)**: tstringlist read ftagnothave;`

[![Public](public.gif "Public")](legend.html)

`property **[FilterFile](GeoFilter.TGeoFilter.html#FilterFile)**: string read FFilterFile;`

[![Public](public.gif "Public")](legend.html)

`property **[FilterName](GeoFilter.TGeoFilter.html#FilterName)**: string read FFilterName;`

[![Public](public.gif "Public")](legend.html)

`property **[WaypointHandling](GeoFilter.TGeoFilter.html#WaypointHandling)**: integer read FWaypointHandling write FWaypointHandling;`

[![Public](public.gif "Public")](legend.html)

`property **[Archived](GeoFilter.TGeoFilter.html#Archived)**: integer read farchived write farchived;`

[![Public](public.gif "Public")](legend.html)

`property **[Own](GeoFilter.TGeoFilter.html#Own)**: integer read fown write fown;`

[![Public](public.gif "Public")](legend.html)

`property **[HaveWaypoint](GeoFilter.TGeoFilter.html#HaveWaypoint)**: integer read fwaypoint write fwaypoint;`

[![Public](public.gif "Public")](legend.html)

`property **[Disabled](GeoFilter.TGeoFilter.html#Disabled)**: integer read fdisabled write fdisabled;`

[![Public](public.gif "Public")](legend.html)

`property **[IsFound](GeoFilter.TGeoFilter.html#IsFound)**: integer read ffound write ffound;`

[![Public](public.gif "Public")](legend.html)

`property **[FamilyIndex](GeoFilter.TGeoFilter.html#FamilyIndex)**: integer read FFamilyIndex write FFamilyIndex;`

[![Public](public.gif "Public")](legend.html)

`property **[FamilyPrefix](GeoFilter.TGeoFilter.html#FamilyPrefix)**: string read FFamilyPrefix write FFamilyPrefix;`

[![Public](public.gif "Public")](legend.html)

`property **[TypeKind](GeoFilter.TGeoFilter.html#TypeKind)**: integer read ftypekind write ftypekind;`

[![Public](public.gif "Public")](legend.html)

`property **[Created](GeoFilter.TGeoFilter.html#Created)**: integer read fcreated write fcreated;`

[![Public](public.gif "Public")](legend.html)

`property **[CreatedDate](GeoFilter.TGeoFilter.html#CreatedDate)**: tdatetime read fcreateddate write fcreateddate;`

[![Public](public.gif "Public")](legend.html)

`property **[Updated](GeoFilter.TGeoFilter.html#Updated)**: integer read fupdated write fupdated;`

[![Public](public.gif "Public")](legend.html)

`property **[UpdatedDate](GeoFilter.TGeoFilter.html#UpdatedDate)**: tdatetime read fupdateddate write fupdateddate;`

[![Public](public.gif "Public")](legend.html)

`property **[LastFound](GeoFilter.TGeoFilter.html#LastFound)**: integer read flastfound write flastfound;`

[![Public](public.gif "Public")](legend.html)

`property **[LastFoundDate](GeoFilter.TGeoFilter.html#LastFoundDate)**: tdatetime read flastfounddate write flastfounddate;`

[![Public](public.gif "Public")](legend.html)

`property **[Found](GeoFilter.TGeoFilter.html#Found)**: integer read ffoundd write ffoundd;`

[![Public](public.gif "Public")](legend.html)

`property **[FoundDate](GeoFilter.TGeoFilter.html#FoundDate)**: tdatetime read ffoundddate write ffoundddate;`

[![Public](public.gif "Public")](legend.html)

`property **[DCreated](GeoFilter.TGeoFilter.html#DCreated)**: integer read fdcreated write fdcreated;`

[![Public](public.gif "Public")](legend.html)

`property **[DCreatedDays](GeoFilter.TGeoFilter.html#DCreatedDays)**: integer read fdcreateddays write fdcreateddays;`

[![Public](public.gif "Public")](legend.html)

`property **[DUpdated](GeoFilter.TGeoFilter.html#DUpdated)**: integer read fdupdated write fdupdated;`

[![Public](public.gif "Public")](legend.html)

`property **[DUpdatedDays](GeoFilter.TGeoFilter.html#DUpdatedDays)**: integer read fdupdateddays write fdupdateddays;`

[![Public](public.gif "Public")](legend.html)

`property **[DLastFound](GeoFilter.TGeoFilter.html#DLastFound)**: integer read fdlastfound write fdlastfound;`

[![Public](public.gif "Public")](legend.html)

`property **[DLastFoundDays](GeoFilter.TGeoFilter.html#DLastFoundDays)**: integer read fdlastfounddays write fdlastfounddays;`

[![Public](public.gif "Public")](legend.html)

`property **[DFound](GeoFilter.TGeoFilter.html#DFound)**: integer read fdfound write fdfound;`

[![Public](public.gif "Public")](legend.html)

`property **[DFoundDays](GeoFilter.TGeoFilter.html#DFoundDays)**: integer read fdfounddays write fdfounddays;`

[![Public](public.gif "Public")](legend.html)

`property **[Distance](GeoFilter.TGeoFilter.html#Distance)**: integer read fdistance write fdistance;`

[![Public](public.gif "Public")](legend.html)

`property **[DistanceValue](GeoFilter.TGeoFilter.html#DistanceValue)**: double read fdistancevalue write fdistancevalue;`

[![Public](public.gif "Public")](legend.html)

`property **[EmptyCoord](GeoFilter.TGeoFilter.html#EmptyCoord)**: integer read femptycoord write femptycoord;`

[![Public](public.gif "Public")](legend.html)

`property **[InCountry](GeoFilter.TGeoFilter.html#InCountry)**: integer read fincountry write fincountry;`

[![Public](public.gif "Public")](legend.html)

`property **[Country](GeoFilter.TGeoFilter.html#Country)**: string read fcountry write fcountry;`

[![Public](public.gif "Public")](legend.html)

`property **[InCountryState](GeoFilter.TGeoFilter.html#InCountryState)**: integer read finstate write finstate;`

[![Public](public.gif "Public")](legend.html)

`property **[CountryState](GeoFilter.TGeoFilter.html#CountryState)**: string read fcountrystate write fcountrystate;`

[![Public](public.gif "Public")](legend.html)

`property **[WImported](GeoFilter.TGeoFilter.html#WImported)**: integer read fwimported write fwimported;`

[![Public](public.gif "Public")](legend.html)

`property **[WEmptyCoord](GeoFilter.TGeoFilter.html#WEmptyCoord)**: integer read fwemptycoord write fwemptycoord;`

[![Public](public.gif "Public")](legend.html)

`property **[WPolyCoord](GeoFilter.TGeoFilter.html#WPolyCoord)**: boolean read fwpolycoord write fwpolycoord;`

[![Public](public.gif "Public")](legend.html)

`property **[WUpdated](GeoFilter.TGeoFilter.html#WUpdated)**: integer read fwupdated write fwupdated;`

[![Public](public.gif "Public")](legend.html)

`property **[WUpdatedDate](GeoFilter.TGeoFilter.html#WUpdatedDate)**: TDateTime read fwupdateddate write fwupdateddate;`

[![Public](public.gif "Public")](legend.html)

`property **[WDUpdated](GeoFilter.TGeoFilter.html#WDUpdated)**: integer read fwdupdated write fwdupdated;`

[![Public](public.gif "Public")](legend.html)

`property **[WDUpdatedDays](GeoFilter.TGeoFilter.html#WDUpdatedDays)**: integer read fwdupdateddays write fwdupdateddays;`

[![Public](public.gif "Public")](legend.html)

`property **[HaveListing](GeoFilter.TGeoFilter.html#HaveListing)**: integer read fhavelisting write fhavelisting;`

[![Public](public.gif "Public")](legend.html)

`property **[HaveComment](GeoFilter.TGeoFilter.html#HaveComment)**: integer read fhavecomment write fhavecomment;`

[![Public](public.gif "Public")](legend.html)

`property **[HaveAttach](GeoFilter.TGeoFilter.html#HaveAttach)**: integer read fhaveattach write fhaveattach;`

[![Public](public.gif "Public")](legend.html)

`property **[HaveFinal](GeoFilter.TGeoFilter.html#HaveFinal)**: integer read fhavefinal write fhavefinal;`

[![Public](public.gif "Public")](legend.html)

`property **[WptKind](GeoFilter.TGeoFilter.html#WptKind)**: integer read Fwptkind write Fwptkind;`

[![Public](public.gif "Public")](legend.html)

`property **[WptImported](GeoFilter.TGeoFilter.html#WptImported)**: integer read fwptimported write fwptimported;`

[![Public](public.gif "Public")](legend.html)

`property **[WptEmptyCoord](GeoFilter.TGeoFilter.html#WptEmptyCoord)**: integer read fwptemptycoord write fwptemptycoord;`

[![Public](public.gif "Public")](legend.html)

`property **[InPoly](GeoFilter.TGeoFilter.html#InPoly)**: integer read finpoly write finpoly;`

[![Public](public.gif "Public")](legend.html)

`property **[PolyCorrected](GeoFilter.TGeoFilter.html#PolyCorrected)**: boolean read fpolycorrected write fpolycorrected;`

[![Public](public.gif "Public")](legend.html)

`property **[InRoute](GeoFilter.TGeoFilter.html#InRoute)**: integer read finroute write finroute;`

[![Public](public.gif "Public")](legend.html)

`property **[RouteCorrected](GeoFilter.TGeoFilter.html#RouteCorrected)**: boolean read froutecorrected write froutecorrected;`

[![Public](public.gif "Public")](legend.html)

`property **[RouteDistance](GeoFilter.TGeoFilter.html#RouteDistance)**: double read froutedistance write froutedistance;`

[![Public](public.gif "Public")](legend.html)

`property **[InPoints](GeoFilter.TGeoFilter.html#InPoints)**: integer read finPoints write finPoints;`

[![Public](public.gif "Public")](legend.html)

`property **[PointsCorrected](GeoFilter.TGeoFilter.html#PointsCorrected)**: boolean read fPointscorrected write fPointscorrected;`

[![Public](public.gif "Public")](legend.html)

`property **[PointsDistance](GeoFilter.TGeoFilter.html#PointsDistance)**: double read fPointsdistance write fPointsdistance;`

Description
-----------

### Methods

[![Public](public.gif "Public")](legend.html)

`constructor **create**;`

class constructor

[![Public](public.gif "Public")](legend.html)

`destructor **Destroy**; override;`

class destructor

[![Public](public.gif "Public")](legend.html)

`procedure **LoadDefault**;`

fill all properties by default values

[![Public](public.gif "Public")](legend.html)

`procedure **LoadFromFile**(value: string);`

load properties from the \*.GGF file

[![Public](public.gif "Public")](legend.html)

`procedure **SaveToFile**(value: string);`

save properties to the \*.GGF file

[![Public](public.gif "Public")](legend.html)

`procedure **LoadFromName**(value: string);`

load properties from the filter name. (Filter with this name must be stored in currect data directory)

[![Public](public.gif "Public")](legend.html)

`procedure **SaveToName**(value: string);`

save properties to the filter name. (Filter with this name will be stored in currect data directory)

[![Public](public.gif "Public")](legend.html)

`procedure **LoadFromGUI**;`

Load properties from the GUI filter dialog.

[![Public](public.gif "Public")](legend.html)

`procedure **SaveToGUI**;`

Save properties to the GUI filter dialog.

[![Public](public.gif "Public")](legend.html)

`function **FilterGeo**(const value: [TGeo](geo.TGeo.html)): boolean;`

Test if TGeo instance can pass current filter.

[![Public](public.gif "Public")](legend.html)

`function **FilterWpt**(const value: [TWpt](geo.TWpt.html)): boolean;`

Test if TWpt instance can pass current filter.

### Properties

[![Public](public.gif "Public")](legend.html)

`property **TypeNames**: Tstringlist read FTypeNames;`

Set of point type names. Handling depending on [TypeKind](GeoFilter.TGeoFilter.html#TypeKind).

[![Public](public.gif "Public")](legend.html)

`property **Container**: TStringlist read FContainer;`

Set of allowed container sizes.

[![Public](public.gif "Public")](legend.html)

`property **Terrain**: TStringlist read FTerrain;`

Set of allowed terrains.

[![Public](public.gif "Public")](legend.html)

`property **Difficulty**: TStringlist read FDifficulty;`

Set of allowed difficulties.

[![Public](public.gif "Public")](legend.html)

`property **WIgnoreNames**: TStringList read FWIgnoreNames;`

Set of waypoint type names what will be ignored on the filter output.

[![Public](public.gif "Public")](legend.html)

`property **WptNames**: Tstringlist read FWptNames;`

Set of way type names. Handling depending on [WptKind](GeoFilter.TGeoFilter.html#WptKind).

[![Public](public.gif "Public")](legend.html)

`property **PolyName**: tstringlist read fpolyname;`

Set of polygon names. (Just relative names without file extension.)

[![Public](public.gif "Public")](legend.html)

`property **RouteName**: tstringlist read froutename;`

Set of route names. (Just relative names without file extension.)

[![Public](public.gif "Public")](legend.html)

`property **PointsName**: tstringlist read fpointsname;`

Set of points\_set names. (Just relative names without file extension.)

[![Public](public.gif "Public")](legend.html)

`property **TagHave**: tstringlist read ftaghave;`

Tags what point must have. (Each line is the pair category=value)

[![Public](public.gif "Public")](legend.html)

`property **TagNotHave**: tstringlist read ftagnothave;`

Tags what point must not have. (Each line is the pair category=value)

[![Public](public.gif "Public")](legend.html)

`property **FilterFile**: string read FFilterFile;`

filename of filter file after load

[![Public](public.gif "Public")](legend.html)

`property **FilterName**: string read FFilterName;`

name of filter after load

[![Public](public.gif "Public")](legend.html)

`property **WaypointHandling**: integer read FWaypointHandling write FWaypointHandling;`

how to handle points and waypoints. 0 - include points and waypoints 1 - waypoints only 2 - points only

[![Public](public.gif "Public")](legend.html)

`property **Archived**: integer read farchived write farchived;`

point is archived (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **Own**: integer read fown write fown;`

point is your own (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **HaveWaypoint**: integer read fwaypoint write fwaypoint;`

point have some waypoints (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **Disabled**: integer read fdisabled write fdisabled;`

point is disabled (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **IsFound**: integer read ffound write ffound;`

point is found by you (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **FamilyIndex**: integer read FFamilyIndex write FFamilyIndex;`

Filter for point family. 0 - GC 1 - WM 2 - OC (OZ,...) 3 - other (prefix is defined by [FamilyPrefix](GeoFilter.TGeoFilter.html#FamilyPrefix))

[![Public](public.gif "Public")](legend.html)

`property **FamilyPrefix**: string read FFamilyPrefix write FFamilyPrefix;`

While [FamilyIndex](GeoFilter.TGeoFilter.html#FamilyIndex) is 3, then here is wanted point name prefix.

[![Public](public.gif "Public")](legend.html)

`property **TypeKind**: integer read ftypekind write ftypekind;`

point type is one of [TypeNames](GeoFilter.TGeoFilter.html#TypeNames) (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **Created**: integer read fcreated write fcreated;`

point created after... (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **CreatedDate**: tdatetime read fcreateddate write fcreateddate;`

date for point created

[![Public](public.gif "Public")](legend.html)

`property **Updated**: integer read fupdated write fupdated;`

point updated after... (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **UpdatedDate**: tdatetime read fupdateddate write fupdateddate;`

date for point updated

[![Public](public.gif "Public")](legend.html)

`property **LastFound**: integer read flastfound write flastfound;`

last-found date after... (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **LastFoundDate**: tdatetime read flastfounddate write flastfounddate;`

date for point last-found

[![Public](public.gif "Public")](legend.html)

`property **Found**: integer read ffoundd write ffoundd;`

you found this point after... (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **FoundDate**: tdatetime read ffoundddate write ffoundddate;`

date for point found

[![Public](public.gif "Public")](legend.html)

`property **DCreated**: integer read fdcreated write fdcreated;`

point is created within last days... (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **DCreatedDays**: integer read fdcreateddays write fdcreateddays;`

days number for point created

[![Public](public.gif "Public")](legend.html)

`property **DUpdated**: integer read fdupdated write fdupdated;`

point is updated within last days... (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **DUpdatedDays**: integer read fdupdateddays write fdupdateddays;`

days number for point updated

[![Public](public.gif "Public")](legend.html)

`property **DLastFound**: integer read fdlastfound write fdlastfound;`

point have last-found within last days... (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **DLastFoundDays**: integer read fdlastfounddays write fdlastfounddays;`

days number for point last-found

[![Public](public.gif "Public")](legend.html)

`property **DFound**: integer read fdfound write fdfound;`

point is found by you within last days... (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **DFoundDays**: integer read fdfounddays write fdfounddays;`

days number for found

[![Public](public.gif "Public")](legend.html)

`property **Distance**: integer read fdistance write fdistance;`

point is within distance from the reference point (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **DistanceValue**: double read fdistancevalue write fdistancevalue;`

Distance from the reference point (in the km)

[![Public](public.gif "Public")](legend.html)

`property **EmptyCoord**: integer read femptycoord write femptycoord;`

point have empty coordinates (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **InCountry**: integer read fincountry write fincountry;`

point is in the country (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **Country**: string read fcountry write fcountry;`

Country name

[![Public](public.gif "Public")](legend.html)

`property **InCountryState**: integer read finstate write finstate;`

point is in the country-state (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **CountryState**: string read fcountrystate write fcountrystate;`

Country-state name

[![Public](public.gif "Public")](legend.html)

`property **WImported**: integer read fwimported write fwimported;`

show imported waypoints (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **WEmptyCoord**: integer read fwemptycoord write fwemptycoord;`

show waypoints with empty coordinates (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **WPolyCoord**: boolean read fwpolycoord write fwpolycoord;`

show waypoints what matching polygon filter (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **WUpdated**: integer read fwupdated write fwupdated;`

show waypoints what was updated after... (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **WUpdatedDate**: TDateTime read fwupdateddate write fwupdateddate;`

Date value for [WUpdated](GeoFilter.TGeoFilter.html#WUpdated)

[![Public](public.gif "Public")](legend.html)

`property **WDUpdated**: integer read fwdupdated write fwdupdated;`

show waypoints what was updated within last days... (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **WDUpdatedDays**: integer read fwdupdateddays write fwdupdateddays;`

Days value for [WDUpdated](GeoFilter.TGeoFilter.html#WDUpdated)

[![Public](public.gif "Public")](legend.html)

`property **HaveListing**: integer read fhavelisting write fhavelisting;`

Point have a listing (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **HaveComment**: integer read fhavecomment write fhavecomment;`

Point have a user comment (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **HaveAttach**: integer read fhaveattach write fhaveattach;`

Point have an attachment (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **HaveFinal**: integer read fhavefinal write fhavefinal;`

Point have an unempty final waypoint (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **WptKind**: integer read Fwptkind write Fwptkind;`

Point must have at least one waypoint of [WptNames](GeoFilter.TGeoFilter.html#WptNames) type (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **WptImported**: integer read fwptimported write fwptimported;`

Point have at least one imported waypoint (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **WptEmptyCoord**: integer read fwptemptycoord write fwptemptycoord;`

Point have at least one waypoint with empty coordinates (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **InPoly**: integer read finpoly write finpoly;`

Point is inside one of polygons specified at [PolyName](GeoFilter.TGeoFilter.html#PolyName) (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **PolyCorrected**: boolean read fpolycorrected write fpolycorrected;`

Use corrected coordinates for polygon match

[![Public](public.gif "Public")](legend.html)

`property **InRoute**: integer read finroute write finroute;`

Point is near the one of routes specified at [RouteName](GeoFilter.TGeoFilter.html#RouteName) (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **RouteCorrected**: boolean read froutecorrected write froutecorrected;`

Use corrected coordinates for route match

[![Public](public.gif "Public")](legend.html)

`property **RouteDistance**: double read froutedistance write froutedistance;`

Allowed point distance from the Route

[![Public](public.gif "Public")](legend.html)

`property **InPoints**: integer read finPoints write finPoints;`

Point is near the one of routes specified at [RouteName](GeoFilter.TGeoFilter.html#RouteName) (tri-state)

[![Public](public.gif "Public")](legend.html)

`property **PointsCorrected**: boolean read fPointscorrected write fPointscorrected;`

Use corrected coordinates for route match

[![Public](public.gif "Public")](legend.html)

`property **PointsDistance**: double read fPointsdistance write fPointsdistance;`

Allowed point distance from the Route

* * *

_Generated by [PasDoc 0.9.0](http://pasdoc.sourceforge.net/) on 2018-03-13 21:07:27_