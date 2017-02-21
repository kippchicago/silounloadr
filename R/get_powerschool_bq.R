#' Collect table from PowerSchool on Big Query
#'
#' @param table_name name of a table from PowerSchool dataset
#' @param collect whether or not table should be pulled into local R session.
#' Default is `FALSE`.
#'
#' @return a data.frame
#' @export
#'

get_powerschool <- function(table_name = 'students',
                      collect = FALSE){

  #check if bq_parcc exists; if not create it


  if (!exists("bq_powerschool_ps")) {
    connect_to_bq("powerschool_ps")
  } else {
    if (!bigrquery::dbIsValid(dplyr::con_acquire(bq_powerschool_ps))) {
      connect_to_bq("powerschool_ps")
    }
  }


  out <- dplyr:::tbl.src_dbi(bq_powerschool_ps, table_name)

  if (collect) {
    out <- dplyr::collect(out)
    names(out) <- tolower(names(out))
  }

  out

}
