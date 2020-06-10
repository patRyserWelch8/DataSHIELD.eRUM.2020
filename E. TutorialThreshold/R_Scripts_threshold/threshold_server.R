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
            },
            data = function(value)
            {
              if(missing(value))
              {
                return(private$.data)
              }
              else
              {
                stop("data is read only")
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
                colnames(private$.data) <- private$.meta.data
          },
          get_no_observations = function()
          {
              return(nrow(private$.data))
          },
          get_class = function(column.name)
          {
             stopifnot(column.name %in% private$.meta.data) 
             return(class(private$.data[[column.name]]))
          }
))

Server  <- R6Class("Server",
           private = list
           (
               .datasets = NULL,
               .current = NULL,
               .thresholds = NULL
           ),
           public = list
           (
             initialize = function()
             {
               private$.datasets          <- list()
               private$.thresholds        <- list()
               private$.thresholds[["min.length"]] <- 10
               private$.thresholds[["max.factor"]] <- 0.2
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
               private$.current = dataset.name
             },
             server.ls = function()
             {
               return(names(private$.datasets))
             },
             server.dim = function()
             {
               if (!is.null(private$.current))
               {
                 return(private$.datasets[[private$.current]]$meta.data)
               }
               else
               {
                 stop("no dataset has yet to be set.")
               }
             },
             server.class = function(variable)
             {
               stopifnot(!is.null(private$.current)) 
               stopifnot(is.character(variable))
               stopifnot(variable %in% as.vector(private$.datasets[[private$.current]]$meta.data))
               return(private$.datasets[[private$.current]]$get_class(variable))
             },  
             server.mean = function(variable)
             {
                stopifnot(!is.null(private$.current)) 
                stopifnot(is.character(variable))
                if (private$.datasets[[private$.current]]$get_no_observations() > private$.thresholds$min.length)
                {
                  print(class(private$.datasets[[private$.current]]$data[[variable]]))
                  if (is.numeric(private$.datasets[[private$.current]]$data[[variable]]))
                  {
                    return(mean(private$.datasets[[private$.current]]$data[[variable]]))
                  }
                  else
                  {
                    stop("server error. Incorrect type")
                  }
                }
                else
                {
                  stop("server disclosure error")
                }
             },
             server.sum = function(variable)
             {
               stopifnot(!is.null(private$.current)) 
               stopifnot(is.character(variable))
               stopifnot(variable %in% as.vector(private$.datasets[[private$.current]]$meta.data))
               if (private$.datasets[[private$.current]]$get_no_observations() > private$.thresholds$min.length)
               {
                   if(is.numeric(private$.datasets[[private$.current]]$data[[variable]]))
                   {
                      return(sum(private$.datasets[[private$.current]]$data[[variable]]))
                   }
                   else
                   {
                     stop("server error. Incorrect type")
                   }
               }
               else
               {
                 stop("server disclosure warning")
               }
             },
             server.length = function()
             {
               if (!is.null(private$.current))
               {
                 return(private$.datasets[[private$.current]]$get_no_observations())
               }
               else
               {
                 return(0)
               }
             },
             server.sd = function(variable)
             {
               stopifnot(!is.null(private$.current)) 
               stopifnot(is.character(variable))
               stopifnot(variable %in% as.vector(private$.datasets[[private$.current]]$meta.data))
               stopifnot(is.numeric(private$.datasets[[private$.current]]$data[[variable]]))
               return(sd(private$.datasets[[private$.current]]$data[[variable]]))
             },
             server.factor = function(variable)
             {
               stopifnot(!is.null(private$.current)) 
               stopifnot(is.character(variable))
               stopifnot(variable %in% as.vector(private$.datasets[[private$.current]]$meta.data))
               
               factors   <- factor(private$.datasets[[private$.current]]$data[[variable]])
               no.factor <- length(levels(factors))
               ratio     <- no.factor/private$.datasets[[private$.current]]$get_no_observations()
               if (ratio <=  private$.thresholds$max.factor)
               {
                  return(levels(factors))
               }
               else
               {
                 stop("server disclosure error")
               }
             }
           )
)