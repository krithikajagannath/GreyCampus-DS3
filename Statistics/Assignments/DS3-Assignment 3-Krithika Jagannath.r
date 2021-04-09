#Step 1: Keep rows containing country information and remove the rest of the rows.Apart from the country, you should not be having any other row.
#Import libraries
library(tidyverse)
library(ggpubr)
library(tm)
library(ggplot2)
library(ggpubr)
dataset = read.csv("E:/GreyCampus-DS3/Statistics/Assignments/COVID19.csv")
View(dataset)
attach(dataset)
str(dataset)
summary(dataset)
nrow(dataset)
dataset_country = dataset %>% select(-2)
dataset_country
#Step 2: Calculate the missing percentage of each column using a function.If any column has missing data more than 5%, please remove it. (Do not try this for rows)
row = nrow(dataset_country)
na_count_col = sapply(dataset_country, function(y) sum(length(which(is.na(y)))))
na_count_col = data.frame((na_count_col/row)*100)
na_count_col
new_dataset = dataset_country %>% select(-c(7))
new_dataset

#Step 3: Give a better column name after cleaning your data.
#1.	Create plots for total cases, total death, and total recovery. Explain with a figure for each.
new_dataset$TotalCases = as.numeric(removePunctuation(new_dataset$TotalCases))
new_dataset$TotalDeaths = as.numeric(removePunctuation(new_dataset$TotalDeaths))
new_dataset$TotalRecovered = as.numeric(removePunctuation(new_dataset$TotalRecovered))
as.String(new_dataset$Country.Other)
as.String(new_dataset$TotalDeaths)
as.String(new_dataset$TotalRecovered)
class(new_dataset$Country.Other)
class(new_dataset$TotalDeaths)
class(new_dataset$TotalRecovered)
ggplot(new_dataset, aes(x=new_dataset$Country.Other, y=new_dataset$TotalCases)) +
  geom_bar(stat="identity")
ggplot(new_dataset, aes(x=new_dataset$Country.Other, y=new_dataset$TotalDeaths)) +
  geom_bar(stat="identity")
ggplot(new_dataset, aes(x=new_dataset$Country.Other, y=new_dataset$TotalRecovered)) +
  geom_bar(stat="identity")

#2.	Create a plot to examine the correlation between total cases and total population. Explain if there is any correlation between total cases and total population

