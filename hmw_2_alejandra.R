
# Homework 2 --------------------------------------------------------------


# PART 1: Organizing your work --------------------------------------------

# 3. Set working directory to where listings.csv is located
setwd("/Users/ale/Desktop/BBUS301/Homework 2")

getwd() 

# 4.  Import the Seattle_wages.csv file from your downloaded folder.
wages_df <- read.csv("Seattle_wages.csv", stringsAsFactors = FALSE)

# 5. Rename "Hourly Rate" column to "hourly_rate"
names(wages_df)[names(wages_df) == "HourlyRate"] <- "hourly_rate"

# 6A. Create a count / frequency table for this variable.
table(wages_df$department)

# 6B. When recording these values a typo has been made...
table(wages_df$department)
# Line 5 and line 24 show "Seattle Center" and "Seattle Centers"

#6C.  Combine them: choose one value and replace the other one(s) with the 
# value you chose.
wages_df$department[wages_df$department == "Seattle Centers"] <- "Seattle Center"
# Check 
table(wages_df$department)
# There are now 41 lines and only 1 "Seattle Center"

# 7. Seattle City Light department employees making an hourly wage higher than 150?
subset(wages_df, department == "Seattle City Light" & hourly_rate > 150)
# Micheal Haynes, Dawn Lindell, Andrew Strong, Ronald Smith, 
# DaVonna Johnson, Kirsty Grainger, and Mujib Lodhi

# 8. How many missing values are present per column? 
sum(is.na(wages_df$hourly_rate))
# 17

# 9. Look at your numerical variable...
#  ...impute missing values as the value of the mean
mean_hourly <- mean(wages_df$hourly_rate, na.rm = TRUE)

wages_df$hourly_rate[is.na(wages_df$hourly_rate)] <- mean_hourly
# I decided to go with inputting the missing values as the value of the mean 
# and I chose this because I felt it may be the cleanliest route and avoids all the 0's

# PART 2: Statistical Graphs – use Base R, not ggplot2 --------------------

# 10. Create a boxplot for the hourly rate variable.
boxplot(wages_df$hourly_rate,
        main = "Boxplot of Hourly Rate",
        ylab = "Hourly Rate",
        col = "lightblue",
        horizontal = FALSE)
# Insight 1: Most employees seem to have an hourly rate clustered around the median.
# Insight 2: There seem to be relatively fewer outliers. Although the ones that exist,
# show that there are people who make higher wages than those clustered around the median.

# 11. Increase the plot margins to accommodate longer labels on the x-axis 
# for the next two plots
par(mar = c(7, 4, 4, 2))

# 12.  Create a boxplot for the hourly wage by department.
# Create vertical boxplot of hourly_rate by department
boxplot(hourly_rate ~ department,
        data = wages_df,
        las = 2,  # Rotates x-axis labels perpendicular
        main = "Hourly Wages by Department",
        ylab = "Hourly Rate",
        col = "lightgreen",
        horizonal = FALSE)
# Insight 1: There seems to be a wide spread throughout the boxplot,
# showcasing a lot of outliers, meaning people in different departments have
# a ranging salary.
# Insight 2: The boxplot is very busy due to the large number of departments.

# 13. Create a bar chart of the departments.
barplot(table(wages_df$department),
        las = 2,  # Rotates x-axis labels
        col = "skyblue",
        main = "Number of Employees by Department",
        ylab = "Count of Employees")
# Insight 1: We can see that some departments have a high number of employees maybe 
# suggesting this position is well needed in abundance for the operations of the city
# Insight 2: The smaller bars suggest that these positions are more specialized or 
# have smaller responsibility hence why the department doesn't need so many people in it
