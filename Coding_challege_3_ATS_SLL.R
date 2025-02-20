
  ### Partner 1: <u>Alex Swystun</u>				
  
  
  ### Partner 2:	<u>Sol Llerena</u>
MycotoxinData <- read.csv("MycotoxinData.csv", na.strings = "na")
MycotoxinData$DON <- as.numeric(MycotoxinData$DON)  
  
#1.	5pts. Using ggplot, create a boxplot of DON by Treatment so that the plot looks like the image below.
  #a.	Jitter points over the boxplot and fill the points and boxplots Cultivar with two colors from the cbbPallete introduced last week. 
  #b.	Change the transparency of the jittered points to 0.6. 
  #c.	The y-axis should be labeled "DON (ppm)", and the x-axis should be left blank. 
  #d.	The plot should use a classic theme
  #e.	The plot should also be faceted by Cultivar

# Introduce color blind palette
cbbPalette <- c( "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7","#000000")

# load ggplot

library(ggplot2)

ggplot(MycotoxinData, aes(x = Treatment, y = DON, fill = Cultivar)) +
  scale_fill_manual(values = cbbPalette) +
  scale_color_manual(values = cbbPalette) +
  stat_summary(fun = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge")+
  theme_classic()+  #added classic theme
  ylab("DON (ppm)")+
  xlab("")+
  geom_point(alpha = 0.6, position=position_jitterdodge(dodge.width=0.9), pch = 21)+ # changed alpha+0.6
  facet_wrap(~Cultivar)

# 2.	4pts. Change the factor order level so that the treatment “NTC” is first, followed by “Fg”, “Fg + 37”, “Fg + 40”, and “Fg + 70. 
?factor

MycotoxinData$Treatment <- factor(MycotoxinData$Treatment, 
                                  levels = c("NTC", "Fg", "Fg + 37", "Fg + 40", "Fg + 70"))

DON<-ggplot(MycotoxinData, aes(x = Treatment, y = DON, fill = Cultivar)) +
  scale_fill_manual(values = cbbPalette) +
  scale_color_manual(values = cbbPalette) +
  stat_summary(fun = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge")+
  theme_classic()+  #added classic theme
  ylab("DON (ppm)")+
  xlab("")+
  geom_point(alpha = 0.6, position=position_jitterdodge(dodge.width=0.9), pch = 21)+ # changed alpha+0.6
  facet_wrap(~Cultivar)

#saving the plot 
ggsave("RplotDON.png") #close and safe the image

#3.	5pts. Change the y-variable to plot X15ADON and MassperSeed_mg. The y-axis label should now be “15ADON” and “Seed Mass (mg)”. 
#Save plots made in questions 1 and 3 into three separate R objects.


#Plot  X15ADON and change label 
X15ADON<- ggplot(MycotoxinData, aes(x = Treatment, y =X15ADON, fill = Cultivar)) +
  scale_fill_manual(values = cbbPalette) +
  scale_color_manual(values = cbbPalette) +
  stat_summary(fun = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge")+
  theme_classic()+  #added classic theme
  ylab("15ADON")+
  xlab("")+
  geom_point(alpha = 0.6, position=position_jitterdodge(dodge.width=0.9), pch = 21)+ # changed alpha+0.6
  facet_wrap(~Cultivar)

#saving the plot 
ggsave("Rplot15.png") #close and safe the image 

#plot MassperSeed_mg and change label 
massperseed<- ggplot(MycotoxinData, aes(x = Treatment, y =MassperSeed_mg, fill = Cultivar)) +
  scale_fill_manual(values = cbbPalette) +
  scale_color_manual(values = cbbPalette) +
  stat_summary(fun = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge")+
  theme_classic()+  #added classic theme
  ylab("Seed Mass (mg)")+
  xlab("")+
  geom_point(alpha = 0.6, position=position_jitterdodge(dodge.width=0.9), pch = 21)+ # changed alpha+0.6
  facet_wrap(~Cultivar)

#saving the plot 
ggsave("Rplotseedmass.png") #close and safe the image


#4.	5pts. Use ggarrange function to combine all three figures into one with three columns and one row. Set the labels for the subplots as A, B and C. Set the option common.legend = T within ggarage function. What did the common.legend option do?

#assign variables to the plots

#loading the package

library(ggpubr)
library(ggrepel)

FIGURE1<- ggarrange(DON,X15ADON,massperseed,
                    labels = "auto",
                    nrow = 3,
                    ncol = 1,
                    common.legend = FALSE )
# the commom legend function makes only one legend specifying the cultivar for all plots instead of repeting the legend in each plot 
#saving the plot 
ggsave("Rplotcombined.png") 

#5.	5pts. Use geom_pwc() to add t.test pairwise comparisons to the three plots made above. Save each plot as a new R object, and combine them again with ggarange as you did in question 4. 

DONtTEST<-DON + geom_pwc(aes(group=Treatment),method = "t_test")

X15ADONtTEST<- X15ADON + geom_pwc(aes(group=Treatment),method = "t_test")

MASSPERSEEDtTEST<- massperseed + geom_pwc(aes(group=Treatment),method = "t_test")


FIGURE2<- ggarrange(DONtTEST,X15ADONtTEST,MASSPERSEEDtTEST,
                    labels = "auto",
                    nrow = 3,
                    ncol = 1,
                    common.legend = FALSE )
