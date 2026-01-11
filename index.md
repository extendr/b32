# b32

b32 provides fast, vectorized base32 encoding and decoding with zero
dependencies powered by rust 🦀

> \[!TIP\]
>
> Need base64 instead? Check out
> [`{b64}`](https://github.com/extendr/b64).

## Installation

You can install the development version of b32 like so:

``` r
pak::pak("extendr/b32")
```

## Example

Encode to base32 using
[`encode()`](http://extendr.rs/b32/reference/encode.md):

``` r
library(b32)

encoded <- encode(c("Hello", "from", "extendr"))
encoded
#> [1] "91JPRV3F"     "CSS6YV8"      "CNW78SBECHS0"
```

Decode using
[`decode_as_string()`](http://extendr.rs/b32/reference/encode.md) to get
back your original string:

``` r
decode_as_string(encoded)
#> [1] "Hello"   "from"    "extendr"
```

You can also decode to raw vectors with
[`decode()`](http://extendr.rs/b32/reference/encode.md) which returns a
`"blob"` object. The [`blob`](https://github.com/tidyverse/blob/)
package is only a suggested dependency, but if you attach it, its print
method will be used:

``` r
library(blob)

decode(encoded)
#> <blob[3]>
#> [1] blob[5 B] blob[4 B] blob[7 B]
```
