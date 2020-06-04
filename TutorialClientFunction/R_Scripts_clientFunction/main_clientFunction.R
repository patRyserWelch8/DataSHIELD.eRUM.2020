#'Author: Patricia Ryser-Welch (DataSHIELD Team)
#'Purpose : to do ...
#'Date of Creation : 26/5/2020
#'Date of update:    27/5/2020


source("R_Scripts_clientFunction/clientFunction_client.R")
source("R_Scripts_clientFunction/ds.mean.R")
source("R_Scripts_clientFunction/ds.factor.R")

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

print("--- factor year publication---")
print(ds.factor(connections,"YearPub", combined =TRUE))
print(ds.factor(connections,"YearPub", combined =FALSE))

print("--- factor words ---")
print(ds.factor(connections,"Words", combined =TRUE))
print(ds.factor(connections,"Words", combined =FALSE))

print("--- foctor Great read score ---")
print(ds.factor(connections,"GreatReadScore", combined =TRUE))
print(ds.factor(connections,"GreatReadScore", combined =FALSE))

print("---Disclosive analysis---")
print("---length London---")
print(connections$get_server("London")$server.length())
print("---length Newcastle---")
print(connections$get_server("Newcastle")$server.length())
print("---length Edinburgh---")
print(connections$get_server("Edinburgh")$server.length())

print("---min London---")
print(connections$get_server("London")$server.min("GreatReadScore"))
print("---min Newcastle---")
print(connections$get_server("Newcastle")$server.min("GreatReadScore"))
print("---min  Edinburgh---")
print(connections$get_server("Edinburgh")$server.min("GreatReadScore"))

print("---max London---")
print(connections$get_server("London")$server.max("GreatReadScore"))
print("---max Newcastle---")
print(connections$get_server("Newcastle")$server.max("GreatReadScore"))
print("---max  Edinburgh---")
print(connections$get_server("Edinburgh")$server.max("GreatReadScore"))

print("---std London---")
print(connections$get_server("London")$server.sd("GreatReadScore"))
print("---std Newcastle---")
print(connections$get_server("Newcastle")$server.sd("GreatReadScore"))
print("---std  Edinburgh---")
print(connections$get_server("Edinburgh")$server.sd("GreatReadScore"))

print ("-- mean edinburgh ---")
print(ds.mean(connections,"GreatReadScore", combined =FALSE))
print("--- let's reconstruct some data ---")
print(mean(c(3.73,3.75,3.75,3.76,3.76)))
print(mean(c(3.73,3.75,3,75,3.76,3.76)))
print(mean(c(3.73,3.73,3.75,3.75,3.76)))
print(sd(c(3.73,3.73,3.75,3.75,3.76)))
