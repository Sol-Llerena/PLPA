# I have had experience with R in the past, and I will be starting at matrices:

mat1 <- matrix(data = c(1, 2, 3), nrow = 3, ncol = 3)
mat1 



mat2 <- matrix(data = c("Zach", "Jie", "Tom"), nrow = 3, ncol = 3)
mat2

mat1[1]
mat1[2]
mat1[3]
mat1[4]
mat1[1:9]
mat1[1,3]
mat1[1,]
mat1[,2]


## Dataframes

df <- data.frame(mat1[,1], mat2[,1]) 
df

colnames(df) <- c("value", "name")
df
df[1,2]
df[1]
df[,"value"]
df["name"]

df$value
df$name


df$value[1]
df$name[3]

df$value[df$name %in% c("Jie","Tom")]
# The %in% function was new to me! :)
df$value[df$name != "Zach"]


df$value[!df$name %in% c("Jie","Mitch")]
subset(df, name=="Jie")

df$log_value <- log10(df$value)

df


# Installing packages
install.packages("tidyverse")
install.packages("lme4")
install.packages("purrr")
install.packages("ggplot2")

library(tidyverse)
library(lme4)
library(purrr)
library(ggplot2)





# Moved csv file to my github R repo.
csv <- read.csv("corr.csv", na.strings = "na")
str(csv) #structure - good for telling num vs chr 






