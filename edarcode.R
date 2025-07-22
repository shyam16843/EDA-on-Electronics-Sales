# Set path to your working folder
setwd("D:\\git")

# Confirm path
getwd()
#Importing data
#install.packages("readxl") cause already installed
library(readxl)
data<-read_excel(file.choose(),sheet = "EDA")


# View basic structure and summary
View(data)
str(data)
summary(data)
head(data)

# Check the column names
colnames(data)






# Create age groups
data$AgeGroup <- cut(data$Age, 
                     breaks = c(15, 25, 35, 45, 55, 65, 75, 85), 
                     labels = c("18-24", "25-34", "35-44", "45-54", "55-64", "65-74","75-80"), 
                     right = F)
# Count distinct Customer IDs by Age Group using base R
age_group_count <- aggregate(`Customer ID` ~ AgeGroup, data = data, FUN = function(x) length(unique(x)))
# Create a bar plot
bar_heights <- barplot(age_group_count$`Customer ID`, 
                       names.arg = age_group_count$AgeGroup, 
                       ylim = c(0,2500),
                       main = "Customer Count by Age Group", 
                       xlab = "Age Group", 
                       ylab = "Number of Customers", 
                       col = "lightblue", 
                       las = 1)  # Rotate x-axis labels by las = 2
# Add counts on top of the bars
text(bar_heights, age_group_count$`Customer ID`, 
     labels = age_group_count$`Customer ID`, 
     pos = 3,   # Position above the bars
     cex = 0.8) # Text size









# Create the table of Age Group and Product Type
age_product_table <- table(data$`Product Type`, data$AgeGroup)
# Set the colors for each product type
product_colors <- c("red", "green", "blue", "cyan", "purple")
# Barplot for age distribution by product type
bar_positions<-barplot(age_product_table, 
                       beside = TRUE, ylim = c(0,1100),
                       col = product_colors, 
                       main = "Age Distribution by Product Type", 
                       xlab = "Age Group", 
                       ylab = "Count", 
                       legend.text = rownames(age_product_table),
                       args.legend = list(x = "topright", cex = 0.5))
# Add data labels on top of each bar
text(x = bar_positions, 
     y = age_product_table, 
     label = age_product_table, 
     pos = 3, # Position above the bar
     cex = 0.6, # Font size
     col = "black") # Label color









#install.packages("ggplot2") installed already
library(ggplot2)
install.packages("dplyr")
library(dplyr)
# Group by Gender and count unique Customer IDs
customer_count_by_gender <- summarise(group_by(data, Gender),CustomerCount = n_distinct(`Customer ID`))
# View the result
print(customer_count_by_gender)
# Prepare the data for the pie chart
gender_labels <- customer_count_by_gender$Gender
customer_counts <- customer_count_by_gender$CustomerCount
# Add percentage labels for each gender
percentage_labels <- paste0(gender_labels, ": ", round(customer_counts / sum(customer_counts) * 100, 1), "%")
# Create a 2D pie chart
pie(customer_counts, 
    labels = percentage_labels, 
    main = "Customer Count by Gender", 
    col = c("lightblue", "lightpink"))  # Color for each gender









# Create a contingency table of Customer Counts by Age Group and Gender
count_table <- table(data$AgeGroup, data$Gender)
# Create a clustered column chart
barplot(count_table, ylim = c(0,2000),
        main = "Customer Count by Age Group and Gender", 
        xlab = "Gender", 
        ylab = "Number of Customers", 
        col = rainbow(7), # Colors for different genders
        beside = TRUE,                     # Clustered bars
        legend.text = TRUE,                # Show legend
        args.legend = list(x = "topright",cex = 0.6,bty = "n")) # Position of legend










# Boxplot comparing total price between male and female customers
boxplot(data$`Total Price` ~ data$Gender,
        main = "Total Price Distribution by Gender", 
        xlab = "Gender", 
        ylab = "Total Price", 
        col = c("lightblue", "pink"))









# Histogram of Total Price
hist(data$`Total Price`, ylim = c(0,6000),
     breaks = 10, 
     main = "Total Price Distribution", 
     xlab = "Total Price", 
     col = "skyblue", 
     border = "white")
