-- 1. Сгенерировать данные таблицы анализа (1000 записей)
DECLARE @i INT = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO Analiz (IS_GROUP, MATERIAL_TYPE, CODE_NAME, FULL_NAME, Price)
    VALUES (0, ROUND(RAND() * 5, 0), 'CODE' + RIGHT('0000' + CAST(@i AS VARCHAR), 4),
            'Analysis full name ' + CAST(@i AS VARCHAR), ROUND(RAND() * 1000, 2));
    SET @i = @i + 1;
END;

-- 2. Сгенерировать данные таблицы сотрудников (200 записей)
SET @i = 1;
WHILE @i <= 200
BEGIN
    INSERT INTO Employee (Login_Name, Name, Patronymic, Surname, Email, Archived, IS_Role)
    VALUES (
        'user' + RIGHT('000' + CAST(@i AS VARCHAR), 3),
        'Name' + CAST(@i AS VARCHAR),
        'Patronymic' + CAST(@i AS VARCHAR),
        'Surname' + CAST(@i AS VARCHAR),
        'user' + CAST(@i AS VARCHAR) + '@example.com',
        0, 0);
    SET @i = @i + 1;
END;

-- 3. Сгенерировать данные таблицы WorkStatus (10 записей)
DECLARE @statuses TABLE (Name VARCHAR(50));
INSERT INTO @statuses VALUES ('New'),('In Progress'),('Completed'),('Canceled'),('On Hold'),
                             ('Reviewed'),('Approved'),('Rejected'),('Invoiced'),('Paid');
INSERT INTO WorkStatus (StatusName)
SELECT Name FROM @statuses;

-- 4. Генерация данных таблицы организации (100 записей)
SET @i = 1;
WHILE @i <= 100
BEGIN
    INSERT INTO Organization (ORG_NAME, Email)
    VALUES ('Organization ' + CAST(@i AS VARCHAR), 'org' + CAST(@i AS VARCHAR) + '@example.org');
    SET @i = @i + 1;
END;

-- 5. Генерация данных таблицы Works (50 000 записей)
SET @i = 1;
WHILE @i <= 50000
BEGIN
    INSERT INTO Works (
    IS_Complit, CREATE_Date, Close_Date, Id_Employee, ID_ORGANIZATION, Comment, Price, FIO, Is_Del, StatusId)
VALUES (
    0,
    DATEADD(day, -FLOOR(RAND() * 365), GETDATE()),
    NULL,
    FLOOR(RAND()*200) + 1,
    FLOOR(RAND()*100) + 1,
    'Comment for work ' + CAST(@i AS VARCHAR),
    ROUND(RAND() * 5000, 2),
    'FIO ' + CAST(@i AS VARCHAR),
    0,
    FLOOR(RAND()*10) + 1
);
    SET @i = @i + 1;
END;


-- 6. Сгенерировать данные таблицы WorkItem (в среднем 3 товара на заказ, всего около 150 000 товаров)
SET @i = 1;
DECLARE @maxWorkId INT = 50000;
WHILE @i <= @maxWorkId
BEGIN
    DECLARE @itemsCount INT = 3; -- 平均3条
    DECLARE @j INT = 1;
    WHILE @j <= @itemsCount
    BEGIN
        INSERT INTO WorkItem (
            CREATE_DATE, Is_Complit, Id_Employee, ID_ANALIZ, Id_Work, Is_Print, Is_Select, Price, Id_SelectType)
        VALUES (
            DATEADD(day, -FLOOR(RAND() * 365), GETDATE()),
            0,
            CAST(RAND() * 200 + 1 AS INT), -- 随机员工Id
            CAST(RAND() * 1000 + 1 AS INT), -- 随机分析规格Id
            @i, -- 订单Id
            0, 0,
            ROUND(RAND() * 1000, 2),
            NULL);
        SET @j = @j + 1;
    END;
    SET @i = @i + 1;
END;
