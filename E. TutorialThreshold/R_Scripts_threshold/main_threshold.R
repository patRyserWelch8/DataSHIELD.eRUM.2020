#'Author: Patricia Ryser-Welch (DataSHIELD Team)
#'Purpose : to do ...
#'Date of Creation : 26/5/2020
#'Date of update:    27/5/2020


source("R_Scripts_threshold/threshold_client.R")
source("R_Scripts_threshold/ds.mean.R")
source("R_Scripts_threshold/ds.factor.R")

print("-------------- Start servers  and connect to servers -------------------")
connections <- Connection$new()
London. <- connections$start.server()
Newcastle. <- connections$start.server()
Edinburgh. <- connections$start.server()

connections$connect("London",London.)
connections$connect("Newcastle",Newcastle.)
connections$connect("Edinburgh",Edinburgh.)

print("-------------- upload the classic datasets -------------------")
meta.data <- list("GreatReadScore","Words","YearPub","Type")
path.to.data <- "data/fully_anonymised_classic_1.csv"
connections$upload("Newcastle",path.to.data,meta.data,"classic")
path.to.data <- "data/fully_anonymised_classic_2.csv"
connections$upload("London",path.to.data,meta.data,"classic")
path.to.data <- "data/fully_anonymised_classic_3.csv"
connections$upload("Edinburgh",path.to.data,meta.data,"classic")

connections$get_server("Newcastle")$set_dataset("classic")
connections$get_server("London")$set_dataset("classic")
connections$get_server("Edinburgh")$set_dataset("classic")

print("-- classes of fields")
print(connections$get_server("Newcastle")$server.class("Type"))
print(connections$get_server("Newcastle")$server.class("YearPub"))
print(connections$get_server("Newcastle")$server.class("Words"))
print(connections$get_server("Newcastle")$server.class("GreatReadScore"))

print("--- foctor Great read score ---")
print(ds.factor(connections,"Type", combined =TRUE))
print(ds.factor(connections,"Type", combined =FALSE))

print("--- foctor Great read score ---")
print(ds.factor(connections,"GreatReadScore", combined =TRUE))
print(ds.factor(connections,"GreatReadScore", combined =FALSE))


print("--- mean year publication---")
print(ds.mean(connections,"YearPub", combined =TRUE))
print(.mean(connections,"YearPub", combined =FALSE))

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



print("--- mean Great read score ---")
print(ds.mean(connections,"Type", combined =TRUE))
print(ds.mean(connections,"Type", combined =FALSE))


