// =================================== STORE TABLES INTO DATAMART =================================== //
// Bart Heijne, 26-8-2014. Do not move the STORE commands to an earlier tab,as in the 'translations-tab' a field might be renamed before storing the fields
// The translated fields are used in formulas in the accesspoint model.
//
// All Dimension tables are stored separately.
// All facts tables are first stored separately. In the final accesspoint-QVW you can choose which fact tables you want to concatenate depending on the customers needs
// Below, as an example, a new facts table is created which concatenes all facts. This is done for checking this datamodel for errors and synthetic keys.
TRACE # Store the aggregated information in the datamart folder;

SET ERRORMODE = 0; // In some cases the file does not exist (depending on if customer uses Globe, Synergy or both). This setting is to prevent an error message. For debugging this setting can be remarked.

STORE Databases 				INTO $(vDirectory_DataMart)\Databases.qvd (qvd);
STORE Accounts 					INTO $(vDirectory_DataMart)\Accounts.qvd (qvd);
STORE ParentAccounts			INTO $(vDirectory_DataMart)\ParentAccounts.qvd (qvd);
STORE Costcenters 				INTO $(vDirectory_DataMart)\Costcenters.qvd (qvd); 
STORE Costunits 				INTO $(vDirectory_DataMart)\Costunits.qvd (qvd);
STORE Items 					INTO $(vDirectory_DataMart)\Items.qvd (qvd);
STORE ItemAccounts 				INTO $(vDirectory_DataMart)\ItemAccounts.qvd (qvd);
STORE Warehouses 				INTO $(vDirectory_DataMart)\Warehouses.qvd (qvd);
STORE Countries 				INTO $(vDirectory_DataMart)\Countries.qvd (qvd);
STORE [General Ledger Chart] 	INTO $(vDirectory_DataMart)\General Ledger Chart.qvd (qvd);
STORE Facts 					INTO $(vDirectory_DataMart)\Facts.qvd (qvd);
STORE Calendar 					INTO $(vDirectory_DataMart)\Calendar.qvd (qvd);
STORE FcCalendar 				INTO $(vDirectory_DataMart)\Forecastcalendar.qvd (qvd);
STORE ReferenceCalendarStart 	INTO $(vDirectory_DataMart)\ReferenceCalendarStart.qvd (qvd);
STORE ReferenceCalendarEnd 		INTO $(vDirectory_DataMart)\ReferenceCalendarEnd.qvd (qvd);
STORE AddressCoordinates 		INTO $(vDirectory_DataMart)\AddressCoordinates.qvd (qvd);
STORE _zoom_level 				INTO $(vDirectory_DataMart)\_zoom_level.qvd (qvd);
STORE maptype 					INTO $(vDirectory_DataMart)\maptype.qvd (qvd);
STORE ABC 						INTO $(vDirectory_DataMart)\ABC.qvd (qvd);
STORE FinanceDimensions 		INTO $(vDirectory_DataMart)\FinanceDimensions.qvd (qvd);
STORE SalesExpressions 			INTO $(vDirectory_DataMart)\SalesExpressions.qvd (qvd);
STORE Translation 				INTO $(vDirectory_DataMart)\Translation.qvd (qvd);
STORE [Object Help Texts] 		INTO $(vDirectory_DataMart)\Object Help Texts.qvd (qvd);
STORE ReloadTimes 				INTO $(vDirectory_DataMart)\ReloadTimes.qvd (qvd);
STORE Languages 				INTO $(vDirectory_DataMart)\Languages.qvd (qvd);
STORE Projects 					INTO $(vDirectory_DataMart)\Projects.qvd (qvd);
STORE Employees 				INTO $(vDirectory_DataMart)\Employees.qvd (qvd);
STORE Requeststatus				INTO $(vDirectory_DataMart)\Requeststatus.qvd (qvd);
STORE Requests					INTO $(vDirectory_DataMart)\Requests.qvd (qvd);
STORE BudgetScenarios			INTO $(vDirectory_DataMart)\BudgetScenarios.qvd (qvd);
STORE IIRSettings				INTO $(vDirectory_DataMart)\IIRSettings.qvd (qvd);
STORE IIRRegisters				INTO $(vDirectory_DataMart)\IIRRegisters.qvd (qvd);
STORE IIRAuthorizers			INTO $(vDirectory_DataMart)\IIRAuthorizers.qvd (qvd);
STORE IIRInvoiceAuthorizers		INTO $(vDirectory_DataMart)\IIRInvoiceAuthorizers.qvd (qvd);
STORE IIRDivisions				INTO $(vDirectory_DataMart)\IIRDivisions.qvd (qvd);



