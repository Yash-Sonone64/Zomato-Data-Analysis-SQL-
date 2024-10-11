--               ZOMATO DATA ANALYSIS PROJECT


-- In this Zomato data analysis project, we aim to explore and 
-- derive insights from a dataset comprising restaurant information, 
-- including details such as location, cuisine, pricing, 
-- and customer reviews. We will examine factors influencing 
-- restaurant popularity, assess the relationship between 
-- price and customer ratings, and investigate the prevalence 
-- of services like online delivery and table booking. 
--  The project seeks to provide valuable insights into the restaurant 
--  industry and enhance decision-making for both customers and 
--  restaurateurs

--  Description of the dataset:

-- RestaurantID: A unique identifier for each restaurant in the dataset.

-- RestaurantName: The name of the restaurant.

-- CountryCode: A code indicating the country where the restaurant 
-- is located.

-- City: The city in which the restaurant is situated.

-- Address: The specific address of the restaurant.

-- Locality: The locality (neighborhood or district) where the restaurant 
-- is located.

-- LocalityVerbose: A more detailed description or name of the locality.

-- Longitude: The geographical longitude coordinate of the restaurant's 
-- location.

-- Latitude: The geographical latitude coordinate of the restaurant's 
-- location.

-- Cuisines: The types of cuisines or food offerings available at the 
-- restaurant. This may include multiple cuisines separated by commas.

-- Currency: The currency used for pricing in the restaurant.

-- Has_Table_booking: A binary indicator (0 or 1) that shows whether 
-- the restaurant offers table booking.

-- Has_Online_delivery: A binary indicator (0 or 1) that shows 
-- whether the restaurant provides online delivery services.

-- Is_delivering_now: A binary indicator (0 or 1) that indicates 
-- whether the restaurant is currently delivering food.

-- Switch_to_order_menu: A field that might suggest whether customers 
-- can switch to an online menu to place orders.

-- Price_range: A rating or category that indicates the price 
-- range of the restaurant's offerings (e.g., low, medium, high).

-- Votes: The number of votes or reviews that the restaurant has received.

-- Average_Cost_for_two: The average cost for two people to dine 
-- at the restaurant, often used as a measure of affordability.

-- Rating: The rating of the restaurant, possibly on a scale 
-- from 0 to 5 or a similar rating system.

-- Datekey_Opening: The date or key representing the restaurant's 
-- opening date.

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Task 1 : Import Data

CREATE DATABASE Zomato_project;
USE Zomato_project;

SHOW tables;

DESC rest_data;
DESC country_data;

SELECT * FROM rest_data;
SELECT * FROM country_data;

-- Task 2 : Data Cleaning
-- country_data >>> country name >>> countryname

SELECT 'country name' FROM country_data;

ALTER TABLE country_data
CHANGE COLUMN `country name` countryname TEXT;

SELECT countryname FROM country_data;

DESC country_data;

-- Rest_Data >>> Datekey_Opening 

SELECT Datekey_Opening FROM rest_data;

SET SQL_SAFE_UPDATES = 0;

UPDATE rest_data SET Datekey_Opening = replace(Datekey_Opening,"_","/");

SELECT Datekey_Opening FROM rest_data;

ALTER TABLE rest_data
MODIFY COLUMN Datekey_Opening DATE;

DESC rest_data;

SET SQL_SAFE_UPDATES = 1;



-- Task 3 : Check unique values
-- Check unique value from categorical column

SELECT DISTINCT countrycode FROM rest_data;
SELECT DISTINCT has_table_booking FROM rest_data;
SELECT DISTINCT has_online_delivery FROM rest_data;
SELECT DISTINCT price_range FROM rest_data;
SELECT DISTINCT rating FROM rest_data;
SELECT DISTINCT is_delivering_now FROM rest_data;

-- Task 4 : Number Of Restaurants
SELECT COUNT(restaurantId) FROM rest_data;

-- Total data is available for 9551 Restaurants.

-- Task 5 : Number Of Country
SELECT COUNT(DISTINCT countrycode) FROM rest_data;

-- Total of 15 country data is available in dataset.

-- Task 6 : Name of country
SELECT countryname FROM country_data;

SELECT DISTINCT c1.countryname FROM rest_data r1
INNER JOIN country_data c1
ON r1.countrycode = c1.countryid;

-- Task 7 : Countrywise count of restaurants peercentage

-- To get the countrywise count of restaurants 
SELECT c1.countryname,COUNT(r1.RestaurantID) FROM rest_data r1
INNER JOIN country_data c1
ON r1.countrycode = c1.countryid
GROUP BY c1.countryname;

-- count of restaurants percentage
SELECT c1.countryname,COUNT(r1.RestaurantID)/9551*100 As Restro_Percentage FROM rest_data r1
INNER JOIN country_data c1
ON r1.countrycode = c1.countryid
GROUP BY c1.countryname;

-- 90 % Of total restaurants are from India.

-- Task 8 : Percentage of Restaurants based on "Has_online_delivery".
SELECT Has_Online_delivery,COUNT(restaurantID) FROM rest_data
GROUP BY Has_Online_delivery;

-- Percentage
SELECT Has_Online_delivery,Round(COUNT(restaurantID)/9551*100) As Total_percent FROM rest_data
GROUP BY Has_Online_delivery;

-- 26% restaurants has online delivery option and 74% don't have online delivery option.


