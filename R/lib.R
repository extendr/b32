#' Base32 Encode and Decode
#'
#' @param x for `encode()`, must be either a character or raw vector. For `decode()`, a character vector.
#' @param alphabet default `"crockford". The base32 encoding alphabet to use. Must be one of "crockford", "rfc4648", "rfc4648lower", "rfc4648hex", "rfc4648hexlower", or "z".
#' @param padded default TRUE. Appends `=` to ensure that the final encoded chunk is 8 blocks of characters.
#'
#' @details
#' `encode()` returns a [blob] object which is a list of raw vectors.
#' If an error is encountered in `decode()` the result will be an NA.
#'
#' @examples
#' encode("hello")
#' encode("hello", padded = FALSE)
#' encode("hello", alphabet = "rfc4648")
#'
#' @export
encode <- function(x, alphabet = "crockford", padded = TRUE) {
  alphabet <- match.arg(
    alphabet,
    c(
      "crockford",
      "rfc4648",
      "rfc4648lower",
      "rfc4648hex",
      "rfc4648hexlower",
      "z"
    )
  )

  encode_(x, alphabet, padded)
}
#' @rdname encode
#' @examples
#' # Decode base32 string
#' decode("NBSWY3DPEBLW64TMMQ======")
#' decode_as_string("NBSWY3DPEBLW64TMMQ======")
#' decode("NBSWY3DPEBLW64TMMQ", padded = FALSE)
#'
#' @export
decode <- function(x, alphabet = "crockford", padded = TRUE) {
  alphabet <- match.arg(
    alphabet,
    c(
      "crockford",
      "rfc4648",
      "rfc4648lower",
      "rfc4648hex",
      "rfc4648hexlower",
      "z"
    )
  )

  decode_(x, alphabet, padded)
}

#' @export
#' @rdname encode
decode_as_string <- function(
  x,
  alphabet = "crockford",
  padded = TRUE
) {
  res <- decode(x, alphabet, padded)
  vapply(
    res,
    rawToChar,
    character(1)
  )
}
