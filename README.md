
<!-- README.md is generated from README.Rmd. Please edit that file -->

# aoc.elf

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg?style=flat-square)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Dev
status](https://img.shields.io/github/r-package/v/tanho63/aoc.elf/master?label=version&style=flat-square&logo=github)](https://github.com/tanho63/aoc.elf)
<!-- badges: end -->

The goal of aoc.elf is to provide helper functions for [Advent of
Code](https://adventofcode.com) solutions in R.

## Installation

You can install aoc.elf with:

``` r
remotes::install_github("tanho63/aoc.elf")
```

## Usage

Configuration options are set with environment variables AOC\_COOKIE and
AOC\_AUTHOR. You can also use the following helper functions:

``` r
aoc_set_cookie(cookie = "{COOKIE}")
aoc_set_author(author = "{AUTHOR}")
```

You can find the cookie value here ![](https://i.imgur.com/IHEBzAe.png)
in your network tab.

Alternatively, you can set AOC\_COOKIE and AOC\_AUTHOR environment
variables in your project’s .Renviron file (this should be a bit more
persistent).

It’s important to have an .Rproj file at the top level of your AOC
folder, the functions rely on that structure to build the subfolder for
each year.

``` r
aoc_init(2) 
```

will create a new RMD template for day 2 of the current year. Can also
specify year, path, overwrite, and open.

``` r
aoc_get(2)
```

will download and cache inputs for the specified day/year. The template
has a chunk with this pre-filled, so you can just run that chunk inside
the notebook! (You can also specify year, path, overwite here.)

## Code of Conduct

Please note that the aoc.elf project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
