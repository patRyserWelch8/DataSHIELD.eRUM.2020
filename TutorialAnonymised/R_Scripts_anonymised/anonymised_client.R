#'Author: Patricia Ryser-Welch (DataSHIELD Team)
#'Purpose : to do ...
#'Date of Creation : 26/5/2020
#'Date of update:    26/5/2020

# library(ies) required for this script
source("R_Scripts_anonymised/anonymised_server.R")
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
                      upload = function(server.name, path.to.data, meta.data, dataset.name)
                      {
                        stopifnot(is.character(server.name))
                        stopifnot(file.exists(path.to.data))
                        stopifnot(is.list(meta.data))
                        stopifnot(server.name %in% names(self$servers))
                        data <- read_csv(path.to.data)
                        self$servers[[server.name]]$upload(meta.data, data, dataset.name)
                      }
))










