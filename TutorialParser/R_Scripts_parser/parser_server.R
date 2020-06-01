#'Author: Patricia Ryser-Welch (DataSHIELD Team)
#'Purpose : to do ...
#'Date of Creation : 26/5/2020
#'Date of update:    26/5/2020

# library(ies) required for this script
library(R6)


#Definition of a server class
  
DataSet <- R6Class("DataSet", 
          private = list
          (
            .meta.data = list(),
            .data = data.frame()
          ),
          active = list
          (
            meta.data = function(value)
            {
              if(missing(value)) 
              {
                return(unlist(private$.meta.data))
              }
              else
              {
                stop("meta.data is read only")
              }
            }
          ),
          public = list
          (
            initialize = function(meta.data, data)
            {
                stopifnot(is.list(meta.data), is.data.frame(data))
                stopifnot(length(meta.data) == ncol(data))
             
                private$.meta.data      <- meta.data
                private$.data           <- data
                colnames(private$.data)   <- private$.meta.data
          }
))

Server  <- R6Class("Server",
           private = list
           (
               .datasets = NULL,
               .current = NULL
           ),
           public = list
           (
             initialize = function()
             {
               private$.datasets <- list()
             },
             upload = function(meta.data, data, name)
             {
               new.dataset <- DataSet$new(meta.data, data)
               private$.datasets[[name]] <- new.dataset
             },
             set_dataset = function(dataset.name)
             {
               stopifnot(is.character(dataset.name))
               stopifnot(dataset.name %in% names(private$.datasets))
               private$.current = private$.datasets[[dataset.name]]
             },
             server.ls = function()
             {
               return(names(private$.datasets))
             },
             server.dim = function(dataset.name)
             {
               stopifnot(is.character(dataset.name))
               stopifnot(dataset.name %in% names(private$.datasets))
               return(private$.datasets[[dataset.name]]$meta.data)
             },
             server.mean = function ()
             {
                
             }
           )
)