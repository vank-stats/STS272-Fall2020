library(dplyr)
library(ggplot2)

# Question 1

round(mean(c(3, 4, 6)), digits = 2)


# Question 2

c(3, 4, 6) %>%
  mean() %>%
  round(digits = 2)


# Question 3

diamonds_expensive <- filter(diamonds, price > 2000)
diamonds_good <- filter(diamonds, cut == "Good")
diamonds_small <- filter(diamonds, x < 5, y < 5, z < 5)

# Optional Bonus

diamonds_best <- filter(diamonds, cut == "Ideal" | color == "D" | clarity == "IF")


# Question 4

summarize(diamonds, mean_x = mean(x), mean_y = mean(y), mean_z = mean(z))


# Question 5

group_by(diamonds, cut) %>%
  summarize(mean_x = mean(x), mean_y = mean(y), mean_z = mean(z))


# Question 6

my_summary <- group_by(diamonds, cut, color) %>%
  summarize(mean_x = mean(x), mean_y = mean(y), mean_z = mean(z))

group_by(diamonds, cut, color) %>%
  summarize(mean_x = mean(x), mean_y = mean(y), mean_z = mean(z)) %>%
  data.frame()

# Question 7

diamonds2 <- mutate(diamonds, volume = x * y * z, price_can = price * 1.31)


# Question 8

can_summary <- diamonds %>%
  filter(cut == "Ideal") %>%
  mutate(price_can = price * 1.31) %>%
  group_by(color) %>%
  summarize(mean_canprice = mean(price_can),
            median_canprice = median(price_can))
can_summary


# Note: To give a name with spaces, put it inside ``(under Esc key)

mutate(diamonds, price_1000s = price / 1000) %>%
  filter(carat > 2) %>%
  group_by(cut, color) %>%
  summarize(`Min Price in $1000s` = min(price_1000s),
            `Med Price in $1000s` = median(price_1000s),
            `Max Price in $1000s` = max(price_1000s))

