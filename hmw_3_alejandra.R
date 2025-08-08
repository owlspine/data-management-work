# Homework 3 --------------------------------------------------------------


# PART 1: Reshape your data -----------------------------------------------

# 1. Set working directory
setwd("/Users/ale/Desktop/BBUS301/Homework 3")

getwd() 

# 2. Load tidyverse package
library(tidyverse)

# 3. Import the grades_mess.csv file in R and create a data frame called grades_df
grades_df <- read_csv("grades_mess.csv")

# 4. Use the functions learned in Module 7 to re-shape this data frame...
# See the original labels
colnames(grades_df)

grades_clean <- grades_df %>%
  separate(grades, into = c("score", "letter"), sep = "/") %>%
  separate(test_info, into = c("type", "value"), sep = "_") %>%
  spread(key = type, value = value) %>%
  mutate(test_date = paste(month, day, year, sep = "-")) %>%
  select(student, score, letter, test_date, subject, instructor)

View(grades_clean)

# PART 2: Data Manipulation and Insights ----------------------------------

# 5. Import the Sold_Fleet_Equipment.csv data and create a data frame called eq_df.
eq_df <- read_csv("Sold_Fleet_Equipment.csv")

# 6. Rename the variable EquipID as equip_id. Save your changes (overwrite the data frame).
eq_df <- rename(eq_df, equip_id = EquipID)

# 7. Change the order of the variables. 
eq_df <- eq_df %>%
  select(equip_id, model_year, sale_year, everything())

# 8. How many pieces of equipment were sold for more than $10,000? 
eq_df %>%
  filter(sale_price > 10000) %>%
  summarise(n = n())
# 358 pieces of equipment were sold for more than $10,000

# 9. What are the top 3 most expensive pieces of equipment sold?
eq_df %>%
  slice_max(order_by = sale_price, n = 3) %>%
  select(make, model, sale_price)
# 1st one is "Make: Pete", "Model: 567", and "Sale_price: 330000",
# 2nd one is "Make: Pete", "Model: 567", and "Sale_price: 175100",
# 3rd one is "Make: Pete", "Model: 348", and "Sale_price: 132100".

# 10. Create a new variable called age_at_sale...
eq_df <- eq_df %>%
  mutate(age_at_sale = sale_year - model_year)

# 11. What are the top 3 departments (dept) with the highest total revenue from equipment sales?
eq_df %>%
  group_by(dept) %>%
  summarise(total_sales = sum(sale_price, na.rm = TRUE)) %>%
  slice_max(order_by = total_sales, n = 3)
# 1st one is "Dept: SPU", "Total_sales: 4269572"
# 2nd one is "Dept: DPR", "Total_sales: 3433036"
# 3rd one is "Dept: SDOT", "Total_sales: 2444511"

# 12. Which equipment type had the lowest average sale price?
eq_df %>%
  group_by(equipment_type) %>%
  summarise(avg_price = mean(sale_price, na.rm = TRUE)) %>%
  slice_min(order_by = avg_price, n = 1)
# "Equipment_type: Other", "Avg_price: 2113"

# 13. For each fuel type, how many pieces of equipment were sold for more than $15,000?
eq_df %>%
  filter(sale_price > 15000) %>%
  group_by(fuel_type) %>%
  summarise(count = n())
# 1st: "Fuel_type: DSL", "Count: 193"
# 2nd: "Fuel_type: NON", "Count: 5"
# 3rd: "Fuel_type: UNL", "Count: 32"