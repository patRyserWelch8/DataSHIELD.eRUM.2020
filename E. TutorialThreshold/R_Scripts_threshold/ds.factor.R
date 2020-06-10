ds.factor <- function(connections, variable.name, combined = FALSE)
{
  stopifnot("Connection" %in% class(connections))
  stopifnot(is.character(variable.name))
  stopifnot(is.logical(combined))
  
  if(combined)
  {
    return(.combined.factor(connections,variable.name))
  }
  else
  {
    return(.split.factor(connections,variable.name))
  }
  
}

.combined.factor <-function(connections, variable.name)
{
  no.servers       <- connections$get_no_servers()
  server.names     <- connections$get_server_names()
  outcome          <- list()
  factors          <- c()
  all.factors      <- c()
  for(server in 1:no.servers)
  {
    server.name   <- server.names[server]
    outcome[[server.name]] <- NULL
    
    tryCatch({outcome[[server.name]] <- connections$get_server(server.name)$server.factor(variable.name)},
             error = function(error){return(0.0)})
    
    if(is.null(outcome[[server.name]]))
    {
      outcome[[server.name]] <- "Server warning: disclosive call"
    }
    else
    {
      all.factors   <- c(all.factors, outcome[[server.name]])
    }
  }
  
  if (length(all.factors) > 0)
  {
    all.factors            <- as.factor(all.factors)
    outcome[["combined"]]  <- levels(all.factors)
  }
  else
  {
    outcome[["combined"]]  <-"all server calls were disclosive"
  }
  return(outcome)
}

.split.factor <- function(connections, variable.name)
{
  no.servers    <- connections$get_no_servers()
  server.names <- connections$get_server_names()
  outcome       <- list()
  for(server in 1:no.servers)
  {
    server.name          <- server.names[server]
    outcome[[server.name]] <- "server warming: disclosive call"
    tryCatch({outcome[[server.name]] <- connections$get_server(server.name)$server.factor(variable.name)},
             error = function(error){return(0.0)})
  }
  return(outcome)
}