new_dataset$Population = as.numeric(removePunctuation(new_dataset$Population))
class(new_dataset$Population)
new_dataset$TotalCases = as.numeric(removePunctuation(new_dataset$TotalCases))
data_corr = data.frame(new_dataset$Population,new_dataset$TotalCases)
data_corr
data_corr = na.omit(data_corr)
data_corr
ggscatter(data_corr, x = "new_dataset.Population", y = "new_dataset.TotalCases", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Population", ylab = "Total Cases")
res = cor.test(data_corr$new_dataset.Population, data_corr$new_dataset.TotalCases, 
                method = "pearson")
res1 = cor(data_corr$new_dataset.Population, data_corr$new_dataset.TotalCases, 
            method = "kendall")
res
res1

#3.	Create a plot to examine the correlation between Tot Cases/1M pop and total population. Explain if there is any correlation between them?
new_dataset$Tot.Cases.1M.pop = as.numeric(removePunctuation(new_dataset$Tot.Cases.1M.pop))
class(new_dataset$Tot.Cases.1M.pop)
data_corr_2 = data.frame(new_dataset$Population,new_dataset$Tot.Cases.1M.pop)
data_corr_2
data_corr_2 = na.omit(data_corr_2)
data_corr_2
ggscatter(data_corr_2, x = "new_dataset.Population", y = "new_dataset.Tot.Cases.1M.pop", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Population", ylab = "Total Cases")
res2 = cor.test(data_corr_2$new_dataset.Population, data_corr_2$new_dataset.Tot.Cases.1M.pop, 
                 method = "pearson")
res3 = cor(data_corr_2$new_dataset.Population, data_corr_2$new_dataset.Tot.Cases.1M.pop, 
            method = "kendall")
res2
res3


#5.	Create a plot to examine the correlation between total cases and total death. Explain the figure.
class(new_dataset$TotalCases)
class(new_dataset$TotalDeaths)
data_corr_3 = data.frame(new_dataset$TotalCases,new_dataset$TotalDeaths)
data_corr_3
data_corr_3 = na.omit(data_corr_3)
data_corr_3
ggscatter(data_corr_3, x = "new_dataset.TotalCases", y = "new_dataset.TotalDeaths", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Population", ylab = "Total Cases")
res4 = cor.test(data_corr_3$new_dataset.TotalCases, data_corr_3$new_dataset.TotalDeaths, 
                 method = "pearson")
res5 = cor(data_corr_3$new_dataset.TotalCases, data_corr_3$new_dataset.TotalDeaths, 
            method = "kendall")
res4
res5

#6.	Create a plot to examine the correlation between total cases and Deaths/1M pop. Explain the figure. Which column is more suitable to compare the result, total death or Death/1Mpop?
new_dataset$Deaths.1M.pop = as.numeric(removePunctuation(new_dataset$Deaths.1M.pop))
class(new_dataset$Deaths.1M.pop)
data_corr_4 = data.frame(new_dataset$TotalCases, new_dataset$Deaths.1M.pop)
data_corr_4
data_corr_4 = na.omit(data_corr_4)
data_corr_4
ggscatter(data_corr_4, x = "new_dataset.TotalCases", y = "new_dataset.Deaths.1M.pop", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Population", ylab = "Total Cases")
res6 = cor.test(data_corr_4$new_dataset.TotalCases, data_corr_4$new_dataset.Deaths.1M.pop, 
                 method = "pearson")
res7 = cor(data_corr_4$new_dataset.TotalCases, data_corr_4$new_dataset.Deaths.1M.pop, 
            method = "kendall")
res6
res7

#7.	Compare Tot Cases/1M pop by continent, and explain your result. 
class(new_dataset$Tot.Cases.1M.pop)
class(new_dataset$Continent)
dataset1 = data.frame(new_dataset$Tot.Cases.1M.pop,new_dataset$Continent)
dataset1 = na.omit(dataset1)
dataset1 = subset(dataset1,new_dataset.Continent!="All")
dataset1
ggplot(data=dataset1, aes(x=new_dataset.Continent,y=new_dataset.Tot.Cases.1M.pop)) +
  geom_bar(fill="#DD8888", width=.8, stat="identity") +
  guides(fill=FALSE) +
  xlab("Continent") + ylab("Total cases per 1M pop") +
  ggtitle("Total Cases / 1M by continent")

#8.	Compare Deaths/1M pop by continent, and explain your result. 
class(new_dataset$Deaths.1M.pop)
class(new_dataset$Continent)
dataset2 = data.frame(new_dataset$Deaths.1M.pop,new_dataset$Continent)
dataset2 = na.omit(dataset2)
dataset2 = subset(dataset2,new_dataset.Continent!="All")
dataset2
ggplot(data=dataset2, aes(x=new_dataset.Continent,y=new_dataset.Deaths.1M.pop)) +
  geom_bar(fill="#DD8888", width=.8, stat="identity") +
  guides(fill=FALSE) +
  xlab("Continent") + ylab("Total deaths per 1M pop") +
  ggtitle("Total deaths / 1M by continent")

#9.	Which country is best among testing the COVID19 and which country is worst? There are two columns total test vs. test/M. Choose appropriate column. 
class(new_dataset$Country.Other)
class(new_dataset$Tests.1M.pop)
dataset3 = data.frame(new_dataset$Country.Other,new_dataset$Tests.1M.pop)
dataset3 = na.omit(dataset3)
dataset3
ggplot(data=dataset3, aes(x=new_dataset.Country.Other,y=new_dataset.Tests.1M.pop)) +
  geom_bar(fill="#DD8888", width=.8, stat="identity") +
  guides(fill=FALSE) +
  xlab("Country") + ylab("Total tests per 1M pop") +
  ggtitle("Total tests / 1M by country")
v1 = max(dataset3$new_dataset.Tests.1M.pop)
v2 = min(dataset3$new_dataset.Tests.1M.pop)
a1 = filter(dataset3,new_dataset.Tests.1M.pop == v1 )
a1$new_dataset.Country.Other
a2 = filter(dataset3,new_dataset.Tests.1M.pop == v2 )
a2$new_dataset.Country.Other



#10.	Compare your COVID19 test results by continent? There are two columns total test vs test/M. Choose appropriate column. 
class(new_dataset$Continent)
class(new_dataset$Tests.1M.pop)
dataset4 = data.frame(new_dataset$Continent,new_dataset$Tests.1M.pop)
dataset4 = na.omit(dataset4)
dataset4
con1 = sum(filter (dataset4,new_dataset.Continent == "Africa")$new_dataset.Tests.1M.pop)
con2 = sum(filter (dataset4,new_dataset.Continent == "Australia/Oceania")$new_dataset.Tests.1M.pop)
con3 = sum(filter (dataset4,new_dataset.Continent == "South America")$new_dataset.Tests.1M.pop)
con4 = sum(filter (dataset4,new_dataset.Continent == "Asia")$new_dataset.Tests.1M.pop)
con5 = sum(filter (dataset4,new_dataset.Continent == "Europe")$new_dataset.Tests.1M.pop)
con6 = sum(filter (dataset4,new_dataset.Continent == "North America")$new_dataset.Tests.1M.pop)
min(con1,con2,con3,con4,con5,con6)
max(con1,con2,con3,con4,con5,con6)


#11.	Check if Tests/1M pop is skewed or normally distributed.
new_dataset$Tests.1M.pop = as.numeric(removePunctuation(new_dataset$Tests.1M.pop))
ggdensity(new_dataset$Tests.1M.pop, main = "Density Plot", xlab="Tests per 1M population")
ggqqplot(new_dataset$Tests.1M.pop)
shapiro.test(new_dataset$Tests.1M.pop)
qqnorm(new_dataset$Tests.1M.pop)
qqline(new_dataset$Tests.1M.pop)
hist(new_dataset$Tests.1M.pop, 100,col="black")