# Homework 4 --------------------------------------------------------------

# PART 1: Joining Data ----------------------------------------------------

# Pre-Homework:
setwd("/Users/ale/Desktop/BBUS301/Homework 4")

getwd() 

# 1. Load the tidyverse package and the lubridate package in your library.
library(tidyverse)
library(lubridate) 

# 2. # Load the CSV files into data frames; addresses and features:
addresses <- read_csv("Seattle_Park_Addresses.csv")
features <- read_csv("Seattle_Park_Features.csv")

# 3. Use the pipe operator to:
# (a). inner_join the addresses data with the features data
parks_df <- addresses %>%
  inner_join(features, by = "PMAID")

# (b). save the newly joined data frame as parks_df

# PART 2: Special Data ----------------------------------------------------

# 4. How many parks contain the feature “Play Area”?...
play_area_count <- parks_df %>%
  filter(str_detect(feature_desc, "Play Area")) %>%
  nrow()

total_parks <- nrow(parks_df)

# Calculate percent of parks with Play Area
play_area_pct <- (play_area_count / total_parks) * 100

play_area_count
# The Play Area count is 138
play_area_pct
# Whereas the Play Area percentage is about 52% (51.56539)

# 5. Which parks offer both “Swimming Beaches” and “Grills”?
swim_grill_parks <- parks_df %>%
  filter(
    str_detect(feature_desc, "Swimming Beaches") &
      str_detect(feature_desc, "Grills")
  )

swim_grill_parks %>% select(name, feature_desc)
# The park(s) offering "Swimming Beaches" and "Grills" is just Madrona Park.

# 6. Which park mentions the word “courts” the most times in feature_desc?...
parks_df <- parks_df %>%
  mutate(
    feature_desc_lower = str_to_lower(feature_desc),
    courts_count = str_count(feature_desc_lower, "courts")
  )

parks_df %>%
  arrange(desc(courts_count)) %>%
  select(name, courts_count) %>%
  slice(1)
# The park(s) that mention the word "courts" the most times is Brighton Playfield 
# and it is mentioned 3 times.

# 7. Use the pipe operator to change the variable type of variable zip from numeric to factor. 
parks_df <- parks_df %>%
  mutate(
    zip = as.factor(zip),  
    area = fct_collapse(zip,
                        North = c("98103", "98105", "98107", "98115", "98117", "98125", "98133", "98177"),
                        South = c("98118", "98178", "98108"),
                        West = c("98106", "98126", "98116", "98136", "98146"),
                        Eastside = c("98102", "98122", "98112", "98144"),
                        Downtown = c("98101", "98121", "98104", "98109", "98119", "98199")
    )
  )

# 8. Draw a bar plot showing the number of parks in each area. 
ggplot(parks_df, aes(x = area)) +
  geom_bar() +
  labs(
    title = "Number of Parks in Each Area of Seattle",
    x = "Area",
    y = "Number of Parks"
  )
# Insight 1: Based off the bar graph I can infer that thhe Northern area of Seattle has the most 
# parks. Which it looks like it's about 75. 
# Insight 2: Whereas the Southern area of Seattle has the least amount of parks which looks to
# be about 50 parks.

# 9. Which area has the most feature-rich parks on average? Why might this be the case?
avg_features <- parks_df %>%
  mutate(n_features = str_count(feature_desc, ",") + 1) %>%
  group_by(area) %>%
  summarise(avg_n_features = mean(n_features, na.rm = TRUE)) %>%
  slice_max(avg_n_features, n = 1)

avg_features
# It shows that the Southern area of Seattle has the most feature rich parks, averaging 5 features.
# This might be the case due to the possibility of lower income in this area code meaning more
# targeted investments being used for these parks. 

# 10. Parse the date variable into a date format using the mutate()...
parks_df <- parks_df %>%
  mutate(parsed_date = dmy(date))  

# 11. Create two new variables: year which extracts the opening year from the date variable,...
parks_df <- parks_df %>%
  mutate(
    year = year(parsed_date),   
    age = 2025 - year
  )

# 12. What is the oldest park in our data (based on the age variable)? 
parks_df %>%
  arrange(desc(age)) %>%
  select(name, age, year, parsed_date) %>%
  slice(1)
# The oldest park is Denny Park with it being 142 years old and it was opened in 1883.
