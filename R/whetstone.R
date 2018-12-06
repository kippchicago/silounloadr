#' Collect table from `whetstone` dataset on Big Query
#'
#' @param table_name name of a table from Whetstone dataset
#' @param collect whether or not table should be pulled into local R session.
#' Default is `FALSE`.
#'
#' @return a data.frame
#' @export
#'

get_whetstone <- function(table_name = 'observations',
                         collect = FALSE){

  #check if bq_tntp exists; if not create it


  if (!exists("bq_whetstone")) {
    connect_to_bq("whetstone")
  } else {
    if (!DBI::dbIsValid(bq_whetstone)) {
      connect_to_bq("whetstone")
    }
  }

  #Save for forthcoming dply release
  #out <- dplyr:::tbl.src_dbi(bq_whetstone, table_name)
  out <- dplyr::tbl(bq_whetstone, table_name)

  if (collect) {
    out <- dplyr::collect(out)
    names(out) <- tolower(names(out))
  }

  out

}

