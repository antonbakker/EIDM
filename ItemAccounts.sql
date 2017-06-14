// =================================== ITEM ACCOUNTS =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Dimensions)\*_ItemAccounts.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN
TRACE # Load Itemaccounts;

ItemAccounts:
LOAD 
	 // Key fields
	%ItemAccount_key, 
	// New Fields
	// Qvd fields 
     ItemAccount.MainSupplier, 
     ItemAccount.PurchasePrice, 
     ItemAccount.PurchaseCurrency, 
     ItemAccount.PurchasePrice_EUR,
     ItemAccount.ItemCode, 
     ItemAccount.Code, 
     ItemAccount.Name
     FROM $(vDirectory_Dimensions)\*_ItemAccounts.qvd (qvd);

	
ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;
