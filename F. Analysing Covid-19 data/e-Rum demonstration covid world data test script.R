#accessed data from https://data.europa.eu/euodp/en/data/dataset/covid-19-coronavirus-data/resource/55e8f966-d5c8-438e-85bc-c7a5a26f4863
# on Monday 08/06/20

###this code, and its #comments, are designed to be run line by line, as an investigation, not in large chunks.
#install packages
install.packages('DSI')
install.packages('DSOpal')
install.packages('DSLite')
install.packages('dsBaseClient', repos='http://cran.obiba.org', type='source')

#load libraries
library(DSI)
library(DSOpal)
library(dsBaseClient)

#login
builder <- DSI::newDSLoginBuilder()

builder$append(server = "africa",  url = "http://192.168.56.100:8080/",
               user = "administrator", password = "datashield_test&",
               table = "COVID19.COVID19_geographic_distribution_1_africa", driver = "OpalDriver")
builder$append(server = "america", url = "http://192.168.56.100:8080/",
               user = "administrator", password = "datashield_test&",
               table = "COVID19.COVID19_geographic_distribution_2_america", driver = "OpalDriver")
builder$append(server = "asia", url = "http://192.168.56.100:8080/",
               user = "administrator", password = "datashield_test&",
               table = "COVID19.COVID19_geographic_distribution_3_asia", driver = "OpalDriver")
builder$append(server = "europe", url = "http://192.168.56.100:8080/",
               user = "administrator", password = "datashield_test&",
               table = "COVID19.COVID19_geographic_distribution_4_europe", driver = "OpalDriver")
builder$append(server = "oceania", url = "http://192.168.56.100:8080/",
               user = "administrator", password = "datashield_test&",
               table = "COVID19.COVID19_geographic_distribution_5_oceania", driver = "OpalDriver")

logindata <- builder$build()

connections <- DSI::datashield.login(logins = logindata, assign = TRUE, symbol = "D")
#############finished logging in ##################



################how big is our dataset?
ds.dim(x = 'D')
#what types of data can we investigate?
ds.colnames(x='D')
ds.class(x='D$dateRep')
ds.class(x='D$day')
ds.class(x='D$month')
ds.class(x='D$year')
ds.class(x='D$cases')
ds.class(x='D$deaths')
ds.class(x='D$countriesAndTerritories')
ds.class(x='D$geoId')
ds.class(x='D$countryterritoryCode')
ds.class(x='D$popData2018')
ds.class(x='D$continentExp')

############################################## How to portray the cases data over time?
?ds.scatterPlot()
#scatter plot for cases over the entire dataset: 
ds.scatterPlot("D$day","D$cases")

  # Doesn't work well; overlaying; no differentiation between nodes.
# can we isolate data for just one day?
#first isolate month
ds.dataFrameSubset(df.name="D", V1.name = "D$month", V2.name = "4", Boolean.operator = "==", newobj = "April.subset", datasources = connections)
#then isolate a random day
ds.dataFrameSubset(df.name="April.subset", V1.name = "April.subset$day", V2.name = "30", Boolean.operator = "==", newobj = "April30th", datasources = connections)
# how to cause disclosure error? Can't isolate a country as they don't occur on all servers

#find out what levels "month" is made of:
ds.levels(x="D$month")
# So, split into month by month, then plot cases against day of month. 
ds.dataFrameSubset(df.name="D", V1.name = "D$month", V2.name = "1", Boolean.operator = "==", newobj = "January.subset", datasources = connections)
ds.dataFrameSubset(df.name="D", V1.name = "D$month", V2.name = "2", Boolean.operator = "==", newobj = "February.subset", datasources = connections)
ds.dataFrameSubset(df.name="D", V1.name = "D$month", V2.name = "3", Boolean.operator = "==", newobj = "March.subset", datasources = connections)
ds.dataFrameSubset(df.name="D", V1.name = "D$month", V2.name = "4", Boolean.operator = "==", newobj = "April.subset", datasources = connections)
ds.dataFrameSubset(df.name="D", V1.name = "D$month", V2.name = "5", Boolean.operator = "==", newobj = "May.subset", datasources = connections)
ds.dataFrameSubset(df.name="D", V1.name = "D$month", V2.name = "6", Boolean.operator = "==", newobj = "June.subset", datasources = connections)
# Check it has worked by seeing dimensions have changed:
ds.dim("January.subset")
ds.dim("February.subset")
ds.dim("March.subset")
ds.dim("April.subset")
ds.dim("May.subset")
ds.dim("June.subset")



#################################################### Creating the Scatter Plots
#scatter plots of cases over time, per month

ds.scatterPlot("January.subset$day","January.subset$cases") #creates datashield.errors, so run them:
datashield.errors()                           ## disclosive 
ds.scatterPlot("February.subset$day","February.subset$cases") ## successfully plots (as do all below)
ds.scatterPlot("March.subset$day","March.subset$cases")             ## note the very different y scales
ds.scatterPlot("April.subset$day","April.subset$cases")
ds.scatterPlot("May.subset$day","May.subset$cases")
ds.scatterPlot("June.subset$day","June.subset$cases")


