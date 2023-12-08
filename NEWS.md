# aoc.elf (development version)

* Added a `NEWS.md` file to track changes to the package.
* Added `aoc_get()` function which also caches network requests.
* Added `aoc_init()` function which copies Tan's personal AOC RMarkdown template.
* Renamed `aoc_cookie_set()` to `aoc_set_cookie()` and kept backwards compat (v0.0.4)
* Unexported `aoc_cookie()` - for internal use only, really. 
* Added `aoc_set_author()` and configure parameter (v0.0.5)
* Uses `here::here()` instead of `getwd()` because of behaviour inconsistencies.  (v0.0.5)
* `aoc_get()` and `aoc_init()` will now automatically swap year and day args if 
day >= 2015 and year <= 31 (i.e. running `aoc_init(2015,3)` will assume you meant 
year 2015 and day 3). (v0.0.6)
* Drop "setup" chunk name so that I can mass-knit these into one file. (v0.0.7)
* Add `aoc_parse()` to read inputs and automatically parse into a tibble (v0.0.9)
* `aoc_init()` now automatically opens files that already exist when `overwrite = FALSE` (v0.0.10)
* Added hyperlink to the AOC problem description to Rmd template (v0.0.11)
* Added `AOC_TEMPLATE` and `AOC_OPEN` environment variables to allow user to 
provide a custom personal template and configure whether `aoc_init()` and `aoc_get()`
automatically open new pages (v0.0.12)
* Fixed memoise and bumped number scheme (v0.13.0)
* Removed memoise and in favour of refactoring to write call to disk (v0.14.0)
* Add notebook_date plugin to template
