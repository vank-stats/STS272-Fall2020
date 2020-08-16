# Notes 2 Code

# Section 4 - Writing Code in R

# 4.1
mynumbers <- c(4, 8, 15, 16, 23, 42)
mynumbers * 2
max(mynumbers)

# 4.2
Max(mynumbers)


# Section 5 - Datasets in R

?mtcars

# 5.1
head(mtcars)

# Note: I may need to install dplyr and skimr if I've never done so on my computer
library(dplyr)
library(skimr)

summary(mtcars)
View(mtcars)
glimpse(mtcars)
skim(mtcars)

# 5.2
mtcars$hp
