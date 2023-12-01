
.onLoad <- function(libname,pkgname){

  .aoc_get_input <<- memoise::memoise(.aoc_get_input)

}

