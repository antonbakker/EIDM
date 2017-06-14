// =================================== AS OF CALENDAR =================================== //

[AsOfCalendar]:
LOAD 
	 %AsOfDate_key, 
     AsOfMonth, 
     AsOfMonth#, 
     AsOfYear, 
     AsOfMonthSort, 
     AsOfYearMonth
FROM [$(vDirectory_Datamodel)\AsOf Calendar.qvd] (qvd);
