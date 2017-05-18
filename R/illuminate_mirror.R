#' Collect table from Illuminate_mirror
#'
#' @param table_name name of a table in illuminate mirror
#'
#' @return a dataframe
#' @export

get_illuminate_mirror <- function(table_name){

  #check if sil_dbname_alumni_mirror exists; if not create it

  if (!exists("silo_dbname_illuminate_mirror")) {
    connect_to_db("Illuminate_mirror")
  } else {
    if (!DBI::dbIsValid(silo_dbname_illuminate_mirror)) {
      connect_to_db("Illuminate_mirror")
    }
  }

  out <- dplyr::tbl(silo_dbname_illuminate_mirror, table_name)

  out

}
