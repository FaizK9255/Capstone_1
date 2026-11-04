-- I am covering the Florida (FL) sales territory 

USE sample_sales;
/*
What is the total revenue overall for sales in the assigned territory, 
plus the start date and end date that tell you what period the data covers
*/

SELECT MIN(o.Date) FirstOnlineSale,
MAX(o.Date) LatestOnlineSale,
MIN(s.Transaction_Date) FirstStoreSale,
MAX(s.Transaction_Date) LastestStoreSale,
sl.State,
SUM(o.SalesTotal + s.Sale_Amount) TotalRevenue
FROM online_sales o
INNER JOIN store_sales s 
	ON o.id = s.id
INNER JOIN store_locations sl
	ON s.Store_ID = sl.StoreId
WHERE sl.State = 'Florida'
GROUP BY sl.State;

SELECT *
FROM store_locations
WHERE State = 'Florida';

