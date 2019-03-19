#' Collect table from `mart_students_attendance` dataset on Big Query
#'
#' @param table_name name of a table from bq_mart_students_attendance dataset
#' @param collect whether or not table should be pulled into local R session.
#' Default is `FALSE`.
#'
#' @return a data.frame
#' @export
#'

get_mart_students_attendance <- function(table_name = 'membership_attendance_students',
                          collect = FALSE){

  #check if bq_tntp exists; if not create it


  if (!exists("bq_mart_students_attendance")) {
    connect_to_bq("mart_students_attendance")
  } else {
    if (!DBI::dbIsValid(bq_mart_students_attendance)) {
      connect_to_bq("mart_students_attendance")
    }
  }

  #Save for forthcoming dply release

  out <- dplyr::tbl(bq_mart_students_attendance, table_name)

  if (collect) {
    out <- dplyr::collect(out)
    names(out) <- tolower(names(out))
  }

  out

}


#' Collect table from `mart_students_attendance` dataset on Big Query
#'
#' @param table_name name of a table from bq_mart_students_attendance dataset
#' @param collect whether or not table should be pulled into local R session.
#' Default is `FALSE`.
#'
#' @return a data.frame
#' @export
#'

get_mart_students_attrition <- function(table_name = 'transfers_by_month',
                                         collect = FALSE){

  #check if bq_tntp exists; if not create it


  if (!exists("bq_mart_students_attrition")) {
    connect_to_bq("mart_students_attrition")
  } else {
    if (!DBI::dbIsValid(bq_mart_students_attrition)) {
      connect_to_bq("mart_students_attrition")
    }
  }

  #Save for forthcoming dply release

  out <- dplyr::tbl(bq_mart_students_attrition, table_name)

  if (collect) {
    out <- dplyr::collect(out)
    names(out) <- tolower(names(out))
  }

  out

}


