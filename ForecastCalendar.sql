// =================================== FORECASTCALENDAR =================================== //

FcCalendar:
NoConcatenate LOAD 
//	[%Date_key],
//	[%Date_Variables],
////	[%AsOfDate_key],
//	[Date #],
//	[Year],
//	[Quarter],
//	[Quarter Year],
//	[Year Quarter],
//	[Month],
//	[Month No],
//	[Year Month],
//	[Month Year],
//	[Week],
//	[Year Week],
//	[Year Week #],
//	[Date],
//	[Day],
//	[Weekday],
//	[Month End Flag],
//	[YTD_Flag],
//	[LYTD_Flag],
//	[YTD_Allyears_Flag]
*
FROM
[$(vDirectory_Datamodel)\Forecastcalendar.qvd]
(qvd);

//STORE FcCalendar INTO $(vDirectory_Datamodel)\Exact Globe Next DataMart\Calendar.qvd (qvd);