// =================================== CONCATENATE FACTS =================================== //
// LOAD ALL FACTS FROM BOTH GLOBE AND SYNERGY
//
// 2015-06-11. Concatenate of facts in the store tab

TRACE # Load all facts from both Exact Globe and Exact Synergy Enterprise;


Facts:
// First load a dummy facts. All other facts are only added when they exist. This depends on if the customer uses Exact Globe, Exact Synergy or both.
LOAD * INLINE [
    %Date_key
    today()
];





//Invoice History Facts
// First check if file exists. If file exists then load
SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_FactsLogistics)\*_Invoicehistory.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_Invoicehistory:
//CONCATENATE 
LOAD  
	// Key fields
	%Database_key, 
	%Item_key, 
	%Customer_key, 
	%Warehouse_key, 
	%Date_key, 
	%Country_key,
	%Project_key,
	%Costcenter_key, 
	%Costunit_key, 
	%Employee_key,
	// New Fields
	// Qvd fields 
	InvoiceHistory.InvoiceNumber, 
	InvoiceHistory.InvoiceDate, 
	InvoiceHistory.Quantity, 
	InvoiceHistory.Revenue, 
	InvoiceHistory.Cost, 
	InvoiceHistory.Margin,
	InvoiceHistory.ProjectCountry
	FROM $(vDirectory_FactsLogistics)\*_Invoicehistory.qvd (qvd)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen   
    
    
    ;
	
ENDIF



SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;


//Sales Order Facts
// First check if file exists. If file exists then load
SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_FactsLogistics)\*SalesOrders.qvd (qvd);
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_SalesOrders:
//NOCONCATENATE 
LOAD 
	// Key fields
	%Database_key, 
	%Item_key, 
	%Customer_key, 
	%Warehouse_key, 
	%Costcenter_key, 
	%Costunit_key, 
	%Date_key,
	%Country_key, 
	// New Fields
	// Qvd fields
//     SalesOrder.LineCountFillRate, 
//     SalesOrder.SKUFillRate, 
//     SalesOrder.ValueFillRate, 
     SalesOrder.DeliveryDate, 
//     SalesOrder.OrderDate, 
//     SalesOrder.RequestedDate, 
//     SalesOrder.PlannedDate, 
     //SalesOrder.OriginalPlannedDate, 
     SalesOrder.OriginalPlannedDate, 
     SalesOrder.LineID, 
     SalesOrder.OrderNumber, 
     SalesOrder.QuantityDelivered, 
     SalesOrder.QuantityDelivered_Early, 
     SalesOrder.QuantityDelivered_Late, 
     SalesOrder.QuantityDelivered_OnTime, 
     SalesOrder.Delivered_OnTimeYesNo,
     SalesOrder.ValueOrdered,
     SalesOrder.SelectionCode
	FROM $(vDirectory_FactsLogistics)\*SalesOrders.qvd (qvd)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen   
    ;

ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;

//Purchase Order Facts
// First check if file exists. If file exists then load
SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_FactsLogistics)\*PurchaseOrders.qvd (qvd);
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_PurchaseOrders:
//NOCONCATENATE 
LOAD 
	// Key fields
	%Database_key, 
	%Item_key, 
	%Customer_key, 
	%Warehouse_key,  
	%Costcenter_key, 
	%Costunit_key, 
	%Date_key,
	%Country_key, 
	// New Fields
	// Qvd fields
     //PurchaseOrder.DeliveryDate, 
     PurchaseOrder.DeliveryDate,
     //PurchaseOrder.OrderDate, 
     PurchaseOrder.OrderDate,
     //PurchaseOrder.RequestedDate, 
     PurchaseOrder.RequestedDate,
     //PurchaseOrder.PlannedDate, 
     PurchaseOrder.PlannedDate,
     //PurchaseOrder.OriginalPlannedDate, 
     PurchaseOrder.OriginalPlannedDate,
     PurchaseOrder.LineID, 
     PurchaseOrder.OrderNumber, 
     PurchaseOrder.QuantityReceived, 
     PurchaseOrder.QuantityReceived_Early, 
     PurchaseOrder.QuantityReceived_Late, 
     PurchaseOrder.QuantityReceived_OnTime, 
     PurchaseOrder.Received_OnTimeYesNo, 
	 // Ferry Laurentiu, 15-9-2015
     // Added PurchaseOrder OrderStatus and OrderLineStatus to be able to determine outstanding lines
     PurchaseOrder.OrderStatus, 
     PurchaseOrder.OrderLineStatus, 
     PurchaseOrder.QuantityOrdered, 
     PurchaseOrder.ValueOrdered, 
     PurchaseOrder.ValueReceived
	FROM $(vDirectory_FactsLogistics)\*PurchaseOrders.qvd (qvd)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen   
    
    ;

ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;


