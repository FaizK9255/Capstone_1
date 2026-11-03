-- I am covering the Florida (FL) sales territory 

USE sample_sales;
/*
What is the total revenue overall for sales in the assigned territory, 
plus the start date and end date that tell you what period the data covers
*/
SELECT MIN.Date) AS N(o.Date), MAX(s.Transaction_Date), MIN(s.Transaction_Date), sl.StoreLocation,
SUM(o.SalesTotal + s.Sale_Amount) AS TotalRevenueDate
FROM online_sales o 
INNER JOIN store_sales s
INNER JOIN store_locations sl
ON o.id = s.id = sl.StoreID
WHERE sl.StoreLocation = 'Florida';

