# Activity 5

library(ggplot2)
library(palmerpenguins)

# 2 - Explore the data

View(penguins)
summary(penguins)
?penguins


# 3 - Boxplot of flipper length between species

ggplot(data = penguins) +
  geom_boxplot(aes(x = species, y = flipper_length_mm))

ggplot(data = penguins) +
  geom_boxplot(aes(x = flipper_length_mm, y = species))

# 4 - Comment on the box plot

# The lines coming out of the boxes go to the min and max (dots are outliers)
# The line in the middle of the box is the median (50% of data is above/below)
# The two other lines making up the box are first/third quartile
# 25% of data is below Q1, 75% of data is below Q3


# 5 - Add title / axis labels with labs()

ggplot(data = penguins) +
  geom_boxplot(aes(x = species, y = flipper_length_mm)) +
  labs(title = "Box Plot of Flipper Length",
       x = "Penguin Species",
       y = "Flipper length (in mm)")

# 6 - Use fill = __ inside aes()

ggplot(data = penguins) +
  geom_boxplot(aes(x = species, y = flipper_length_mm, fill = sex)) +
  labs(title = "Box Plot of Flipper Length",
       x = "Penguin Species",
       y = "Flipper length (in mm)")


# 7 - Bar graph of number of penguins per island

ggplot(data = penguins) +
  geom_bar(aes(x = island))


# 8 - Add some color and a theme

ggplot(data = penguins) +
  geom_bar(aes(x = island), fill = "white", color = "gray7") +
  theme_classic()


# 9 - Map species to fill

ggplot(data = penguins) +
  geom_bar(aes(x = island, fill = species), color = "gray7") +
  theme_classic()



# 10 - Put position = "dodge" outside of aes()

ggplot(data = penguins) +
  geom_bar(aes(x = island, fill = species), color = "blue",
           position = "dodge") +
  theme_classic()

# 11 - Try something on your own