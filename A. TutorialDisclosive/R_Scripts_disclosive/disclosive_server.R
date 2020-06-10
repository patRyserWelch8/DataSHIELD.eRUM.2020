#'Author: Patricia Ryser-Welch (DataSHIELD Team)
#'Purpose : to do ...
#'Date of Creation : 26/5/2020
#'Date of update:    26/5/2020

# library(ies) required for this script
library(R6)


#Definition of a server class
  
DataSet <- R6Class("DataSet", list(
          meta.data = list(),
          data = data.frame(),
          initialize = function(meta.data, data)
          {
             stopifnot(is.list(meta.data), is.data.frame(data))
             stopifnot(length(meta.data) == ncol(data))
             
             self$meta.data      <- meta.data
             self$data           <- data
             colnames(self$data) <- self$meta.data
          }
))

Server  <- R6Class("Server", list(
           datasets = NULL, 
           initaliaze = function()
           {
             self$datasets <- list()
           },
           upload = function(meta.data, data, name)
           {
             new.dataset <- DataSet$new(meta.data, data)
             self$datasets[[name]] <- new.dataset
           }
  
))