rainfall <- read.csv("C:/Users/rvankrevelen/Downloads/rainfall.csv")


library(ggplot2)
library(infer)

ggplot(rainfall) +
  geom_histogram(aes(x = rain)) +
  facet_wrap(treatment~ .)


rainfall %>%
  specify(formula = rain ~ treatment) %>%
  calculate(stat = "diff in means", order = c("SEEDED", "UNSEEDED")) %>%
  data.frame()

# Our estimate for the difference in population mean rainfall is
# 277.4 acre feet. (This is also the difference in sample means)

rainfall_boot <- rainfall %>%
  specify(formula = rain ~ treatment) %>%
  generate(reps = 5000, type = "bootstrap") %>%
  calculate(stat = "diff in means", order = c("SEEDED", "UNSEEDED"))
visualize(rainfall_boot)


# Percentile method CI
get_confidence_interval(rainfall_boot, type = "percentile", level = 0.95)



# Theory based confidence intterval

t.test(rainfall$rain ~ rainfall$treatment)

# Interpretation of Theory based CI
# We are not 95% confident that either method has a higher population
# mean rainfall than the other. We are 95% confident the population
# mean rainfall is anywhere from 4.7 acre=feet higher for unseeded
# clouds to 559.6 acre-feet higher for seeded clouds.