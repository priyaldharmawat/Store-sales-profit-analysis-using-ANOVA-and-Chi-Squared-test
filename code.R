library(tidyverse)
library("scales")
library(agricolae)
library(plyr)
library(dplyr)
library(corrplot)

# Loading the dataset
SuperStoreOrders <- read.csv("SuperStoreOrders.csv")
head(SuperStoreOrders)

# Summary of the dataset
dim(SuperStoreOrders)
str(SuperStoreOrders)
summary(SuperStoreOrders)

# Removing comma from sales values and converting it into numeric variable
SuperStoreOrders$sales <-gsub(",", "", SuperStoreOrders$sales)
SuperStoreOrders$sales <- as.numeric(SuperStoreOrders$sales)
head(SuperStoreOrders$sales,20)

# Checking missing values
missing_values <- sum(is.na(SuperStoreOrders))
missing_values # No missing values in the dataset 

## EXPLORATORY DATA ANALYSIS

# Plotting sales by segment
segmentSales <- aggregate(SuperStoreOrders$sales, by=list(SuperStoreOrders$segment), FUN=sum) 
colnames(segmentSales) <- c("Segment", "Total_sales")
head(segmentSales)
ggplot(segmentSales,aes(x=segmentSales$Segment, y=segmentSales$Total_sales)) + geom_bar(stat = "identity", color = "black", fill="blue") + 
  ggtitle("Total sales by segment") + scale_y_continuous(labels = comma)+xlab("Segments") + ylab("Total sales")

# Plotting sales by region
ggplot(SuperStoreOrders, aes(x = region,fill=region)) +
  geom_bar()+ggtitle("Orders Count as per region")+xlab("Region") + ylab("Count")+theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Plotting profit by first 15 sub_categories 
profit_by_subcategory <- aggregate(SuperStoreOrders$profit, by=list(SuperStoreOrders$sub_category), FUN=sum)
colnames(profit_by_subcategory) <- c("Sub_Category", "Total_Profit")
head(profit_by_subcategory)
top15subcat <- profit_by_subcategory %>% arrange(desc(Total_Profit)) %>% head(15)
head(top15subcat)
ggplot(top15subcat,aes(y=Total_Profit,x=Sub_Category))+  geom_bar(stat = "identity", color = "black", fill = "light pink")+  labs(x = "Sub-Category", y = "Profit") +
  ggtitle("Top 15 Profitable Sub-Categories")+theme(axis.text.x = element_text(angle = 45, hjust = 1))+scale_y_continuous(labels = comma)


# Plotting profit by market
profit_by_market <- aggregate(SuperStoreOrders$profit, by=list(SuperStoreOrders$market), FUN=sum)
colnames(profit_by_market) <- c("Market", "Total_Profit")
head(profit_by_market)
ggplot(profit_by_market,aes(y=Total_Profit,x=Market))+  geom_bar(stat = "identity", color = "black", fill ="light blue")+  labs(x = "Market", y = "Profit") +
  ggtitle("Profits of all the markets")+theme(axis.text.x = element_text(angle = 45, hjust = 1))+scale_y_continuous(labels = comma)


# Plotting shipping cat
ShippingCat <- SuperStoreOrders %>% group_by(ship_mode) %>% mutate(total_sales = sum(sales),percentage = sales/sum(sales)) %>% mutate(labels = scales::percent(percentage))
head(ShippingCat)
ggplot(ShippingCat, aes(x = "", y = total_sales, fill = ship_mode)) +
  geom_bar(width = 1, stat = "identity")+ coord_polar("y", start = 0) +
  labs(x = NULL, y = NULL, fill = "Sub-Category", title = "Shipping mode analysis") + theme_void()

# Correlation plot
# Creating correlation matrix between all variables
orders.cor <- cor(SuperStoreOrders[, unlist(lapply(SuperStoreOrders, is.numeric))])
orders.cor
corrplot(orders.cor)

# Scatterplot between highest correlation variable with sales
ggplot(SuperStoreOrders, aes(y=sales,x=shipping_cost)) + geom_point(shape=23) + scale_y_continuous(labels = comma) + geom_smooth(method="lm")

