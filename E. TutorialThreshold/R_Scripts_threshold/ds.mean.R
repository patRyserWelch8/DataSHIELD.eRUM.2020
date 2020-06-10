ds.mean <- function(connections = NULL, variable.name = NULL, combined = FALSE)
{
  outcome <- NULL
  tryCatch(
    {outcome <- .mean(connections, variable.name, combined)},
    warning = function(warning){.warning(warning)},
    error = function(error){.error(error)},
    finally = {return(outcome)}
  )
}


.mean <- function(connections = NULL, variable.name = NULL, combined = FALSE)
{
  stopifnot("Connection" %in% class(connections))
  stopifnot(is.character(variable.name))
  stopifnot(is.logical(combined))
  
  if(combined)
  {
    return(.combined.mean(connections,variable.name))
  }
  else
  {
    return(.split.mean(connections,variable.name))
  }
  
}

.combined.mean <-function(connections, variable.name)
{
  no.servers       <- connections$get_no_servers()
  server.names     <- connections$get_server_names()
  outcome          <- list()
  outcome[["combined"]]
  totals           <- c(rep(0,no.servers))
  no.observations  <- c(rep(0,no.servers))
  for(server in 1:no.servers)
  {
    server.name             <- server.names[server]
    tryCatch({totals[server]  <- connections$get_server(server.name)$server.sum(variable.name)},
             error = function(error){return(0.0)})
    if (totals[server] != 0)
    { 
      no.observations[server] <- connections$get_server(connections$get_server_names()[server])$server.length()
      outcome[[server.name]] <- c(paste ("total:",totals[server]), 
                                  paste("observations :", no.observations[server]))
    }
    else
    {
      outcome[[server.name]] <-  "server warming: disclosive call"
    }
  }
  
  if (sum(no.observations) > 0)
  {
    outcome[["combined"]]  <- sum(totals)/sum(no.observations)
  }
  
  return(outcome)
}

.split.mean <- function(connections, variable.name)
{
  no.servers    <- connections$get_no_servers()
  server.names <- connections$get_server_names()
  outcome       <- list()
  for(server in 1:no.servers)
  {
    server.name          <- server.names[server]
    outcome[[server.name]] <- 0.0
    tryCatch({outcome[[server.name]] <- connections$get_server(server.name)$server.mean(variable.name)},
              error = function(error){return(0.0)})
    if(outcome[[server.name]] == 0.0)
    {
      outcome[[server.name]] <- "server warming: disclosive call"
    }
  }
  return(outcome)
}


.warning <- function(message)
{
  message(paste("ds.mean :",   message ))
}

.error <- function(message)
{
  
  message(paste("ds.mean :",  message ))
}