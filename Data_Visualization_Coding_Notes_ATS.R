install.packages("ggplot2")

library(ggplot2)


data("mtcars")


str(mtcars)



# Using Base R
plot(mtcars$wt, mtcars$mpg,
     xlab= "Car Weight",
     ylab= "Miles per Gallon",
     font.lab=3,
     pch=3)





# Using ggplot
# Best way to plot best fitting linear relationship between two variables, 
#   without 95% CI.
ggplot()
ggplot(mtcars, aes(x = wt, y = mpg)) + 
  geom_point()+
  geom_smooth(method = lm , se = FALSE)


ggplot(mtcars, aes(x = wt, y = mpg, size = wt)) +
  geom_smooth(method = lm, se = FALSE, color = "purple") +
  geom_point( color = "red") +
  xlab("Weight") + 
  ylab("Miles per gallon")


ggplot(mtcars, aes(wt,mpg)) +
  geom_smooth(method = lm, se = FALSE, color = "gold") +
  geom_point(aes(size = wt, color = wt)) +
  xlab("Weight") + 
  ylab("Miles per gallon")



ggplot(mtcars, aes(wt,mpg)) +
  geom_smooth(method = lm, se = FALSE, color = "gold") +
  geom_point(aes(size = gear, color = wt)) +
  xlab("Weight") + 
  ylab("Miles per gallon")



ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_smooth(method = lm, se = FALSE) +
  geom_point(aes(size = cyl,color = wt)) +
  xlab("Weight") + 
  ylab("Miles per gallon") +
  scale_colour_gradient(low = "gold", high = "purple")



ggplot(mtcars, aes(x = wt, y = mpg/100)) +
  geom_smooth(method = lm, se = FALSE) +
  geom_point(aes(size = cyl,color = wt)) +
  xlab("Weight") + 
  ylab("Miles per gallon") +
  scale_colour_gradient(low = "gold", high = "purple")+
  scale_x_log10()+
  scale_y_continuous(labels = scales::percent)


# Download .csv from canvas

bull.richness <- read.csv("Bull_richness.csv")
bull.richness.soy.no.till <- bull.richness[bull.richness$Crop == "Soy" & 
                                           bull.richness$Treatment == "No-till",
                                           ] # subset to soy data


ggplot(bull.richness.soy.no.till, aes(x = GrowthStage, y = richness, 
                                      color = Fungicide)) + 
                                      geom_boxplot() 

ggplot(bull.richness.soy.no.till, 
       aes(x = GrowthStage, y = richness, 
           color = Fungicide)) + 
  geom_boxplot() + 
  xlab("") + 
  ylab("Fungal richness") +
  geom_point(position = position_dodge(width = 1))
  #geom_point(position = position_jitterdodge(width = 2))



ggplot(bull.richness.soy.no.till, 
       aes(x = GrowthStage, y = richness, 
           color = Fungicide)) + 
  geom_boxplot() + 
  xlab("") + 
  ylab("Fungal richness") +
# geom_point(position = position_dodge(width = 1))
  geom_point(position = position_jitterdodge(dodge.width = 0.9))



# stat summary

ggplot(bull.richness.soy.no.till, 
       aes(x = GrowthStage, 
           y = richness, 
           color = Fungicide)) + 
           stat_summary(fun = mean, geom = "bar") +
           stat_summary(fun.data = mean_se, geom = "errorbar",
                        position = "dodge") + 
           xlab("") + 
           ylab("Fungal richness") +
           geom_point(position=position_jitterdodge(dodge.width=0.9))





#color vs fill


ggplot(bull.richness.soy.no.till,
       aes(x = GrowthStage, y = richness, color = Fungicide, 
           fill = Fungicide)) + 
       stat_summary(fun=mean,geom="bar", position = "dodge") +
       stat_summary(fun.data = mean_se, geom = "errorbar",position = "dodge") + 
       xlab("") + 
       ylab("Fungal richness") 


# geom line!
ggplot(bull.richness.soy.no.till,
       aes(x = GrowthStage, y = richness, color = Fungicide, 
           fill = Fungicide)) + 
  stat_summary(fun=mean,geom="line") +
  stat_summary(fun.data = mean_se, geom = "errorbar") + 
  xlab("") + 
  ylab("Fungal richness") 




#time series

ggplot(bull.richness.soy.no.till, aes(x = GrowthStage, y = richness, group = Fungicide, color = Fungicide)) + 
  stat_summary(fun=mean,geom="line") +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.5) +
  ylab("Bulleribasidiaceae \n richness") + 
  xlab("") 




# Differences within an interaction

# Faceting!
ggplot(bull.richness, aes(x = GrowthStage, y = richness, group = Fungicide,
                          color = Fungicide)) + 
       stat_summary(fun = mean, geom = "line") +
       stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.5) +
       ylab("Bulleribasidiaceae \n richness") + 
       xlab("") +
       facet_wrap(~Treatment*Crop) # * adds another variable to facet
      #facet_wrap(Crop~Treatment) # same as ^




















