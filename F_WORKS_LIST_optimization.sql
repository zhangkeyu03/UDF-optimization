CREATE FUNCTION dbo.F_WORKS_LIST_v2()
RETURNS TABLE
AS
RETURN
WITH WorkItemsCount AS (
    SELECT 
        Id_Work,
        SUM(CASE WHEN Is_Complit = 0 THEN 1 ELSE 0 END) AS WorkItemsNotComplit,
        SUM(CASE WHEN Is_Complit = 1 THEN 1 ELSE 0 END) AS WorkItemsComplit
    FROM WorkItem
    GROUP BY Id_Work
),
EmployeeNames AS (
    SELECT 
        Id_Employee,
        Surname + ' ' + Name + ' ' + Patronymic AS EmployeeFullName
    FROM Employee
)
SELECT 
    w.Id_Work,
    w.CREATE_Date,
    w.MaterialNumber,
    w.IS_Complit,
    w.FIO,
    CONVERT(VARCHAR(10), w.CREATE_Date, 104) AS D_DATE,
    ISNULL(wc.WorkItemsNotComplit, 0) AS WorkItemsNotComplit,
    ISNULL(wc.WorkItemsComplit, 0) AS WorkItemsComplit,
    e.EmployeeFullName AS FULL_NAME,
    w.StatusId,
    ws.StatusName,
    CASE 
        WHEN w.Print_Date IS NOT NULL OR
             w.SendToClientDate IS NOT NULL OR
             w.SendToDoctorDate IS NOT NULL OR
             w.SendToOrgDate IS NOT NULL OR
             w.SendToFax IS NOT NULL
        THEN 1 ELSE 0
    END AS Is_Print
FROM Works w
LEFT JOIN WorkItemsCount wc ON w.Id_Work = wc.Id_Work
LEFT JOIN EmployeeNames e ON w.Id_Employee = e.Id_Employee
LEFT JOIN WorkStatus ws ON w.StatusId = ws.StatusID
WHERE w.IS_DEL <> 1;