# Creating model
x = SuperStoreOrders[,c("shipping_cost", "discount","order_priority", "quantity", "sub_category")]
model <- lm(SuperStoreOrders$sales ~ ., data = x)
summary(model)
# Plotting the model
par( mfrow= c(2,2) )
plot(model, id.method="identify")

# Removing the outliers and creating the model
SuperStoreOrders_1 <- SuperStoreOrders[-c(36240, 29531, 1104, 31885),]
x_1 = SuperStoreOrders_1[,c("shipping_cost", "discount","order_priority", "quantity", "sub_category")]
model_1 <- lm(SuperStoreOrders_1$sales ~ ., data = x_1)
summary(model_1)
par( mfrow= c(2,2) )
plot(model_1, id.method="identify")

# Checking for multicollinearity
library(car)
vif(model_1)
# No multicollinearity 
sqrt(vif(model_1))  


## Is there any difference in mean sales for each category of product?
saleCatFilter <- SuperStoreOrders %>% dplyr::select(sales,sub_category)
# Plotting the graph for sales of each category of product
ggplot(saleCatFilter,aes(y=sales,x=sub_category))+  geom_bar(stat = "identity", fill = "lightpink")+  labs(x = "Sub-Category", y = "Sales") +
  ggtitle("Sales for each category of product")+theme(axis.text.x = element_text(angle = 45, hjust = 1))+scale_y_continuous(labels = comma)
# Creating ANOVA model to check the difference in mean sales for each product
saleSubCatModel <- aov(sales ~ sub_category, data = saleCatFilter)
summary(saleSubCatModel)

## Is there any difference in mean sales for each type of shipping method used?
filterforanova <- SuperStoreOrders %>% dplyr::select(sales,ship_mode)
shippingsaleModel <- aov(sales ~ ship_mode, data = filterforanova)
summary(shippingsaleModel)

# Plotting the graph for sales of each category of product
ggplot(saleCatFilter,aes(y=sales,x=sub_category))+  geom_bar(stat = "identity", fill = "lightpink")+  labs(x = "Sub-Category", y = "Sales") +
  ggtitle("Sales for each category of product")+theme(axis.text.x = element_text(angle = 45, hjust = 1))+scale_y_continuous(labels = comma)



## Is there a significant association between the region where a product is sold and the category of the product?
regcattable <- xtabs(sales~region+category, data=SuperStoreOrders)
chisq.test(regcattable)

## Is there a significant difference in the distribution of sales across different sub-categories between the different shipping modes?
subCatshipmodeTable <-  xtabs(sales~sub_category+ship_mode, data=SuperStoreOrders)
chisq.test(subCatshipmodeTable)




## Is there a significant difference in quantity bought between products that are sold at a discount versus those that are not ?
profitDiscountFilter <- SuperStoreOrders %>% dplyr::select(quantity,discount)
profitDiscountFilter$discount <- ifelse(profitDiscountFilter$discount >0 ,"Yes","No")
ggplot(profitDiscountFilter,aes(y=quantity,x=discount))+  geom_bar(stat = "identity", fill = "lightpink")+  labs(x = "Discount", y = "Quantity") +
  ggtitle("discount influence of the quantity of purchase")+theme(axis.text.x = element_text(angle = 45, hjust = 1))+scale_y_continuous(labels = comma)
prodisModel <- aov(quantity ~ discount, data = profitDiscountFilter)
summary(prodisModel)
TukeyHSD(prodisModel)


# Checking sales and profit for discounted orders
profitDiscountFilter <- SuperStoreOrders %>% dplyr::select(sales,profit,discount)

profitDiscountFilter$discount <- ifelse(profitDiscountFilter$discount >0 ,1,0)
 
ggplot(profitDiscountFilter, aes(x = sales, y = profit,color=discount)) +
  geom_point() +
  scale_color_gradient(low = "blue", high = "red") +
  labs(x = "Sales", y = "Profit") +
  ggtitle("Sales, Profit, and Discount")