//Stock facts
// First check if file exists. If file exists then load
SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_FactsLogistics)\*_Stock.qvd (qvd);
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_Stock:
//NOCONCATENATE 
LOAD 
	// Key fields
	%Database_key, 
	%Date_key, 
	%Customer_key, 
	%Country_key, 
	%Item_key, 
	%Warehouse_key,  
	%Costcenter_key, 
	%Costunit_key,  
	// New Fields
	// Qvd fields
     Stock.TransactionSubTypeDescription, 
     Stock.TransactionTypeDescription, 
     Stock.TransactionDate,
     Stock.QuantityOnHand, 
     Stock.ValueOnHand, 
     Stock.QuantityToBeDelivered, 
     Stock.QuantityToBeReceived, 
     Stock.QuantityAvailable 
	FROM $(vDirectory_FactsLogistics)\*_Stock.qvd (qvd)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen   
    
    ;

ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;


//Stock Levels Month Start
// First check if file exists. If file exists then load
SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_MonthStartStock)\*_StockMonthStartTotal.qvd (qvd);
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_StockMonthStartTotal:
//NOCONCATENATE 
LOAD 
	// Key fields
	%Database_key, 
	%Item_key, 
	%Date_key, 
	// New Fields
	// Qvd fields
     %Date_key AS StockMonthStart.Date, 
     StockMonthStart.QuantityOnHand, 
     StockMonthStart.ValueOnHand 
	FROM $(vDirectory_MonthStartStock)\*_StockMonthStartTotal.qvd (qvd)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen       
    ;

ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;



// Financial Facts:
// First check if file exists. If file exists then load
SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Facts)\*_GLTransactions.qvd (qvd);
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_GLTransactions:
//NOCONCATENATE 
LOAD 
	// Key fields
	%Date_key, 
	%Database_key, 
	%GeneralLedger_key, 
	%Costcenter_key, 
	%Costunit_key, 
	%Customer_key,  
	%Item_key, 
	%Project_key,
	%Employee_key,
	AUTONUMBER(%IIREntryGuid_key) as %IIREntryGuid_key ,
	// New Fields
	// Qvd fields
	GLTransaction.PL_Balance, 
    GLTransaction.Balance_Balance, 
    NUM(GLTransaction.InvoiceNumber)  AS [GLTransaction.InvoiceNumber], 
    GLTransaction.Quantity, 
    GLTransaction.EntryNumber, 
//    GLTransaction.EntryNumberSub, 
//    GLTransaction.Value, 
//    GLTransaction.BalanceOrPL, 
    GLTransaction.YourReference,
    GLTransaction.Description,
   	GLTransaction.Transsubtype,
	GLTransaction.Transsubtypedescription
	FROM $(vDirectory_Facts)\*_GLTransactions.qvd (qvd)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen    
    
    ; 

ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;



// =================================== FACTS: OUTSTANDING ITEMS CURRENT=================================== //

// First check if file exists. If file exists then load
SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_OutstandingItems)\*_OutstandingItems_CurrentYear.qvd (qvd);
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_OutstandingItems:
//NOCONCATENATE 
LOAD
	// Key fields
	%Date_key, 
	%Customer_key, 
	%Database_key, 
	// New Fields
	// Qvd fields
 	OutstandingItems.SalesOrPurchase, 
     //OutstandingItems.AgeCategory, 
     OutstandingItems.Balance, 
     OutstandingItems.Age_Invoice,
     OutstandingItems.EntryNumber,
     //OutstandingItems.DaysToLate, 
     //OutstandingItems.OrderNumber, 
     OutstandingItems.InvoiceNumber, 
     //OutstandingItems.ReferenceNumber, 
     //OutstandingItems.Description
     //IF(DATE(TODAY(), 'YYYY-MM-DD') = %Date_key, 1, 0) AS [OutstandingItems.CurrentYesNo]
     IF(date(DATE(today()), 'YYYY-MM-DD') = %Date_key, 1, 0) 				AS [OutstandingItems.CurrentYesNo],
     IF(FLOOR(DATE(MonthEnd(%Date_key)))=FLOOR(DATE(%Date_key)),1,0) 		AS [Open invoice MonthEnd YesNo]
	FROM $(vDirectory_OutstandingItems)\*_OutstandingItems_CurrentYear.qvd (qvd)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen       
    
    ;


