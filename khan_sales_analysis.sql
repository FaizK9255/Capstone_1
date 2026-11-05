-- I am covering the Florida (FL) sales territory 

USE sample_sales;

-- 1) What is total revenue overall for sales in the assigned territory, plus the start date and end date that tell you what period the data covers?
SELECT 
MIN(s.Transaction_Date) FirstStoreSale,
MAX(s.Transaction_Date) LastestStoreSale,
sl.State,
SUM(s.Sale_Amount) TotalRevenue
FROM store_sales s 
INNER JOIN store_locations sl
	ON s.Store_ID = sl.StoreId
WHERE sl.State = 'Florida'
GROUP BY sl.State;

-- 2) What is the revenue breakdown by year and month for the sales territory?

SELECT 
YEAR(s.Transaction_Date) SaleByYear,
MONTH(s.Transaction_Date) SaleByMonth,
sl.State,
SUM(s.Sale_Amount) TotalSales
FROM store_sales s 
INNER JOIN store_locations sl
	ON s.Store_ID = sl.StoreId
WHERE sl.State = 'Florida'
GROUP BY SaleByYear, SaleByMonth, sl.State
ORDER BY SaleByYear, SaleByMonth;

-- 3) Provide a comparison of total revenue for the specific sales territory and the region it belongs to.

SELECT 
COALESCE(sl.State, 'South Total Revenue') State,
ROUND(SUM(s.Sale_Amount), 2) Revenue
FROM store_sales s
INNER JOIN store_locations sl
	ON s.Store_ID = sl.StoreID
INNER JOIN management m 
	ON sl.State = m.State
WHERE m.Region = 'South'
GROUP BY sl.State WITH ROLLUP;

-- 4) What is the number of transactions per month and average transaction amount by product category for the sales territory?

SELECT 
YEAR(s.Transaction_Date) 'Year',
MONTH(s.Transaction_Date) 'Month',
COUNT(s.id) Transactions,
AVG(s.Sale_Amount) 'Average Transaction Amount',
i.Category 'Product Category'
FROM store_sales s
INNER JOIN products p
	ON s.Prod_Num = p.ProdNum
INNER JOIN inventory_categories i
	ON p.Categoryid = i.Categoryid
INNER JOIN store_locations sl
	ON s.Store_ID = sl.StoreID
WHERE sl.State = 'Florida'
GROUP BY Year, Month, i.Category
ORDER BY Year, Month, i.Category;

-- 5) Can you provide a ranking of in-store sales performance by each store in the sales territory, or a 
-- ranking of online sales performance by state within an online sales territory?

SELECT *
FROM store_locations
WHERE State = 'Florida';





