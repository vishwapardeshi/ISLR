#' ---
#' title: 'Fuel Efficiency Prediction: Linear Regression'
#' author: 'By Vishwa Pardeshi'
#' output:
#'   html_document: default
#'   pdf_document: default
#' ---
#' 
#' In this notebook, we will predict the fuel consumption rate of cars using the autompg dataset which is available on the popular UCI machine learning repository. To learn more about linear regression refer [here.](https://medium.com/@pardeshi.vishwa25/linear-regression-model-for-ml-cd18a392bd8b?source=friends_link&sk=7682368acebef7c531b02da7788892bf)  
#' 
#' **Learning Outcome:**
#' By following the notebook you will be able to 
#' 
#' 1. Perform context inspired EDA to understand relationship between predictor variables and mpg (fuel consumption variable)
#' 
#' 2. Implement & infer Simple Linear Regression
#' 
#' 3. Plot OLS regression line & diagnostic plot
#' 
#' 4. Implement & infer multiple linear regression model
#' 
#' 5. Integrate interaction effects in the model
#' 
#' 6. Implement non-linear transformation to the model
#' 
#' 
#' ## Setup
#' 
#' Here, we will load the libraries and packages.
#' 
## ----setup, message=FALSE------------------------------------------------

library(MASS)
library(ISLR)
library(tidyverse)
library(ggplot2)
library(corrplot)

knitr::purl()

#' 
#' The *Auto* dataset is present in the ISLR package and hence can be called directly
#' 
#' ## Exploratory Data Analysis
#' 
#' ### Glimpse of the data 
#' 
#' Let us first look at the head of the dataset.
#' 
## ----data head, echo=FALSE-----------------------------------------------
head(Auto)

## ----data shape----------------------------------------------------------
cat("The auto dataset shape is ", dim(Auto)[1], "x", dim(Auto)[2])

#' 
#' We notice tht there are 9 columns. Out of which a few look categorical such as model year and origin. Additionally, name is a string. Let's explore the summary of the data to undertand the data type of variables.
#' 
## ----data summary--------------------------------------------------------
summary(Auto)

#' From summary we notice that origin, and cylinder and year could be categorical variables as they seem to be whole numbers with a limited range. Looking at the data variable this is not evident as they are all numeric value.
#' 
## ----data type-----------------------------------------------------------
str(Auto)

#' **We notice that all the variables have the correct data type except name which can be converted to string.**
#' 
#' 
#' ### Number of unique values in each column
#' Let's check out the number of unique values in each column.
## ----find unique values / column-----------------------------------------

no_unique_values <- function(column){
  unique_values_list <- unique(column)
  return(length(unique_values_list))
}
apply(Auto ,2,no_unique_values)


#' Thus, We have established that:
#' * mpg: continuous
#' 
#' * cylinders: multi-valued discrete
#' 
#' * displacement: continuous
#' 
#' * horsepower: continuous
#' 
#' * weight: continuous
#' 
#' * acceleration: continuous
#' 
#' * model year: multi-valued discrete
#' 
#' * origin: multi-valued discrete
#' 
#' * car name: string (unique for each instance)
#' 
#' ### Number of missing values in the dataset
## ----missing values/column-----------------------------------------------

no_missing_values <- function(column){
  return(sum(is.na(column)))
}

cat("The number of missing values in each column\n\n\n")
apply(Auto ,2,no_missing_values)


#' 
#' ### Scatterplot Matrix
## ----scatterplot matrix--------------------------------------------------
plot(Auto)

#' 
#' Vieweing the scatterplot alongwith the summary makes our observation about the nature of the variable more clear. From the scatterplot we can also notice the relationship trend between our response variable mpg and the other potential predictor variable. 
#' 
#' **We notive that horsepower, weight, displacement have a clear relationship with mpg though not necessarily linear**
#' 
#' ## Correlation Matrix
#' 
## ----correlation matrix--------------------------------------------------
corr_matrix <- cor(Auto[, -which(names(Auto)=="name")])
corr_matrix

#' 
#' ### Heatmap of Correlation
## ----heatmap of correlation----------------------------------------------
corrplot(corr_matrix, type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)

#' 
#' We notice here that mpg has significant correlation with
#' 1. horsepower
#' 
#' 2. weight
#' 
#' 3. cylinders
#' 
#' 4. displacement
#' 
#' 5. year
#' 
#' ## Clean Data
#' 
#' ### Convert to categorical form i.e. factor
## ----correct datatype, output = F----------------------------------------
discrete_col <- c("origin", 'year', 'cylinders')
Auto[, discrete_col] <- lapply(Auto[, discrete_col], factor)
str(Auto[, discrete_col])

#' Now, we can visualize the relationship between the response and other variables
#' 
#' 
#' ### Explore relationship of mpg with discrete variable
#' 
## ----explore mpg discrete------------------------------------------------
attach(Auto)
par(mfrow=c(1,3))
ggplot(data = Auto, mapping = aes(x = origin, y = mpg)) +
         geom_boxplot()
