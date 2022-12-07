#' Get puzzle for day
#'
#' Requires AOC_COOKIE environment variable to be set. Downloads and caches puzzle inputs onto your machine.
#'
#'
#' @param day the day of the puzzle
#' @param year year of puzzle, defaults to current year
#' @param path path to copy template to, defaults to subfolders of current directory
#' @param overwrite overwrite existing file, default to TRUE
#'
#' @return Returns the timestamp, in case you're keen on timing your results.
#'
#' @export
aoc_get <- function(day,
                    year = format(Sys.Date(),"%Y"),
                    path = here::here(),
                    overwrite = TRUE,
                    open = Sys.getenv("AOC_OPEN", unset = "true")
                    ) {

  open <- isTRUE(as.logical(open))

  if(day >= 2015 && year <= 31) {
    cli::cli_alert_info("Swapping day and year, assuming you did not mean to solve day {day} of year {year}!")
    d <- year
    year <- day
    day <- d
  }

  .aoc_check_timestamp(day, year)
  fs::dir_create(path, year)

  cli::cli_process_start("Downloading input for {year}-{day}")
  input <- .aoc_get_input(day, year, aoc_cookie())
  .aoc_write_input(input, path, year, day, overwrite)
  cli::cli_process_done(msg = "Downloading input for {year}-{day} ... done! {Sys.time()}")

  .aoc_view_problem(year = year, day = day, open = open)

  invisible(Sys.time())
}

.aoc_get_input <- function(day, year, cookie){

  x <- httr::GET(
    paste0("https://adventofcode.com/", year, "/day/", day, "/input"),
    httr::user_agent("aoc.elf R package <https://github.com/tanho63/aoc.elf>"),
    cookie)

  httr::stop_for_status(x)

  return(httr::content(x, as = "text"))
}

.aoc_check_timestamp <- function(day, year){

  puzzle_timestamp <- paste0(year,"-12-",day," 12:00:00 AM") |>
    lubridate::as_datetime() |>
    lubridate::force_tz("EST")

  if(puzzle_timestamp > Sys.time()) {
    cli::cli_abort("It's not yet midnight EST on {paste0(year,'-12-',day)} - puzzle not yet available!")
  }
}

.aoc_write_input <- function(input, path, year, day, overwrite, ...){

  input_path <- file.path(path, year, glue::glue("day-{stringr::str_pad(day,2,'left',pad = '0')}-input.txt"))

  if(overwrite) unlink(input_path)

  if(file.exists(input_path)) {
    cli::cli_abort("Existing file found at {input_path} and overwrite set to FALSE!")
  }
  writeLines(input, con = input_path, sep = "")
  writeLines(format(Sys.time(),usetz = TRUE),
             file.path(path, year, glue::glue("day-{stringr::str_pad(day,2,'left',pad = '0')}-timestamp.txt")))
}

.aoc_view_problem <- function(year, day, open){
  url <- glue::glue("https://adventofcode.com/{year}/day/{day}")

  if (open) {
    cli::cli_alert_info("Opening {.url {url}}")
    utils::browseURL(url)
  } else {
    cli::cli_alert_info("View problem at {.url {url}}")
  }
  invisible(url)
}
