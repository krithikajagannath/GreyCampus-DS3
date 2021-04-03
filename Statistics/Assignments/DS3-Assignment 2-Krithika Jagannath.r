#Assignment 2

#Question 1: The final score of the World Cup finals of football is France  4 and Croatia 2. Please use a control structure to print the results as Team ---- Wins -----.

france = 4
croatia = 2
if(france>croatia)
{
  print(paste("france wins"))
}else{
  print(paste("croatia wins"))
}

#Question 3: Write a function to get the percentage of NAs in each column.
library(tidyverse)
colMeans(is.na(dataset))

#Question 4: Write a function to get the percentage of NAs in each row.
rowMeans(is.na(dataset))

#Question 5: Write a function to get a summary of numeric columns (use the summary function) such as THC, CO, CO2, and so on in the data set. With the same function, try to generate box plot using base R.

boxplot(dataset$THC)
boxplot(dataset$CO)
boxplot(dataset$CO2)

#Question 6: Write a function to create histograms of numeric columns, such as THC, CO, CO2, and so on in the data set. Use ggpot2 to generate figures.

library(ggplot2)
ggplot(dataset, aes(x=THC)) + geom_histogram()
ggplot(dataset, aes(x=CO)) + geom_histogram()  

#Question 7: The data set contains date columns. All of these date columns are untidy. Please create a better formatted data set. The date should be dd/mm/yyyy in the final format. Use columns 2, 3, and 5 only.

dataset = read_csv("Data set2.2.csv")
dates <- c(2,3,5,8)
for (dates  in dates ) {
  dataset[, dates ] = as.Date(dataset[dates ],format, tryFormats = ( "%d/%m/%Y"))
}
?as.Date

#Question 9: Convert all dates into date format; they are currently in character variable format.

dates <- as.Date(dataset, "%m/%d/%Y")
