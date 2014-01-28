========================================================
GeoWorldMap Import script for postgresql
========================================================

This is an adaption of the import script available at http://forums.geobytes.com/viewtopic.php?f=32&t=6816
as part of the geoworldmapuploader that allows the importing of the tables to a postgres DB.

It assumes an 8.2+ server version and uses psql functions
This means that the script needs to be run from psql:

> \i import_all_pg.sql

The script assumes that all the data is stored in a subfolder named DATA
The script assumes that all the tables are to be added in a schema called geobytes which is already created and has appropriate permissions

My changes to the original import file (import_all.sql) are
 - change the create if not exists with conditional drop and then replace (and removing the corresponding table truncation)
 - add latin encoding
 - put all the tables in a schema instead of leaving them at the global space
 - replace int/smallint AUTOINCREMENTs with SERIAL
 - use \echo to display progress information instead of the select functions
 - changed the version file - rows is illegal field name use vrows
 - change vrows type to string - some of the rows data is "" which fails on import
 - use \copy to import the files - 
 - change the logic for test to make it work - also cast vrows  before comparing
 - put all test output as rows of a single table
