# Create a vector named 'z' with the values 1 to 200
#c concatenates the values 1 - 200 (1:200)
z <- c(1:200)


# o Print the mean and standard deviation of z on the console
# mean and sd are commands from the base R STATS package
mean(z)
sd(z)

# o Create a logical vector named zlog that is 'TRUE' for z values greater than 
#   30 and 'FALSE' otherwise.

# Creates a vector to show numbers under 30 are FALSE, while the rest are true.
zlog <- z>=30


# o Make a dataframe with z and zlog as columns. Name the dataframe zdf
# data.frame is a command that will make a dataframe out of two vectors.
zdf<-data.frame(z,zlog)

View(zdf)
# o Change the column names in your new dataframe to equal “zvec” and “zlogic”
# I use the View command a few times here to double check my work
# Here I am assigning column names to the zdf dataframe.

colnames(zdf)<-(c("zvec","zlogic"))
View(zdf)


# o Make a new column in your dataframe equal to zvec squared (i.e., z2). Call the
#   new column zsquared.
# Here I used $ to find a column that I wanted to manipulate and then saved it into 
#   a new vector
zsquared <- zdf$zvec^2

# Then
zdf<- data.frame(zdf,zsquared)
View(zdf)


# o Subset the dataframe with and without the subset() function to only include
# values of zsquared greater than 10 and less than 100

sub1<-subset.data.frame(zdf,subset = zsquared>10 & zsquared <100)

sub2<- zdf[zdf$zsquared>10 & zdf$zsquared<100,]
View(sub2)


# o Subset the zdf dataframe to only include the values on row 26



sub3<- zdf[26,1:3]

View(sub3)

# o Subset the zdf dataframe to only include the values in the column zsquared in
# the 180th row.


sub4<- zdf$zsquared[180]




# o Annotate your code, commit the changes and push it to your GitHub



Tips<-read.csv(file = "TipsR.csv",na.strings = ".")

View(Tips)

str(Tips)
