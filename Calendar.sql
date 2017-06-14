// =================================== CALENDAR =================================== //
TRACE # Load Calendar information;

Calendar:
NoConcatenate LOAD 
	[%Date_key],
	[%Date_Variables],
	[%AsOfDate_key],
	[Date #],
	[Year],
	[Quarter],
	[Quarter Year],
	[Year Quarter],
	[Month],
	[Month No],
	[Year Month],
	[Month Year],
	[Week],
	[Year Week],
	[Year Week #],
	[Date],
	[Day],
	[Weekday],
	[Month End Flag],
	[YTD_Flag],
	[LYTD_Flag],
	[YTD_Allyears_Flag]
FROM
[$(vDirectory_Datamodel)\Mastercalendar.qvd]
(qvd);

ReferenceCalendarStart:
NOCONCATENATE LOAD
Date 			AS ReferenceDateStart,
YEAR(Date)		AS ReferenceYear
RESIDENT Calendar;

ReferenceCalendarEnd:
NOCONCATENATE LOAD
Date 			AS ReferenceDateEnd,
YEAR(Date) 		AS ReferenceYear
RESIDENT Calendar;



