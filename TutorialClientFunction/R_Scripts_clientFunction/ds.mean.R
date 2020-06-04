
ds.mean <- function(connections = NULL, variable.name = NULL, combined = FALSE)
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
  totals           <- c(rep(0,no.servers))
  no.observations  <- c(rep(0,no.servers))
  for(server in 1:no.servers)
  {
    server.name             <- server.names[server]
    totals[server]          <- connections$get_server(server.name)$server.sum(variable.name)
    no.observations[server] <- connections$get_server(connections$get_server_names()[server])$server.length()
  }
  
  outcome[["combined"]]  <- sum(totals)/sum(no.observations)
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
    outcome[server.name] <- connections$get_server(server.name)$server.mean(variable.name)
  }
  return(outcome)
}