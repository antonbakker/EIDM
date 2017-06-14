// =================================== REQUEST STATUS =================================== //
TRACE # Load Requeststatus descriptions;

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Dimensions)\*Requeststatus.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

[Requeststatus]:
LOAD 
	%RequestStatus_key, 
     Requeststatuscode, 
     Requeststatusdescription
FROM $(vDirectory_Dimensions)\Requeststatus.qvd (qvd);

ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;