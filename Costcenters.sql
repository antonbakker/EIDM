// =================================== COSTCENTERS =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Dimensions)\*_Costcenters.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN
TRACE # Load Costcnters;

Costcenters:
LOAD 
[%Costcenter_key],
[Costcenter.CodeAndDescription],
[Costcenter.Code],
[Costcenter.Class01],
[Costcenter.Class1Description],
[Costcenter.Class02],
[Costcenter.Class2Description],
[Costcenter.Class03],
[Costcenter.Class3Description],
[Costcenter.Class04],
[Costcenter.Class4Description],
[Costcenter.Enabled]
FROM $(vDirectory_Dimensions)\*_Costcenters.qvd (qvd);
	
ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;

