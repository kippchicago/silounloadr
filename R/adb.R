#' Collect table from Alumni BQ mirror
#'
#' @param table_name name of a table in illuminate mirror
#' @param collect if TRUE collect the table locally.
#'
#' @return a dataframe
#' @export

get_alumni_db <- function(table_name, collect = FALSE){

  #check if sil_dbname_alumni_mirror exists; if not create it

  if (!exists("bq_alumni_db")) {
    connect_to_bq("alumni_db")
  } else {
    if (!bigrquery::dbIsValid(dplyr::con_acquire(bq_alumni_db))) {
      connect_to_bq("alumni_db")
    }
  }

  # Sove for forthcoming dplyr release
  #out <- dplyr:::tbl.src_dbi(bq_alumni_db, table_name)
  out <- dplyr::tbl(bq_alumni_db, table_name)

  if (collect) {
    out <- dplyr::collect(out)
    names(out) <- tolower(names(out))
  }

  out

}
