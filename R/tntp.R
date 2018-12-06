#' Collect table from `tntp` dataset on Big Query
#'
#' @param table_name name of a table from TNTP dataset
#' @param collect whether or not table should be pulled into local R session.
#' Default is `FALSE`.
#'
#' @return a data.frame
#' @export
#'

get_tntp <- function(table_name = 'items',
                         collect = FALSE){

  #check if bq_tntp exists; if not create it


  if (!exists("bq_tntp")) {
    connect_to_bq("tntp")
  } else {
    if (!DBI::dbIsValid(bq_tntp)) {
      connect_to_bq("tntp")
    }
  }

  #Save for forthcoming dply release
  #out <- dplyr:::tbl.src_dbi(bq_powerschool_ps, table_name)
  out <- dplyr::tbl(bq_tntp, table_name)

  if (collect) {
    out <- dplyr::collect(out)
    names(out) <- tolower(names(out))
  }

  out

}
