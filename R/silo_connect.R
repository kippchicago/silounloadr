#' Create connection to Silo warehouse and return object to global environment
#'
#' @param db_name database name which will be connected to.
#'
#' @description This makes a connection to Silo via `RSQLServer`.  This call requires
#' that system environment variable for Silo are set (typically with a an `.Renviron`
#' file in the users home directory that is sourced when R is started).  This
#' function is called for it's side effect: createing a connection object for
#' the named database that can be used by `dplyr` calls in other functions in
#' this package.
#'
#' @return a
#' @export
#'
#' @examples
#'
#' connect_to_db('Alumni_mirror')
#'
connect_to_db <- function(db_name) {

  db_name <- sprintf("SILO_DBNAME_%s",
                     toupper(db_name))


  host <- Sys.getenv("SILO_URL")
  port <- Sys.getenv("SILO_PORT")
  user <- Sys.getenv("SILO_USER")
  pwd <- Sys.getenv("SILO_PWD")
  db <- Sys.getenv(db_name)

  connection_name <- tolower(db_name)

  #conn <- RSQLServer::src_sqlserver(server = host,
  #                         database = db,
  #                         properties = list(user = user,
  #                                           password = pwd)
  #                         )

  conn <- DBI::dbConnect(RSQLServer::SQLServer(),
                         server = host,
                                    database = db,
                                    properties = list(user = user,
                                                      password = pwd)
  )

  # Using a call to global so that this connection object is only made once
  # and is available for all get_* functions
  do.call("<<-", list(connection_name, conn))
}
