// Date Dimension
 

// to load Quarters Full Name
 QuarterNAME:
 
 LOAD * Inline [
 Quarter		, QuarterFullName
 Q1				,FIRST
 Q2				,SECOND
 Q3				,THIRD
 Q4				,FOURTH
 ];
 
 
 // to create Quarters ie Q1,Q2
 QuartersMap:  
    MAPPING LOAD   
    rowno() 																				as Month,  
    'Q' & Ceil (rowno()/3)																  	as Quarter  
    
    AUTOGENERATE (12);  

      
       varMinDate = num(date(mid('2013-01-01',1,10 ),'YYYY-MM-DD'));
       varMaxDate = num(date(today(),'YYYY-MM-DD'));

// Creating a Temporary Calendar
      
TempCalendar:  
    LOAD  
                   $(varMinDate) + Iterno()-1 												as Num,  
                   Date($(varMinDate) + IterNo() - 1) 										as TempDatum  
                   AutoGenerate 1 While $(varMinDate) + IterNo() -1 <= $(varMaxDate);  
   
// Date Dimension

MasterCalendar:  

LOAD
	*,
	[Quarter Number]-1 																		as PQ,
	if(LastQtrFlag=1 and len(QuarterEnd([Effective Date]))>0,1,0) 							as lastQtrMnth,
	AutoNumber ([Year Month Num], 'PeriodID') 												as PeriodID,
	AutoNumber (Year & Quarter, 'QuarterID')												as QuarterID;
	
Load            
	trim(date(TempDatum,'YYYYMMDD'))														as DatumID,
	date(TempDatum,'MM/DD/YYYY') 															as [Effective Date],
	if(month(QuarterEnd(TempDatum))=Month(TempDatum),1,0) 									as [LastMnthPerQtr],
    day(TempDatum) 																			as Day,
    TempDatum 																				as UrenRegDatum, 
    date(TempDatum,'DD/MM/YYYY') 															as [UK Calendar Format], 
    date(TempDatum,'WWWW') 																	as [Full Day Name], 
    year(TempDatum) 																		as Year,
    inyear(TempDatum,today(),0) * -1  														as [CY],    // Current Year
    inyear(TempDatum,today(),-1) * -1 														as [First PY],
    inyear(TempDatum,today(),-2) * -1 														as [Second PY],
    inyeartodate(TempDatum,today(),0) * -1  												as [CYTD],
    inyeartodate(TempDatum,today(),-1) * -1 												as [First PYTD],
    inyeartodate(TempDatum,today(),-2) * -1 												as [Second PYTD], 
    if(InYearToDate(TempDatum, today(),0), 1, 0) 											as CurYearFlag,
	if(InQuarterToDate(TempDatum, today(),0), 1, 0) 										as CurQtrFlag,
	if(InMonthToDate(TempDatum, today(),0), 1, 0) 											as CurMonthFlag,
	if(InYear(TempDatum, today(),-1), 1, 0) 												as LastYearFlag,
	if(InQuarter(TempDatum, today(),-1), 1, 0) 												as LastQtrFlag,
	if(InMonth(TempDatum, today() ,-1), 1, 0) 												as LastMonthFlag,
	if(InMonthToDate(TempDatum, today(),-2), 1, 0) 											as LastQtrLastMonthFlag,
    ApplyMap('QuartersMap', month(TempDatum), Null()) 										as Quarter,
    Ceil(Month(TempDatum)/3)																as [Quarter Number],
    quarterName(TempDatum) 																	as [Quarter Name],
    yearname(TempDatum) & 'Q' & Ceil(Month(TempDatum)/3)  									as [Quarter Year], 
    inquarter(TempDatum,today(),0) * -1 													as [CQ],  // Current Quarter
    //    if(InQuarter(TempDate, today(),-1), 1, 0) 										as [PQ1],  // Previous Quarter
    inquarter(TempDatum,today(),-4) * -1 													as [First PQ],
    inquarter(TempDatum,today(),-8) * -1 													as [Second PQ],  
    inquartertodate(TempDatum,today(),0) * -1 												as [CQTD],
    inquartertodate(TempDatum,today(),-4) * -1 												as [First PQTD],
    inquartertodate(TempDatum,today(),-8) * -1 												as [Second PQTD], 
    date(monthstart(TempDatum),'MM') 														as [Month Number], 
    num(month(TempDatum))																	as Num_Month,
    month(TempDatum) 																		as Month,                   
    date(monthstart(TempDatum),'MMMM') 														as [Month Full Name],
    monthstart(TempDatum) 																	as [Calendar Month Start Date],
    monthend(TempDatum) 																	as [Calendar Month End Date],
	date(monthstart(TempDatum), 'MMM-YYYY') 												as [Month Year], 
	date(monthstart(TempDatum), 'YYYYMM') 													as [Year Month Num],
    week(TempDatum) 																		as Week, 
    week(weekstart(TempDatum)) & '-' & WeekYear(TempDatum)									as [Week Year],
    week(weekstart(TempDatum)) & '-' & Month(TempDatum)   									as [Week Month],
    weekDay(TempDatum) 																		as [Week Day],
	WeekEnd(TempDatum) 																		as WEEKENDS, 
    If( TempDatum > monthstart(addmonths(today(),-11)) and TempDatum <= today(),1)	 		as [Rolling 12],
    If( TempDatum > monthstart(addmonths(today(),-2)) and TempDatum <= today(),1) 			as [Rolling 3]
                
Resident TempCalendar  
Order By TempDatum ASC;  

Drop Table 	TempCalendar; 
Drop Table  QuarterNAME;