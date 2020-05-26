#'Author: Patricia Ryser-Welch (DataSHIELD Team)
#'Purpose : to do ...
#'Date of Creation : 26/5/2020
#'Date of update:    26/5/2020

source("R_Scripts_disclosive/disclosive_server.R")
require(readr)

start.Server <- function(a.server.name)
{
  stopifnot(is.character(a.server.name))
  assign(a.server.name, Server$new(), pos=1)
}

upload.great.fire <- function(a.server)
{
  data <- read_csv("data/GreatFire.csv")
  meta.data <- list("Name","record_ID","Material", "Title","Country_pub", "Place_pub", "Publisher","Date_pub","Pages")
  a.server$upload(meta.data, data, "Great Fire")
}