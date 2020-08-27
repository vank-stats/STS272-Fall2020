# Notes 3 Code

# Section 3 - The ggplot2 package

# Load the ggplot2 library (assuming you've installed it before)
library(ggplot2)

# 3.2

# Create a scatterplot of car weights vs. mpg
ggplot(data = mtcars) +
  geom_point(aes(x = wt, y = mpg))

# Practice - Make scatterplot with hp on x axis instead
ggplot(data = mtcars) +
  geom_point(aes(x = hp, y = mpg))

# Practice - Make bar graph of transmission types using geom_bar()
ggplot(data = mtcars) +
  geom_bar(aes(x = am))


# Section 4 - Types of graphs

# 4.1 - Histograms

# Generic code for a histogram
ggplot(data = dataset_name) +
  geom_histogram(aes(x = quant_var))

# Recreate histogram of Temp from airquality dataset
ggplot(data = airquality) +
  geom_histogram(aes(x = Temp))


# 4.2 - Side-by-side boxplots

# Generic code for a side-by-side boxplot
ggplot(data = dataset_name) +
  geom_boxplot(aes(x = cat_var, y = quant_var))

# Recreate side-by-side boxplots of len by supp from Toothgrowth dataset
ggplot(data = ToothGrowth) +
  geom_boxplot(aes(x = supp, y = len))


# 4.3 - Bar graphs

# Generic code for bar graph (with raw data)
ggplot(data = dataset_name) +
  geom_bar(aes(x = cat_var))

# Generic code for bar graph (with summarized data)
ggplot(data = dataset_name) +
  geom_col(aes(x = cat_var, y = count_var))

# Bar graph of cut categories from diamonds dataset
ggplot(data = diamonds) +
  geom_bar(aes(x = cut))


# Section 5 - Changing titles / labels / backgrounds / colors / etc

# 5.1

# Example of adding labels using labs()
ggplot(diamonds) +
  geom_point(aes(x = carat, y = price, color = cut)) +
  labs(title = "Scatterplot of diamond prices",
       subtitle = "Using diamonds dataset from ggplot2",
       caption = "Created for STS272 (Fall 2020)",
       x = "Weight of the Diamond (in carats)",
       y = "Price in US Dollars",
       color = "Quality of Cut")

# 5.3

# Example of changing colors without mapping a variable to an aesthetic
ggplot(airquality) +
  geom_histogram(aes(x = Temp), fill = "darkred", color = "gold")

# Example of mapping a variable to colors using aes()
ggplot(data = diamonds) +
  geom_bar(aes(x = cut, fill = cut))
