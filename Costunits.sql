// =================================== COSTUNITS =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Dimensions)\*_Costunits.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN
TRACE # Load Costunits;

Costunits:
LOAD 
	// Key fields
	%Costunit_key, 
	// New Fields
	// Qvd fields
    Costunit.CodeAndDescription, 
    Costunit.Code
	FROM $(vDirectory_Dimensions)\*_Costunits.qvd (qvd);
	
ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;
