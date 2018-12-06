#' Create connection to BigQuery warehouse and return object to global environment
#'
#' @param dataset_name name in BigQuery project  which will be connected to.
#'
#' @description This makes a connection to BigQuery via `bigrquery`.  This call requires
#' that system environment variable for BigQuery are set (typically with a an `.Renviron`
#' file in the users home directory that is sourced when R is started).  This
#' function is called for it's side effect: createing a connection object for
#' the named database that can be used by `dplyr` calls in other functions in
#' this package.
#'
#' @return a src object
#' @export
#'
#' @examples
#'
#' connect_to_bq('PARCC')
#'
connect_to_bq <- function(dataset_name) {

  dataset_title <- sprintf("bq_%s",
                     toupper(dataset_name))


  project_name <- Sys.getenv("BQ_PROJECT")

  connection_name <- tolower(dataset_title)

  conn <- DBI::dbConnect(bigrquery::bigquery(),
                         project = project_name,
                         dataset = dataset_name,
                         use_legacy_sql = FALSE
                         )

  # Using a call to global so that this connection object is only made once
  # and is available for all get_* functions
  do.call("<<-", list(connection_name, conn))
}
