1.  2 pts. Regarding reproducibility, what is the main point of writing
    your own functions and iterations?

When we are dealing with big sets of data were we have to perform
repetitive actions or mathemathical operations, it is better to have a
function or iteration to go trough all the data instead of copying and
pasting the information. It also makes it easier for someone else to
understand what we are doing. Writing functions and using iterations
helps us understand what we didi as well so that we can re-run our data
or use the same analysis for a different set of data.

1.  2 pts. In your own words, describe how to write a function and a for
    loop in R and how they work. Give me specifics like syntax, where to
    write code, and how the results are returned.

To write a function first we give our function a name that could be
related to what it does , then we add the variable in a parentheses. We
call for the function definition of Rstudio and write down what we want
our function to do using code inside {}.Finally we add the return()
output of the function

name\<-function(variable){code return()}

To write for loop in R, the common synthax 1.- for() 2. i common name or
a varible 3. in (sequence we want to iterate) 4. {} to tell it what to
do with that input 5. function 6.print or show the output in some way

for (i in sequence we want to iterate){ funtion output

Load packages

``` r
library(readr)
```

    ## Warning: package 'readr' was built under R version 4.4.3

``` r
library(tidyverse)
```

    ## Warning: package 'tidyverse' was built under R version 4.4.3

    ## Warning: package 'ggplot2' was built under R version 4.4.3

    ## Warning: package 'tibble' was built under R version 4.4.3

    ## Warning: package 'tidyr' was built under R version 4.4.3

    ## Warning: package 'purrr' was built under R version 4.4.3

    ## Warning: package 'dplyr' was built under R version 4.4.3

    ## Warning: package 'stringr' was built under R version 4.4.3

    ## Warning: package 'forcats' was built under R version 4.4.3

    ## Warning: package 'lubridate' was built under R version 4.4.3

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.4     ✔ purrr     1.0.4
    ## ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ## ✔ ggplot2   3.5.1     ✔ tibble    3.2.1
    ## ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

This dataset contains the population and coordinates (latitude and
longitude) of the 40 most populous cities in the US, along with Auburn,
AL. Your task is to create a function that calculates the distance
between Auburn and each other city using the Haversine formula. To do
this, you’ll write a for loop that goes through each city in the dataset
and computes the distance from Auburn. Detailed steps are provided
below.

1.  2 pts. Read in the Cities.csv file from Canvas using a relative file
    path.

``` r
Cities_US<- read.csv("../data/Cities.csv")
#View(Cities_US)
```

1.  6 pts. Write a function to calculate the distance between two pairs
    of coordinates based on the Haversine formula (see below). The input
    into the function should be lat1, lon1, lat2, and lon2. The function
    should return the object distance_km. All the code below needs to go
    into the function.

Create function

``` r
mad_function<- function(lat1,lon1,lat2,lon2){# convert to radians
rad.lat1 <- lat1 * pi/180
rad.lon1 <- lon1 * pi/180
rad.lat2 <- lat2 * pi/180
rad.lon2 <- lon2 * pi/180
# Haversine formula
delta_lat <- rad.lat2 - rad.lat1
delta_lon <- rad.lon2 - rad.lon1
a <- sin(delta_lat / 2)^2 + cos(rad.lat1) * cos(rad.lat2) * sin(delta_lon / 2)^2
c <- 2 * asin(sqrt(a))
# Earth's radius in kilometers
earth_radius <- 6378137
# Calculate the distance
distance_km <- ((earth_radius * c)/1000)
return(distance_km)}
```

test the function

``` r
mad_function(32.6087,-85.4903,40.6943,-73.9249)
```

    ## [1] 1367.854

1.  5 pts. Using your function, compute the distance between Auburn, AL
    and New York City

<!-- -->

1.  Subset/filter the Cities.csv data to include only the latitude and
    longitude values you need and input as input to your function.

sub-setting the csv file to include only the latitude and longitude
values needed

``` r
NY<-Cities_US%>%
  select(city,lat,long)%>%
  filter(city=="Auburn" | city == "New York")
NY
```

    ##       city     lat     long
    ## 1 New York 40.6943 -73.9249
    ## 2   Auburn 32.6087 -85.4903

1.  The output of your function should be 1367.854 km

``` r
mad_function(NY[1,2],NY[1,3],NY[2,2],NY[2,3])
```

    ## [1] 1367.854

1.  6 pts. Now, use your function within a for loop to calculate the
    distance between all other cities in the data. The output of the
    first 9 iterations is shown below. \## \[1\] 1367.854 \## \[1\]
    3051.838 \## \[1\] 1045.521 \## \[1\] 916.4138 \## \[1\] 993.0298
    \## \[1\] 1056.022 \## \[1\] 1239.973 \## \[1\] 162.5121 \## \[1\]
    1036.99 Bonus point if you can have the output of each iteration
    append a new row to a dataframe, generating a new column of data. In
    other words, the loop should create a dataframe with three columns
    called city1, city2, and distance_km, as shown below. The first six
    rows of the dataframe are shown below. \## City1 City2 Distance_km
    \## 1 New York Auburn 1367.8540 \## 2 Los Angeles Auburn 3051.8382
    \## 3 Chicago Auburn 1045.5213 \## 4 Miami Auburn 916.4138 \## 5
    Houston Auburn 993.0298 \## 6 Dallas Auburn 1056.0217

``` r
# Subset Auburn, AL's coordinates
AU <- Cities_US %>%
  filter(city == "Auburn") %>%
  select(lat, long)

AU_lat <- AU$lat
AU_long <- AU$long

# Create an empty dataframe to store results
distance_df <- data.frame(city_1 = character(),
                          city_2 = character(),
                          distance_from_auburn = numeric())

# Loop through each city and compute distance
for (i in 1:nrow(Cities_US)) {
  city_name <- Cities_US$city[i]
  city_lat <- Cities_US$lat[i]
  city_long <- Cities_US$long[i]
  
  # Compute distance only if it's not Auburn itself
  if (!(city_name == "Auburn")) {
    distance_km <- mad_function(AU_lat, AU_long, city_lat, city_long)
  } else {
    distance_km <- 0  # Distance to itself is 0
  }
  
  distance_df <- rbind(distance_df, data.frame(city_1 = "Auburn",
                                               city_2 = paste(city_name),
                                               distance_from_auburn = distance_km))
}

# View results
head(distance_df)
```

    ##   city_1      city_2 distance_from_auburn
    ## 1 Auburn    New York            1367.8540
    ## 2 Auburn Los Angeles            3051.8382
    ## 3 Auburn     Chicago            1045.5213
    ## 4 Auburn       Miami             916.4138
    ## 5 Auburn     Houston             993.0298
    ## 6 Auburn      Dallas            1056.0217

1.  2 pts. Commit and push a gfm .md file to GitHub inside a directory
    called Coding Challenge 6. Provide me a link to your github written
    as a clickable link in your .pdf or .docx

[Link to this
assignment](https://github.com/Aswystun/PLPA/tree/master/coding_challenge_6)
[link to my github](https://github.com/Aswystun/PLPA)
