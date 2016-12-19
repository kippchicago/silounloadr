#' Collect table from PowerSchool_mirror
#'
#' @param table_name name of a table in alumni mirror
#'
#' @return a data.frame
#' @export
#'

get_ps <- function(table_name){

  #check if sil_dbname_alumni_mirror exists; if not create it

  if(!exists("silo_dbname_ps_mirror")) connect_to_db("ps_mirror")
  if (!exists("silo_dbname_ps_mirror")) {
    connect_to_db("PS_mirror")
  } else {
    if (!RSQLServer::dbIsValid(silo_dbname_ps_mirror$obj)) {
      connect_to_db("PS_mirror")
    }
  }


  out <- dplyr::tbl(silo_dbname_ps_mirror, table_name)

  names(out) <- tolower(names(out))

  out

}
