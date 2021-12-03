
<!-- README.md is generated from README.Rmd. Please edit that file -->

# aoc.elf

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg?style=flat-square)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of aoc.elf is to provide helper functions for [Advent of
Code](https://adventofcode.com)

## Installation

You can install aoc.elf with:

``` r
remotes::install_github("tanho63/aoc.elf")
```

## Usage

Key functions:

``` r
aoc_cookie_set(cookie = "{COOKIE}")
```

You can find the cookie value here <https://i.imgur.com/IHEBzAe.png> in
your network tab. Alternatively set AOC\_COOKIE environment variable in
.Renviron

``` r
aoc_init(day = 2)
```

will create a new RMD template for day two. Can also specify year, path,
overwrite, and open.

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
