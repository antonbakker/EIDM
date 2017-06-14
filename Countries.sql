// =================================== COUNTRIES =================================== //

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Dimensions)\*Countries.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN
TRACE # Load Countries; 

Countries:
	LOAD 
	%Country_key, 
	// New Fields
	// Qvd fields
	Country.ContinentDescription,
	Country.ContinentCode,
	Country.Description,
	Country.Code
	FROM $(vDirectory_Dimensions)\*Countries.qvd (qvd);


ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;