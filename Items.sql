// =================================== ITEMS =================================== //

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Dimensions)\*_Items.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN
TRACE # Load Items;

Items:
	LOAD 
	// Key fields
	%Item_key, 
	%ItemAccount_key, 
	// New Fields
	// Qvd fields
     Item.Assortment01_CodeAndDescription, 
     Item.Assortment02_CodeAndDescription, 
     Item.Assortment03_CodeAndDescription, 
     Item.Assortment04_CodeAndDescription, 
     Item.Assortment05_CodeAndDescription, 
     Item.Assortment06_CodeAndDescription, 
     Item.Assortment07_CodeAndDescription, 
     Item.Assortment08_CodeAndDescription, 
     Item.Assortment09_CodeAndDescription, 
     Item.Assortment10_CodeAndDescription, 
     Item.WarehouseCodeAndDescription, 
     Item.Code, 
     Item.Description, 
     Item.TextDescription, 
     Item.Type, 
     Item.Status, 
     Item.Group, 
     Item.GroupDescription, 
     Item.Assortment01_Code, 
     Item.Assortment02_Code, 
     Item.Assortment03_Code, 
     Item.Assortment04_Code, 
     Item.Assortment05_Code, 
     Item.Assortment06_Code, 
     Item.Assortment07_Code, 
     Item.Assortment08_Code, 
     Item.Assortment09_Code, 
     Item.Assortment10_Code, 
     Item.Assortment01_Description,
	 Item.Assortment02_Description,
	 Item.Assortment03_Description,
	 Item.Assortment04_Description,
	 Item.Assortment05_Description,
	 Item.Assortment06_Description,
	 Item.Assortment07_Description,
	 Item.Assortment08_Description,
	 Item.Assortment09_Description,
	 Item.Assortment10_Description,
     Item.SalesItemYesNo, 
     Item.PurchaseItemYesNo, 
     Item.ServiceItemYesNo, 
     Item.DiscountItemYesNo, 
     Item.StockItemYesNo, 
     Item.WarehouseCode, 
     Item.WarehouseDescription, 
     Item.CostPriceStandard,
     Item.SalesPackagePrice,
     //
//     Item.MainItem, 
//     Item.MainItemDescription,
//     Item.ItemMatrix_Size,
//	 Item.ItemMatrix_Color 
	Item.MainOwnerpersonID,
	Item.MainOwnerpersonFullname,
	Item.GLAccountRevenueCode ,
	Item.GLAccountRevenueDesciption, 
	Item.GLAccountCostCode,
	Item.GLAccountCostDescription 
	FROM $(vDirectory_Dimensions)\*_Items.qvd (qvd);

	
ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;



