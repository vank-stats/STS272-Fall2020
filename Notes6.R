# Notes 6 Code


# Load the packages I will use

library(moderndive)
library(ggplot2)
library(dplyr)


# Create the House of Reps population in R
house_of_reps <- data.frame(member = 1:431,
                            party = c(rep("Democratic", 232),
                                      rep("Republican", 198),
                                      "Libertarian"))


# Take my same sample from Notes 5 of 30 representatives then look at it

set.seed(82720)
mysamp <- rep_sample_n(house_of_reps, size = 30) %>%
  ungroup() %>%
  select(-replicate)
mysamp


# Sample with replacement from my original sample. Calculate p-hat.

mysamp2 <- rep_sample_n(mysamp, size = 30, replace = TRUE)
mysamp2
mean(mysamp2$party == "Democratic")


# Take 1,000 samples with replacement and calculate p-hat for each
# Then make a graph of my 1,000 sample proportions to explore sampling variability

resamples <- mysamp %>%
  rep_sample_n(size = 30, replace = TRUE, reps = 1000) %>%
  group_by(replicate) %>%
  summarize(prop_dems = mean(party == "Democratic"))

ggplot(data = resamples) +
  geom_histogram(aes(x = prop_dems), binwidth = 1/30, color = "white") +
  labs(title = "Resampling 1000 Times From My Sample of 30 Representatives",
       x = "Sample proportions in Democratic party",
       y = "Number of samples") +
  theme_classic()


# Visualize the percentile method for a 95% confidence interval

ggplot(data = resamples) +
  geom_histogram(aes(x = prop_dems), binwidth = 1/30, color = "white") +
  labs(title = "Resampling 1000 Times From My Sample of 30 Representatives",
       x = "Sample proportions in Democratic party",
       y = "Number of samples",
       subtitle = "90% Confidence Lines in Red") +
  geom_vline(xintercept = quantile(resamples$prop_dems, c(.05, .95)), color = "red") +
  theme_classic()


# Calculate an interval using the Standard Error method

resample_sd <- sd(resamples$prop_dems)
resample_mean <- mean(resamples$prop_dems)

resample_mean - 1.645 * resample_sd
resample_mean + 1.645 * resample_sd


# Compare my two methods on a graph

ggplot(data = resamples) +
  geom_histogram(aes(x = prop_dems), binwidth = 1/30, color = "white") +
  labs(title = "Resampling 1000 Times From My Sample of 30 Representatives",
       x = "Sample proportions in Democratic party",
       y = "Number of samples",
       subtitle = "90% Confidence Lines (Red = Percentile Method, Blue = SE Method)") +
  geom_vline(xintercept = quantile(resamples$prop_dems, c(.05, .95)), color = "red") +
  geom_vline(xintercept = c(.313, .623), color = "blue") +
  theme_classic()


# Compare the theory based method too

ggplot(data = resamples) +
  geom_histogram(aes(x = prop_dems), binwidth = 1/30, color = "white") +
  labs(title = "Resampling 1000 Times From My Sample of 30 Representatives",
       x = "Sample proportions in Democratic party",
       y = "Number of samples",
       subtitle = "90% Confidence Lines (Red = Percentile, Blue = SE. Gold = Theory)") +
  geom_vline(xintercept = quantile(resamples$prop_dems, c(.05, .95)), color = "red") +
  geom_vline(xintercept = c(.313, .623), color = "blue") +
  geom_vline(xintercept = c(.317, .617), color = "gold") +
  theme_classic()