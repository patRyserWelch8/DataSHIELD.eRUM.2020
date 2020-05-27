#'Author: Patricia Ryser-Welch (DataSHIELD Team)
#'Purpose : to do ...
#'Date of Creation : 26/5/2020
#'Date of update:    26/5/2020

# library(ies) required for this script
source("R_Scripts_disclosive/disclosive_server.R")
require(readr)
library(R6)

Connection <- R6Class("Connection", list(
                      servers = NULL,
                      initaliaze = function()
                      {
                        self$server <- list()
                      },
                      start.server = function()
                      {
                        return(Server$new())
                      },
                      connect = function(server.name,server)
                      {
                        stopifnot(is.character(server.name))
                        stopifnot(is.R6(server))
                        self$servers[[server.name]] <- server
                      },
                      upload = function(server, path.to.data, meta.data, dataset.name)
                      {
                        stopifnot(file.exists(path.to.data))
                        stopifnot(is.list(meta.data))
                        data <- read_csv(path.to.data)
                        server$upload(meta.data, data, dataset.name)
                      }
))







upload.classic.1 <- function(a.server)
{
  data <- read_csv("data/classic_1.csv")
  meta.data <- list("Title", "Author","GreatReadScore","Words","YearPub")
  a.server$upload(meta.data, data, "Classic_1")
}


upload.classic.2 <- function(a.server)
{
  data <- read_csv("data/classic_2.csv")
  meta.data <- list("Title", "Author","GreatReadScore","Words","YearPub")
  a.server$upload(meta.data, data, "Classic_2")
}

upload.classic.3 <- function(a.server)
{
  data <- read_csv("data/classic_3.csv")
  meta.data <- list("Title", "Author","GreatReadScore","Words","YearPub")
  a.server$upload(meta.data, data, "Classic_3")
}



