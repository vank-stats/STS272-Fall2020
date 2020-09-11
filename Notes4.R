# Notes 4 Code

# Section 4 - The pipe operator (%>%)

# Load the tidyverse library (assuming you've installed it before)
library(tidyverse)

# Example where we don't use %>%

# Subset the mtcars dataset to only include cars with automatic transmission
auto <- filter(mtcars, am == 0)
# Then group these cars by the number of cylinders
auto_grouped <- group_by(auto, cyl)
# Then calculate the mean mpg for each number of cylinders
auto_avg_by_cyl <- summarize(auto_grouped, mean_mpg = mean(mpg))
# Look at our new dataset with averages by cylinder for automatic transmission cars
auto_avg_by_cyl


# Example where we DO use %>%

auto_avg_by_cyl <- mtcars %>%
  filter(am == 0) %>%
  group_by(cyl) %>%
  summarize(mean_mpg = mean(mpg))
auto_avg_by_cyl


# 5.1

auto <- filter(mtcars, am == 0)

# Practice - Create subset of cars getting less than 20 mpg

# 5.2

summarize(mtcars, Minimum = min(mpg), Q1 = quantile(mpg, .25), Median = median(mpg),
          Q3 = quantile(mpg, .75), Maximum = max(mpg))

group_by(mtcars, am) %>%
  summarize(Minimum = min(mpg), Q1 = quantile(mpg, .25), Median = median(mpg),
            Q3 = quantile(mpg, .75), Maximum = max(mpg))

# Practice - Calculate mean and median mpg by number of cylinders

# 5.3

mycars <- mutate(mtcars, weight = wt * 1000)
summary(mycars$wt)
summary(mycars$weight)

# Practice - Create disp_cm variable by multiplying disp by 16.387
