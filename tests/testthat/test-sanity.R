test_that("sanity checks", {
  expect_equal(
    encode("hello, world"),
    "D1JPRV3F5GG7EVVJDHJ0"
  )

  encoded <- encode("hello, world")

  expect_equal(
    decode_as_string(encoded),
    "hello, world"
  )

  decoded <- decode(encoded)
  expect_s3_class(decoded, c("blob", "vctrs_vctr"))
  expect_length(decoded, 1)
  expect_identical(
    decoded[[1]],
    charToRaw("hello, world")
  )
})

test_that("padded parameter works", {
  text <- "test"
  padded_encoded <- encode(text, padded = TRUE)
  unpadded_encoded <- encode(text, padded = FALSE)

  # Padded version may have padding characters
  expect_true(nchar(padded_encoded) >= nchar(unpadded_encoded))

  # Round-trip with padded = FALSE
  decoded <- decode_as_string(unpadded_encoded, padded = FALSE)
  expect_equal(decoded, text)
})

test_that("different alphabets produce different results", {
  text <- "hello"
  crockford <- encode(text, alphabet = "crockford")
  rfc4648 <- encode(text, alphabet = "rfc4648")
  z_alphabet <- encode(text, alphabet = "z")

  expect_false(identical(crockford, rfc4648))
  expect_false(identical(crockford, z_alphabet))
  expect_false(identical(rfc4648, z_alphabet))
})

test_that("round-trip works with raw vectors", {
  raw_input <- charToRaw("test data")
  encoded <- encode(raw_input)
  decoded <- decode(encoded)

  expect_identical(
    decoded[[1]],
    raw_input
  )
})

test_that("empty string round-trip", {
  encoded <- encode("")
  decoded <- decode_as_string(encoded)

  expect_equal(decoded, "")
})
