library(ggplot2)
library(dplyr)
library(infer)
library(patchwork)
set.seed(91920)

n <- 30
samples <- 10
conf <- .8

# Sampling distribution of 5000 sample mean diamond prices

diam_sampdist <- diamonds %>%
  rep_sample_n(size = n, reps = 5000) %>%
  group_by(replicate) %>%
  summarize(xbar = mean(price))


# Take samples of size n

mysamps <- rep_sample_n(diamonds, size = n, reps = samples)

samplemeans <- mysamps %>%
  group_by(replicate) %>%
  summarize(sampmean = mean(price)) %>%
  rename(sample = replicate)



# Create a bootstrap distribution for each and a percentile CI

boots <- data.frame(replicate = NA, stat = NA, sample = NA)[-1, ]
cis <- data.frame(lower = NA, upper = NA)
for(i in 1:samples) {
  newsamp <- filter(mysamps, replicate == i)
  newboot <- newsamp %>%
    specify(formula = price ~ NULL) %>%
    generate(reps = 5000, type = "bootstrap") %>%
    calculate(stat = "mean") %>%
    mutate(sample = i) %>%
    data.frame()
  cis[i,] <- get_confidence_interval(newboot, level = conf, type = "percentile")
  boots <- rbind(boots, newboot)
}

cover <- sum(cis[,1] < mean(diamonds$price) & cis[,2] > mean(diamonds$price))
samplemeans <- cbind(samplemeans, cis, cover)

# Graph of approximate sampling distribution

g1 <- ggplot(diam_sampdist) +
  geom_histogram(aes(x = xbar), fill = "lightblue", color = 'white', binwidth = 100) +
  labs(title = "Sampling Distribution of Mean Diamond Prices",
       subtitle = paste0("n = ", n)) +
  theme_classic() +
  geom_vline(xintercept = mean(diamonds$price), color = "red", size = 3) +
  geom_vline(NULL, xintercept = samplemeans$sampmean, linetype = 2, color = "gray") +
  xlim(c(min(boots$stat), max(boots$stat)))

g2 <- ggplot(boots) +
  geom_histogram(aes(x = stat), fill = "lightblue", color = "white", binwidth = 100) +
  facet_grid(rows = vars(sample)) +
  geom_vline(xintercept = mean(diamonds$price), color = "red") +
  geom_vline(samplemeans, mapping = aes(xintercept = lower), linetype = 2,
             color = "gray") +
  geom_vline(samplemeans, mapping = aes(xintercept = upper), linetype = 2,
             color = "gray") +
  labs(title = paste0(samples, " Bootstrap samples"),
       subtitle = paste0(cover, " of the ", samples, " ", 100*conf, 
                         "% confidence intervals contain mu")) +
  theme_classic() +
  xlim(c(min(boots$stat), max(boots$stat)))

g1 + g2 + plot_layout(heights = c(1, samples - 1))
