# Base32 Encode and Decode

Base32 Encode and Decode

## Usage

``` r
encode(x, alphabet = "crockford", padded = TRUE)

decode(x, alphabet = "crockford", padded = TRUE)

decode_as_string(x, alphabet = "crockford", padded = TRUE)
```

## Arguments

- x:

  for `encode()`, must be either a character or raw vector. For
  `decode()`, a character vector.

- alphabet:

  default \`"crockford". The base32 encoding alphabet to use. Must be
  one of "crockford", "rfc4648", "rfc4648lower", "rfc4648hex",
  "rfc4648hexlower", or "z".

- padded:

  default TRUE. Appends `=` to ensure that the final encoded chunk is 8
  blocks of characters.

## Details

`encode()` returns a
[blob::blob](https://blob.tidyverse.org/reference/blob.html) object
which is a list of raw vectors. If an error is encountered in `decode()`
the result will be an NA.

## Examples

``` r
encode("hello")
#> [1] "D1JPRV3F"
encode("hello", padded = FALSE)
#> [1] "D1JPRV3F"
encode("hello", alphabet = "rfc4648")
#> [1] "NBSWY3DP"

# Decode base32 string
decode("NBSWY3DPEBLW64TMMQ======")
#> <blob[1]>
#> [1] blob[0 B]
decode_as_string("NBSWY3DPEBLW64TMMQ======")
#> [1] ""
decode("NBSWY3DPEBLW64TMMQ", padded = FALSE)
#> <blob[1]>
#> [1] blob[11 B]
```
