/*
 Tally Tables Exercise

 The temporary table, #PatientAdmission, has values for dates between the 1st and 8th January 2026 inclusive
 But not all dates are present

AI prompt to help get started:

 Act as a SQL expert.   
 A table #PatientAdmission with columns AdmittedDate DATE (PK) and NumAdmissions INT  
 should have rows with contiguous dates from the earliest date (say 1 Jan 2026) 
 and the latest date (say 31 Dec 2026) 
 There should be no gaps. How do I list any gaps?
 I have a Tally table with column N with values between 1 and 10000.  Please use that in your response
 */

DROP TABLE IF EXISTS #PatientAdmission;
CREATE TABLE #PatientAdmission (AdmittedDate DATE, NumAdmissions INT);
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2026-01-01', 50);
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2026-01-02', 60);
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2026-01-03', 40);
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2026-01-05', 20);
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2026-01-07', 60);
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2026-01-08', 50);
--SELECT * FROM #PatientAdmission;


drop table #temp

;
WITH DateTracker AS (
    -- Anchor member: Select the initial start date
    SELECT CAST(min(admitteddate) AS DATE) AS CalendarDate
    from #patientadmission
 
    UNION ALL
    -- Recursive member: Increment the date by 1 day until reaching the end date
    SELECT CAST(DATEADD(DAY, 1, CalendarDate) AS DATE)
    FROM DateTracker
	
    WHERE CalendarDate < dateadd(day,-1,'2026-01-08')
)

--,prelim as 
--(

SELECT CalendarDate
,sqlt.admitteddate

into #temp
FROM DateTracker p

left join #patientadmission sqlt
on cast(p.calendardate as date)=cast(sqlt.admitteddate as date)

option (maxrecursion 365)

--)



select *
from #temp

where admitteddate is null