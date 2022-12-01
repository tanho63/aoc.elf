#' Read to tibble
#'
#' Reads in input lines into a tibble and optionally tries type detection
#' @param convert logical: whether to run `readr::type_convert()` or not
#' @inheritParams aoc_get
#'
#' @export

aoc_read <- function(day, year = format(Sys.Date(),"%Y"), convert = TRUE){
  input <- readLines(here::here(glue::glue("{year}/day-{day}-input.txt")))

  out <- tibble::tibble(x = input)
  if(convert) out <- readr::type_convert(out)
  return(out)
}
