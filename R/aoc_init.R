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
aoc_init <- function(day, year = format(Sys.Date(),"%Y"), path = getwd(),  overwrite = FALSE, open = TRUE){

  fs::dir_create(path, year)

  rmd_path <- file.path(path, year, glue::glue("day-{stringr::str_pad(day,2,'left',pad = '0')}.Rmd"))

  file.copy(system.file("template.Rmd", package = "aoc.elf"), rmd_path, overwrite = overwrite)

  xfun::gsub_file(rmd_path, pattern = "{$Year}", replacement = year, fixed = TRUE)
  xfun::gsub_file(rmd_path, pattern = "{$Day}", replacement = stringr::str_pad(day,2,'left',pad = '0'),
                  fixed = TRUE)
  xfun::gsub_file(rmd_path, pattern = "{$args}", replacement = glue::glue("day = {day}, year = {year}"),
                  fixed = TRUE)

  if(interactive() && open == TRUE){
    if(rstudioapi::isAvailable()) rstudioapi::navigateToFile(rmd_path) else file.edit(rmd_path)
  }

  invisible(NULL)
}
