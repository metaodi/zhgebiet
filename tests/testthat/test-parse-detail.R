test_that("parse_detail returns correct tibble for gemeinde fixture", {
  body <- fixture("gemeinde_261.json")
  result <- zhgebiet:::parse_detail(body, "gemeinde")

  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 1L)
  expect_named(result, c("gemeinde_code", "gemeinde_name"))
  expect_equal(result$gemeinde_code, 261L)
  expect_equal(result$gemeinde_name, "Zürich")
})

test_that("parse_detail returns correct tibble for bezirk fixture", {
  body <- fixture("bezirk_101.json")
  result <- zhgebiet:::parse_detail(body, "bezirk")

  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 1L)
  expect_named(result, c("bezirk_code", "bezirk_name"))
  expect_equal(result$bezirk_code, 101L)
  expect_equal(result$bezirk_name, "Affoltern")
})

test_that("parse_detail returns correct tibble for raumplanungsregion fixture", {
  body <- fixture("raumplanungsregion_101.json")
  result <- zhgebiet:::parse_detail(body, "raumplanungsregion")

  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 1L)
  expect_named(result, c("raumplanungsregion_code", "raumplanungsregion_name"))
  expect_equal(result$raumplanungsregion_code, 101L)
})

test_that("parse_detail returns correct tibble for gemeindezuweisung fixture", {
  body <- fixture("gemeindezuweisung_261.json")
  result <- zhgebiet:::parse_detail(body, "gemeindezuweisung")

  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 1L)
  expect_named(result, c("gemeinde_code", "gemeinde_name", "bezirk_code",
                         "bezirk_name", "raumplanungsregion_code",
                         "raumplanungsregion_name"))
  expect_equal(result$gemeinde_name, "Zürich")
})

test_that("parse_detail returns empty tibble for unknown key", {
  result <- zhgebiet:::parse_detail(list(), "gemeinde")
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 0L)
})
