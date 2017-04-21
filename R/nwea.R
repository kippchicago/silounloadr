#' Collect table from NWEA
#'
#' @param table_name name of a table from NWEA db
#'
#' @return a data.frame
#' @export
#'

get_nwea <- function(table_name){

  #check if sil_dbname_alumni_mirror exists; if not create it

  if (!exists("silo_dbname_nwea")) connect_to_db("NWEA")
  if (!exists("silo_dbname_nwea")) {
    connect_to_db("NWEA")
  } else {
    if (!RSQLServer::dbIsValid(dplyr::con_acquire(silo_dbname_nwea))) {
      connect_to_db("NWEA")
    }
  }

  out <- dplyr::tbl(silo_dbname_nwea, dplyr::sql(sprintf('SELECT * FROM %s', table_name)))

  out<-dplyr::collect(out)

  #names(out) <- tolower(names(out))

  out

}