// =================================== FACTS: OUTSTANDING ITEMS MONTH END =================================== //
// Only load data from years before current year!! -> Load until previous month. Current year above is only today. Then no overlap.
// First check if file exists. If file exists then load


Facts_OutstandingItems_MonthEnd: // Table will be merges with previous table as all fields are the same
CONCATENATE LOAD 
		 %Database_key, 
	     %Date_key, 
	     %Customer_key, 
	     SalesOrPurchase 	AS OutstandingItems.SalesOrPurchase, 
	     //AgeCategory, 
	     Balance 			AS OutstandingItems.Balance, 
	     Age_Invoice 		AS OutstandingItems.Age_Invoice, 
	     EntryNumber		AS OutstandingItems.EntryNumber, 
	//     DaysToLate, 
	//     OrderNumber, 
	     InvoiceNumber, 
	//     ReferenceNumber, 
	//     Description,
		 0	AS [OutstandingItems.CurrentYesNo],
	     1  AS [Open invoice MonthEnd YesNo]
	FROM $(vDirectory_OutstandingItems)\*_OutstandingItems_MonthEnd.qvd (qvd)
	//WHERE YEAR(%Date_key) < YEAR(TODAY())
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen       
    
    
	;

ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;






// =================================== FACTS: GLOBE BUDGETS =================================== //
//Budgets Facts

// First check if file exists. If file exists then load
SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Facts)\*_Budget.qvd (qvd);
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_Budget:
//NOCONCATENATE 
LOAD
	[%Date_key],
	[%Database_key],
	[%GeneralLedger_key],
	[%Costcenter_key],
	[%Costunit_key],
	[%Employee_key],
	[%Item_key],
	[%Project_key],
	[%BudgetScenario_key],
	[Budget.id],
	[Budget.bkjrcode],
	[Budget.periode],
	[Budget.Linedescription],
	[Budget.Amount],
	[Budget.Quantity],
	[Budget.debcode],
	[Budget.crdcode],
	[Budget.facode],
	[Budget.omzrek],
	[Budget.parentproject],
	[Budget.bal_vw]
	FROM $(vDirectory_Facts)\*_Budget.qvd (qvd)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen   
    
    ;

ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;

// =================================== FACTS: OPPORTUNITIES SYNERGY =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM	$(vDirectory_FactsSynergy)\*_Opportunities.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_Opportunities:
//NOCONCATENATE 
LOAD
		[Opportunities.ID],
		[Opportunities.Code],
		[%Project_key],
		[%Costcenter_key],
		[%Customer_key],
		[%Country_key],
		[%Employee_key],
		[%Date_key],
		[%Database_key],
		[%Opportunitysourcedescription_key],
		[Opportunities.Description],
		[Opportunities.AccountID],
		[Opportunities.PlannedStartDate],
		[Opportunities.Probability],
		[Opportunities.Currency],
		[Opportunities.PlannedAmount],
		[Opportunities.PlannedAmountFC],
		[Opportunities.ExpectedAmount],
		[Opportunities.ExpectedAmountFC],
		[Opportunities.RealizedAmount],
		[Opportunities.RealizedAmountFC],
		[Opportunities.SalesCycleID],
		[Opportunities.Assortment],
		[Opportunities.SourceID],
		[Opportunities.StageID],
		[Opportunities.Salescycledescription],
		[DealStatus],
		[DealStatusdescription],
		[Opportunities.DealWonDate],
		[Opportunities.DealLostDate],
		[Opportunities.LostTo],
		[Opportunities.ReasonLost],
		[Opportunities.Remarks],
		[Opportunities.SecurityLevel]
	FROM
	$(vDirectory_FactsSynergy)\*_Opportunities.qvd
	(qvd)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen       
    
    ;

ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;


