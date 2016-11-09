#' Collect table from PARCC
#'
#' @param table_name name of a table from PARCC dataset
#' @param collect whether or not table should be pulled into local R session.
#' Default is `FALSE`.
#'
#' @return a data.frame
#' @export
#'

get_parcc <- function(table_name = 'parcc_student_results',
                      collect = FALSE){

  #check if bq_parcc exists; if not create it


  if (!exists("bq_parcc")) {
    connect_to_bq("parcc")
  } else {
    if (!bigrquery::dbIsValid(bq_parcc$con)) {
      connect_to_bq("parcc")
    }
  }


  out <- dplyr::tbl(bq_parcc, table_name)

  if (collect) {
    out <- dplyr::collect(out)
    names(out) <- tolower(names(out))
  }

  out

}
