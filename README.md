# Superstore Sales and Profit Analysis using ANOVA and Chi-Squared Tests

## Overview

This project analyzes a Superstore sales dataset covering transactions from 2011 to 2015. The analysis explores sales, profit, regional performance, shipping methods, and product category relationships. Statistical methods, including ANOVA, Chi-Squared tests, and Exploratory Data Analysis (EDA), are employed using R and visualizations are created with ggplot2.

## Dataset Description

The `SuperStoreOrders.csv` dataset contains the following columns:

*   **Order Date:** Date when the order was placed.
*   **Ship Date:** Date when the order was shipped.
*   **Customer Name:** Name of the customer.
*   **Product Name:** Name of the product.
*   **Product Category:** Category to which the product belongs (e.g., Furniture, Office Supplies, Technology).
*   **Subcategory:** Subcategory of the product (e.g., Tables, Binders, Phones).
*   **Sales:** Total sales amount for the transaction.
*   **Quantity:** Number of items in the transaction.
*   **Discount:** Discount applied to the transaction.
*   **Profit:** Profit earned from the transaction.
*   **Shipping Cost:** Shipping cost of the order.

## Objectives

*   Explore and visualize the dataset to gain insights into sales and profits across different product categories, regions, and shipping methods.
*   Test the following hypotheses:
    *   Is there a statistically significant difference in sales based on the product category? (ANOVA)
    *   Do shipping methods have a statistically significant impact on sales performance? (ANOVA)
    *   Is there a significant association between regions and product categories? (Chi-Squared Test)

## Methodology

The analysis was conducted in R, using the following steps:

1.  **Data Loading and Cleaning:** The `SuperStoreOrders.csv` file was loaded into R. Data cleaning steps, such as handling missing values (if any) and data type conversions, were performed.
2.  **Exploratory Data Analysis (EDA):** EDA techniques were used to understand the data's distribution, identify patterns, and generate initial insights. This included creating visualizations using `ggplot2`.
3.  **ANOVA Testing:** One-way ANOVA tests were conducted to determine if there were statistically significant differences in sales based on product category and shipping method.
4.  **Chi-Squared Test:** A Chi-Squared test of independence was performed to assess the association between regions and product categories.
5.  **Visualization:** `ggplot2` was extensively used to visualize the findings, including bar charts, box plots, and other relevant plots.

## Key Findings

*   **Sales by Region:** [Insert specific findings, e.g., "The Central and South regions had the highest volume of orders, accounting for X% and Y% of total orders, respectively."].
*   **Profit by Subcategory:** [Insert specific findings, e.g., "Copiers and Phones were the most profitable subcategories, contributing \$X and \$Y in profit, respectively."].
*   **Shipping Methods:** [Insert specific findings, e.g., "Standard Class was the most frequently used shipping method, comprising Z% of all shipments."].
*   **Statistical Analysis Results:**
    *   **ANOVA (Product Category and Sales):** [State the results of the ANOVA test, e.g., "The ANOVA test revealed a statistically significant difference in sales across product categories (p < 0.05)."].
    *   **ANOVA (Shipping Method and Sales):** [State the results of the ANOVA test, e.g., "The ANOVA test indicated a statistically significant impact of shipping method on sales (p < 0.01)."].
    *   **Chi-Squared Test (Region and Product Category):** [State the results of the Chi-Squared test, e.g., "The Chi-Squared test confirmed a significant association between region and product category (p < 0.001)."].

## Code and Requirements

The R code for this analysis can be found in the `superstore_analysis.R` file.

**Required R Packages:**

*   `ggplot2`
*   `dplyr` (or other data manipulation packages used)
*   `stats` (for ANOVA and Chi-Squared tests)


## Future Work

*   Explore other statistical tests, such as post-hoc tests for ANOVA to identify specific group differences.
*   Perform time series analysis to identify sales trends over time.
*   Investigate the impact of discounts on sales and profitability.
*   Develop predictive models for sales forecasting.

## Author

Priyal Dharmawat
