// =================================== ADDITIONAL FIELDS / TRANSLATIONS =================================== //
TRACE # Load translation information;

// Translation of qvd fieldnames to User Interface (UI) 'business friendly' names:
FieldMap:
Mapping 
LOAD [QVD Fieldname] 
     ,[UI Fieldname] 
     //,Sourcetabel
FROM
$(vDirectory_Include)\Exact Template Data.xlsx
(ooxml, embedded labels, table is QVD_to_UI_Fieldnames);

Rename fields using FieldMap;

Languages:
LOAD Language, Flagname, Abbreviation
FROM
$(vDirectory_Include)\Exact Template Data.xlsx
(ooxml, embedded labels, table is Languages, filters(
Remove(Row, RowCnd(CellValue, 1, StrCnd(null)))
));

Translation:
LOAD * INLINE [TextToTranslate];
[Object Help Texts]:
LOAD * INLINE [ObjectID];


TRACE # Load language descriptions by language;

/* Count all languages */
LET vNoOfLanguages = NoOfRows('Languages');

/* 
Loop through all Languages. Important: -1 because Peek function is 0 based 
This is needed to be able to dynamically add translations to the dashboards
*/
For l = 0 to $(vNoOfLanguages)-1

	/* Set variable vLanguage */
	LET vLanguage 		= Peek('Language',$(l),'Languages');

UNQUALIFY *;


// Load translations of labes and texts used in the UI:
//Translation:
//LOAD Language, 
//     TextToTranslate, 
//     Translation
//FROM
//$(vDirectory_Include)\Exact Template Data.xlsx
//(ooxml, embedded labels, table is UI_Translation);

//LOAD TextToTranslate, 
//     English, 
//     Dutch
//FROM
//$(vDirectory_Include)\Exact Template Data.xlsx
//(ooxml, embedded labels, table is UI_Translation);

JOIN (Translation)
LOAD TextToTranslate,
	$(vLanguage)
FROM
$(vDirectory_Include)\Exact Template Data.xlsx
(ooxml, embedded labels, table is UI_Translation);


//Object Help Texts

//[Object Help Texts]:
//LOAD 
//	 //Mainmenu, 
//     //Submenu, 
//     //[Object Title], 
//     //[Object Type], 
//     ObjectID, 
//     Dutch, 
//     English
//FROM
//$(vDirectory_Include)\Exact Template Data.xlsx
//(ooxml, embedded labels, table is Helptexts);

JOIN ([Object Help Texts])
LOAD
	ObjectID,
	$(vLanguage)
FROM
$(vDirectory_Include)\Exact Template Data.xlsx
(ooxml, embedded labels, table is Helptexts);

next l;

TRACE # Finished loading translations;
