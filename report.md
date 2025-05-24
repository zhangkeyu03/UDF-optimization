# 1.Выполните Create objects.sql для создания структуры таблицы.
## осуществлять
select count(*) from dbo.Works;
select count(*) from dbo.WorkItem;
## Результаты запроса следующие:
![image](https://github.com/user-attachments/assets/af63f370-69da-4839-a351-99edd47d61b7)

# 2.Тест функции dbo.F_WORKS_LIST()
## Выполните следующий SQL-запрос:
SET STATISTICS TIME ON;
SELECT TOP 3000 * FROM dbo.F_WORKS_LIST();
SET STATISTICS TIME OFF;
## Результаты следующие:
![image](https://github.com/user-attachments/assets/2e0c7cfb-2d6e-4c55-8190-cd9eb00c028b)
Перевод текста на картинке следующий:
Время анализа и компиляции SQL Server:
Время ЦП = 0 мс, прошедшее время = 0 мс.
(затронуто 3000 строк)
Время выполнения SQL Server:
Время ЦП = 9318 мс, прошедшее время = 9454 мс.

# 3.Выполните F_WORKS_LIST_v2.sql для создания оптимизированной функции.
## Выполните следующий скрипт, чтобы проверить его производительность:
SET STATISTICS TIME ON;
SELECT TOP 3000 *
FROM dbo.F_WORKS_LIST_v2()
ORDER BY ID_WORK DESC;
SET STATISTICS TIME OFF;
## Результаты следующие:
![image](https://github.com/user-attachments/assets/24112183-c352-4d5c-916f-5676b9c3e19b)
Перевод текста на картинке следующий:
(затронуто 3000 строк)
Время выполнения SQL Server:
Время ЦП = 156 мс, прошедшее время = 234 мс.

