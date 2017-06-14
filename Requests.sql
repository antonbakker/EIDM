// =================================== REQUESTS =================================== //
TRACE # Load request data;

SET ERRORMODE = 0;
	CheckFileExists:
	LOAD COUNT(DISTINCT FileName()) AS Files
	FROM $(vDirectory_Dimensions)\*_Requests.qvd;
	LET vFileCount = Alt(Peek('Files'), 0);
SET ERRORMODE =1;

IF vFileCount = 1 THEN


[Requests]:
LOAD 
[%Request_key],
[Request.ID],
[Request.HID],
[Request.Type],
[Request.TypeDescription],
[Request.Description],
[Request.StartDate],
[Request.EndDate],
[Request.HoursPlanned],
[Request.DaysPlanned],
[Request.StartDateActual],
[Request.EndDateActual],
[Request.HoursActual],
[Request.DaysActual],
[Request.AmountPlanned],
[Request.AmountActual],
[Request.StatusdescriptionDutch],
[Request.StatusdescriptionEnglish],
[Request.EmpID],
[Request.Currency],
[Request.AmountFC],
[Request.CurrencyActual],
[Request.AmountFCActual],
[Request.BillCustomer],
[Request.ItemCode],
[Request.Status],
[Request.ProjectNumber],
[Request.RequestComments],
[Request.WorkflowComments],
[Request.Approver],
[Request.Approved],
[Request.Processor],
[Request.Processed],
[Request.Realizer],
[Request.Realized],
[Request.StatusChanged],
[Request.syscreated],
[Request.syscreator],
[Request.sysmodified],
[Request.sysmodifier],
[Request.Division],
[Request.FreeTextField_01],
[Request.FreeTextField_02],
[Request.FreeTextField_03],
[Request.FreeTextField_04],
[Request.FreeTextField_05],
[Request.FreeTextField_06],
[Request.FreeTextField_07],
[Request.FreeTextField_08],
[Request.FreeTextField_09],
[Request.FreeTextField_10],
[Request.FreeTextField_11],
[Request.FreeTextField_12],
[Request.FreeTextField_13],
[Request.FreeTextField_14],
[Request.FreeTextField_15],
[Request.FreeDateField_01],
[Request.FreeDateField_02],
[Request.FreeDateField_03],
[Request.FreeDateField_04],
[Request.FreeDateField_05],
[Request.FreeBoolField_01],
[Request.FreeBoolField_02],
[Request.FreeBoolField_03],
[Request.FreeBoolField_04],
[Request.FreeBoolField_05],
[Request.FreeNumberField_01],
[Request.FreeNumberField_02],
[Request.FreeNumberField_03],
[Request.FreeNumberField_04],
[Request.FreeNumberField_05],
[Request.FreeIntField_01],
[Request.FreeIntField_02],
[Request.FreeIntField_03],
[Request.FreeIntField_04],
[Request.FreeIntField_05],
[Request.OpportunityID]
FROM $(vDirectory_Dimensions)\*_Requests.qvd (qvd);

ENDIF

SET ERRORMODE = 0;
	DROP TABLES CheckFileExists;
SET ERRORMODE =1;