# Add counts above each bar
hist_data <- hist(data$`Total Price`, 
                  breaks = 10, 
                  plot = FALSE)  # Compute the histogram without plotting to get counts
# Add text to the bars showing the count
text(hist_data$mids, 
     hist_data$counts, 
     labels = hist_data$counts, 
     pos = 3, 
     cex = 0.8, 
     col = "black")












# Convert Purchase Date to Date type
data$Purchase.Date <- as.Date(data$`Purchase Date`, format = "%d-%m-%Y")  # Adjust format if needed
# Aggregate total price by date
sales_trend <- aggregate(`Total Price` ~ `Purchase Date`, data, sum)
# Plot sales trends over time
plot(sales_trend$`Purchase Date`, sales_trend$`Total Price`, type = "b",  # 'b' for both points and lines
     main = "Sales Trend Over Time", 
     xlab = "Purchase Date", 
     ylab = "Total Sales", 
     col = "blue", lwd = 2)









# Calculate total sales, average rating, and total quantity by Product Type
product_performance <- aggregate(cbind(`Total Price`, Rating, Quantity) ~ `Product Type`, 
                                 data = data, 
                                 FUN = function(x) c(Total = sum(x), Average = mean(x)))
# Convert the matrix into a data frame for easier handling
product_performance_df <- do.call(data.frame, product_performance)
# Print the product performance summary
print(product_performance_df)
# Bar plot for Total Sales by Product Type
barplot(product_performance_df$Total.Price.Total, 
        names.arg = product_performance_df$Product.Type, 
        main = "Total Sales by Product Type", 
        xlab = "Product Type", 
        ylab = "Total Sales", 
        col = "lightblue", 
        las = 1, # Rotate x-axis labels
        ylim = c(0, max(product_performance_df$Total.Price.Total) + 1000)) # Adjust y-limit
# Bar plot for Average Rating by Product Type
barplot(product_performance_df$Rating.Average, 
        names.arg = product_performance_df$Product.Type, 
        main = "Average Rating by Product Type", 
        xlab = "Product Type", 
        ylab = "Average Rating", 
        col = "lightgreen", 
        las = 1, 
        ylim = c(0, max(product_performance_df$Rating.Average) + 1)) # Adjust y-limit
# Bar plot for Total Quantity Sold by Product Type
barplot(product_performance_df$Quantity.Total, 
        names.arg = product_performance_df$Product.Type, 
        main = "Total Quantity Sold by Product Type", 
        xlab = "Product Type", 
        ylab = "Total Quantity", 
        col = "lightcoral", 
        las = 1, 
        ylim = c(0, max(product_performance_df$Quantity.Total) + 5000)) # Adjust y-limit











# Scatter plot of Quantity vs. Add-on Total
plot(data$Quantity, data$`Add-on Total`, 
     main = "Relationship Between Quantity Purchased and Add-on Total", 
     xlab = "Quantity Purchased", 
     ylab = "Total Add-on Price", 
     col = "blue", 
     pch = 19, # Point shape
     cex = 0.5) # Size of points
# Add a regression line to see the trend
abline(lm(`Add-on Total` ~ Quantity, data = data), col = "red") # Linear regression line












# Proportion of completed vs canceled orders
order_status <- table(data$`Order Status`)
# Create a pie chart for order status
percentages <- round(100 * order_status / sum(order_status), 1)  # Calculate percentages
labels <- paste(names(order_status), "\n", percentages, "%", sep = "")  # Create labels
pie(order_status, 
    main = "Order Status Distribution", 
    col = c("lightblue", "lightcoral"), 
    labels = labels,  # Use the custom labels
    border = "white")  # Optional: Add a border to the segments










# Load RColorBrewer for better color palettes (if not already loaded)
# install.packages("RColorBrewer") # Uncomment this line if you haven't installed it yet
library(RColorBrewer)
# Contingency table of Payment Methods and Order Status
payment_order_table <- table(data$`Payment Method`, data$`Order Status`)
# Stacked barplot of payment methods across order statuses
bar_positions <- barplot(payment_order_table, 
                         beside = FALSE, 
                         col = brewer.pal(nrow(payment_order_table), "Set3"),  # Use a color palette from RColorBrewer
                         main = "Payment Methods by Order Status", 
                         xlab = "Order Status", 
                         ylab = "Count", 
                         legend.text = rownames(payment_order_table),
                         args.legend = list(x = "topleft", cex = 0.6))









