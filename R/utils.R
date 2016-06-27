#' Calculate School or Academic Year from date
#'
#' @param x the date to be parsed
#' @param format one of `long`, `short`, `first_year`, or `second_year`,
#' which are rendered as `SY 2015-2016`, `15-16`, `2015`, or `2016`, respectively,
#' for the 2015-2016 school year.
#' @param date_parser a parser (such as as \code{lubrdiate}'s \code{\link[lubridate]{ymd}} function)
#'
#' @return a character or integer vector
#' @export
#'
#' @examples
#' calc_academic_year('2014-09-15')
calc_academic_year <- function(x,
                               format = "long",
                               date_parser=lubridate::ymd) {

  date_parsed <- date_parser(x) %>% as.POSIXlt()
  out <- date_parsed$year + (date_parsed$mo >= 6) + 1899

  # return SY
  if(format == "long") out <- sprintf("SY %s-%s", out, out+1)

  if(format == "short") {
    out <- sprintf("%s-%s",
                   stringr::str_extract(out, "\\d{2}$"),
                   stringr::str_extract(out+1, "\\d{2}$"))
  }

  if(format == "first_year") out <- out
  if(format == "second_year") out <- out + 1


  out

}


#' Calculate PowerSchool TermId given first year of a school year
#'
#' @param sy First year in a school year (e.g. 2015 for SY 2015-2016)
#' @param quarter the quarter as integer in a year. The default is 0 for
#' the school year's termid.
#'
#' @return a character or integer vector
#' @export
#'
#' @examples
#' calc_ps_termid(2015)
calc_ps_termid <- function(sy,
                           quarter = 0) {
  (sy - 1990)*100 + quarter
}
