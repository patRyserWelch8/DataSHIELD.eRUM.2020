#'Author: Patricia Ryser-Welch (DataSHIELD Team)
#'Purpose : to do ...
#'Date of Creation : 26/5/2020
#'Date of update:    27/5/2020


source("R_Scripts_disclosive/disclosive_client.R")

print("-------------- Start servers  and connect to servers -------------------")
connections <- Connection$new()
London <- connections$start.server()
Newcastle <- connections$start.server()
Edinburgh <- connections$start.server()

connections$connect("London",London)
connections$connect("Newcastle",Newcastle)
connections$connect("Edinburgh",London)



print("-------------- upload all the data in the servers using the connections -------------------")
print("The Great Fire data set is uploaded in the London Server")
path.to.data <- "data/GreatFire.csv"
meta.data <- list("Name","record_ID","Material", "Title","Country_pub", "Place_pub", "Publisher","Date_pub","Pages")
connections$upload("London",path.to.data,meta.data,"GreatFire")

print("The Black history data set is uploaded in the Newcastle Server")
path.to.data <- "data/BritishHistoryCleaned.csv"
meta.data <- list("Name","Country of publication", "Place of publication","Date of publication","Pages","Languages","BMI","BMR")
connections$upload("Newcastle",path.to.data,meta.data,"BlackHistory")



print("-------------- retrieve some of the data from the servers and display data -------------------")
names.great.fires <- connections$servers$London$datasets[["GreatFire"]]$data$Name
print (names.great.fires)

some.authors <- connections$servers$Newcastle$datasets[["BlackHistory"]]$data[, c("Name","Country of publication")]
print(some.authors)
