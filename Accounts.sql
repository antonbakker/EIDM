// =================================== ACCOUNTS =================================== //
TRACE # Load Accounts;

Accounts:
	LOAD *,
    IF(
	match(LEFT(RIGHT(Account.Code,5),3),'999','399')
	> 0,'Ja','Nee')										as [Intercompany relatie]
        ;
    LOAD 
	// Key fields
	%Customer_key, 
	%CustomerParent_key,
	AUTONUMBER(Account.GUID) AS %Location_key, 
//	Account.GUID		AS %Location_key,
    // New Fields
	// Qvd fields 
     Account.SectorCodeAndDescription, 
     Account.ClassificationCodeAndDescription, 
     Account.SizeCodeAndDescription, 
     Account.CustomerNumberAndName, 
     Account.VendorNumberAndName, 
     Account.AssociateNumberAndName, 
     Account.BankNumberAndName, 
     Account.DivisionNumberAndName, 
     Account.EmployeeNumberAndName, 
     Account.LeadNumberAndName, 
     Account.NotValidatedNumberAndName, 
     Account.ProspectNumberAndName, 
     Account.ResellerNumberAndName, 
     Account.SupplierNumberAndName, 
     Account.SuspectNumberAndName, 
     Account.Code, 
     Account.SectorCode, 
     Account.SectorDescription, 
     Account.Subsector,
     Account.SubsectorDescription,
     Account.ClassificationCode, 
     Account.ClassificationDescription, 
     Account.VendorNumber, 
     Account.CustomerOrVendor, 
     Account.CustomerNumber, 
     Account.Email, 
     Account.Fax, 
     Account.Country, 
     Account.Name, 
     Account.Address1, 
     Account.Address2, 
     Account.Address3, 
     Account.Postcode, 
     Account.Province, 
     Account.SizeCode, 
     Account.SizeDescription, 
     Account.City, 
     Account.Phone, 
     Account.Status, 
//     Account.RepresentativeID, 
//     Account.RepresentativeName, 
     Account.Website,
     Account.TaxCreditorFlag,
     Account.Type,
     Account.cmp_parent,
     Account.PaymentCondition
	FROM $(vDirectory_Dimensions)\*_Accounts.qvd (qvd);
	








	
	
