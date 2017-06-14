// =================================== ORDERDEBTORS =================================== //

//Orderdebtors:
//	LOAD 
//	// Key fields
//	AUTONUMBER(%Orderdebtor_key, 'Orderdebtor_key' ) AS %Orderdebtor_key, 
//	// New Fields
//	// Qvd fields
//    Orderdebiteur.Code, 
//    Orderdebiteur.Naam, 
//    Orderdebiteur.Plaats, 
//    Orderdebiteur.Landcode, 
//    Orderdebiteur.Land 		
//	FROM $(vDirectory_Dimensions)\*_Orderdebiteur.qvd (qvd);