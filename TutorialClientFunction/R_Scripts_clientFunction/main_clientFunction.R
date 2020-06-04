#'Author: Patricia Ryser-Welch (DataSHIELD Team)
#'Purpose : to do ...
#'Date of Creation : 26/5/2020
#'Date of update:    27/5/2020


source("R_Scripts_clientFunction/clientFunction_client.R")
source("R_Scripts_clientFunction/ds.mean.R")

print("-------------- Start servers  and connect to servers -------------------")
connections <- Connection$new()
London. <- connections$start.server()
Newcastle. <- connections$start.server()
Edinburgh. <- connections$start.server()

connections$connect("London",London.)
connections$connect("Newcastle",Newcastle.)
connections$connect("Edinburgh",Edinburgh.)

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

connections$get_server("Newcastle")$set_dataset("classic")
connections$get_server("London")$set_dataset("classic")
connections$get_server("Edinburgh")$set_dataset("classic")

print("--- mean year publication---")
print(ds.mean(connections,"YearPub", combined =TRUE))
print(ds.mean(connections,"YearPub", combined =FALSE))

print("--- mean words ---")
print(ds.mean(connections,"Words", combined =TRUE))
print(ds.mean(connections,"Words", combined =FALSE))

print("--- mean Great read score ---")
print(ds.mean(connections,"GreatReadScore", combined =TRUE))
print(ds.mean(connections,"GreatReadScore", combined =FALSE))

