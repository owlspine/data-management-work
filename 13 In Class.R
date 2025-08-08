library(tidyverse)

# If Else Statement
pieces <- 7

if (pieces < 5) {
  print("Below Average")
} else if (pieces == 5) {
  print ("Average")
} else {
  print("Above Average")
}
  
# Vector
pieces <- c(7,5,4,6,3,5)
blood_sugar <- vector(mode = "character",length = length(pieces))

for (i in 1:6) {
  if (pieces[i] < 5) {
    result <- "Below Average"
  } else if (pieces[i] == 5) {
    result <- "Average"
  } else {
  result <- "Above Average"
  }
  blood_sugar[i] <- result
}

# Data Frame
names <- c("Hamant", "Connor", "Jack", "I-En", "Jayrylle", "Jena")
pieces <- c(7,5,4,6,3,5)

candy <- data.frame(names,pieces)

candy <- candy %>%
   mutate(blood_sugar = NA)
 
 for(i in 1:nrow(candy)){
   if(candy[i, 2] < 5) {
     result <- "Below Average"
   } else if (candy[i, 2] == 5) {
     result <- "Average"
   } else {
     result <- "Above Average"
   } 
   candy [i, 3] <- result
 }

# Case_when
candy %>%
  mutate(
    blood_sugar = case_when(
      pieces < 5 ~ "Below Average",
      pieces == 5 ~ "Average",
      .default = "Above Average"
    )
  )

# Diamonds_df  
diamonds_df <- diamonds

for(i in 1:nrow(diamonds_df)){
  if (diamonds_df$cut[i] == "Fair"){
    result <- "Low"
  } else if (diamonds_df$cut[i] %in% c("Good", "Very Good")){
  result <- "Medium"
  } else {
  result <- "Excellent"
  }
  diamonds_df$cut_catergory[i] = result
}

# In Class Exercise (focus on month only)
# PART 1
airquality

air_df <- airquality

for(i in 1:nrow(air_df)){
  if(air_df$Month[i] %in% c(3,4,5)){
    result = "Spring"
  } else if(air_df$Month[i] %in% c(6,7,8)){
    result = "Summer"
  } else if(air_df$Month[i] %in% c(9,10,11)){
  }else {
    result = "Winter"
  }
  air_df$Season[i] = result
}

# PART 2
air_df %>%
  mutate(
    Season = case_when(
      Month %in% c(3,4,5) ~ "Spring",
      Month %in% c(6,7,8) ~ "Summer",
      Month %in% c(9,10,11) ~ "Fall",
      .default = "Winter"
    )
  )
