select 'Creating/Clearing Destination Tables' as '';
-- Create Tables

CREATE TABLE IF NOT EXISTS Cities (
	CityId int AUTO_INCREMENT NOT NULL ,
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
TRUNCATE TABLE Cities;

CREATE TABLE IF NOT EXISTS Regions (
	RegionID smallint AUTO_INCREMENT NOT NULL ,
	CountryID smallint NOT NULL ,
	Region varchar (45) NOT NULL ,
	Code varchar (8) NOT NULL ,
	ADM1Code char (4) NOT NULL ,
	PRIMARY KEY(RegionID)
	);
TRUNCATE TABLE Regions;

CREATE TABLE IF NOT EXISTS Countries (
	CountryId smallint AUTO_INCREMENT NOT NULL ,
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
TRUNCATE TABLE Countries;

CREATE TABLE IF NOT EXISTS Dmas (
	DmaId smallint NOT NULL ,
	CountryId smallint NULL ,
	DMA varchar (3) NULL ,
	Market varchar (50) NULL
	);
TRUNCATE TABLE Dmas;

CREATE TABLE IF NOT EXISTS Version (
	Component varchar (50),
	Version varchar (50),
	Rows int
	);

TRUNCATE TABLE Version;


select 'Loading Data Files Please Wait ...' as '';
-- Load Data From Flat Files

LOAD DATA local INFILE 'cities.txt' INTO TABLE Cities
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA local INFILE 'regions.txt' INTO TABLE Regions
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA local INFILE 'countries.txt' INTO TABLE Countries
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA local INFILE 'dmas.txt' INTO TABLE Dmas
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA local INFILE 'version.txt' INTO TABLE Version
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

select "Checking Tables row count" as "";

select 'Countries          ',count(1), v.rows, if (count(1) = v.rows,"OK","ERROR" ) from  Countries	t, Version v where Component ="Countries";
select 'Regions            ',count(1), v.rows, if (count(1) = v.rows,"OK","ERROR" ) from  Regions		t, Version v where Component ="Regions";
select 'Cities             ',count(1), v.rows, if (count(1) = v.rows,"OK","ERROR" ) from  Cities		t, Version v where Component ="Cities";
select 'Dmas               ',count(1), v.rows, if (count(1) = v.rows,"OK","ERROR" ) from  Dmas		t, Version v where Component ="Dmas";

