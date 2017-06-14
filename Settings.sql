// =================================== SETTINGS =================================== //

// Load standard variables in QlikView
TRACE # Load variables in QlikView;

LET vTest = right(QvPath, len(QvPath)-Index(QvPath,'\Q'));
IF UPPER(vTest) = UPPER('Qlikview') THEN
SET vProduct='Qlikview';
ELSE
SET vProduct='Qliksense';
END IF;

IF vProduct='Qlikview' THEN
$(Include=..\Include\ExactTemplate.txt);
ELSE
$(Include=ExactTemplate.txt);
END IF;

//Variables
	tables_variables:
	LOAD Variable, 
	     Content
	FROM
	[$(vDirectory_Include)\Exact Template Data.xlsx]
	(ooxml, embedded labels, table is QVDLoad_Variables)
	WHERE ISNULL(Variable)=0 
	AND ([QVW File]='LOADQVD_Datamodel' OR [QVW File]='ALL' OR [QVW File]='Exact Globe Next Datamodel');
	
	for i=0 to noofrows('tables_variables')-1
	LET var_name= peek('Variable',i,'tables_variables');
	LET $(var_name) = peek('Content',i,'tables_variables');
	next i
	
	drop table tables_variables;

SET ThousandSep='.';
SET DecimalSep=',';
SET MoneyThousandSep='.';
SET MoneyDecimalSep=',';
SET MoneyFormat='€ #.##0,00;€ #.##0,00-';
SET TimeFormat='h:mm:ss';
SET DateFormat='D-M-YYYY';
SET TimestampFormat='D-M-YYYY h:mm:ss[.fff]';
SET MonthNames= $('vMonthNames'); //'jan;feb;mrt;apr;mei;jun;jul;aug;sep;okt;nov;dec';
SET DayNames=$('vDayNames');//;ma;di;wo;do;vr;za;zo';

// QlikView Directories
// are imported via the include file at the top part of the script

