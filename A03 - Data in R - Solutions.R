# Make sure bridges.csv is in same folder as this R Script
# Session --> Set Working Directory --> To Source File Location


# Question 4

bridges <- read.csv(file = "Bridges.csv")


# Question 5 - We can look in the environment pane or use functions like summary(),
# or View()

summary(bridges)
View(bridges)


# Question 7

min(bridges$YEARBUILT)
max(bridges$YEARBUILT)


# Question 8

year <- bridges$YEARBUILT


# Question 9

year[1]
year[c(1, 13367)]
year[seq(1, 100, 10)]


# Question 10 - These are all ways to do the same thing

Alamance <- bridges[seq(1, 149), ]
Alamance <- bridges[1:149, ]
Alamance <- bridges[seq(from = 1, to = 149, by = 1), ]


# Question 11

Alamance <- bridges[seq(1, 149), c(3, 4, 6, 7, 8)]