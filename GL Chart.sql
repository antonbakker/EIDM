// =================================== GL CHART =================================== //
// First check if file exists. If file exists then load
TRACE # Load GL Chart information if exists;

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Dimensions)\*_GeneralLedgers.qvd (qvd);
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN

[General Ledger Chart]:
	LOAD 
	%GeneralLedger_key, 
	// New Fields
	//GL.Subclassification_01Code	 AS CategorieSetting, //important for financial kpi settings
	$(vCategorieSetting1) AS CategorieSetting1,
	$(vCategorieSetting2) AS CategorieSetting2,
	$(vCategorieSetting3) AS CategorieSetting3,
	// Qvd fields
	GL.NumberAndDescription, 
     GL.Subclassification_01CodeAndDescription, 
     GL.Subclassification_02CodeAndDescription, 
     GL.Subclassification_03CodeAndDescription, 
     GL.Subclassification_04CodeAndDescription, 
     GL.Subclassification_05CodeAndDescription, 
     GL.Subclassification_06CodeAndDescription, 
     GL.Subclassification_07CodeAndDescription, 
     GL.Subclassification_08CodeAndDescription, 
     GL.Subclassification_09CodeAndDescription, 
     GL.Subclassification_10CodeAndDescription, 
     GL.BalanceOrPL, 
     GL.Number, 
     GL.Description, 
     GL.Type, 
     GL.Subclassification_01Code, 
     GL.Subclassification_02Code, 
     GL.Subclassification_03Code, 
     GL.Subclassification_04Code, 
     GL.Subclassification_05Code, 
     GL.Subclassification_06Code, 
     GL.Subclassification_07Code, 
     GL.Subclassification_08Code, 
     GL.Subclassification_09Code, 
     GL.Subclassification_10Code, 
     GL.Subclassification_01Description, 
     GL.Subclassification_02Description, 
     GL.Subclassification_03Description, 
     GL.Subclassification_04Description, 
     GL.Subclassification_05Description, 
     GL.Subclassification_06Description, 
     GL.Subclassification_07Description, 
     GL.Subclassification_08Description, 
     GL.Subclassification_09Description, 
     GL.Subclassification_10Description
FROM $(vDirectory_Dimensions)\*_GeneralLedgers.qvd (qvd);
	
ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;