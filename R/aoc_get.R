#' Get puzzle for day
#'
#' @export
aoc_get <- function(day, year = format(Sys.Date(),"%Y"), path = getwd(), overwrite = TRUE, open = TRUE) {

  .aoc_check_timestamp(day, year)
  fs::dir_create(path, year)

  cli::cli_process_start("Downloading input for {year}-{day}")
  input <- .aoc_get_input(day, year, aoc_cookie())
  .aoc_write_input(input, path, year, day, overwrite)
  cli::cli_process_done(msg = "Downloading input for {year}-{day} ... done! {Sys.time()}")

  return(Sys.time())
}

.aoc_get_input <- function(day, year, cookie){

  x <- httr::GET(
    paste0("https://adventofcode.com/", year, "/day/", day, "/input"),
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

.aoc_write_input <- function(input, path, year,day, overwrite){

  input_path <- file.path(path, year, glue::glue("day-{stringr::str_pad(day,2,'left',pad = '0')}-input.txt"))

  if(overwrite) unlink(input_path)

  if(file.exists(input_path)) {
    cli::cli_abort("Existing file found at {input_path} and overwrite set to FALSE!")
  }
  writeLines(input, con = input_path, sep = "")
}

#' @export
aoc_init <- function(day, year = format(Sys.Date(),"%Y"), path = getwd(),  overwrite = TRUE, open = TRUE){

  fs::dir_create(path, year)

  rmd_path <- file.path(path, year, glue::glue("day-{stringr::str_pad(day,2,'left',pad = '0')}.Rmd"))

  file.copy(system.file("template.Rmd", package = "aoc.elf"), rmd_path, overwrite = overwrite)

  xfun::gsub_file(rmd_path, pattern = "{$Year}", replacement = year, fixed = TRUE)
  xfun::gsub_file(rmd_path, pattern = "{$Day}", replacement = stringr::str_pad(day,2,'left',pad = '0'),
                  fixed = TRUE)
  xfun::gsub_file(rmd_path, pattern = "{$day_int}", replacement = day,
                  fixed = TRUE)
  xfun::gsub_file(rmd_path, pattern = "{$Date}", replacement = Sys.Date(), fixed = TRUE)

  if(interactive() && open == TRUE){
    if(rstudioapi::isAvailable()) rstudioapi::navigateToFile(rmd_path) else file.edit(rmd_path)
  }

  invisible(NULL)
}
