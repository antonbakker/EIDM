// =================================== BUDGET SCENARIOS =================================== //
TRACE # Load Budgetscenarios ;

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Dimensions)\*_BudgetScenarios.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

[BudgetScenarios]:
LOAD *
	FROM $(vDirectory_Dimensions)\*_BudgetScenarios.qvd (qvd);


ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;