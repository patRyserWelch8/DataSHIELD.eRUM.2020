#'Author: Patricia Ryser-Welch (DataSHIELD Team)
#'Purpose : to do ...
#'Date of Creation : 26/5/2020
#'Date of update:    27/5/2020


source("R_Scripts_parser/parser_client.R")


print("--------------- Disclosive example ----------------")
print("----   Start servers  and connect to servers ------")
connections <- Connection$new()
London    <- connections$start.server()
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

path.to.data <- "data/classic_2.csv"
meta.data <- list("Title", "Author","GreatReadScore","Words","YearPub")
connections$upload("London",path.to.data,meta.data,"classic")

print("Edinbugh has upload classic 3 datasets")
path.to.data <- "data/classic_3.csv"
meta.data <- list("Title", "Author","GreatReadScore","Words","YearPub")
connections$upload("Edinburgh",path.to.data,meta.data,"classic")



print("----  retrieve some of the data from the servers and display them -----")
print(connections$servers[["Newcastle"]]$datasets[["classic"]]$data)
print(connections$servers[["London"]]$datasets[["classic"]]$data[,c("Author","Title","Words")])
print(connections$servers[["Edinburgh"]]$datasets[["classic"]]$data[,c("Author","Title","Words")])

print("--------------- Less disclosive examples ----------------")
print("-------------- Start servers  and connect to servers -------------------")
connections <- Connection$new()
London.less.disclosive <- connections$start.server()
Newcastle.less.disclosive <- connections$start.server()
Edinburgh.less.disclosive <- connections$start.server()

connections$connect("London",London.less.disclosive)
connections$connect("Newcastle",Newcastle.less.disclosive)
connections$connect("Edinburgh",Edinburgh.less.disclosive)

print("-------------- upload the classic datasets -------------------")
print("Newcastle has upload classic 1 datasets")
path.to.data <- "data/synth_classic_1.csv"
meta.data <- list("GreatReadScore","Words","YearPub")
connections$upload("Newcastle",path.to.data,meta.data,"synth_classic")
path.to.data <- "data/fully_anonymised_classic_1.csv"
connections$upload("Newcastle",path.to.data,meta.data,"classic")

print("London has upload classic 2 datasets")
path.to.data <- "data/synth_classic_2.csv"
meta.data <- list("GreatReadScore","Words","YearPub")
connections$upload("London",path.to.data,meta.data,"synth_classic")
path.to.data <- "data/fully_anonymised_classic_2.csv"
connections$upload("London",path.to.data,meta.data,"classic")


print("Edinbugh has upload classic 3 datasets")
path.to.data <- "data/synth_classic_3.csv"
meta.data <- list("GreatReadScore","Words","YearPub")
connections$upload("Edinburgh",path.to.data,meta.data,"synth_classic")
path.to.data <- "data/fully_anonymised_classic_3.csv"
connections$upload("Edinburgh",path.to.data,meta.data,"classic")

print("----  retrieve some of the data from the servers and display them -----")
print("Dataset 1")
print("Original data:")
print(summary(connections$servers[["Newcastle"]]$datasets[["classic"]]$data[,c("YearPub","Words","GreatReadScore")]))
print("Synthetic data:")
print(summary(connections$servers[["Newcastle"]]$datasets[["synth_classic"]]$data[,c("YearPub","Words","GreatReadScore")]))

print("Dataset 2")
print("Original data:")
print(summary(connections$servers[["London"]]$datasets[["classic"]]$data[,c("YearPub","Words","GreatReadScore")]))
print("Synthetic data:")
print(summary(connections$servers[["London"]]$datasets[["synth_classic"]]$data[,c("YearPub","Words","GreatReadScore")]))

print("Dataset 3")
print("Original data:")
print(summary(connections$servers[["Edinburgh"]]$datasets[["classic"]]$data[,c("YearPub","Words","GreatReadScore")]))
print("Synthetic data:")
print(summary(connections$servers[["Edinburgh"]]$datasets[["synth_classic"]]$data[,c("YearPub","Words","GreatReadScore")]))

print(connections$servers[["Newcastle"]]$datasets[["classic"]]$data[,c("YearPub","Words","GreatReadScore")])
print(connections$servers[["London"]]$datasets[["synth_classic"]]$data[,c("YearPub","Words","GreatReadScore")])
print(connections$servers[["Edinburgh"]]$datasets[["synth_classic"]]$data[,c("YearPub","Words","GreatReadScore")])


print("----- data sets and their meta data and retrieve meta.data -----")
print(connections$get_server("Newcastle")$server.ls())
connections$get_server("Newcastle")$set_dataset("classic")
print(connections$get_server("Newcastle")$server.dim())
print(connections$get_server("Newcastle")$server.mean("Words"))
print(connections$get_server("Newcastle")$server.sd("Words"))




