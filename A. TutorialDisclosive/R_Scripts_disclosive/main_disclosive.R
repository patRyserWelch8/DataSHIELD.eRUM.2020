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
connections$connect("Edinburgh",Edinburgh)


print("-------------- upload the classic datasets -------------------")
print("Newcastle has upload classic 1 datasets")
path.to.data <- "data/classic_1.csv"
meta.data <- list("Title", "Author","GreatReadScore","Words","YearPub")
connections$upload("Newcastle",path.to.data,meta.data,"classic")

print("London has upload classic w datasets")
path.to.data <- "data/classic_2.csv"
meta.data <- list("Title", "Author","GreatReadScore","Words","YearPub")
connections$upload("London",path.to.data,meta.data,"classic")

print("Edinburghhas upload classic 1 datasets")
print("Edinbugh has upload classic 3 datasets")
path.to.data <- "data/classic_3.csv"
meta.data <- list("Title", "Author","GreatReadScore","Words","YearPub")
connections$upload("Edinburgh",path.to.data,meta.data,"classic")



print("----  retrieve some of the data from the servers and display them -----")
print(connections$servers[["Newcastle"]]$datasets[["classic"]]$data)
print(connections$servers[["London"]]$datasets[["classic"]]$data)
print(connections$servers[["Edinburgh"]]$datasets[["classic"]]$data)
#print(connections$servers[["London"]]$datasets[["classic"]]$data[,c("Author","Title","Words")])

