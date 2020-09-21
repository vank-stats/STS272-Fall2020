# Notes 8 Code


# Load packages for Notes 8

library(infer)
library(dplyr)
library(ggplot2)
library(palmerpenguins)


###


# Example - Estimate population mean bill length of Antarctic penguins

# Calculate sample mean

peng_xbar <- mean(penguins$bill_length_mm, na.rm = TRUE)
peng_xbar


# Remove NA values from our sample

peng_samp <- filter(penguins, !is.na(bill_length_mm))


# Generate a bootstrap distribution of 1,000 sample means

set.seed(91920)
peng_bootstrap <- peng_samp %>%
  specify(formula = bill_length_mm ~ NULL) %>%
  generate(reps = 1000, type = "bootstrap") %>%
  calculate(stat = "mean")


# Graph our bootstrap distribution with red line for original sample mean

visualize(peng_bootstrap) +
  geom_vline(xintercept = peng_xbar, color = "red")


# Calculate 90% confidence intervals for population mean (using both methods)

peng_ci_percentile <- get_confidence_interval(peng_bootstrap, level = .9, 
                                              type = "percentile")
peng_ci_se <- get_confidence_interval(peng_bootstrap, level = .9, type = "se",
                                      point_estimate = peng_xbar)
peng_ci_percentile
peng_ci_se


###


# Example - Estimate the difference in population mean bill lengths of 
# Chinstrap penguins minus Gentoo penguins

# Remove Adelie penguins from our data

peng_samp2 <- filter(peng_samp, species != "Adelie")


# Calculate our two sample means

peng_xbars <- peng_samp2 %>%
  group_by(species) %>%
  summarize(xbar = mean(bill_length_mm)) %>%
  data.frame()
peng_xbars


# Calculate the difference in our sample means (our point estimate)

peng_diff_in_xbars <- peng_xbars[1, 2] - peng_xbars[2, 2]
peng_diff_in_xbars


# Generate a bootstrap distribution of 1,000 differences in sample means
# Then visualize the results in a histogram

peng_bootstrap2 <- peng_samp2 %>%
  specify(formula = bill_length_mm ~ species) %>%
  generate(reps = 1000, type = "bootstrap") %>%
  calculate(stat = "diff in means", order = c("Chinstrap", "Gentoo"))

visualize(peng_bootstrap2) +
  geom_vline(xintercept = peng_diff_in_xbars, color = "red")


# Calculate 90% confidence intervals for differnences in population means
# using the percentile and standard error methods

peng2_ci_percentile <- peng_bootstrap2 %>%
  get_confidence_interval(type = "percentile", level = 0.9)
peng2_ci_se <- peng_bootstrap2 %>%
  get_confidence_interval(type = "se", level = 0.9, 
                          point_estimate = peng_diff_in_xbars)

peng2_ci_percentile
peng2_ci_se