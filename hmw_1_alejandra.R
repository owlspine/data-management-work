
# Homework 1 --------------------------------------------------------------

# PART 1: Introduction to R programming -----------------------------------

# 3. Set working directory to where listings.csv is located
setwd("/Users/ale/Desktop/BBUS301/Homework 1")

getwd()

# 4. Create three new variables: x, y and z

x <- 4200
y <- 24
z <- 6

# 5. Determine the value:

# Calculate x^2 + y*z
result1 <- x^2 + y * z
result1

# Calculate x + y + z
result2 <- x + y + z
result2

# result1 should be: 4200^2 + 24*6
# result2 should be: 4200 + 24 + 6

# PART 2: Data Structures, variables and data types -----------------------

# 6A. Create a variable
expected_bookings <- 154

#6B. Create a variable
rate <- 120

#6C. How much money do you project to make?
projected_income <- expected_bookings * rate
projected_income

#6D. Use R to check if projected_income is greater than 18000. 
projected_income > 18000
# I got 18,480 which is over 18,000 and the logical operator used is >

#7A. Create monthly bookings vector (Jan to Dec)
monthly_bookings <- c(5, 8, 12, 10, 7, 0, 0, 0, 0, 0, 0, 0)
monthly_bookings

#7B. What did you find?
typeof(monthly_bookings)
# It returned as "double"

#7C. Coerce the monthly_bookings vector into an integer vector. 
monthly_bookings <- as.integer(monthly_bookings)
as.integer(monthly_bookings)

#7D. Calculate monthly income
monthly_income <- monthly_bookings * 120
monthly_income

#7E. Check which months made more than $1000. In which months is the answer TRUE?
monthly_income > 1000
# Returns TRUE for March and April

#8. The first column will be the monthly_income vector.
# The second column should be called month, and needs to include the names of all 12 months.
month <- c("January", "February", "March", "April", "May", 
           "June", "July", "August", "September", 
           "October", "November", "December")
airbnb_df <- data.frame(monthly_income, month)
data.frame(monthly_income, month)

#9. Use the str function to examine your data frame (airbnb_df). 
# How many observations and how many variables you have in the data frame?
str(airbnb_df)
# Output shows 12 observations and 2 variables

# PART 3: Descriptive statistics in R -------------------------------------

#10. Import the listings.csv file
airbnb_listings <- read.csv("listings.csv")
read.csv("listings.csv")

#11A. Mean. What is the value?
mean(airbnb_listings$price, na.rm = TRUE)
# The value is 148.5397

#11B. Variance. What is the value?
var(airbnb_listings$price, na.rm = TRUE)
# The value is 13762.05

#12. What is the price value such that 75% of the prices lie below this value?
quantile(airbnb_listings$price, 0.75, na.rm = TRUE)
# The price value is 174

#13. Describe the room_type variable
# Check structure first
str(airbnb_listings$room_type)

# room_type is a categorical variable 
# Use frequency count; table function
table(airbnb_listings$room_type)

# I found that the most common room type is Entire home/apt

#14. Create a multidimensional table
# Create table
table3 <- table(airbnb_listings$neighborhood,
                airbnb_listings$room_type,
                airbnb_listings$license)

# Use ftable function
ftable(table3)

# In Alki it looks like there is only 1 private room.

#15. Analyze the relationship/ correlation between the price and the number of reviews.
cor(airbnb_listings$number_of_reviews, airbnb_listings$price)

# A correlation near 0 suggests a weak relationship, 
# while closer to plus or minus 1 indicates a stronger association,
# and the number that came after the correlation is -0.1164582 placing it near 0 
# indicating a weak relationship.
# Also, as the number of reviews increases, price tends to slightly decrease, 
# but the relationship seems to be minimal.
# Therefore, there is no strong association between the two variables.


