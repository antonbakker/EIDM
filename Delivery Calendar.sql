//// =================================== CALENDAR =================================== //
//
//Qualify *;
//UNQUALIFY '*_key';
//
//[Delivery]:
//NoConcatenate LOAD 
//	 %Date_key AS %DeliveryDate_key,  
//     Year, 
//     Quarter, 
//     [Quarter Year], 
//     [Year Quarter], 
//     Month, 
//     [Year Month], 
//     [Month Year], 
//     Week, 
//     [Year Week], 
//     [Year Week #], 
//     Date, 
//     Day, 
//     Weekday
//FROM
//[$(vDirectory_Datamodel)\Mastercalendar.qvd]
//(qvd);
//
//UNQUALIFY;

TRACE # End loading  calendar information;