ds.colnames(x="January.subset") # to remind what the column name is for deaths: it's just "deaths"! (no change from server-side object x="D")

# Scatter plots of deaths over time
ds.scatterPlot("January.subset$day","January.subset$deaths") ## disclosive
ds.scatterPlot("February.subset$day","February.subset$deaths") ## disclosive # doesn't plot like cases in February did, as fewer datapoints for people dying in the relatively early month of February
ds.scatterPlot("March.subset$day","March.subset$deaths")    ## successfully plots!   
ds.scatterPlot("April.subset$day","April.subset$deaths")   ## again note the very different y scales
ds.scatterPlot("May.subset$day","May.subset$deaths")
ds.scatterPlot("June.subset$day","June.subset$deaths")    #error, so investigate...
datashield.errors()          #disclosive
ds.scatterPlot("June$day", "June$deaths", method="probabilistic")  ### uses different method to plot, however now some numbers are sub-zero!



# Is it fair to compare a large continent like Asia with a small continent like Oceania? Are we giving countries like New Zealand too much praise?
# Firstly, scale for the average size of the country in the continent, the
ds.colnames(x="D")
# "popData2018" column.
# We will be dividing by some very large numbers;
ds.quantileMean("D$popData2018", type = "split")
# in the order of hundreds of millions for asia.
# So we can present case numbers in terms of cases per million population of each country:
# can apply this using ds.make()
#ds.make() is an assign type function. It creates an object that gets stored on the server-side. We cannot directly view it. But we can do some functions on it that investigate its properties, and we can use it for other things like plotting.
?ds.make()                      # to view the help, which arguments to use for what.
ds.make(toAssign = "(1*10^6)*D$cases/D$popData2018", newobj = "Population_scaled_cases", datasources = connections)
# this is an assign function so it was created on the server side.
ds.scatterPlot("D$day", "Population_scaled_cases")             # we're not separating the months, instead seeing the worst cases across all months stand out.
ds.mean(x="Population_scaled_cases")
# what we can see is that europe comes in "worst", with cases in the order of x10^3 for some case numbers in some countries.
# Asia, Africa, and America are all around the x10^2 magnitude
# Oceania is still doing the best with none being greater than x10^1 magnitude.



# This plot is still not the best it could be. The spread of possible case numbers is clearly not normally distributed,
# it is highly clustered towards the zero lower bound end and very dispersed at the upper end of case numbers.
# It could be replotted with a logged y axis.
?ds.log()
ds.make(toAssign = "log(Population_scaled_cases)", newobj = "Population_log_scaled_cases_dsmake", datasources = connections)
ds.scatterPlot("D$day", "Population_log_scaled_cases_dsmake")
# errors??
ds.mean(x="Population_log_scaled_cases_dsmake")
#alternative method using function "ds.log":
ds.log(x="Population_scaled_cases", newobj = "Population_log_scaled_cases", datasources = connections)
ds.scatterPlot("D$day", "Population_log_scaled_cases")
datashield.errors() # errors??
ds.mean(x="Population_log_scaled_cases",datasources = connections)
# still errors... for now. Wait for Paul's comments.



# The final step is to compare the continents in terms of central tendency and spread. 
# We will do this using the assumption that non-normally distributed data can be sqrt-transformed to become normally distributed.
# if log isn't working, above, use square root transformation method:
ds.mean(x="Population_scaled_cases", datasources= connections)
ds.make(toAssign = "(Population_scaled_cases)^0.5", newobj = "Population_sqrt_scaled_cases", datasources = connections)
#check it has created values in sensible range...
ds.mean(x="Population_sqrt_scaled_cases", datasources= connections)
ds.scatterPlot("D$day", "Population_sqrt_scaled_cases") # IT FLIPPIN WORKS!
### notice the clustering has changed a lot




# now find mean and sd.
ds.mean(x="Population_sqrt_scaled_cases", datasources= connections)
?ds.var()
ds.var(x="Population_sqrt_scaled_cases", datasources= connections)



# Can we extract the key values to plot this locally in RStudio?
ds.mean(x="Population_sqrt_scaled_cases", datasources= connections)[[1]][[1,1]] # extracts the mean for africa
ds.var(x="Population_sqrt_scaled_cases", datasources= connections)[[1]][[1,1]] # extracts the var for africa
#assign them to local variables for ease of reading
a<-ds.mean(x="Population_sqrt_scaled_cases", datasources= connections)[[1]][[1,1]] # extracts the mean for cases in africa
b<-ds.var(x="Population_sqrt_scaled_cases", datasources= connections)[[1]][[1,1]] # extracts the variance for cases in africa
c<-sqrt(ds.var(x="Population_sqrt_scaled_cases", datasources= connections)[[1]][[1,1]]) # calculated the standard deviation for cases in africa

