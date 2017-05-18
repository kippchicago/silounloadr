#' Collect tables from DeansList
#'
#' @param table_name name of a table from the DeansList Mirror on BigQuery
#' @param collect whether or not table should be pulled into local R session.
#' Default is `FALSE`.
#'
#' @return a data.frame
#' @export
#'

get_deanslist <- function(table_name = 'suspensions',
                      collect = FALSE){

  #check if bq_parcc exists; if not create it


  if (!exists("bq_deanslist")) {
    connect_to_bq("deanslist")
  } else {
    if (!DBI::dbIsValid(bq_deanslist)) {
      connect_to_bq("deanslist")
    }
  }

  #SAve below for forthcoming dplry release
  #out <- dplyr:::tbl.src_dbi(bq_deanslist, table_name)

  out <- dplyr::tbl(bq_deanslist, table_name)

  if (collect) {
    out <- dplyr::collect(out)
    names(out) <- tolower(names(out))
  }

  out

}


