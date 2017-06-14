// =================================== WAREHOUSES =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Dimensions)\*_Warehouses.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN
TRACE # Load Warehouses;

Warehouses:
	LOAD 
	// Key fields
	%Warehouse_key, 
	//AUTONUMBER(%Warehouserights_key, 'Warehouserights_key' ) AS %Warehouserights_key, 
	// New Fields
	// Qvd fields
	 Warehouse.CodeAndDescription, 
     Warehouse.Code, 
     Warehouse.Description, 
     Warehouse.Address, 
     Warehouse.Postcode, 
     Warehouse.City	
	FROM $(vDirectory_Dimensions)\*_Warehouses.qvd (qvd);

ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;


//Warehouserights:
	//LOAD 
	//AUTONUMBER(%Warehouserights_key, 'Warehouserights_key' ) AS %Warehouserights_key, 
	//Magazijn_Rechten.MAGAZUSERID 
	//FROM $(vDirectory_Dimensions)\*_MagazijnRechten.qvd (qvd);

