# Superstore-sales-profit-analysis-using-ANOVA-and-Chi-Squared-test

## Overview

This project involves analyzing a sales dataset from a Superstore, covering sales transactions from 2011 to 2015. The dataset includes information on customers, products, sales transactions, and various other attributes. Through this analysis, we explore insights related to product sales, profits, regions, shipping methods, and more.

The analysis is performed using various statistical methods like ANOVA, Chi-Square tests, and Exploratory Data Analysis (EDA). The dataset is analyzed in R and visualizations are created using ggplot2.

## Dataset Description

The dataset SuperStoreOrders.csv contains the following columns:
	•	Order Date: Date when the order was placed
	•	Ship Date: Date when the order was shipped
	•	Customer Name: Name of the customer
	•	Product Name: Name of the product
	•	Product Category: Category to which the product belongs
	•	Subcategory: Subcategory of the product
	•	Sales: Total sales amount for the transaction
	•	Quantity: Number of items in the transaction
	•	Discount: Discount applied to the transaction
	•	Profit: Profit earned from the transaction
	•	Shipping Cost: Shipping cost of the order

## Objectives

	•	Explore and visualize the dataset to uncover insights related to sales and profits across different product categories, regions, and shipping methods.
	•	Test various hypotheses, such as:
	•	Is there any difference in sales based on the product category?
	•	Do shipping methods impact the sales performance?
	•	Is there a significant association between regions and product categories?

## Key Findings

	1.	Sales by Region: Most orders came from the Central and South regions.
	2.	Profit by Subcategory: The highest profits were made from the Copier and Phone subcategories.
	3.	Shipping Methods: The most common shipping method used was the “Standard Class.”
	4.	Significant Associations:
	•	The region and product category have a significant association.
	•	There is a difference in sales distribution based on the shipping method.
