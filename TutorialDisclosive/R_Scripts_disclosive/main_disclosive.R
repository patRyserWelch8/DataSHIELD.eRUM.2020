#'Author: Patricia Ryser-Welch (DataSHIELD Team)
#'Purpose : to do ...
#'Date of Creation : 26/5/2020
#'Date of update:    26/5/2020


source("R_Scripts_disclosive/disclosive_client.R")

print("-------------- Start servers -------------------")
start.Server("London")
start.Server("Newcastle")
start.Server("Edinburgh")

print("-------------- upload data Great Fire -------------------")
upload.great.fire(London)

print ("------------- access the data ----------------")
print (London$datasets[["Great Fire"]]$data$Name)

print("-------------- upload data Black history -------------------")
upload.black.history(London)
print (London$datasets[["Black history"]]$data$Name)


print("-------------- upload classic 1 -------------------")
upload.classic.1(Edinburgh)
print (Edinburgh$datasets[["Classic_1"]]$data$Title)


print("-------------- upload classic 2 -------------------")
upload.classic.2(Newcastle)
print (Newcastle$datasets[["Classic_2"]]$data$Title)

print("-------------- upload classic 3 -------------------")
upload.classic.3(London)
print (London$datasets[["Classic_3"]]$data$Title)