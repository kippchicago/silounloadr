#' Collect tables from TeachBoost
#'
#' @param table_name name of a table from the \code{teachboost} dataset on BigQuery
#' @param collect whether or not table should be pulled into local R session.
#' Default is `FALSE`.
#'
#' @return a data.frame
#' @export
#'

get_teachboost <- function(table_name = 'forms',
                      collect = FALSE){

  #check if bq_parcc exists; if not create it


  if (!exists("bq_teachboost")) {
    connect_to_bq("teachboost")
  } else {
    if (!bigrquery::dbIsValid(dplyr::con_acquire(bq_teachboost))) {
      connect_to_bq("teachboost")
    }
  }

  #SAve below for forthcoming dplry release
  #out <- dplyr:::tbl.src_dbi(bq_deanslist, table_name)

  out <- dplyr::tbl(bq_teachboost, table_name)

  if (collect) {
    out <- dplyr::collect(out)
    names(out) <- tolower(names(out))
  }

  out

}


