// =================================== DATABASES =================================== //
TRACE # Load Databases;

MapNaam:
Mapping
LOAD
    Database	as [Database Code],
    "Naam administratie"	as [Administratie naam]
FROM [lib://Include (sagro_qsadmin)/Vertaaltabel administraties.xlsx]
(ooxml, embedded labels, table is Sheet1);

Databases:
	LOAD 
	ApplyMap('MapNaam',[Database Code],'')				as [Administratie naam],
    [%Database_key],
	[Database Label],
	[Database Code],
	[Database],
	[Divisions.bedrzk],
	[Divisions.bank_rek],
	[Divisions.pstbanknr],
	[Divisions.kvk_nummer],
	[Divisions.kvk_woonpl],
	[Divisions.btw_nummer],
	[Divisions.lb_nummer],
	[Divisions.fiscnr],
	[Divisions.valcode],
	[Divisions.batchlevel],
	[Divisions.achternaam],
	[Divisions.adr],
	[Divisions.adres2],
	[Divisions.adres3],
	[Divisions.pstcd],
	[Divisions.woonpl],
	[Divisions.landcode],
	[Divisions.cpers],
	[Divisions.telnr],
	[Divisions.faxnr],
	[Divisions.telex],
	[Divisions.corr_adres],
	[Divisions.corr_adr2],
	[Divisions.corr_adr3],
	[Divisions.corr_pcode],
	[Divisions.corr_wplts],
	[Divisions.corr_lndcd],
	[Divisions.fiscode],
	[Divisions.region],
	[Divisions.syscreated],
	[Divisions.Active],
	[Divisions.VersionMajor],
	[Divisions.VersionMinor],
	[Divisions.Revision],
	[Divisions.Build],
	[Divisions.website],
	[Divisions.WorkingHours],
	[Divisions.start_date],
	[Divisions.CompanyType],
	[Divisions.CompanyNumber],
	[Divisions.CompanyPath],
	[Divisions.LastImportTransactionCode],
	[Divisions.LastImportDate],
	[Divisions.DateStart],
	[Divisions.DateEnd],
	[Divisions.hrcmp_wwn],
	[Divisions.CostcenterCode],
	[Divisions.ESalaris],
	[Divisions.DefForCountry],
	[Divisions.ResellerPort],
	[Divisions.CustomerPort],
	[Divisions.PeriodCloseFlag],
	[Divisions.fakt_code],
	[Divisions.MailBoxOption],
	[Divisions.MailBoxServer],
	[Divisions.SecurityLevel],
	[Divisions.MaintCRMBackOffice],
	[Divisions.Division],
	[Divisions.URL]
FROM $(vDirectory_Dimensions)\*_Databases.qvd (qvd);