# Scatter plot of unit price vs total price
plot(data$`Unit Price`, data$`Total Price`, 
     main = "Unit Price vs. Total Price", 
     xlab = "Unit Price", 
     ylab = "Total Price", 
     col = "darkgreen", 
     pch = 16, 
     cex = 0.8)  # Adjust point size
# Add a regression line
abline(lm(`Total Price` ~ `Unit Price`, data = data), col = "red", lwd = 2)  # Linear regression line
# Add a grid
grid()










# Histogram of quantity distribution
hist(data$Quantity, 
     breaks = 10, 
     main = "Quantity Distribution", 
     xlab = "Quantity", 
     col = "lightblue", 
     border = "white", 
     freq = FALSE)  # Set freq to FALSE for density
# Add a density curve
lines(density(data$Quantity), col = "red", lwd = 2)
# Add mean and median lines
abline(v = mean(data$Quantity), col = "green", lwd = 2, lty = 2)  # Mean line
abline(v = median(data$Quantity), col = "blue", lwd = 2, lty = 2)  # Median line
# Add legend
legend("topright", legend = c("Density Curve", "Mean", "Median"), 
       col = c("red", "green", "blue"), lty = c(1, 2, 2), lwd = 2)









# Barplot for shipping type distribution
shipping_type <- table(data$`Shipping Type`)
# Order the shipping types by count
shipping_type <- shipping_type[order(shipping_type, decreasing = TRUE)]
# Barplot for shipping type distribution
bar_positions <- barplot(shipping_type, ylim = c(0,7500),
                         main = "Shipping Type Distribution", 
                         xlab = "Shipping Type", 
                         ylab = "Count", 
                         col = rainbow(length(shipping_type)),  # Use a rainbow palette for better distinction
                         las = 1)  # Rotate x-axis labels for better readability
# Add data labels on top of the bars
text(x = bar_positions, 
     y = shipping_type, 
     labels = shipping_type, 
     pos = 3, 
     cex = 0.8, 
     col = "black")  # Adjust label color as needed









# Histogram for product ratings
hist(data$Rating, 
     breaks = 5, ylim = c(0,1.1),
     main = "Product Ratings Distribution", 
     xlab = "Rating", 
     col = "lightblue", 
     border = "white", 
     freq = FALSE)  # Use density instead of frequency
# Add a density curve
lines(density(data$Rating, na.rm = TRUE), col = "red", lwd = 2)
# Add mean and median lines
abline(v = mean(data$Rating, na.rm = TRUE), col = "green", lwd = 2, lty = 2)  # Mean line
abline(v = median(data$Rating, na.rm = TRUE), col = "blue", lwd = 2, lty = 2)  # Median line
# Add legend
legend("topright", legend = c("Density Curve", "Mean", "Median"), 
       col = c("red", "green", "blue"), lty = c(1, 2, 2), lwd = 2)







# Boxplot comparing ratings and total price
boxplot(data$`Total Price` ~ data$Rating, 
        main = "Total Price by Product Rating", 
        xlab = "Product Rating", 
        ylab = "Total Price", 
        col = rainbow(length(unique(data$Rating))),  # Adjust color count based on unique ratings
        notch = TRUE,  # Add notches to the boxplot
        outline = TRUE)  # Show outliers
# Add means to the boxplot
points(x = 1:length(unique(data$Rating)), 
       y = tapply(data$`Total Price`, data$Rating, mean), 
       col = "black", pch = 18, cex = 1.5)  # Mean points














# Load necessary libraries
library(ggplot2)
library(reshape2)
# Select relevant numerical columns for correlation
num_data <- data[, c("Age", "Total Price", "Unit Price", "Quantity", "Rating", "Add-on Total")]
# Compute correlation matrix
cor_matrix <- cor(num_data, use = "complete.obs")
# Melt the correlation matrix for ggplot
melted_cor <- melt(cor_matrix)
# Plot heatmap
ggplot(data = melted_cor, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0, 
                       limit = c(-1, 1), space = "Lab", name="Correlation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  ggtitle("Heatmap of Correlation Matrix")