ggplot(data = Auto, mapping = aes(x = cylinders, y = mpg)) +
         geom_boxplot()
ggplot(data = Auto, mapping = aes(x = year, y = mpg)) +
         geom_boxplot()

#' 
#' 
#' ## Simple Linear Regression
#' 
#' For building our simple linear regression model, using our findings from scatterplot and correlation matrix, we are using the following variables.
#' 
#' **Predictor Variable** : horsepower
#' **Response Variable** : mpg
#' 
## ----simple lm-----------------------------------------------------------
simple.lm <- lm(mpg ~ horsepower)
summary(simple.lm)

#' ### Inference from Simple Linear Regression model : mpg ~ horsepower
#' 1. From the p-value associated with the F-statistic, we know that there is a strong association between horsepower & mpg.
#' 
#' 2. As the coefficient estimate is negative, the relationship between mpg and horsepower is negative.
#' 
#' 3. The fit can be observed below which shows a curved pattern which is missed by the straight line assumption of linear model
#' 
## ----plot slm------------------------------------------------------------
plot(horsepower, mpg)
abline(simple.lm, col = 'blue')

#' 
#' This non-linear relationship is highlighted in the residual vs fitted diagnostic plot.
#' 
## ----diagnostic plot-----------------------------------------------------
diagnostic_plot <- function(model){
  par(mfrow=c(2,2))
  plot(model)
}
diagnostic_plot(simple.lm)


#' 
#' 
## ------------------------------------------------------------------------
new_data <- data.frame(horsepower = 98)

cat("The predicted mpg for 98 horsepower is ", predict(simple.lm, new_data))

#predict the confidence and prediction interval
conf_interval <- predict(simple.lm, new_data, interval = "confidence")
cat("\n\nThe confidence interval is [", conf_interval[, 2],",",  conf_interval[, 3], "]")

pred_interval <- predict(simple.lm, new_data, interval = "prediction")
cat("\n\nThe prediction interval is [", pred_interval[, 2],",",  pred_interval[, 3], "]")


#' 
#' ## Multiple Linear Regression
#' 
#' For building our simple linear regression model, using our findings from scatterplot and correlation matrix, we are using all the predictor vairables expect name.
#' 
## ----multiple lm---------------------------------------------------------
multiple.lm <- lm(mpg ~ . -name, data = Auto)
summary(multiple.lm)

#' ### Inference from Multiple Linear Regression model : mpg ~ . - name
#' 1. From the p-value associated with the F-statistic, we know that there is a relationship between mpg and the predictor variables.
#' 
#' 2. Of all the predictors, displacement, weight, year and origin have statistically significant relationship to the response.
#' 
#' 3. The coefficient of the year 0.75 suggest that later model have better mpg
#' as shown in the figure below
#' 
## ----inference-----------------------------------------------------------
ggplot(data = Auto, mapping = aes(x = year, y = mpg)) +
         geom_boxplot()

#' 
#' 4. The residual vs fitted plot show evidence of non-linearity. There is a funnel shape hinting at heteroscedasticity.
#' 
#' 5. Additionally, high leverage is noticed for point 14.
#' 
## ----diagnostic plots----------------------------------------------------
diagnostic_plot(multiple.lm)

## ----vif-----------------------------------------------------------------
library(rms)
rms::vif(multiple.lm)

#' 
#' 
#' 
#' 
#' 6. Multi collinearity: When VIF values lies in 5 - 10 range, a problematic amount of collinearity is presented. This was evident from the correlation plot too.  The problem of collinearity is that it reduces the accuracy of the estimates of the regression coefficients and it causes the standard error to increase.
#' 
#' 
#' ## Interaction Term
## ----interaction terms---------------------------------------------------
inter.lm1 <- lm(mpg~displacement+origin+year*weight, data=Auto)
inter.lm2 <- lm(mpg~year+origin+displacement*weight, data=Auto)
summary(inter.lm1)
summary(inter.lm2)

#' 
#' displacement & weight have statistically significant interaction. 
#' 
#' ## Non-linear transformations
#' 
#' Here we are exploring various non-linear transformations such as log, polynomial.
## ----non linear transformations------------------------------------------
nonlinear.lm1 <- lm(mpg~displacement+I(log(weight))+year+origin, data=Auto)
nonlinear.lm2 <- lm(mpg~poly(displacement,3)+weight+year+origin, data=Auto)
nonlinear.lm3 <- lm(mpg~displacement+I(weight^2)+year+origin, data=Auto)
summary(nonlinear.lm1)
summary(nonlinear.lm2)
summary(nonlinear.lm3)

#' 
#' From noticing the p-value associated with the different variables which have been transformed, we know that 
#' 
#' 1. displacement has a lower p-value for square as compared to cubic
#' 
#' 2. weight^2 is statistically significant.
