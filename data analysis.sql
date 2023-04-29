#cleaning the data

#DELETE the COLUMN that wont use
ALTER TABLE `amazon-products`
DROP COLUMN image

ALTER TABLE `amazon-products`
DROP COLUMN link

#remove the currency symbol 
UPDATE `amazon-products`
set discount_price = REPLACE(discount_price, '₹',"")

UPDATE `amazon-products`
set actual_price = REPLACE(actual_price, "₹",'')

# get rip of comma
UPDATE `amazon-products`
set discount_price = REPLACE(discount_price, ',','')

UPDATE `amazon-products`
SET actual_price = REPLACE(actual_price, ',', '');

------------------------------------------------------------------------------------------------------------------------------------------------------------
#Data Analysis

#Checing all the data
SELECT *
from `amazon-products`

##checing how many type of main_category
SELECT main_category,count(*)  as ct
from `amazon-products`
GROUP BY main_category
ORDER BY ct desc

##checing how many sub_category
SELECT sub_category,count(*) as ct
from `amazon-products`
GROUP BY sub_category
ORDER BY ct desc

## check the top10 most sale category and sub_category
SELECT main_category, sub_category,count(main_category) as ct
from `amazon-products`
GROUP BY main_category,sub_category
ORDER BY ct DESC
limit 20

##avg rating of all product
SELECT avg(ratings)
from `amazon-products`

# look like the avg rating of each product is 3.7

##check the price
SELECT  name,actual_price
from `amazon-products`
ORDER BY actual_price DESC


##checing the sport shoes value
SELECT main_category, sub_category, NAME
from `amazon-products`
WHERE sub_category = 'Sports shoes'

SELECT sub_category, name, count(*) as ct
from `amazon-products`
WHERE sub_category = 'Sports shoes'
GROUP BY NAME
ORDER BY ct DESC
limit 20

##checing the sport shoes value
SELECT sub_category, name, count(*) as ct
from `amazon-products`
WHERE sub_category = 'Formal Shoes'
GROUP BY NAME
ORDER BY ct DESC
limit 20


## what is the discount percent of each product
SELECT name,actual_price, discount_price, ((actual_price -discount_price)/actual_price) *100 as percentCut
from `amazon-products`

SELECT AVG((actual_price - discount_price) / actual_price) * 100 AS avg_discount_percent
FROM `amazon-products`



## check the sub_category and price
SELECT a.sub_category, a.NAME, a.discount_price, a.actual_price,a.ct
from(
SELECT sub_category,NAME,discount_price,actual_price,count(*) as ct
from `amazon-products` 
WHERE sub_category = 'Sports shoes'
GROUP BY sub_category,NAME ,discount_price,actual_price
) as a
ORDER BY a.ct desc
LIMIT 20