-- Task 9 : Percentage of Restaurants based on "Has_table_booking".
SELECT Has_table_booking,COUNT(restaurantID) FROM rest_data
GROUP BY Has_table_booking;

-- Percentage
SELECT Has_table_booking,Round(COUNT(restaurantID)/9551*100) As Total_percent FROM rest_data
GROUP BY Has_table_booking;

-- 12% restaurants has table booking option and 88% don't have table booking option.


-- Task 10 : Top 5 restaurants who has more number of votes and there country
SELECT c1.countryname, r1.Restaurantname, r1.votes FROM rest_data r1
INNER JOIN country_data c1
ON r1.countrycode = c1.countryid
ORDER BY r1.votes DESC
limit 5;

-- Toit, Truffles , Hauz Khas Social, Peter Cat, AB's - Absolute Barbecues  are the top 5 restaurants from india who has more number of votes

-- Task 11 : Find most common cuisines in dataset.
SELECT  cuisines,COUNT(restaurantID) total FROM rest_data
GROUP BY cuisines
ORDER BY total DESC;

-- North Indian is the most common cuisine.

-- Task 12 : Number of restaurants opening based on year month quarter.

-- YEAR
SELECT YEAR(datekey_opening) year1, Count(*) Total FROM rest_data
Group BY YEAR(datekey_opening)
ORDER BY year1 ASC;

-- MONTH
SELECT Monthname(datekey_opening) month1, Count(*) Total FROM rest_data
Group BY monthname(datekey_opening),month(datekey_opening) 
ORDER BY month(datekey_opening) ASC;

-- Quarter
SELECT concat("Q",quarter(datekey_opening)) quarter1, Count(*) Total FROM rest_data
Group BY concat("Q",quarter(datekey_opening))
ORDER BY quarter1 DESC;

-- Most of the restaurants are open in 2018.

-- Task 13 : Find the city with highest average cost for two people in India (Expensive). 	
SELECT r1.city,avg(average_cost_for_two) average FROM rest_data r1
INNER JOIN country_data c1
ON r1.countrycode = c1.countryid
WHERE c1.countryname = "India"
GROUP BY r1.city
ORDER BY average DESC
limit 3;

-- Panchkula city has highest average cost for two people in India.

-- Task 14 : highest voting restaurants in each counntry
SELECT c1.countryname,max(r1.votes) FROM rest_data r1
INNER JOIN country_data c1
ON r1.countrycode = c1.countryid
GROUP BY c1.countryname;

-- By using window function
WITH CTE1 AS(
SELECT c1.countryname,r1.restaurantname,r1.votes,row_number() over(partition by c1.countryname ORDER BY r1.votes DESC) rn
FROM rest_data r1
INNER JOIN country_data c1
ON r1.countrycode = c1.countryid)
SELECT * FROM CTE1 WHERE rn = 1;

-- Task 15 : highest rating restaurants in each counntry
WITH CTE1 AS (
    SELECT c1.countryname, r1.restaurantname, r1.rating, 
           ROW_NUMBER() OVER(PARTITION BY c1.countryname ORDER BY r1.rating DESC) AS rn
    FROM rest_data r1
    INNER JOIN country_data c1
    ON r1.countrycode = c1.countryid
)
SELECT countryname, restaurantname, rating
FROM CTE1 
WHERE rn = 1;

-- Task 16 : Meaning of price range category and add new column status and give category accordingly.
SELECT DISTINCT Price_range FROM rest_data;

SELECT Price_range,min(Average_Cost_for_two),max(Average_Cost_for_two) FROM rest_data
GROUP BY Price_range;

-- 1, 0, 450      >> Cheap D
-- 2, 15, 70000   >> Expensive B
-- 3, 30, 800000  >> Most Expensive A
-- 4, 50, 8000    >> Moderate C

ALTER TABLE rest_data
ADD COLUMN status VARCHAR(40);

SELECT * FROM rest_data;

SET SQL_SAFE_UPDATES = 0;

UPDATE rest_data SET status = 
CASE WHEN Price_range = 3 then "Most Expensive"
 WHEN Price_range = 2 then "Expensive"
 WHEN Price_range = 1 then "Cheap"
 WHEN Price_range = 4 then "Moderate"
 end;
 
 SELECT * FROM rest_data;
 
 SET SQL_SAFE_UPDATES = 1;
 
 -- Task 17 : Find count of restaurants by the countries where the majority of restaurants offer online delivery and table booking.
 
 SELECT c1.countryname,COUNT(*) Total FROM rest_data r1
 INNER JOIN country_data c1 
 on r1.countrycode = c1.countryid
 WHERE r1.Has_Online_delivery = "Yes" and r1.Has_Table_booking = "Yes"
 GROUP BY c1.countryname;
 
 -- Task 18 : Fetch restaurant name where number of character > 15 character.
 SELECT restaurantname,length(restaurantname) FROM rest_data
 WHERE length(restaurantname) > 15;
 
 -- Task 19 : average cost is greater than 1000 then good otherwise bad.
 SELECT Average_Cost_for_two,if(Average_Cost_for_two>1000,"Good","Bad")
 FROM rest_data;
 
 -- Task 20 : Find restaurants that are currently delivering.
 SELECT RestaurantName,City,Is_delivering_now FROM rest_data
 WHERE Is_delivering_now = "Yes";
 
