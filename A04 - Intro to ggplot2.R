# This is a template for Activity 4's code

# First we need to make sure the bridges.csv file is in the same folder as
# this R Script. Then go to 
# Session --> Set Working Directory --> To Source File Location
# After that you can run the code below

bridges <- read.csv(file = "bridges.csv")

# If you haven't installed the ggplot2 package yet (or if you're using 
# AppsAnywhere), you will need to use install.packages("ggplot2"). Otherwise,
# just load the library like below.

library(ggplot2)


# Question 3

ggplot(data = bridges)


# Question 4

ggplot(data = bridges) +
  geom_point(aes(x = YEARBUILT, y = SR))


## Question 5

ggplot(data = bridges) +
  geom_histogram(aes(_________))


## Question 7



## Question 8



## Question 9
