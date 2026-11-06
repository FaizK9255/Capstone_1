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


SELECT 
sl.StoreLocation,
SUM(s.Sale_Amount) Total_Sales,
RANK() OVER (ORDER BY SUM(s.Sale_Amount) DESC) Ranking
FROM store_sales s
INNER JOIN store_locations sl
	ON s.Store_ID = sl.StoreId
WHERE sl.State = 'FLorida'
GROUP BY sl.StoreLocation
ORDER BY Ranking;

/*
What is your recommendation for where to focus sales attention in the next quarter?

For EmporiUm's next quarter, I recommend a focus on our two lowest preforming product categories, Books and Stationary/Supplies

Books and Stationary & Supplies have been EmporiUm's lowest preforming categories month by month. Books average
30 monthly transactions, with $30 being the average transaction amount, and Stationary & Supplies average 66 monthly transactions,
with only $11 being the average transaction amount.  The estimated monthly revenue for both of these categories is around $830.

Technology and Accessories is an anomoly category that consistently produces the highest transactions and transaction amounts. However,
being a student bookstore, Stationary is on par with Technology transactions. With such a strong technological front, we must pick up the 
pace in other categories.

What this means: 
Stationary & Supplies brings in heavy customer traffic, however it lacks high average transaction amounts. Books, are the inverse. 

My proposal:
I propose we utilize Stationary/Supplies to push Books as a main product in the upcoming quarter. Books have strong value in purchases
and have room to grow. The timing ties in as well. The upcoming quarter includes holiday season, harsh weather that keep the public indoors,
and the start of the spring semester

Approach:
With heavy traffic from Stationary customers, they will be our main target audience. We can bundle products together, such as books with
highlighters, journals with pens, etc. We can also run cross item promotions. For example, a discounted book with a minimum purhcase of stationary items

Overall, pulling in more Book transactions with the Stationary traffic is my recommendation moving into the next quarter. 

*/





