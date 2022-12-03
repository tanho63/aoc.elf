#' Copy Template for Day
#'
#' This function copies the bundled RMarkdown template into a folder within the (current) path, creating a subfolder for the year if necessary and pre-filling variables
#'
#' @param day the day of the puzzle
#' @param year year of puzzle, defaults to current year
#' @param path path to copy template to, defaults to subfolders of current directory
#' @param overwrite overwrite existing file, default to FALSE
#' @param open open file for editing, if RStudio is available
#'
#' @return opens the template
#'
#' @export
aoc_init <- function(day, year = format(Sys.Date(),"%Y"), path = here::here(),  overwrite = FALSE, open = TRUE){

  if(day >= 2015 && year <= 31) {
    cli::cli_alert_info("Swapping day and year, assuming you did not mean to solve day {day} of year {year}!")
    d <- year
    year <- day
    day <- d
  }

  stopifnot(
    is.numeric(day),
    day <=31,
    year >= 2015,
    is.character(path),
    length(path) == 1,
    is.logical(overwrite),
    length(overwrite) == 1,
    is.logical(open),
    length(open) == 1
  )

  fs::dir_create(path, year)

  rmd_path <- file.path(path, year, glue::glue("day-{stringr::str_pad(day,2,'left',pad = '0')}.Rmd"))

  if(fs::file_exists(rmd_path) && !overwrite) {
    warning("File already exists and overwrite = FALSE")
    if(interactive() && open == TRUE){
      if(rstudioapi::isAvailable()) rstudioapi::navigateToFile(rmd_path) else file.edit(rmd_path)
    }
    return(invisible(NULL))
  }
  file.copy(system.file("template.Rmd", package = "aoc.elf"), rmd_path, overwrite = overwrite)

  author <- aoc_author()

  aoc_get_args <- glue::glue("day = {day}, year = {year}")
  padded_day <- stringr::str_pad(day,2,'left',pad = '0')

  xfun::gsub_file(rmd_path, pattern = "{$Year}", replacement = year, fixed = TRUE)
  xfun::gsub_file(rmd_path, pattern = "{$Day}", replacement = padded_day, fixed = TRUE)
  xfun::gsub_file(rmd_path, pattern = "{$Args}", replacement = aoc_get_args, fixed = TRUE)
  xfun::gsub_file(rmd_path, pattern = "{$Author}", replacement = author, fixed = TRUE)

  if(interactive() && open == TRUE){
    if(rstudioapi::isAvailable()) rstudioapi::navigateToFile(rmd_path) else file.edit(rmd_path)
  }

  invisible(NULL)
}
