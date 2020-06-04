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
    factors       <- connections$get_server(server.name)$server.factor(variable.name)
    all.factors   <- c(all.factors, factors)
  }
  print(all.factors)
  all.factors            <- as.factor(all.factors)
  outcome[["combined"]]  <- as.numeric(levels(all.factors))
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
    server.factor        <- connections$get_server(server.name)$server.factor(variable.name)
    outcome[[server.name]] <- server.factor
  }
  return(outcome)
}
