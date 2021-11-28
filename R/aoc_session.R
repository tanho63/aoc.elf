# x <- httr::GET("https://adventofcode.com/2019/day/1/input",
#                aoc_cookie())

#' Set and retrieve AOC session cookie
#'
#' @rdname aoc_cookies
#' @param cookie a character string of the session cookie as found with network tools
#'
#' @return sets AOC_COOKIE environment variable and returns success message
#' @export
aoc_cookie_set <- function(cookie){
  stopifnot(
    is.character(cookie),
    length(cookie) == 1
  )
  Sys.setenv(AOC_COOKIE = cookie)
  cli::cli_alert_success("Successfully set AOC cookie.")
}

#' @rdname aoc_cookies
#' @return an `httr` object that contains a session cookie
#' @export
aoc_cookie <- function(){
  session <- Sys.getenv("AOC_COOKIE")

  if(session==""){
    cli::cli_abort("No session cookie found - please set with {.code aoc_cookie_set()} (and consult the README!)")
  }

  cookie <- httr::set_cookies(session = session)

  return(cookie)
}
