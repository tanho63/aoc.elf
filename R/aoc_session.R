#' Set AOC configuration options
#'
#' @rdname aoc_config
#' @param cookie a character string of the session cookie as found with network tools
#'
#' @return sets environment variable and returns success message
#' @export
aoc_set_cookie <- function(cookie){
  stopifnot(
    is.character(cookie),
    length(cookie) == 1
  )
  Sys.setenv(AOC_COOKIE = cookie)
  cli::cli_alert_success("Successfully set AOC cookie.")
}

#' @noRd
#' @return an `httr` object that contains a session cookie
aoc_cookie <- function(){
  session <- Sys.getenv("AOC_COOKIE")

  if(session==""){
    cli::cli_abort("No session cookie found - please set with {.code aoc_cookie_set()} (and consult the README!)")
  }

  cookie <- httr::set_cookies(session = session)

  return(cookie)
}

#' Set AOC configuration options
#'
#' AOC author will also try to read options("usethis.full_name") for the author's name, if the environment variable is not set.
#'
#' @rdname aoc_config
#' @param author Author name, for template
#'
#' @return sets environment variable and returns success message
#' @export
aoc_set_author <- function(author){
  stopifnot(
    is.character(author),
    length(author) == 1
  )
  Sys.setenv(AOC_AUTHOR = author)
  cli::cli_alert_success("Successfully set AOC author.")
}

#' @noRd
#' @return the configured author, or else tries to use options(usethis.full_name).
aoc_author <- function(){

  author <- Sys.getenv("AOC_AUTHOR")

  if(author=="") author <- getOption("usethis.full_name", default = "AUTHOR")

  if(author=="AUTHOR") cli::cli_alert("Author not yet configured! Configure with `aoc_author_set()` or the AOC_AUTHOR env variable.")

  return(author)
}

#' @noRd
#' @export
aoc_author_set <- aoc_set_author

#' @noRd
#' @export
aoc_cookie_set <- aoc_set_cookie
