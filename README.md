

<!-- README.md is generated from README.Rmd. Please edit that file -->

# b32

<!-- badges: start -->

[![extendr](https://img.shields.io/badge/extendr-%5E0.8.1-276DC2)](https://extendr.github.io/extendr/extendr_api/)
<!-- badges: end -->

<!-- badges: start -->

[![R-CMD-check](https://github.com/extendr/b32/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/extendr/b32/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

b32 provides fast, vectorized base32 encoding and decoding with zero
dependencies powered by rust 🦀

> [!TIP]
>
> Need base64 instead? Check out
> [`{b64}`](https://github.com/extendr/b64).

## Installation

You can install the development version of b32 like so:

``` r
pak::pak("extendr/b32")
```

## Example

Encode to base32 using `encode()`:

``` r
library(b32)

encoded <- encode(c("Hello", "from", "extendr"))
encoded
#> [1] "91JPRV3F"     "CSS6YV8"      "CNW78SBECHS0"
```

Decode using `decode_as_string()` to get back your original string:

``` r
decode_as_string(encoded)
#> [1] "Hello"   "from"    "extendr"
```

You can also decode to raw vectors with `decode()` which returns a
`"blob"` object. The [`blob`](https://github.com/tidyverse/blob/)
package is only a suggested dependency, but if you attach it, its print
method will be used:

``` r
library(blob)

decode(encoded)
#> <blob[3]>
#> [1] blob[5 B] blob[4 B] blob[7 B]
```
