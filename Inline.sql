// =================================== INLINE TABLES =================================== //
TRACE # LOAD Inline tables for hardcoded information used in UI; 
// Inline (hard coded) data tables for layout or other UI purposes


// Table ABS ic used for presenting combinations of percentages in the ABC analysis
ABC:
Load * inline
[ABC_A	,ABC_B	,ABC_C	, Label_A	,Label_B	,Label_C, 
"0,900"	,"0,1000"	,"0,0000"	, "90"		,"10"		,"0"
"0,800"	,"0,2000"	,"0,0000"	, "80"		,"20"		,"0"
"0,800"	,"0,1500"	,"0,0500"	, "80"		,"15"		,"5"
"0,800"	,"0,1000"	,"0,1000"	, "80"		,"10"		,"10"
"0,750"	,"0,2000"	,"0,0005"	, "75"		,"20"		,"5"
"0,750"	,"0,1500"	,"0,1000"	, "75"		,"15"		,"10"
"0,700"	,"0,2000"	,"0,1000"	, "70"		,"20"		,"10"
"0,700"	,"0,1500"	,"0,1500"	, "70"		,"15"		,"15"
"0,600"	,"0,3000"	,"0,1000"	, "60"		,"30"		,"10"
"0,600"	,"0,2000"	,"0,2000"	, "60"		,"20"		,"20"
];

STORE ABC 						INTO [$(vDirectory_Datamodel)\Exact Globe Next DataMart\ABC.qvd] (qvd);


//Choosing columns in tab finance / P&L. Dutch and English descriptions.
FinanceDimensions:
LOAD * INLINE [
_Finance_dimension	, _Finance_dimension_oms	, _Finance_dimension_Desc
Costcenter label	, Kostenplaats				, Costcenter
G/L Account type	, Rekening Type				, G/L Account Type
G/L Account			, Rekening					, G/L Account
G/L Categorie 01	, Verdichting 1				, G/L Category 1
G/L Categorie 02	, Verdichting 2				, G/L Category 2
G/L Categorie 03	, Verdichting 3				, G/L Category 3
G/L Categorie 04	, Verdichting 4				, G/L Category 4
G/L Categorie 05	, Verdichting 5				, G/L Category 5
G/L Categorie 06	, Verdichting 6				, G/L Category 6
G/L Categorie 07	, Verdichting 7				, G/L Category 7
G/L Categorie 08	, Verdichting 8				, G/L Category 8
G/L Categorie 09	, Verdichting 9				, G/L Category 9
G/L Categorie 10	, Verdichting 10			, G/L Category 10
Budget              , Budget                    , Budget
Database            , Administratie             , Database
];



// Selection table for Sales ABC Analysis
SalesExpressions:
LOAD * INLINE [
    SalesExpression
    Revenue
    Sales
    Margin
];