// Bart Heijne, 2015-06-11
// Store each individual facts table so in the final model you are able to choose which facts table to concatenate.
// $(vDirectory_DataMart)
STORE Facts_Invoicehistory					INTO $(vDirectory_DataMart)\Facts_Invoicehistory.qvd (qvd);
STORE Facts_SalesOrders						INTO $(vDirectory_DataMart)\Facts_SalesOrders.qvd (qvd);
STORE Facts_PurchaseOrders					INTO $(vDirectory_DataMart)\Facts_PurchaseOrders.qvd (qvd);
STORE Facts_Stock							INTO $(vDirectory_DataMart)\Facts_Stock.qvd (qvd);
STORE Facts_StockMonthStartTotal 			INTO $(vDirectory_DataMart)\Facts_StockMonthStartTotal.qvd (qvd);
STORE Facts_GLTransactions					INTO $(vDirectory_DataMart)\Facts_GLTransactions.qvd (qvd);
STORE Facts_OutstandingItems				INTO $(vDirectory_DataMart)\Facts_OutstandingItems.qvd (qvd);	
STORE Facts_Budget 							INTO $(vDirectory_DataMart)\Facts_Budget.qvd (qvd);               
STORE Facts_Projectactuals					INTO $(vDirectory_DataMart)\Facts_Projectactuals.qvd (qvd);
STORE Facts_Opportunities					INTO $(vDirectory_DataMart)\Facts_Opportunities.qvd (qvd);  	
STORE Facts_Projectbudgets					INTO $(vDirectory_DataMart)\Facts_Projectbudgets.qvd (qvd);	
STORE Facts_HourRequests					INTO $(vDirectory_DataMart)\Facts_HourRequests.qvd (qvd);		
STORE Facts_InvoiceProposalRequests			INTO $(vDirectory_DataMart)\Facts_InvoiceProposalRequests.qvd (qvd);
STORE Facts_Verzuim							INTO $(vDirectory_DataMart)\Facts_Verzuim.qvd (qvd);				
STORE Facts_EmployeeContracts				INTO $(vDirectory_DataMart)\Facts_EmployeeContracts.qvd (qvd);		
STORE Facts_IIRRequests						INTO $(vDirectory_DataMart)\Facts_IIRRequests.qvd (qvd);
//STORE Facts_Banktransactions				INTO $(vDirectory_DataMart)\Facts_Banktransactions.qvd (qvd);
STORE Facts_Workschedule					INTO $(vDirectory_DataMart)\Facts_Workschedule.qvd (qvd);
STORE Facts_WBS								INTO $(vDirectory_DataMart)\Facts_WBS.qvd (qvd);
STORE Facts_Vacation						INTO $(vDirectory_DataMart)\Facts_Vacation.qvd (qvd);
//STORE FACTS_SpecialLeave					INTO $(vDirectory_DataMart)\Facts_SpecialLeave.qvd (qvd); replace by otherleaveperday
STORE Facts_OtherLeavePerDay 				INTO $(vDirectory_DataMart)\Facts_OtherLeavePerDay.qvd (qvd);
STORE Facts_SupplierPerformance				INTO $(vDirectory_DataMart)\Facts_SupplierPerformance.qvd (qvd);
STORE Facts_IIRTransactions					INTO $(vDirectory_DataMart)\Facts_IIRTransactions.qvd (qvd);



// Bart Heijne, 2015-06-11
// Drop all facts table except the overall 'facts' table which include all these below
DROP TABLE Facts_Invoicehistory;
DROP TABLE Facts_SalesOrders;
DROP TABLE Facts_PurchaseOrders;
DROP TABLE Facts_Stock;
DROP TABLE Facts_StockMonthStartTotal;
DROP TABLE Facts_GLTransactions;
DROP TABLE Facts_OutstandingItems;	
DROP TABLE Facts_Budget;
DROP TABLE Facts_Opportunities;	
DROP TABLE Facts_Projectbudgets;
DROP TABLE Facts_Projectactuals;
DROP TABLE Facts_HourRequests;	
DROP TABLE Facts_InvoiceProposalRequests;
DROP TABLE Facts_Verzuim;					
DROP TABLE Facts_EmployeeContracts;			
DROP TABLE Facts_IIRRequests;
//DROP TABLE Facts_Banktransactions;
DROP TABLE Facts_Workschedule;
DROP TABLE Facts_WBS;
DROP TABLE Facts_Vacation;
DROP TABLE Facts_OtherLeavePerDay;
DROP TABLE Facts_SupplierPerformance;
DROP TABLE Facts_IIRTransactions;

// Merge all facts to a total facts table for dashboards which needs all facts, like the overall exact template dashboard 
// Bart Heijne, 2016-04-19. Temporarily remarked the code below. Looks like some bug in Qlikview 12 where program generated an error and stops.
// Bart Heijne, 2016-06-01. Fixed in Qlikview 12 SR2. load concatenate works again. Still remarked 'STORE Facts', because separate facts_ can be loaded in the accesspoint. For performance reason no need to load all facts.
//				

Facts:
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_Invoicehistory.qvd (qvd);
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_SalesOrders.qvd (qvd);
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_PurchaseOrders.qvd (qvd);
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_Stock.qvd (qvd);
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_StockMonthStartTotal.qvd (qvd);
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_GLTransactions.qvd (qvd);
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_OutstandingItems.qvd (qvd);	
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_Budget.qvd (qvd);		
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_Projectactuals.qvd (qvd);
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_Opportunities.qvd (qvd);	
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_Projectbudgets.qvd (qvd);	
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_HourRequests.qvd (qvd);	
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_InvoiceProposalRequests.qvd (qvd);
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_Verzuim.qvd (qvd);				
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_EmployeeContracts.qvd (qvd);		
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_IIRRequests.qvd (qvd);
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_Workschedule.qvd (qvd);
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_WBS.qvd (qvd);
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_Vacation.qvd (qvd);
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_OtherLeavePerDay.qvd (qvd);
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_SupplierPerformance.qvd (qvd); //Bart Heijne, 1-10-2015. Temporarily excluded due to Synthetic key
CONCATENATE (Facts) LOAD * FROM $(vDirectory_DataMart)\Facts_IIRTransactions.qvd (qvd);
//
//
STORE Facts 								INTO $(vDirectory_DataMart)\AllFacts.qvd (qvd);


SET ERRORMODE = 1; // Error mode is set OFF again (so errors are displayed again. It is set on 0 above to prevent errors of non-existing tables in case the customer does not use this part in Globe or Synergy. 