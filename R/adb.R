#' Collect table from Alumni mirror
#'
#' @param table_name name of a table in illuminate mirror
#'
#' @return a dataframe
#' @export

get_alumni_db <- function(table_name){

  #check if sil_dbname_alumni_mirror exists; if not create it

  if (!exists("bq_alumni_db")) {
    connect_to_bq("alumni_db")
  } else {
    if (!RSQLServer::dbIsValid(bq_alumni_db$con)) {
      connect_to_bq("alumni_db")
    }
  }


  out <- dplyr::tbl(bq_alumni_db, table_name)

  out

}
