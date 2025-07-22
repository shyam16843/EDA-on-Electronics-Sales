# EDA-on-Electronics-Sales
Exploratory Data Analysis on Electronics sales

Project Overview
This project involves an in-depth Exploratory Data Analysis (EDA) of electronics sales data. The primary objective is to uncover significant trends, patterns, and insights that can inform business strategies, optimize sales performance, and identify areas for potential improvement within the electronics sales domain.

Files Included
This repository contains the following key resources related to this EDA project:

edaexcel.xlsx - EDA.csv: The raw sales dataset in Excel (CSV format) used as the foundation for this analysis.

edarcode.R: The R code used to perform the entire EDA process, including data cleaning, transformation, statistical analysis, and data visualization.

Key Questions Explored
This EDA was conducted to answer a range of business-centric questions, such as:

What are the overall sales trends observed over the analyzed period (e.g., monthly, quarterly)?

Which product types or categories are exhibiting the best and worst sales performance?

What are the top-selling individual products (SKUs)?

How do customer demographics (age, gender, loyalty membership) correlate with sales patterns?

What is the impact of different order statuses (completed vs. canceled) and payment methods on overall transactions?

Are there any significant correlations between product ratings, unit price, quantity, and total price?

Methodology
The Exploratory Data Analysis process followed these systematic steps:

Data Loading and Initial Inspection: The sales dataset was loaded, and its basic structure, data types, and initial summary statistics were reviewed.

Data Cleaning and Preprocessing: This involved handling missing values, addressing inconsistencies, and transforming variables (e.g., creating age groups from raw age data) to prepare the data for analysis.

Descriptive Statistics: Calculation of measures like mean, median, mode, and standard deviation to understand the central tendencies and spread of key numerical variables.

Univariate Analysis: Examination of individual variables through frequency distributions, histograms, and bar plots to understand their characteristics.

Bivariate and Multivariate Analysis: Investigating relationships between two or more variables, such as sales trends over time, total price by product rating, and correlations between numerical features.

Data Visualization: Creation of various charts and plots (e.g., bar plots for age groups, line plots for monthly sales, boxplots for price vs. rating, heatmaps for correlations) to visually represent insights and patterns.

Insight Generation: Drawing actionable conclusions and observations from the analyzed data and visualizations to inform strategic decisions.

Technologies Used
R: The primary programming language utilized for data manipulation, statistical analysis, and visualization.

ggplot2: An R package for creating elegant and effective data visualizations.

reshape2: An R package used for reshaping data, particularly for preparing correlation matrices for heatmaps.

readxl: An R package for reading Excel files.

How to Explore This Project

To get a complete understanding of this project and explore the analysis yourself:

Clone the repository:

Bash

git clone https://github.com/shyam16843/EDA-on-Electronics-Sales.git

cd EDA-on-Electronics-Sales

Install R and the necessary packages:
Ensure you have R installed. Then, open an R environment (like RStudio) and install the required packages:

R

install.packages(c("readxl", "ggplot2", "reshape2"))
Run the R code:
Open the edarcode.R file in RStudio or a similar R environment and execute the script. Make sure the edaexcel.xlsx - EDA.csv file is in the same directory or update the file path in the R script if needed.

Insights and Findings
Through this EDA, several key insights were uncovered, including:

Identification of significant sales peaks and troughs across different months, suggesting seasonal patterns or impact of specific events.

A clear understanding of the performance of various product types, highlighting which categories contribute most to revenue.

Analysis of customer demographics revealing insights into the primary age groups and gender distributions among buyers.

Observations on the relationship between product ratings and total price, and the influence of different payment methods on order completion rates.

For a detailed breakdown of all findings, please refer to the EDA Project .pdf report link and the EDA project .pptx presentation link.

EDA Project pdf -> https://drive.google.com/file/d/1lTyGMuw7KHLnVn-BDukMw4kROXvpuDTD/view?usp=sharing

EDA Project ppt -> https://docs.google.com/presentation/d/1hVretST-PIBlkxOgqLTN697TMCVnn2IO/edit?usp=sharing&ouid=116007538419023173984&rtpof=true&sd=true

Future Work
Future enhancements for this project could include:

Predictive Modeling: Developing models to forecast future sales based on historical data and identified trends.

Customer Segmentation: Applying advanced clustering techniques to identify more granular customer segments for targeted marketing.

Integration of External Data: Incorporating external factors such as marketing campaign data, economic indicators, or competitor sales data for a more holistic analysis.

Interactive Dashboard: Creating an interactive dashboard (e.g., using Shiny in R) to allow users to explore the data and insights dynamically.
