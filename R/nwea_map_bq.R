#' Collect table from `nwea_map` dataset on Big Query
#'
#' @param table_name name of a table from PowerSchool dataset
#' @param collect whether or not table should be pulled into local R session.
#' Default is `FALSE`.
#'
#' @return a data.frame
#' @export
#'

get_nwea_map <- function(table_name = 'cdf_combined_kipp_cps',
                            collect = FALSE){

  #check if bq_parcc exists; if not create it


  if (!exists("bq_nwea_map")) {
    connect_to_bq("nwea_map")
  } else {
    if (!DBI::dbIsValid(bq_nwea_map)) {
      connect_to_bq("nwea_map")
    }
  }

  #Save for forthcoming dply release
  #out <- dplyr:::tbl.src_dbi(bq_powerschool_ps, table_name)
  out <- dplyr::tbl(bq_nwea_map, table_name)

  if (collect) {
    out <- dplyr::collect(out)
    names(out) <- tolower(names(out))
  }

  out

}
