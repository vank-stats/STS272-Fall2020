# Notes 9 Code


# Load packages for Notes 9

library(dplyr)
library(tidyr)
library(palmerpenguins)


###


# Example - CI for proportion of Antarctic penguins that are female

prop.test(x = 165, n = 333, conf.level = .95)


# Example - CI for diff in proportions of Chinstrap/Gentoo that are female

prop.test(x = c(34, 58), n = c(68, 119), conf.level = .95)


# Example - CI for mean bill length of Antarctic penguins

t.test(penguins$bill_length_mm, conf.level = 0.95)


# Example - CI for difference in mean bill lengths of Chinstrap/Gentoo penguins

# Method 1

penguins_twospecies <- filter(penguins, species != "Adelie")
t.test(penguins_twospecies$bill_length_mm ~ penguins_twospecies$species, 
       conf.level = 0.95)

# Method 2

bills_chin <- filter(penguins, species == "Chinstrap")$bill_length_mm
bills_gen <- filter(penguins, species == "Gentoo")$bill_length_mm
t.test(bills_chin, bills_gen, conf.level = 0.95)