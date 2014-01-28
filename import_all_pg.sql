\echo Creating/Clearing Destination Tables
SET SEARCH_PATH TO geobytes;
SET CLIENT_ENCODING TO Latin1;
-- Create Tables

DROP TABLE IF EXISTS Cities;
CREATE TABLE Cities (
	CityId SERIAL NOT NULL ,
	CountryID smallint NOT NULL ,
	RegionID smallint NOT NULL ,
	City varchar (45) NOT NULL ,
	Latitude float NOT NULL ,
	Longitude float NOT NULL ,
	TimeZone varchar (10) NOT NULL ,
	DmaId smallint NULL ,
	Code varchar (4) NULL ,
	PRIMARY KEY(CityId)
	); 

DROP TABLE IF EXISTS Regions;
CREATE TABLE Regions (
	RegionID SERIAL NOT NULL ,
	CountryID smallint NOT NULL ,
	Region varchar (45) NOT NULL ,
	Code varchar (8) NOT NULL ,
	ADM1Code char (4) NOT NULL ,
	PRIMARY KEY(RegionID)
	);

DROP TABLE IF EXISTS Countries;
CREATE TABLE Countries (
	CountryId SERIAL NOT NULL ,
	Country varchar (50) NOT NULL ,
	FIPS104 varchar (2) NOT NULL ,
	ISO2 varchar (2) NOT NULL ,
	ISO3 varchar (3) NOT NULL ,
	ISON varchar (4) NOT NULL ,
	Internet varchar (2) NOT NULL ,
	Capital varchar (25) NULL ,
	MapReference varchar (50) NULL ,
	NationalitySingular varchar (35) NULL ,
	NationalityPlural varchar (35) NULL ,
	Currency varchar (30) NULL ,
	CurrencyCode varchar (3) NULL ,
	Population bigint NULL ,
	Title varchar (50) NULL ,
	Comment varchar (255) NULL ,
	PRIMARY KEY(CountryId)
	);

DROP TABLE IF EXISTS Dmas;
CREATE TABLE Dmas (
	DmaId smallint NOT NULL ,
	CountryId smallint NULL ,
	DMA varchar (3) NULL ,
	Market varchar (50) NULL
	);

-- changed rows to vrows and int vrows to varchar ... file contains empty strings the rows col
DROP TABLE IF EXISTS Version;
CREATE TABLE Version (
	Component varchar (50),
	Version varchar (50),
	VRows  varchar (50)
	);


\echo Loading Data Files Please Wait ...
-- Load Data From Flat Files

\echo Loading Cities...
\COPY Cities from 'DATA/cities.txt' DELIMITERS ',' CSV HEADER;
\echo Loading Regions...
\COPY Regions from 'DATA/regions.txt' DELIMITERS ',' CSV HEADER;
\echo Loading Countries...
\COPY Countries from 'DATA/countries.txt' DELIMITERS ',' CSV HEADER;
\echo Loading Dmas...
\COPY Dmas from 'DATA/dmas.txt' DELIMITERS ',' CSV HEADER;
\echo Loading Version...
\COPY Version from 'DATA/version.txt' DELIMITERS ',' CSV HEADER;

\echo Checking Tables ...

select 'Cities             ' as Table, (case when t.cnt = cast (v.vrows as int) then 'OK' else 'ERROR' end) as Test from (select count(*) as cnt from  Cities ) t, Version v where v.Component ='Cities'
UNION
select 'Countries          ' as Table, (case when t.cnt = cast (v.vrows as int) then 'OK' else 'ERROR' end) as Test from (select count(*) as cnt from  Countries ) t, Version v where v.Component ='Countries'
UNION
select 'Regions            ' as Table, (case when t.cnt = cast (v.vrows as int) then 'OK' else 'ERROR' end) as Test from (select count(*) as cnt from  Regions ) t, Version v where v.Component ='Regions'
UNION
select 'Dmas               ' as Table, (case when t.cnt = cast (v.vrows as int) then 'OK' else 'ERROR' end) as Test from (select count(*) as cnt from  Dmas ) t, Version v where v.Component ='Dmas';