// =================================== FACTS: PROJECTBUDGETS SYNERGY =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM	$(vDirectory_FactsSynergy)\*_Projectbudgets.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_Projectbudgets:
//NOCONCATENATE 
LOAD
		 %Database_key, 
	     %Project_key, 
	     %Customer_key, 
	     Projectbudgets.startdate,
	     Projectbudgets.enddate,
	     Projectbudgets.budgetyear, 
	     Projectbudgets.revenuebudget, 
	     Projectbudgets.costsbudget
	FROM
	$(vDirectory_FactsSynergy)\*_Projectbudgets.qvd
	(qvd);

ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;

// =================================== FACTS: PROJECT ACTUALS GLOBE =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
CheckFileExists:
LOAD COUNT(DISTINCT FileName()) AS Files
FROM $(vDirectory_Facts)\*_Projectactuals.qvd;
LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_Projectactuals: 
//NOCONCATENATE 
LOAD 
	[%Database_key],
	[%Date_key],
	[%Project_key],
	[%Item_key],
	[%GeneralLedger_key],
	[%Costcenter_key],
	[%Employee_key],
	[Projectactuals.ID],
	[Projectactuals.Oms25],
	[Projectactuals.RealRevenue],
	[Projectactuals.RealCosts],
	[Projectactuals.RealQuantityCosts],
	[Projectactuals.RealQuantityRevenue]
	FROM $(vDirectory_Facts)\*_Projectactuals.qvd
	(qvd)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen       
    
    ;
ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;

// =================================== FACTS: Requests / absences =================================== //
// First check if file exists. If file exists then load
// Bart Heijne, 2016-07-01. Removed requests from facts table and moved it to a dimension table.
// Only load the fact key-field and fields with specific goals (like the freefields) as a fact.
 
//SET ERRORMODE = 0;
//	CheckFileExists:
//	LOAD COUNT(DISTINCT FileName()) AS Files
//	FROM $(vDirectory_FactsSynergy)\*_Requests.qvd;
//	LET vFileCount = Alt(Peek('Files'), 0);
//SET ERRORMODE =1;
//
//IF vFileCount = 1 THEN
//
//Facts_Requests: 
////NOCONCATENATE 
//LOAD 
//	[%Request_key],
//	[%Project_key],
//	[%Employee_key],
//	[%Item_key],
//	[%Database_key],
//	[Request.HID],
//	[Request.Type],
//	[Request.Description],
//	[Request.StartDate],
//	[Request.EndDate],
//	[Request.HoursPlanned],
//	[Request.DaysPlanned],
//	[Request.StartDateActual],
//	[Request.EndDateActual],
//	[Request.HoursActual],
//	[Request.DaysActual],
//	[Request.AmountPlanned],
//	[Request.AmountActual],
//	[Request.StatusdescriptionDutch],
//	[Request.StatusdescriptionEnglish]
//	FROM $(vDirectory_FactsSynergy)\*_Requests.qvd
//	(qvd);
//ENDIF
//
//SET ERRORMODE = 0;
//	DROP TABLES CheckFileExists;
//SET ERRORMODE =1;
//
//
//
// =================================== FACTS: PSA HOURS =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_FactsSynergy)\*_HourRequests.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_HourRequests: 
//NOCONCATENATE 
LOAD 
	[%Date_key],
	[%Project_key],
	[%Customer_key],
	[%Employee_key],
	[%Item_key],
	[%Workschedule_key],
	[%WBS_key],
	[%Database_key],
	[%Costcenter_key],
	[%Request_key],
	[Hours.Hid],
	[Hours.ID],
	[Hours.Type],
	[Hours.Empid],
	[Hours.Startdate],
	[Hours.Enddate],
	[Hours.Hours],
	[Hours.Days],
	[Hours.StartDateActual],
	[Hours.EndDateActual],
	[Hours.HoursActual],
	[Hours.DaysActual],
	[Hours.Amount],
	[Hours.Currency],
	[Hours.AmountActual],
	[Hours.CurrencyActual],
	[Hours.BillCustomer],
	[Hours.ItemCount],
	[Hours.ItemCountActual],
	[Hours.Status],
	[Hours.StatusdescriptionDutch],
	[Hours.StatusdescriptionEnglish],
	[Hours.Description],
	[Hours.ProcessNumber],
	[Hours.FreeIntField_01],
	[Hours.RegisterCost],
	[Hours.Syscreator],
	[Hours.Syscreated],
	[Hours.DeliverableCode],
	[Hours.Deliverabledescription]
	FROM $(vDirectory_FactsSynergy)\*_HourRequests.qvd
	(qvd)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen       
    ;
ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;

