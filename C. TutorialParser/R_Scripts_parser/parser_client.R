#'Author: Patricia Ryser-Welch (DataSHIELD Team)
#'Purpose : to do ...
#'Date of Creation : 26/5/2020
#'Date of update:    26/5/2020

# library(ies) required for this script
source("R_Scripts_parser/parser_server.R")
require(readr)
library(R6)

Connection <- R6Class("Connection", 
               private = list
               (
                 .servers = NULL
               ),
               public = list
               (
                          initialize = function()
                          {
                            private$.servers <- list()
                          },
                          start.server = function()
                          {
                            return(Server$new())
                          },
                          connect = function(server.name,server)
                          {
                            stopifnot(is.character(server.name))
                            stopifnot(is.R6(server))
                            private$.servers[[server.name]] <- server
                          },
                          upload = function(server.name, path.to.data, meta.data, dataset.name)
                          {
                            stopifnot(is.character(server.name))
                            stopifnot(file.exists(path.to.data))
                            stopifnot(is.list(meta.data))
                            stopifnot(server.name %in% names(private$.servers))
                            data <- read_csv(path.to.data)
                            private$.servers[[server.name]]$upload(meta.data, data, dataset.name)
                          },
                         use = function(server.name,dataset.name)
                         {
                           stopifnot(is.character(server.name))
                           stopifnot(dataset.name %in% names(private$.servers))
                           private$.servers[[server.name]]$set_dataset(dataset.name)
                         },
                         get_server = function(server.name)
                         {
                              stopifnot(is.character(server.name))
                              stopifnot(server.name %in% names(private$.servers))
                              return(private$.servers[[server.name]])
                         }
             )
)










