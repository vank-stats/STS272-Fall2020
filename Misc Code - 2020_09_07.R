# Going over Notes 4 Lesson Part 2 Question
#
# Use the functions from this set of notes to perform the following tasks with the 
# mtcars dataset. 
# 
# (i) subset to only include cars with at least 100 hp, 
# (ii) create a called mpt (for miles per tank) by multiplying mpg by 14, 
# (iii) summarize your new mpt variable by finding the mean and standard deviation
# 
# You may want to try doing this with and without the pipe operator %>% to gain
# experience with how it works.

library(dplyr)
# First we'll do the three parts separately

# (i)
parti <- filter(mtcars, hp >= 100)

# (ii)
partii <- mutate(parti, mpt = mpg * 14)

# (iii)
summarize(partii, Mean = mean(mpt), StandardDeviation = sd(mpt))


# Now we'll use piping to do (i) - (iii) together
filter(mtcars, hp >= 100) %>%
  mutate(mpt = mpg * 14) %>%
  summarize(Mean = mean(mpt), StandardDeviation = sd(mpt))




##
## Example of bar graph with and without summaized data
##

library(ggplot2)

# With raw data - mtcars has rows for each car

ggplot(data = mtcars) +
  geom_bar(aes(x = factor(cyl)))

# Create a summarized data set called mtcars_sum

mtcars_sum <- mtcars %>%
  group_by(cyl) %>%
  summarize(count = n())

# Notice that there are only three rows now, one for each group (not each car)
# The count variable I created tells me how many cars in each group, so now I
# need to use geom_col() and map count to y

mtcars_sum

ggplot(data = mtcars_sum) +
  geom_col(aes(x = factor(cyl), y = count))

# Note: If I had tried to use geom_bar() still it would think I only had three cars

ggplot(data = mtcars_sum) +
  geom_bar(aes(x = factor(cyl)))




###
### Changing colors in graphs
###

# You can use scale_fill_manual() to choose colors for your fill aesthetic

ggplot(data = mtcars) +
  geom_bar(aes(x = factor(cyl), fill = factor(cyl))) +
  scale_fill_manual(values = c("orange", "purple", "yellow"))

# You can do the same thing with scale_color_manual() to change color aesthetic

ggplot(data = mtcars) +
  geom_bar(aes(x = factor(cyl), color = factor(cyl))) +
  scale_color_manual(values = c("orange", "purple", "yellow"))

# There are also some pre-set color schemes. Try scale_fill_viridis_d()
# and choose from options "A" - "E"

ggplot(data = mtcars) +
  geom_bar(aes(x = factor(cyl), fill = factor(cyl))) +
  scale_fill_viridis_d(option = "B")




### 
### Customizing Themes of graphs
###

# This is a bit more difficult. Go to the help for theme() to see ALL the options
# There are a couple resources on Moodle to help more with this

?theme()


# Below I've included some examples that you can play around with to customize
# your own backgrounds and more

ggplot(data = mtcars) +
  geom_bar(aes(x = factor(cyl), fill = factor(cyl))) +
  scale_fill_viridis_d(option = "E") +
  labs(title = "Very nice graph I made",
       subtitle = "Here is my nice subtitle") +
  theme(plot.title = element_text(color = "pink", size = 16),
        plot.subtitle = element_text(color = "darkgreen", face = "italic"),
        panel.background = element_rect(fill = "pink"),
        plot.background = element_rect(fill = "lightblue2"),
        legend.background = element_rect(fill = "lightgreen"),
        axis.text = element_text(color = "purple", face = "bold"),
        axis.title = element_text(color = "brown"))

# I can also save my theme for later doing something like this...

theme_drv <- function() {
  theme(plot.title = element_text(color = "pink", size = 16),
        plot.subtitle = element_text(color = "darkgreen", face = "italic"),
        panel.background = element_rect(fill = "pink"),
        plot.background = element_rect(fill = "lightblue2"),
        legend.background = element_rect(fill = "lightgreen"),
        axis.text = element_text(color = "purple", face = "bold"),
        axis.title = element_text(color = "brown"))
}

# Now I just need to add theme_drv() to my graphs

ggplot(data = mtcars) +
  geom_bar(aes(x = factor(cyl), fill = factor(cyl))) +
  scale_fill_viridis_d(option = "E") +
  labs(title = "Very nice graph I made",
       subtitle = "Here is my nice subtitle") +
  theme_drv()


# There is also a tvthemes package to use other custom themes. It doesn't work
# well with AppsAnywhere (or older versions of R/RStudio), but the example below 
# should work on your own computer (hopefully) if you install the package

library(tvthemes)
ggplot(data = mtcars) +
  geom_bar(aes(x = factor(cyl), fill = factor(cyl))) +
  scale_fill_viridis_d(option = "E") +
  labs(title = "Very nice graph I made") +
  theme_theLastAirbender()
    


###
### Moving aes() to ggplot() and multiple geoms
###

# In the example below I moved aes() to the ggplot() function. This will carry those
# aesthetics over to any geoms below.
# I also used two geoms on the same graph, geom_boxplot() and geom_point()
# This lets me see actual data values AND the boxplot summary

ggplot(data = mtcars, aes(x = factor(cyl), y = mpg)) +
  geom_boxplot() +
  geom_point(alpha = .3)