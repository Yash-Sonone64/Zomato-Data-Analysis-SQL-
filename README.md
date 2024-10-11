# Zomato-Data-Analysis-SQL

In this Zomato data analysis project, we aim to explore and derive insights from a dataset comprising restaurant information, 
including details such as location, cuisine, pricing, and customer reviews. We will examine factors influencing 
restaurant popularity, assess the relationship between price and customer ratings, and investigate the prevalence 
of services like online delivery and table booking. The project seeks to provide valuable insights into the restaurant 
industry and enhance decision-making for both customers and restaurateurs.

# Description of the dataset:

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

Task 1 : Import Data
Task 2 : Data Cleaning
Task 3 : Check unique values
Task 4 : Number Of Restaurants
Task 5 : Number Of Country
Task 6 : Name of country
Task 7 : Countrywise count of restaurants peercentage
Task 8 : Percentage of Restaurants based on "Has_online_delivery"
Task 9 : Percentage of Restaurants based on "Has_table_booking"
Task 10 : Top 5 restaurants who has more number of votes and there country
Task 11 : Find most common cuisines in dataset
Task 12 : Number of restaurants opening based on year month quarter
Task 13 : Find the city with highest average cost for two people in India (Expensive)
Task 14 : highest voting restaurants in each country
Task 15 : highest rating restaurants in each country
Task 16 : Meaning of price range category and add new column status and give category accordingly
Task 17 : Find count of restaurants by the countries where the majority of restaurants offer online delivery and table booking
Task 18 : Fetch restaurant name where number of character > 15 character
Task 19 : average cost is greater than 1000 then good otherwise bad
Task 20 : Find restaurants that are currently delivering
