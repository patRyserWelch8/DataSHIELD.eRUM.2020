#'Author: Patricia Ryser-Welch (DataSHIELD Team)
#'Purpose : to do ...
#'Date of Creation : 26/5/2020
#'Date of update:    27/5/2020


source("R_Scripts_anonymised/anonymised_client.R")


print("--------------- Disclosive examples ----------------")
print("-------------- Start servers  and connect to servers -------------------")
connections <- Connection$new()
London <- connections$start.server()
Newcastle <- connections$start.server()
Edinburgh <- connections$start.server()

connections$connect("London",London)
connections$connect("Newcastle",Newcastle)
connections$connect("Edinburgh",London)



print("-------------- upload the classic datasets -------------------")
print("Newcastle has upload classic 1 datasets")
path.to.data <- "data/classic_1.csv"
meta.data <- list("Title", "Author","GreatReadScore","Words","YearPub")
connections$upload("Newcastle",path.to.data,meta.data,"classic")

print("London has upload classic 1 datasets")
path.to.data <- "data/classic_2.csv"
meta.data <- list("Title", "Author","GreatReadScore","Words","YearPub")
connections$upload("Newcastle",path.to.data,meta.data,"classic")

print("Edinbugh has upload classic 1 datasets")
path.to.data <- "data/classic_3.csv"
meta.data <- list("Title", "Author","GreatReadScore","Words","YearPub")
connections$upload("Edinburgh",path.to.data,meta.data,"classic")



print("----  retrieve some of the data from the servers and display them -----")
print(connections$servers[["Newcastle"]]$datasets[["classic"]]$data[,c("Author","Title")])
print(connections$servers[["London"]]$datasets[["classic"]]$data[,c("Author","Title","Words")])

print("--------------- Less disclosive examples ----------------")
print("-------------- Start servers  and connect to servers -------------------")
connections <- Connection$new()
London.less.disclosive <- connections$start.server()
Newcastle.less.disclosive <- connections$start.server()
Edinburgh.less.disclosive <- connections$start.server()

connections$connect("London",London.less.disclosive)
connections$connect("Newcastle",Newcastle.less.disclosive)
connections$connect("Edinburgh",London.less.disclosive)



print("-------------- upload the classic datasets -------------------")
print("Newcastle has upload classic 1 datasets")
path.to.data <- "data/anonymised_classic_1.csv"
meta.data <- list("Title","GreatReadScore","Words","YearPub")
connections$upload("Newcastle",path.to.data,meta.data,"classic")

print("London has upload classic 1 datasets")
path.to.data <- "data/anonymised_classic_2.csv"
meta.data <- list("Title","GreatReadScore","Words","YearPub")
connections$upload("Newcastle",path.to.data,meta.data,"classic")

print("Edinbugh has upload classic 1 datasets")
path.to.data <- "data/anonymised_classic_3.csv"
meta.data <- list("Title","GreatReadScore","Words","YearPub")
connections$upload("Edinburgh",path.to.data,meta.data,"classic")



print("----  retrieve some of the data from the servers and display them -----")
print(connections$servers[["Newcastle"]]$datasets[["classic"]]$data[,c("YearPub","Title")])
print(connections$servers[["London"]]$datasets[["classic"]]$data[,c("YearPub","Title","Words")])
print(connections$servers[["Edinburgh"]]$datasets[["classic"]]$data[,c("YearPub","Title")])



print("-------------- even less disclosive examples ----------------")
print("-------------- Start servers  and connect to servers -------------------")
connections <- Connection$new()
London.even.less.disclosive <- connections$start.server()
Newcastle.even.less.disclosive <- connections$start.server()
Edinburgh.even.less.disclosive <- connections$start.server()

connections$connect("London",London.even.less.disclosive)
connections$connect("Newcastle",Newcastle.even.less.disclosive)
connections$connect("Edinburgh",London.even.less.disclosive)



print("-------------- upload the classic datasets -------------------")
print("Newcastle has upload classic 1 datasets")
path.to.data <- "data/fully_anonymised_classic_1.csv"
meta.data <- list("GreatReadScore","Words","YearPub")
connections$upload("Newcastle",path.to.data,meta.data,"classic")

print("London has upload classic 1 datasets")
path.to.data <- "data/fully_anonymised_classic_2.csv"
meta.data <- list("GreatReadScore","Words","YearPub")
connections$upload("Newcastle",path.to.data,meta.data,"classic")

print("Edinbugh has upload classic 1 datasets")
path.to.data <- "data/fully_anonymised_classic_3.csv"
meta.data <- list("GreatReadScore","Words","YearPub")
connections$upload("Edinburgh",path.to.data,meta.data,"classic")


print("----  retrieve some of the data from the servers and display them -----")
print(connections$servers[["Newcastle"]]$datasets[["classic"]]$data[,c("YearPub","Words","GreatReadScore")])
print(connections$servers[["London"]]$datasets[["classic"]]$data[,c("YearPub","Words","GreatReadScore")])
print(connections$servers[["Edinburgh"]]$datasets[["classic"]]$data[,c("YearPub","Words","GreatReadScore")])