// =================================== FACTS: PSA INVOICE PROPOSALS =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_FactsSynergy)\*_InvoiceProposalRequests.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_InvoiceProposalRequests:	
//NOCONCATENATE 
LOAD 
	[%Date_key],
	[%Project_key],
	[%Customer_key],
	[%Employee_key],
	[%Database_key],
	[%Request_key],
	[RequestNumber],
	[InvoiceProposals.ID],
	[InvoiceProposals.Type],
	[InvoiceProposals.Empid],
	[InvoiceProposals.StartDateActual],
	[InvoiceProposals.AmountActual],
	[InvoiceProposals.BillCustomer],
	[InvoiceProposals.status],
	[InvoiceProposals.StatusdescriptionDutch],
	[InvoiceProposals.StatusdescriptionEnglish],
	[InvoiceProposals.Description],
	[InvoiceProposals.ProcessNumber],
	[InvoiceProposals.FreeIntField_01],
	[InvoiceProposals.ReferenceNumber],
	[InvoiceProposals.FreeTextField_03],
	[InvoiceProposals.FreeTextField_04],
	[InvoiceProposals.FreeTextField_06],
	[InvoiceProposals.FreeDateField_01],
	[InvoiceProposals.FreeDateField_02]
	FROM $(vDirectory_FactsSynergy)\*_InvoiceProposalRequests.qvd
	(qvd)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen       
    ;
ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;

// =================================== FACTS: Verzuim - Ziek- en betermeldingen / Sick requests  =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_FactsSynergy)\*_Verzuim.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_Verzuim:
//NOCONCATENATE 
LOAD 
	[%Date_key],
	[%Ziekmelding_key],
	[%Employee_key],
	[%Division_key],
	[%Database_key],
	[%Item_key],
	[%Request_key],
	[Ziekmeldingen.Type],
	[Ziekmeldingen.EmployeeID],
	[Ziekmeldingen.ZiekmeldingID],
	[Ziekmeldingen.Ziekmelding Aard],
	[Ziekmeldingen.Herstelmeldingen Ja/Nee],
	[Ziekmeldingen.Description],
	[Ziekmeldingen.Startdatum],
	[Ziekmeldingen.Eind datum],
	[Ziekmeldingen.Ziekmelding Teller],
	[Ziekmeldingen.Ziekmelding Einde Teller],
	[Ziekmeldingen.Ziektedagen_ExclHerstel],
	[Ziekmeldingen.Ziektedagen_InclHerstel],
	[Ziekmeldingen.HerstelmeldingID],
	[Ziekmeldingen.PercentageZiek],
	[Ziekmeldingen.EmployeeType]
	FROM $(vDirectory_FactsSynergy)\*_Verzuim.qvd
	(QVD)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen       
    
    ;

ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;

// =================================== FACTS: Other leaves per day  =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_FactsSynergy)\*_OtherLeavePerDay.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_OtherLeavePerDay:
//NOCONCATENATE 
LOAD 
	[%Date_key],
	[OtherLeave.ID],
	[%Database_key],
	[%Employee_key],
	[%Division_key],
	[%Item_key],
	[%Request_key],
	[OtherLeave.OtherLeaveHID],
	[RequestNumber],
	[OtherLeave.Type],
	[OtherLeave.Status],
	[OtherLeave.Description],
	[OtherLeave.StartDate],
	[OtherLeave.EndDate],
	[OtherLeave.OtherLeaveStartCounter],
	[OtherLeave.OtherLeaveEndCounter],
	[OtherLeave.OtherLeaveCounter],
	[OtherLeave.OtherLeaveHours]
	FROM $(vDirectory_FactsSynergy)\*_OtherLeavePerDay.qvd
	(QVD)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen       
    
    ;

ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;



// =================================== FACTS: Employee Contracts  =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_FactsSynergy)\*_EmployeeContracts.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_EmployeeContracts:
//NOCONCATENATE 
LOAD 
	[EmployeeContracts.Contract description],
	[EmployeeContracts.Division],
	[%Employee_key],
	[%Database_key],
	[EmployeeContracts.StartDate],
	[EmployeeContracts.EndDate],
	[EmployeeContracts.FreeTextField_01],
	[EmployeeContracts.FreeTextField_02],
	[EmployeeContracts.HID],
	[EmployeeContracts.Count]
	FROM $(vDirectory_FactsSynergy)\*_EmployeeContracts.qvd (QVD);
	
ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;

