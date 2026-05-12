# Project Background

  
This anonymous company is a UK based online retailer specializing in all occasion gifts. The company sells primarily to wholesalers in the UK, although a small percentage of their customers also come from surrounding European countries.

Insights and recommendations are provided on the following key areas:

- **Sales Trends Analysis:** Evaluation of sales trends for the time period provided, focusing on revenue, order volume, and average order value (AOV)

- **Product Category Trends:** An analysis of how the different categories of products perform by revenue and order volume, as well as key products in each category.

- **Customer Profiles:** Constructed profiles of highest revenue and volume customers

  
The SQL queries used to inspect, clean, and analyze the data can be found here [\[link\]](https://github.com/ares-slone/uk-gift-store-sales/blob/main/online_retail_script.sql).

  

An interactive Tableau dashboard used to report and explore sales trends can be found here [\[link\]](https://public.tableau.com/app/profile/ares.slone/viz/OnlineUKGiftStoreSalesPerformance/Dashboard1).

  
<br>

# Data Structure & Initial Checks

  

The company’s main database structure consists of a single table with a total row count of 541,909. The data dictionary can be found below:


<br>

 
| Field Name | Field Description |
|--|--|
| invoice_number | A 6 digit transaction identifier. Cancelled orders are designated by a ‘c’ before the ID. |
| stock_code | A 5 digit product identifier |
| description| The original product description |
| clean_description | The product descriptions cleaned and standardized |
| category | The category of product out of 12 overall categories. Category descriptions can be found here: [LINK]
| quantity | The amount of the product purchased |
|invoice_date | The date and time of purchase |
| unit_price | The price of the product purchased in sterling |
| unit_total | The price of the number of product purchases in sterling |
| customer_id | A 5 digit customer identifier |
| country | The country where the customer lives |
<br>


The data was originally sourced here: [\[LINK\]](https://archive.ics.uci.edu/dataset/352/online+retail).

Chen, D. (2015). Online Retail [Dataset]. UCI Machine Learning Repository. [https://doi.org/10.24432/C5BW33](https://doi.org/10.24432/C5BW33).

  

The data was further checked for quality control and additional information added to the database. The changelog can be found here: [\[LINK\]](https://docs.google.com/spreadsheets/d/1hoeMj1kUZ5cn0A-8ndhy4o3gZCB1msDu/edit?gid=1649578158#gid=1649578158).

  
<br>

# Executive Summary

For the reporting period between December 2010 and November 2011, **sales totaled £8,848,305** with an **average AOV of £386**. **Sales are fairly steady in Q1-Q3** with an average monthly sales total of £634k, **then increase over Q4** with a significant peak in November, while AOV remains steady throughout the year. **Top product categories are Home Decor and Kitchen & Dining** by a wide margin, comprising 30% and 24% of total sales respectively.

Overall, while the pattern of sales during the reporting period would suggest that end of year holidays are the main driving factor of sales, the top product categories, individual product purchase patterns, and AOV trends suggest otherwise. The following sections of this report will highlight these contrasting patterns and suggest potential areas of growth to expand on both seasonal and non seasonal sales.

<br>
<br>
<div align="center">
  <img src="images/Executive Summary Dashboard.png" width="800">
</div>

<br>

# Insights Deep Dive
  
## Sales

-   **The company’s sales totaled £8,848,305** for December 2010 to November 2011.
    
-   **The company’s sales peaked in November 2011** with 83,000 orders totaling £1,426,588 monthly revenue. As the company specializes in all occasion gifts with mostly wholesaler customers, this aligns with stores stocking up for the holiday season.
    
-   Overall, **lowest sales numbers are in February** with 27,282 orders totaling almost £499,464, and rise until November before dropping off.
    
-   Notably, **AOV remains mostly steady throughout the year**, with a slight dip in April, being the lowest at £282, with September being the highest at £446. This suggests that while more orders are being made later in the year, the amount purchased per customer holds steady despite intuition suggesting wholesalers may need more stock for the holiday rush.

<br>
<br>   
<div align="center">
  <img src="images/Total Sales.png" width="800">
</div>
<br>


## Products

-   **The overall largest product category is Home Decor** with £3,123,550 total in sales, 30% of total revenue.
-   **Kitchen & Dining follows close behind** with £2,462,466 total in sales, 24% of total revenue.
-   Home Decor’s and Kitchen & Dining’s difference in revenue comes mostly from Home Decor having a sales spike between September and November
-   **All other categories contribute 2-7% each to total revenue**
-   Many categories have distinct patterns of sales peaks through the year:
	-  Home Decor increases in March and May, with its highest sales volume in September through November
	-  Celebration & Seasonal increases only towards the end of the year, reflecting the high number of Christmas and Halloween items 
	-   Jewelry and Fashion increases in March and May, but doesn’t increase in Q4  
	-   Storage and Organization has a unique peak in June  
	-   Otherwise, all other categories follow a narrowed version of the overall sales peak and valleys
-   **The lowest performing categories include Home Fragrance & Wellness, Garden & Outdoor, and Arts & Crafts**, with around £15k, £23k, and £21k in sales respectively. 
<br>
<br>   
<div align="center">
  <img src="images/Product category sales totals by month.png" width="800">
</div>
<br>
<br>
<div align="center">
  <img src="images/Category percent of total sales per month.png" width="800">
</div>

<br>

## Product Categories
  
Within each category, there are some stand out products and patterns:

**Arts & Crafts:**
-   6 Ribbons Rustic Charm significantly outperforms other products in the category at £17,130
	 -   Only Rustic Charm ribbons perform well; other ribbon varieties perform far worse
-   Feltcraft 6 Flower Friends is the next top performer at £11,198

<br>

**Celebration and Seasonal:**
-   Party Bunting is the significant outlier revenue wise at £98,243
	-   Sales are steady throughout the year with a peak in May
 -   The next outlier is the Paper Chains Christmas Kit at £63,715
	-   Most units are sold in November, as would be expected with a holiday product

<br>


**Garden & Outdoor:**
-   The major outlier is the Edwardian Parasol Natural at £23,400, with the next highest product being Edwardian Parasol Black at £16,263
	-   Notably, all other parasols perform significantly less, but the other two Edwardian parasols are still fairly high performers, suggesting that this style of parasols are quite popular overall

<br>


**Gifts & Novelties:**

-   The top products are all hot water bottles despite having a relatively low unit price (£4.95)
	-   Tea and Sympathy, Chocolate, Scottie Dog, and White Skull hot water bottles are the top performers, all above £20k in revenue
	-   Union Jack, Pink Heart Dots and Red White Scarf hot bottles are significant under performers with less than £1k revenue 
-   Bling Key Rings and Crochet keyrings are significant underperformers in the category, making far less than other products with a similarly low unit price

<br>


**Home Decor & Accents:**

-   Home Decor contains 4 of the top performers in terms of revenue. Compared to other categories, Home Decor has a significant amount of higher revenue items with 32 products making over £20k in revenue  
-   Each of the top products except the Rabbit Nightlight have fairly consistent sales throughout the year with a slight increase in November, reflecting the overall store increase
	-   The Rabbit Nightlight was introduced in May, and jumped from around £3k in sales per month to over £34k in sales in November. This is the second highest individual product sales peak across all inventory

<br>


**Home Fragrance & Wellness:**
-   The large outlier is Homemade Jam Scented Candles with £18,585 in revenue. The next highest performer is the Grand Chocolate Candle at £8,159
	-   Jam Scented Candles perform fairly consistently across the year with small peaks in March and September

<br>


**Jewelry & Accessories:**
-   The large outlier is Jumbo Bag Red Retrospot with £92,175 in revenue, while the next highest performer is Jumbo Bag Pink Polkadot with £41,584   
	-   Overall, Jumbo Bags are the by and away the top performers in this category, holding 8 of the top 10 spots in the category  
-   This category has a significantly long tail of underperforming products, with 295 items earning under £100 in revenue and 469 products earning under £1000 in revenue    
-   In general, jewelry and hair accessories perform poorly, while bags do fairly well

<br>


**Kitchen & Dining:**

-   The Regency Cakestand is the top performer in this category and overall, earning £164,459 in revenue. The next highest is Set of 3 Cake Tins Pantry Design at £37,378   
-   While there is a massive gap between the top performer and next highest performing product, the category has a large number of high performers, with 24 products making over £20k   
-   Lunch boxes perform fairly well, with the lowest performing lunchbox earning £7,820, but most earning over £20k   
-   Big Mugs are underperforming, all earning less than £20   
-   Mugs’ performance has some of the largest range, with the top performing Save the Planet Mug earning £5,938 and the lowest performing mug being Funky Monkey Mug at £1.25

<br>


**Stationary & Gift Wrap:**

-   The top performer is Wood Black Board Ant White Finish with £35,795, with the next top performers being Paper Bunting Retrospot at £22,588 and Paper Chain Kit Empire at £14,978    
-   Sets of 10 Cards make up most of the bottom performers. While cards in general don’t necessarily perform poorly as a few do perform significantly better, well performing cards seem to be the outlier

 <br>

  
**Storage & Organization:**

-   This category has two outliers: Picnic Basket Wicker Small at £51,023 and Popcorn Holder at £50,967   
	-   Most of the Picnic Basket sales were due to the June peak, with a monthly revenue of £40,298. This is the largest individual product sales peak across all inventory   
-   Popcorn Holder sales were more steady, with an average monthly revenue of £2,872 before a November peak of £13,961 
-   This category has a very small tail of underperformers, with only 5 products performing under £100   
-   The lowest performer is the Folding Shoe Tidy with £8.85

<br>


**Toys, Games, & Kids**

-   The top performer is Red Harmonica in Box at £26,210, with the next top performer being Grow a Flytrap or Sunflower in Tin at £17,837
    


<br>
<br>
<div align="center">
  <img src="images/Top Two Products per Category.png" width="600">
</div>

<br>
<br>

## Specific Products

-   **Overall, orders are spread across the store’s inventory with only 4 products contributing more than 1% of the total revenue**, and no products contributing more than 2%    
-   **The Regency Cakestand is the top earning product**, contributing 1.7% of the total revenue, and 6.7% of the Kitchen & Dining category    
-   **Popcorn holders are the top product by number of units sold**, but due to the low unit price at £0.85 only earned a third of the revenue of the highest revenue product 
	-   Popcorn holder sales peak in November, tripling the otherwise steady sales the rest of the year
-   **All top performing products except the Regency Cakestand and Wicker Picnic Basket have at least a small sales peak in November**
	-   Christmas Paper Chain Kits and the Rabbit Nightlight have a particularly large peak   
	-   Regency Cakestands peak in December
	-   Picnic Baskets peak in June, at the beginning of picnic season


<br>
<br>  
<div align="center">
  <img src="images/Top product sales.png" width="800">
</div>


<br>

## Customer Success

- The top 10 customers make up **14.7% of total revenue**
- **6 customers had yearly purchases of over £100,000**

Within the reported time period, these customers:

- - Averaged 85 orders
      - Averaged 90k units ordered
      - **Primarily purchased Home Decor and Kitchen & Dining products**, although proportions depend on the customer

As this company's customers consist primarily of wholesalers who will make repeat bulk orders, understanding the products they are providing for their customers will help the team establish loyalty and introduce customers to new, related products.

<br>
<br>

<div align="center">
  <img src="images/Customer product category sales mix.png" width="800">
</div>

<br>
<br>


Below are customer profiles for the customers purchasing over £100,000 in the reporting period

### Customer 14646

- This customer placed orders in almost every month of the reporting period, marking them as a consistent customer
  - Volume of sales reflect overall sales trends with highest sales volume in Q4, but with an additional peak in August
  - Proportion of sales between product categories remained fairly consistent throughout the year
- Product types this customer tends to purchase include lunch boxes or bags, night lights, and products with woodland themes, including forest animals and mushroom patterns
	- This customer made increasing bulk purchases of the Rabbit Nightlight after its introduction in May, suggesting this product type does well with for this customer
<br>

| **Top Categories**    | **Sales Volume per Category** | **Top Item Ordered in Category** | **Sales Volume per Item** |
| --------------------- | ----------------------------- | -------------------------------- | ------------------------- |
| **Kitchen & Dining**  | **£114,711**                  | Round Snack Boxes Set of 4       | £7,956                    |
| Home Decor            | £58,611                       | **Rabbit Night Light**           | **£9,568**                |
| Jewelry & Accessories | £31,144                       | Jumbo Bag Red Retrospot          | £3,468                    |

<br>
<br>
<div align="center">
  <img src="images/Customer 14646 stacked categories.png" width="800">
</div>

<br>

### Customer 18102

- This customer made purchases every month of the reporting period, but monthly sales volume varies widely from a low of under £1,000 to over £52,000
  - The highest sales volume, and highest sales months were in Q4
- Purchases were almost solely from the Home Decor product category with 85% of revenue from Home Decor products
- Product types this customer tends to purchase include wall hangings and door mats
<br>


| **Top Categories**     | **Sales Volume per Category** | **Top Item Ordered in Category**  | **Sales Volume per Item** |
| ---------------------- | ----------------------------- | --------------------------------- | ------------------------- |
| **Home Decor**         | **£220,898**                  | **Vintage Union Jack Memoboard**  | **£16,592**               |
| Stationery & Gift Wrap | £15,351                       | Wood Black Board Ant White Finish | £15,351                   |
| Kitchen & Dining       | £11,998                       | Bread Bin Diner Style Red         | £839                      |

<br>
<br>

<div align="center">
  <img src="images/Customer 18102 stacked categories.png" width="800">
</div>

<br>

### Customer 17450

- While orders were placed throughout the year, by far and away the largest sales month was September at £70,629
- Home Decor was the top product category, making up 59% of the customer's sales volume
  - Kitchen & Dining products, despite being the second top category, were primarily purchased during peaks in June and September
- This customer purchases a variety of home decor items, but wicker heart wall hangings and tea light holders were significant outliers among purchased products
<br>


| **Top Categories** | **Sales Volume per Category** | **Top Item Ordered in Category**    | **Sales Volume per Item** |
| ------------------ | ----------------------------- | ----------------------------------- | ------------------------- |
| **Home Decor**     | **£111,374**                  | **Heart of Wicker Large**           | **£13,428**               |
| Kitchen & Dining   | £48,978                       | Set of Tea Coffee Sugar Tins Pantry | £10,567                   |
| Gifts & Novelties  | £7,493                        | Scottie Dog Hot Water Bottle        | £2,530                    |

<br>
<br>


<div align="center">
  <img src="images/Customer 17450 stacked categories.png" width="800">
</div>

<br>

### Customer 14911

- The customer's sales volume trend mimics the overall sales trend. The highest volume and peaks are in Q4
- Although Kitchen & Dining and Home Decor are flipped for the top two categories, category trends otherwise mimic the overall sales trends for categories, with the top two categories far outpacing all others until Q4 where Celebration & Seasonal products significantly increases
- The product types this customer tends to buy are those with an 'older' style, with products labeled "vintage" and "regency" being top purchases
  - There are also more Christmas specific product purchases, particularly "vintage" Christmas products, likely accounting for the increase in the Celebration & Seasonal category in Q4
<br>


| **Top Categories**     | **Sales Volume per Category** | **Top Item Ordered in Category**   | **Sales Volume per Item** |
| ---------------------- | ----------------------------- | ---------------------------------- | ------------------------- |
| **Kitchen & Dining**   | **£43,941**                   | **Regency Cakestand 3 Tier**       | **£3,591**                |
| Home Decor             | £33,508                       | White Hanging Heart T-Light Holder | £2,010                    |
| Celebration & Seasonal | £13,996                       | Paper Chain Kit 50s Christmas      | £1,046                    |

<br>
<br>

<div align="center">
  <img src="images/Customer 14911 stacked categories.png" width="800">
</div>

<br>

### Customer 12415

- Overall sales trends are far less consistent with changing category proportions and sales volume peaks differing greatly from overall trends. Notably, the Q4 increase isn't seen.
  - Monthly sales range from 0 to £23k, with higher volume every 2-3 months
- While Kitchen & Dining and Home Decor are the highest categories, Kitchen & Dining had the most sales in the first half of the year before decreasing dramatically, while Home Decor products only began to be purchased in May with the Rabbit Night Light product was introduced
  - Notably, the Rabbit Night Light is the top purchased product overall
<br>


| **Top Categories**   | **Sales Volume per Category** | **Top Item Ordered in Category**  | **Sales Volume per Item** |
| -------------------- | ----------------------------- | --------------------------------- | ------------------------- |
| **Kitchen & Dining** | **£48,692**                   | Set of 6 Spice Tins Pantry Design | £1,987                    |
| Home Decor           | £24,101                       | **Rabbit Night Light**            | **£2,748**                |
| Toys, Games, & Kids  | £13,919                       | Red Harmonica in Box              | £1,781                    |

<br>
<br>


<div align="center">
  <img src="images/Customer 12415 stacked categories.png" width="800">
</div>

<br>

### Customer 14156

- Notably, sales trends differ entirely from overall sales trends, with the largest peak of over 25k in July. While there's a secondary peak in September, sales are otherwise not elevated in Q4, although the proportion of Home Decor items does increase
- The product types this customer tends to purchase are Kitchen & Dining related, with the top items in other categories still being related to cooking
<br>


| **Top Categories**     | **Sales Volume per Category** | **Top Item Ordered in Category** | **Sales Volume per Item** |
| ---------------------- | ----------------------------- | -------------------------------- | ------------------------- |
| **Kitchen & Dining**   | **£47,417**                   | **Regency Cakestand 3 Tier**     | **£3,119**                |
| Home Decor             | £32,359                       | Cook with Wine Metal Sign        | £1,983                    |
| Storage & Organization | £6,401                        | Recipe Box Pantry Yellow Design  | £1,330                    |

<br>
<br>



<div align="center">
  <img src="images/Customer 14156 stacked categories.png" width="800">
</div>

<br>

# Recommendations

-   **Reevaluate underperforming products:** Many categories have many underperforming products, in particular **Gifts & Novelties and Jewelry & Accessories**. **Home Fragrance & Wellness** as a whole is underperforming, minus a few outlier products. Given that the main audience is wholesalers, narrowing focus to products which sell in bulk over variety can reduce storage and inventory costs without reducing potential sales.
    
-   **Look to capitalize on holiday stock needs for wholesalers in Q4:** While inventory needs for wholesale customers should increase in Q4, AOV does not, which suggests that the company is missing an opportunity for increased wholesaler sales for the holiday season.
    
-   **Create a B2B success program:** As wholesalers are the main customer, and need to buy consistently in bulk, sales can potentially be increased by understanding their needs and directing them to similar products which may appeal to their audience, as well as offering discounts to increase loyalty and consistency.
    
-   **Consider summer holiday products:** A notable outlier in products are picnic baskets, which have the highest individual product sales peak. This suggests that there may be an untapped market for summer related products for outdoor recreation and gatherings which can help increase sales in Q2.
    

<br>

# Assumptions and Caveats

Throughout the analysis, assumptions were made to manage challenges with the data. These assumptions and caveats are noted below:

- December 2011 was left out of the analysis as data collection ended halfway through the month
- Approximately 25% of the rows did not include a customer ID. For the analysis, it is assumed that these are normal transactions but the customers do not overlap with any of those with an ID.
- Around 0.5% of the data was entered with a unit price of ‘0’. Notes in the data suggest these entries are for correcting various stock errors, and so were used in the analysis as is to maintain an accurate sales volume.
- Category types were primarily generated with an AI tool given only the product names as input. While these category types were manually cleaned to ensure no obvious miscategorizations, there may still be some errors due to unclear descriptions, or lack of clarity as to how the store itself groups products.
