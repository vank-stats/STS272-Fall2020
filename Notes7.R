# Notes 7 Code


# Load packages for Notes 7

library(infer)
library(dplyr)
library(ggplot2)
library(palmerpenguins)
library(moderndive)


# Create my House of Reps population and take my original sample of 30

house_of_reps <- data.frame(member = 1:431,
                            party = c(rep("Democratic", 232),
                                      rep("Republican", 198),
                                      "Libertarian"))

set.seed(82720)
HOR_samp <- rep_sample_n(house_of_reps, size = 30) %>%
  ungroup() %>%
  select(-replicate)


# Calculate p-hat (my sample proportion) for my sample

HOR_phat <- mean(HOR_samp$party == "Democratic")
HOR_phat


# Create a bootstrap distribution of 1,000 sample proportions
# by sampling with replacement from my original sample

HOR_bootstrap <- HOR_samp %>%
  specify(formula = party ~ NULL, success = "Democratic") %>%
  generate(reps = 1000, type = "bootstrap") %>%
  calculate(stat = "prop")


# Make a histogram of this distribution and add my sample proportion in red

visualize(HOR_bootstrap) +
  geom_vline(xintercept = HOR_phat, color = "red")


# Calculate 95% confidence interval using percentile method

HOR_ci_percentile <- HOR_bootstrap %>%
  get_confidence_interval(level = 0.95, type = "percentile")
HOR_ci_percentile


# Calculate 95% confidence interval using SE method

HOR_ci_se <- HOR_bootstrap %>%
  get_confidence_interval(level = 0.95, type = "se", point_estimate = HOR_phat)
HOR_ci_se


# Load penguins data and remove Adelie penguins

peng_samp <- filter(penguins, species != "Adelie")


# Use table() and prop.table() to see proportion of each species that are female
# calculate the difference in sample proportions

table(peng_samp$species, peng_samp$sex) %>%
  prop.table(margin = 1)
peng_phats <- .5 - .487395
peng_phats


# Create a bootstrap distribution of 1,000 differences in proportions from 
# sampling with replacement from our original sample.
# Visualize this in a histogram

peng_bootstrap <- peng_samp %>%
  specify(formula = sex ~ species, success = "female") %>%
  generate(reps = 1000, type = "bootstrap") %>%
  calculate(stat = "diff in props", order = c("Chinstrap", "Gentoo"))
visualize(peng_bootstrap)


# Create 95% confidence intervals for difference in proportions using both
# Percentile and SE Methods

peng_ci_percentile <- peng_bootstrap %>%
  get_confidence_interval(type = "percentile")
peng_ci_se <- peng_bootstrap %>%
  get_confidence_interval(type = "se", point_estimate = peng_phats)

peng_ci_percentile
peng_ci_se

