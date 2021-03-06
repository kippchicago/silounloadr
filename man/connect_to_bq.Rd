% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bigquery_connect.R
\name{connect_to_bq}
\alias{connect_to_bq}
\title{Create connection to BigQuery warehouse and return object to global environment}
\usage{
connect_to_bq(dataset_name)
}
\arguments{
\item{dataset_name}{name in BigQuery project  which will be connected to.}
}
\value{
a src object
}
\description{
This makes a connection to BigQuery via `bigrquery`.  This call requires
that system environment variable for BigQuery are set (typically with a an `.Renviron`
file in the users home directory that is sourced when R is started).  This
function is called for it's side effect: createing a connection object for
the named database that can be used by `dplyr` calls in other functions in
this package.
}
\examples{

connect_to_bq('PARCC')

}
