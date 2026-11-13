library(tidyverse)
install.packages("DataExplorer")
library(DataExplorer)
install.packages("rstatix")
library(rstatix)
library(here)

stations <- c("KCLT", "KCQT", "KHOU", "KIND", "KJAX", "KMDW", "KNYC", "KPHL", "KPHX", "KSEA")
cities <- c("Charlotte", "Los Angeles", "Houston", "Indianapolis", "Jacksonville", 
            "Chicago", "New York City", "Philadelphia", "Phoenix", "Seattle")

# QUESTION 1
#> The data files are in the directory 'us-weather-history'
#> Write a function that takes each station abbreviation and reads
#> the data file and adds the station name in a column
#> Make sure the date column is a date
#> The function should return a tibble
#> Call the function "read_weather" 
#> Check by reading/glimpsing a single station's file
here()

read_weather <- function(s) {

  if (s == "KCLT") {
    charlotte <- read_csv("us-weather-history/KCLT.csv")
    charlotte <- charlotte |> mutate(station = "Charlotte",.before=1)
    return(charlotte)
  } else if (s == "KCQT") {
    la <- read_csv("us-weather-history/KCQT.csv")
      la <- la |> mutate(station = "Los Angeles",.before=1)
      return(la)
  } else if (s == "KHOU") {
    houston <- read_csv("us-weather-history/KHOU.csv")
    houston <- houston |> mutate(station = "Houston",.before=1)
    return(houston)
  } else if (s == "KIND") {
    ind <- read_csv("us-weather-history/KIND.csv")
    ind <- ind |> mutate(station = "Indianapolis",.before=1)
    return(ind)
  } else if (s == "KJAX") {
    jack <- read_csv("us-weather-history/KJAX.csv")
    jack <- jack |> mutate(station = "Jacksonville",.before=1)
    return(jack)
  } else if (s == "KMDW") {
    chic <- read_csv("us-weather-history/KMDW.csv")
    chic <- chic |> mutate(station = "Chicago",.before=1)
    return(chic)
  } else if (s == "KNYC") {
    nyc <- read_csv("us-weather-history/KNYC.csv")
    nyc <- nyc |> mutate(station = "New York City",.before=1)
    return(nyc)
  } else if (s == "KPHL") {
    phil <- read_csv("us-weather-history/KPHL.csv")
    phil <- phil |> mutate(station = "Philadelphia",.before=1)
    return(phil)
  } else if (s == "KPHX") {
    phx <- read_csv("us-weather-history/KPHX.csv")
    phx <- phx |> mutate(station = "Phoenix",.before=1)
    return(phx)
  } else if (s == "KSEA") {
    sea <- read_csv("us-weather-history/KSEA.csv")
    sea <- sea |> mutate(station = "Seattle",.before=1)
    return(sea)
  }
}

read_weather("KSEA")

# QUESTION 2
#> Use map() and your new function to read in all 10 stations
#> Note that because map_dfr() has been superseded, and map() does not automatically bind rows, 
#> you will need to do so in the code with bind_rows()
#> Save the resulting dataset to "ds"

ds <- map(stations, read_weather) |> 
  bind_rows()


# QUESTION 3
#> Make a factor called "city" based on the station variable
#> (station should be the level and city should be the label)
#> Use rstatix::freq_tables() to check that there are 365 days of data for each city 
#> and save the results to a new tibble
#> Write a logical statement that would trigger a warning if any city did not have 365 days

city <- factor(stations)
freq <- freq_table(ds$station)

if(any(freq$n != 365)) {
  print("A city does NOT have 365 days")
  print(freq)
} else {
  print("All cities have 365 days")
}

# QUESTION 4
#> In question 3, all of the cities do have 365 days of data, so how would you know
#> if your check worked? Create a test to mess up the dataset to make sure that your
#> check does throw an error if the conditions aren't met

freq2 <- freq |> mutate(n2 = n +1)

if(any(freq2$n2 != 365)) {
  print("A city does NOT have 365 days")
  print(freq2)
} else {
  print("All cities have 365 days")
}
#it worked

#> At this point, your data should look like the "compiled_data.csv" file
#> in data-clean. If it isn't, read in that file to use for the remaining
#> questions so that you have the right data to work with.

# QUESTION 5
#> Find a function that lets you pull out the month from the date 
#> and make "month" a factor as a new variable in ds



# QUESTION 7
#> Use rstatix to check if there are any outliers for actual_mean_temp.
#> Save the outliers to a new tibble.
#> In a piped statement, filter out those outliers from ds and then use
#> get_summary_stats() to get the mean and SE for actual_mean_temp
#> by month.


# QUESTION 8
#> Use the Data Explorer package to plot boxplots of all of the numeric variables in the dataset
#> grouped by city, then do the same thing grouped by month. 
#> Finally, use plot_correlation to investigate correlations between the continuous variables only
#> Check the documentation for plot_correlation for an easy way to do this


# QUESTION 9
#> Create a scatterplot of actual_mean_temp (y axis) by date (x axis)
#> Use facet_wrap to make a separate plot for each city (3 columns)
#> Make the points different colors according to month


# QUESTION 10
#> Write a function that takes the dataset and the abbreviate month as arguments
#> and creates a scatter and line plot of actual temperature (y axis) by date (x axis)
#> filtered for that particular month.
#> Your ggplot will need both geom_line() and geom_scatter().
#> Use the ggtitle() function to add the month as a title
#> The function should save the plot as "eda/month_name.png"
#> The eda folder has an example of what each plot should look like
#> Call the function in a map or loop to generate graphs for each month