// =================================== FACTS: IIR requests  =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_FactsSynergy)\*_IIRRequests.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
	IF ScriptError>1 AND ScriptError<>8 THEN 
	    TRACE File not found;
	ELSE 
	    TRACE File loaded;
	END IF 
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_IIRRequests:
//NOCONCATENATE 
LOAD 
	AUTONUMBER([IIRRequests.InvoiceDivision] & '|' & [IIRRequests.IIREntryGuid]) AS %IIREntryGuid_key,
	*
	FROM $(vDirectory_FactsSynergy)\*_IIRRequests.qvd (QVD);


SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;
ENDIF


// =================================== FACTS: Bank Transactions  =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Facts)\*_Banktransactions.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_Banktransactions:
//NOCONCATENATE 
LOAD 
	[%Date_key],
	[%Database_key],
	[%GeneralLedger_key],
	[Banktransactions.ID],
	[Banktransactions.ValueDate],
	[Banktransactions.originalamount],
	[Banktransactions.amountpayed],
	[Banktransactions.OwnBankAccount],
	[Banktransactions.TransactionType],
	[Banktransactions.TransactionTypeDescription],
	[Banktransactions.CreditorNumber],
	[Banktransactions.DebtorNumber],
	[Banktransactions.OffsetBankAccount],
	[Banktransactions.Description],
	[Banktransactions.Blocked],
	[Banktransactions.InvoiceNumber],
	[Banktransactions.StatementType],
	[Banktransactions.StatementTypeDescription],
	[Banktransactions.StatementDate],
	[Banktransactions.StatementNumber],
	[Banktransactions.StatementLineNumber],
	[Banktransactions.LedgerAccount],
	[Banktransactions.OffsetLedgerAccountNumber],
	[Banktransactions.EntryNumber],
	[Banktransactions.SupplierInvoiceNumber],
	[Banktransactions.PaymentType],
	[Banktransactions.PaymentTypeDescription],
	[Banktransactions.Journalized],
	[Banktransactions.OwnBankAccountRef],
	[Banktransactions.ReportingDate]
	FROM $(vDirectory_Facts)\*_Banktransactions.qvd (qvd)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen       
    
    ;


SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;
ENDIF


// =================================== FACTS: Workschedule / Roosters  =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_FactsSynergy)\*_Workschedule.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

Facts_Workschedule:
LOAD 
	[%Workschedule_key],
	[%Employee_key],
	[%Date_key],
	[Workschedule.workschedulehours]
	FROM $(vDirectory_FactsSynergy)\*_Workschedule.qvd (QVD);

ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;

// =================================== FACTS: Work Breakdown Structurelines WBS  =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_FactsSynergy)\*_WBS.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

	Facts_WBS:
	LOAD 
	[%Project_key],
	[%Item_key],
	[%WBS_key],
	[WBS.ID],
	[WBS.StartDate],
	[WBS.EndDate],
	[WBS.ItemCode],
	[WBS.Description],
	[WBS.ProjectNumber],
	[WBS.DeliverableCode],
	[WBS.ItemCount],
	[WBS.Amount],
	[WBS.AmountFC],
	[WBS.BillCustomer],
	[WBS.RegisterCost],
	[WBS.Calculatedhoursactual],
	[WBS.CalculatedHours],
	[WBS.Calculateditemcountactual],
	[WBS.CostFC],
	[WBS.SalesPriceFC],
	[WBS.WbsHours],
	[WBS.FixedterminvoicelineProcessedAmount],
	[WBS.FixedterminvoicelineRealizedAmount],
	[WBS.ProjectInvoiceproposalamount],
	[WBS.CalculatedSalesAmount]
	FROM $(vDirectory_FactsSynergy)\*_WBS.qvd (QVD);

ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;

// =================================== FACTS: Vacation  =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_FactsSynergy)\*_Vacation.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

	Facts_Vacation:
	LOAD 
	[%Date_key],
	[Vacation.ID],
	[%Database_key],
	[%Employee_key],
	[%Division_key],
	[%Item_key],
	[%Request_key],
	[%RequestType_key],
	[Vacation.VacationHID],
	[RequestNumber],
	[Vacation.Type],
	[Vacation.Status],
	[Vacation.Description],
	[Vacation.StartDate],
	[Vacation.EndDate],
	[Vacation.Buildup],
	[Vacation.VacationStartCounter],
	[Vacation.VacationEndCounter],
	[Vacation.VacationCounter]
	FROM $(vDirectory_FactsSynergy)\*_Vacation.qvd (QVD)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen       
    ;

ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;


