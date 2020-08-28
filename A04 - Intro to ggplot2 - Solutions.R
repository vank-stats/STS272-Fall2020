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
  geom_histogram(aes(x = YEARBUILT))


## Question 7

ggplot(data = bridges) +
  geom_histogram(aes(x = YEARBUILT), color = "white")

# We can add fill = ___ to change the color of the bars themselves. For example...

ggplot(data = bridges) +
  geom_histogram(aes(x = YEARBUILT), color = "white", fill = "pink")


## Question 8

ggplot(data = bridges) +
  geom_histogram(aes(x = YEARBUILT), color = "white", binwidth = 10)


## Question 9 - here is our example from class

ggplot(data = bridges) +
  geom_histogram(aes(x = SR), color = "cadetblue", fill = "orange", bins = 20)
                 
                 