// =================================== IIR Dimensions =================================== //
TRACE # Load IIR dimensions;

SET ErrorMode = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Dimensions)\*_IIRSettings.qvd;
	IF ScriptError>1 AND ScriptError<>8 THEN 
	    TRACE File not found;
	ELSE 
	    TRACE File loaded;
	END IF 
	LET vFileCount = Alt(Peek('Files'), 0);
SET ErrorMode =1;

IF vFileCount = 1 THEN

IIRSettings:
LOAD * 
FROM $(vDirectory_Dimensions)\*_IIRSettings.qvd (qvd);


ENDIF

SET ErrorMode = 0;
	DROP TABLES CheckFileExists;
SET ErrorMode =1;

SET ErrorMode = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Dimensions)\*_IIRDivisions.qvd;
	IF ScriptError>1 AND ScriptError<>8 THEN 
	    TRACE File not found;
	ELSE 
	    TRACE File loaded;
	END IF 
	LET vFileCount = Alt(Peek('Files'), 0);
SET ErrorMode =1;

IF vFileCount = 1 THEN

IIRDivisions:
LOAD * 
FROM $(vDirectory_Dimensions)\*_IIRDivisions.qvd (qvd);


ENDIF

SET ErrorMode = 0;
	DROP TABLES CheckFileExists;
SET ErrorMode =1;


SET ErrorMode = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Dimensions)\*_IIRRegisters.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ErrorMode =1;

IF vFileCount = 1 THEN

IIRRegisters:
LOAD * 
FROM $(vDirectory_Dimensions)\*_IIRRegisters.qvd (qvd);


ENDIF

SET ErrorMode = 0;
	DROP TABLES CheckFileExists;
SET ErrorMode =1;


SET ErrorMode = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Dimensions)\*_IIRAuthorizers.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ErrorMode =1;

IF vFileCount = 1 THEN

IIRAuthorizers:
LOAD 
	* 
FROM $(vDirectory_Dimensions)\*_IIRAuthorizers.qvd (qvd);


ENDIF

SET ErrorMode = 0;
	DROP TABLES CheckFileExists;
SET ErrorMode =1;


SET ErrorMode = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Dimensions)\*_IIRInvoiceAuthorizers.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ErrorMode =1;

IF vFileCount = 1 THEN

IIRInvoiceAuthorizers:
LOAD 
	AUTONUMBER([IIRInvoiceAuthorizers.IIRDivision] & '|' & [IIRInvoiceAuthorizers.IIREntryGuid]) AS %IIREntryGuid_key,
	* 
FROM $(vDirectory_Dimensions)\*_IIRInvoiceAuthorizers.qvd (qvd);


ENDIF

SET ErrorMode = 0;
	DROP TABLES CheckFileExists;
SET ErrorMode =1;