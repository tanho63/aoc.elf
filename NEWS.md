# aoc.elf (development version)

* Added a `NEWS.md` file to track changes to the package.
* Added `aoc_get()` function which also caches network requests.
* Added `aoc_init()` function which copies Tan's personal AOC RMarkdown template.
* Renamed `aoc_cookie_set()` to `aoc_set_cookie()` and kept backwards compat (v0.0.4)
* Unexported `aoc_cookie()` - for internal use only, really. 
* Added `aoc_set_author()` and configure parameter (v0.0.5)
* Uses `here::here()` instead of `getwd()` because of behaviour inconsistencies.  (v0.0.5)