//// =================================== FACTS: Special leave  =================================== //
//// First check if file exists. If file exists then load
//
//
//SET ERRORMODE = 0;
//	CheckFileExists:
//	LOAD COUNT(DISTINCT FileName()) AS Files
//	FROM $(vDirectory_FactsSynergy)\*_SpecialLeave.qvd;
//	LET vFileCount = Alt(Peek('Files'), 0);
//SET ERRORMODE =1;
//
//IF vFileCount = 1 THEN
//
//	Facts_SpecialLeave:
//	LOAD
//	[%Date_key],
//	[SpecialLeave.ID],
//	[%Database_key],
//	[%Employee_key],
//	[%Division_key],
//	[%Item_key],
//	[%Request_key],
//	[SpecialLeave.SpecialLeaveHID],
//	[RequestNumber],
//	[SpecialLeave.Type],
//	[SpecialLeave.Status],
//	[SpecialLeave.Description],
//	[SpecialLeave.StartDate],
//	[SpecialLeave.EndDate],
//	[SpecialLeave.SpecialLeaveStartCounter],
//	[SpecialLeave.SpecialLeaveEndCounter],
//	[SpecialLeave.SpecialLeaveCounter],
//	[SpecialLeave.SpecialLeaveHours]
//	FROM $(vDirectory_FactsSynergy)\*_SpecialLeave.qvd (QVD)
//  where
//  (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen   

;
//
//ENDIF
//
//SET ERRORMODE = 0;
//	DROP TABLES CheckFileExists;
//SET ERRORMODE =1;
//
//

// Ferry Laurentiu, 2015-09-30 
// =================================== FACTS: SupplierPerformance  =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_FactsLogistics)\*_SupplierPerformance.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN
	Facts_SupplierPerformance:
	LOAD 
		%Database_key,
		%Customer_key,
		%Date_key,
		SupplierPerformance.Entity,
		SupplierPerformance.EntityCode,
		SupplierPerformance.PerformanceOverAllYears,
		SupplierPerformance.PerformanceInYear,
		SupplierPerformance.Year,
		SupplierPerformance.NoOfOrder,
		SupplierPerformance.TotalOrder,
		SupplierPerformance.TotalDelivered, 
		SupplierPerformance.FillRate,
		SupplierPerformance.DefectRate		
	FROM
	[$(vDirectory_FactsLogistics)\*_SupplierPerformance.qvd]
	(qvd)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen       
    ;
	
ENDIF;

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;


// =================================== FACTS: IIR Financial Entry lines  =================================== //
// First check if file exists. If file exists then load

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Facts)\*_IIRTransactions.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN
	Facts_IIRTransactions:
	LOAD 
	[%Customer_key],
	[%Date_key],
	[%Database_key],
	[%GeneralLedger_key],
	[%Costcenter_key],
	[%Costunit_key],
	[%Employee_key],
	[%Item_key],
	[%Project_key],
	[%Journal_key],
	AUTONUMBER(%IIREntryGuid_key) as %IIREntryGuid_key ,
	[GLTransaction.PL_Balance],
	[GLTransaction.Balance_Balance],
	[GLTransaction.InvoiceNumber] ,
	[GLTransaction.Quantity],
	[GLTransaction.EntryNumber],
	[GLTransaction.YourReference],
	[GLTransaction.Description],
	[GLTransaction.IIRRegistercode],
	[GLTransaction.Transsubtype],
	[GLTransaction.Transsubtypedescription]
	FROM
	[$(vDirectory_Facts)\*_IIRTransactions.qvd]	(qvd)
    where
    (left([%Database_key],1) = 0 and year([%Date_key]) < 2017) or (left([%Database_key],1) = 5 and year([%Date_key]) > 2016)
// bovenstaande where claus toegevoegd om data te selecteren om dubbelingen te voorkomen       
    ;
	;

SET ERRORMODE = 0;

	DROP TABLES CheckFileExists;
SET ERRORMODE =1;
ENDIF;




// When adding a new table, don't forget to add this table in the store tab.




