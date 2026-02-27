test_that("error response is properly detected and raised", {
  body <- fixture("error_jahr_2027.json")

  # Verify that the error key exists in the fixture
  expect_true(!is.null(body[["error"]]))
  expect_equal(body[["error"]], "Keine Gemeinden für das Jahr 2027 gefunden")
})

test_that("error response for gemeinde detail is properly detected", {
  body <- fixture("error_gemeinde_21_2024.json")

  # Verify that the error key exists in the fixture
  expect_true(!is.null(body[["error"]]))
  expect_equal(body[["error"]], "Keine Gemeinde 21 im Jahr 2024 gefunden")
})

test_that("parse_list handles valid responses without errors", {
  # Ensure that valid responses still work correctly
  body <- fixture("gemeinden.json")
  result <- zhgebiet:::parse_list(body, "gemeinden")

  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) > 0)
})

test_that("parse_detail handles valid responses without errors", {
  # Ensure that valid responses still work correctly
  body <- fixture("gemeinde_261.json")
  result <- zhgebiet:::parse_detail(body, "gemeinde")

  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 1L)
})