#visualise this result: where the number of cases previously appeared up the y axis, now they appear along the x axis, with the normal density plotted against them.
?plot
par(mfrow=c(1,1))
plot(seq(-5,10,by=0.01),dnorm(seq(-5,10,by=0.01),mean=a , c), xlab="Square root-transformed number of cases in Africa",ylab="Normal density curve for mean = 0.9830229 and standard deviation = 0.706878", type="l")
?abline
abline(v=0, col="red")
abline(v=c(a,a+c,a+2*c),col="blue")
#how to create shaded area?
# source for solution: https://stackoverflow.com/questions/15975653/shading-certain-area-in-r
?polygon
install.packages("scales")
library("scales")
my_colors <-alpha(rainbow(6), alpha = 0.35)
polygon(x=c(-10,0,0,-10),y=c(-2,-2,0.3,0.3),col= my_colors)


#at this point, we can't say that our model of the distribution makes much sense. 
#Either
# a) our sqrt transformation didn't work well (although a sqrt transformation would never create negative values...)
#or
# b) the underlying dataset is not normally distributed. This is the more likely one.






#### here: should we tabulate mean and sd for all the other continents? probably not if the underlying data is not the right distribution..
#some prior work:
# compare mean and sd by tabulating in R
ds.mean(x="Population_sqrt_scaled_cases", datasources= connections)
ds.var(x="Population_sqrt_scaled_cases", datasources= connections)
continent_comparisons<- #matrix... see hint below
# https://www.cyclismo.org/tutorial/R/tables.html
#smoke <- matrix(c(51,43,22,92,28,21,68,22,9),ncol=3,byrow=TRUE)
#> colnames(smoke) <- c("High","Low","Middle")
#> rownames(smoke) <- c("current","former","never")
#> smoke <- as.table(smoke)
#> smoke
#High Low Middle
#current   51  43     22
#former    92  28     21
#never     68  22      9



#### Where we could go from here: other things you could take to the analysis:

# keep going and find the mean and standard deviation for all 5 of the continents.
# "prettify" the scatter plots: something not yet introduced in datashield, but is being considered to implement it in the future. With this, we could colour plotted points according to country to visually draw out any particularly high ones.
# could do population scaling/ logging/ fitting to a distribution on a per-month basis, to observe the change in central tendency and spread over time between continents.
# could attempt to plot a line of best fit on a logged graph, which would proves that cases were rising exponentially in real terms...
# could attempt to subset individual countries to see how they compared to the rest of their continent
# could create a scatterplot of deaths/cases ratio against time, to see if it's particularly high in any continent (with possible inferences about worse outcomes for people catching it where this statistic is higher). Again could be split into month-by-month plots.


##### 
# attempt to makescatterplot of deaths/cases ratio against time

ds.assign(toAssign='casesJanuary$deaths/casesJanuary$cases' ,newobj='death_to_case_ratio_January')
ds.assign(toAssign='casesFebruary$deaths/casesFebruary$cases' ,newobj='death_to_case_ratio_February')
ds.assign(toAssign='casesMarch$deaths/casesMarch$cases' ,newobj='death_to_case_ratio_March')
ds.assign(toAssign='casesApril$deaths/casesApril$cases' ,newobj='death_to_case_ratio_April')
ds.assign(toAssign='casesMay$deaths/casesMay$cases' ,newobj='death_to_case_ratio_May')
ds.assign(toAssign='casesJune$deaths/casesJune$cases' ,newobj='death_to_case_ratio_June')

#scatter plots of ratio deaths to cases over time
ds.scatterPlot("casesJanuary$day","death_to_case_ratio_January") ## doesn't plot (read errors)
ds.scatterPlot("casesFebruary$day","death_to_case_ratio_February") ## ERRORS
ds.scatterPlot("casesMarch$day","death_to_case_ratio_March")         ## ERRORS. may have done something wrong.
ds.scatterPlot("casesApril$day","death_to_case_ratio_April")
ds.scatterPlot("casesMay$day","death_to_case_ratio_May")
ds.scatterPlot("casesJune$day","death_to_case_ratio_June")



###what else to do: tabulate data?
# can't see any factor variables that would work well...



##### 
# attempt to isolate single country

#We are interested in the number of cases. What are some summary statistics about that?
#statistical mean alone:


ds.mean(x="D$cases")
#or, quantile levels (including mean):
ds.quantileMean(x='D$cases',type="split")


#find the world average 
ds.quantileMean(x='D$cases',type="combine")


#find how much higher the Americas are than the world average:
#### THIS USES ASSIGN FUNCTIONALITY


ds.assign(toAssign='D$cases-316.70693', newobj='World_cases_normalised')
#check it has normalised:
ds.quantileMean(x='World_cases_normalised')
round(ds.quantileMean(x='World_cases_normalised')[[8]],digits = 5)


ds.quantileMean(x='World_cases_normalised',type="split")
#this shows that cases in the Americas are about 430 above the world average.


#What about just the USA?
#HOW TO ONLY LOOK AT THE STUDY CALLED AMERICA??
ds.mean(x="D$cases", datasources = "connections$america") #no this doesn't work...


ds.assign(toAssign='D$countriesAndTerritories==United_States_of_America', newobj='USA')




### REMEMBER TO LOGOUT!
DSI::datashield.logout(connections)
