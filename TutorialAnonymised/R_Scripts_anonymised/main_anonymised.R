#'Author: Patricia Ryser-Welch (DataSHIELD Team)
#'Purpose : to do ...
#'Date of Creation : 26/5/2020
#'Date of update:    27/5/2020


source("R_Scripts_anonymised/anonymised_client.R")


print("--------------- Disclosive example ----------------")

print("----   Start servers  and connect to servers ------")
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
path.to.data <- "data/anonymised_classic_1.csv"
meta.data <- list("Title","GreatReadScore","Words","YearPub")
connections$upload("Newcastle",path.to.data,meta.data,"classic")

print("London has upload classic 1 datasets")
path.to.data <- "data/anonymised_classic_2.csv"
meta.data <- list("Title","GreatReadScore","Words","YearPub")
connections$upload("London",path.to.data,meta.data,"classic")

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
connections$connect("Edinburgh",Edinburgh.even.less.disclosive)



print("-------------- upload the classic datasets -------------------")
print("Newcastle has upload classic 1 datasets")
path.to.data <- "data/fully_anonymised_classic_1.csv"
meta.data <- list("GreatReadScore","Words","YearPub")
connections$upload("Newcastle",path.to.data,meta.data,"classic")

print("London has upload classic 1 datasets")
path.to.data <- "data/fully_anonymised_classic_2.csv"
meta.data <- list("GreatReadScore","Words","YearPub")
connections$upload("London",path.to.data,meta.data,"classic")

print("Edinbugh has upload classic 1 datasets")
path.to.data <- "data/fully_anonymised_classic_3.csv"
meta.data <- list("GreatReadScore","Words","YearPub")
connections$upload("Edinburgh",path.to.data,meta.data,"classic")


print("----  retrieve some of the data from the servers and display them -----")
print(connections$servers[["Newcastle"]]$datasets[["classic"]]$data)
print(connections$servers[["London"]]$datasets[["classic"]]$data[,c("YearPub","Words","GreatReadScore")])
print(connections$servers[["Edinburgh"]]$datasets[["classic"]]$data[,c("YearPub","Words","GreatReadScore")])


print("-------------- Synthetic data examples ----------------")
print("-----Start servers  and connect to servers ------------")
connections <- Connection$new()
London.synthetic <- connections$start.server()
Newcastle.synthetic <- connections$start.server()
Edinburgh.synthetic <- connections$start.server()

connections$connect("London",London.synthetic)
connections$connect("Newcastle",Newcastle.synthetic)
connections$connect("Edinburgh",Edinburgh.synthetic)


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




