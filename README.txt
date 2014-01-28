========================================================
GeoWorldMap Import script for postgresql
========================================================

This is an adaption of the import script available at http://forums.geobytes.com/viewtopic.php?f=32&t=6816
as part of the geoworldmapuploader that allows the importing of the tables to a postgres DB.

It assumes an 8.2+ server version and uses psql functions
This means that the script needs to be run from psql:

> \i import_all_pg.sql

The script assumes that all the data is stored in a subfolder named DATA

