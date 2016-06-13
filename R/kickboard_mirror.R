#' Collect table from Kickboard db
#'
#' @param table_name name of a table in illuminate mirror
#'
#' @return a dataframe
#' @export

get_kb <- function(table_name){

  #check if sil_dbname_alumni_mirror exists; if not create it

  if(!exists("silo_dbname_kickboard")) connect_to_db("kickboard")

  out <- dplyr::tbl(silo_dbname_kickboard, table_name)

  names(out) <- tolower(names(out))

  out

}
