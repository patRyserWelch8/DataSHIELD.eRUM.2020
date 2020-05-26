#'Author: Patricia Ryser-Welch (DataSHIELD Team)
#'Purpose : to do ...
#'Date of Creation : 26/5/2020
#'Date of update:    26/5/2020


source("R_Scripts_disclosive/disclosive_client.R")

print("-------------- Start server -------------------")
start.Server("London")

print("-------------- upload data  -------------------")
upload.great.fire(London)

print ("------------- access the data ----------------")
print (London$datasets[["Great Fire"]]$data$Name)
