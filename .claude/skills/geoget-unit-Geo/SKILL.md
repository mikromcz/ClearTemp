Unit geo
========

[Description](#@Description)

uses

[Classes, Interfaces, Objects and Records](#@Classes)

[Functions and Procedures](#@FuncsProcs)

Types

[Constants](#@Constants)

Variables

Description
-----------

Geoget classes for handling geocache data

Used internaly by Geoget, but can be used in Geoget scripts too!

Overview
--------

### Classes, Interfaces, Objects and Records

Name

Description

Class [`TGeoLog`](geo.TGeoLog.html)

Class for storing finder's logs

Class [`TWpt`](geo.TWpt.html)

Class for storing waypoint informations

Class [`TWptList`](geo.TWptList.html)

Class for storing set of waypoints

Class [`TGeoLogList`](geo.TGeoLogList.html)

Class for storing set of logs

Class [`TGeoList`](geo.TGeoList.html)

Class for storing set of geocaches

Class [`TGeo`](geo.TGeo.html)

Class for storing geocache informations

Class [`TGeoPolyList`](geo.TGeoPolyList.html)

 

Class [`TGeoPolyDivider`](geo.TGeoPolyDivider.html)

 

### Functions and Procedures

`procedure **[GetTagCategories](geo.html#GetTagCategories)**(const Result: tStrings);`

`procedure **[GetTagCategoriesUni](geo.html#GetTagCategoriesUni)**(const Result: tStrings);`

`procedure **[GetTagValues](geo.html#GetTagValues)**(Category: string; const Result: tStrings);`

`procedure **[GetTagValuesUni](geo.html#GetTagValuesUni)**(Category: string; const Result: tStrings);`

`procedure **[TagDelOrphan](geo.html#TagDelOrphan)**;`

`procedure **[DelTagCategoryByKey](geo.html#DelTagCategoryByKey)**(Key: int64);`

`procedure **[DelTagCategory](geo.html#DelTagCategory)**(Category: string);`

`procedure **[DelRenameTagCategoryByKey](geo.html#DelRenameTagCategoryByKey)**(Key: Int64; newcat: string);`

`procedure **[DelRenameTagCategory](geo.html#DelRenameTagCategory)**(Oldcat, newcat: string);`

`procedure **[GetCacheTypes](geo.html#GetCacheTypes)**(const value: TStrings);`

`procedure **[GetCacheSizes](geo.html#GetCacheSizes)**(const value: TStrings);`

`procedure **[GetWptTypes](geo.html#GetWptTypes)**(const value: TStrings);`

`procedure **[GetGradeValues](geo.html#GetGradeValues)**(const value: TStrings);`

`function **[NormalizeWptType](geo.html#NormalizeWptType)**(value: String): string;`

`function **[GetCacheTypeByID](geo.html#GetCacheTypeByID)**(value: integer): string;`

`function **[GetIDbyCacheType](geo.html#GetIDbyCacheType)**(value: string): integer;`

`function **[GetIDbyCacheSize](geo.html#GetIDbyCacheSize)**(value: string): integer;`

`function **[GetCacheSizeByID](geo.html#GetCacheSizeByID)**(value: integer): string;`

`procedure **[PrepareCountryPolygons](geo.html#PrepareCountryPolygons)**(const value: [TSqliteDatabase](SQLiteWrap.TSQLiteDatabase.html));`

`procedure **[MetadataWrite](geo.html#MetadataWrite)**(meta, value: string);`

`function **[MetadataRead](geo.html#MetadataRead)**(meta: string): string;`

### Constants

`**[wp_final](geo.html#wp_final)** = 'Final Location';`

`**[wp_reference](geo.html#wp_reference)** = 'Reference Point';`

`**[wp_stage](geo.html#wp_stage)** = 'Stages of a Multicache';`

`**[wp_question](geo.html#wp_question)** = 'Question to Answer';`

`**[wp_parking](geo.html#wp_parking)** = 'Parking Area';`

`**[wp_trail](geo.html#wp_trail)** = 'Trailhead';`

Description
-----------

### Functions and Procedures

`procedure **GetTagCategories**(const Result: tStrings);`

Fill all existing tag categories to stringlist.

`procedure **GetTagCategoriesUni**(const Result: tStrings);`

Fill all existing tag categories to stringlist. (native unicode version)

`procedure **GetTagValues**(Category: string; const Result: tStrings);`

Fill all existing tag values of some category to stringlist.

`procedure **GetTagValuesUni**(Category: string; const Result: tStrings);`

Fill all existing tag values of some category to stringlist. (native unicode version)

`procedure **TagDelOrphan**;`

Remove all orphaned tags.

`procedure **DelTagCategoryByKey**(Key: int64);`

Remove tag category and all associated tags.

`procedure **DelTagCategory**(Category: string);`

Remove tag category and all associated tags.

`procedure **DelRenameTagCategoryByKey**(Key: Int64; newcat: string);`

Rename tag category.

`procedure **DelRenameTagCategory**(Oldcat, newcat: string);`

Rename tag category.

`procedure **GetCacheTypes**(const value: TStrings);`

Fill all existing Geocache types to stringlist.

`procedure **GetCacheSizes**(const value: TStrings);`

Fill all existing Geocache sizes to stringlist.

`procedure **GetWptTypes**(const value: TStrings);`

Fill all existing waypoint types to stringlist.

`procedure **GetGradeValues**(const value: TStrings);`

Fill all existing terrain/difficulty values.

`function **NormalizeWptType**(value: String): string;`

 

`function **GetCacheTypeByID**(value: integer): string;`

 

`function **GetIDbyCacheType**(value: string): integer;`

 

`function **GetIDbyCacheSize**(value: string): integer;`

 

`function **GetCacheSizeByID**(value: integer): string;`

 

`procedure **PrepareCountryPolygons**(const value: [TSqliteDatabase](SQLiteWrap.TSQLiteDatabase.html));`

 

`procedure **MetadataWrite**(meta, value: string);`

 

`function **MetadataRead**(meta: string): string;`

 

### Constants

`**wp_final** = 'Final Location';`

 

`**wp_reference** = 'Reference Point';`

 

`**wp_stage** = 'Stages of a Multicache';`

 

`**wp_question** = 'Question to Answer';`

 

`**wp_parking** = 'Parking Area';`

 

`**wp_trail** = 'Trailhead';`

 

* * *

_Generated by [PasDoc 0.9.0](http://pasdoc.sourceforge.net/) on 2018-03-13 21:07:27_