#' Collect table from Alumni mirror
#'
#' @param table_name name of a table in illuminate mirror
#'
#' @return a dataframe
#' @export

get_alumni <- function(table_name){

  #check if sil_dbname_alumni_mirror exists; if not create it

  if (!exists("silo_dbname_alumni_mirror")) {
    connect_to_db("Alumni_mirror")
  } else {
    if (!RSQLServer::dbIsValid(silo_dbname_alumni_mirror$obj)) {
      connect_to_db("Alumni_mirror")
    }
  }


  out <- dplyr::tbl(silo_dbname_alumni_mirror, table_name)

  names(out) <- tolower(names(out))

  out

}
