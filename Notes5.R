# Notes 5 Code

# Load necessary packages

library(moderndive)
library(dplyr)
library(ggplot2)
library(gridExtra)


# Create House of Reps population to sample from

house_of_reps <- data.frame(member = 1:431,
                            party = c(rep("Democratic", 232),
                                      rep("Republican", 198),
                                      "Libertarian"))


# Choose my sample from the population and look at it with table()

set.seed(82720)
mysamp <- rep_sample_n(house_of_reps, size = 30)
table(mysamp$party)


# Take 100 samples of 30 representatives from the population
# Calculate proporiton of Dems for each sample
# Make a graph of the 100 sample proportions

manysamps <- rep_sample_n(house_of_reps, size = 30, reps = 100) %>%
  group_by(replicate) %>%
  summarize(prop_dem = mean(party == "Democratic"))

ggplot(manysamps) +
  geom_histogram(aes(x = prop_dem), color = "white", binwidth = 1/30) +
  geom_vline(xintercept = 14 / 30, color = "red") +
  geom_vline(xintercept = 232 / 431, color = "blue") +
  labs(title = "Sample proportions from 100 samples of 30 US Representatives",
       subtitle = "Red = Original sample, Blue = Population Proportion")


# Take 100 samples of 60 and of 120 representatives. Calculate p-hat for each.

manysamps_60 <- rep_sample_n(house_of_reps, size = 60, reps = 100) %>%
  group_by(replicate) %>%
  summarize(prop_dem = mean(party == "Democratic"))
manysamps_120 <- rep_sample_n(house_of_reps, size = 120, reps = 100) %>%
  group_by(replicate) %>%
  summarize(prop_dem = mean(party == "Democratic"))


# Create graphs to compare my samples of different sizes
# Use the gridExtra package to display them all together

g30 <- ggplot(manysamps) +
  geom_histogram(aes(x = prop_dem), color = "white", binwidth = 1/30) +
  xlim(c(.3, .8)) + ylim(c(0, 35)) +
  geom_vline(xintercept = 232 / 431, color = "blue") +
  labs(title = "Sample proportions from 100 samples of 30 US Representatives")

g60 <- ggplot(manysamps_60) +
  geom_histogram(aes(x = prop_dem), color = "white", binwidth = 1/30) +
  xlim(c(.3, .8)) + ylim(c(0, 35)) +
  geom_vline(xintercept = 232 / 431, color = "blue") +
  labs(title = "Sample proportions from 100 samples of 60 US Representatives")

g120 <- ggplot(manysamps_120) +
  geom_histogram(aes(x = prop_dem), color = "white", binwidth = 1/30) +
  xlim(c(.3, .8)) + ylim(c(0, 35)) +
  geom_vline(xintercept = 232 / 431, color = "blue") +
  labs(title = "Sample proportions from 100 samples of 120 US Representatives")

grid.arrange(g30, g60, g120, ncol = 1)


# Calculate the Standard Error for samples of different sizes

allsamps <- rbind(manysamps, manysamps_60, manysamps_120)
allsamps$n <- c(rep(30, 100), rep(60, 100), rep(120, 100))
allsamps %>%
  group_by(n) %>%
  summarize(StErr = sd(prop_dem))