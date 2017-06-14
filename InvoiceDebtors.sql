// =================================== INVOICEDEBTORS =================================== //

//Invoicedebtors:
//	LOAD 
//	// Key fields
//	AUTONUMBER(%Invoicedebtor_key, 'Invoicedebtor_key' ) AS %Invoicedebtor_key, 
//	// New Fields
//	// Qvd fields
//     Factuurdebiteur.Code, 
//     Factuurdebiteur.Naam, 
//     Factuurdebiteur.Plaats, 
//     Factuurdebiteur.Landcode, 
//     Factuurdebiteur.Land 	
//	FROM $(vDirectory_Dimensions)\*_Factuurdebiteur.qvd (qvd);