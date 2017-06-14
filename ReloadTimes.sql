// =================================== LOAD RELOADTIME =================================== //
TRACE # Load reload information;

ReloadTimes:
LOAD Reloadtime AS [QVW Reloadtime], 
     Document	AS [QVW Document]
FROM
[$(vDirectory_Workbooks)\Reloadtime_*.txt]
(txt, utf8, embedded labels, delimiter is ',', msq);

