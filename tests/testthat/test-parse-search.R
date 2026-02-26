test_that("parse_search returns flattened tibble with correct columns", {
  body <- fixture("gemeinden_suche_tha.json")
  result <- zhgebiet:::parse_search(body)

  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 2L)
  expect_named(result, c("gemeinde_code", "gemeinde_name",
                         "bezirk_code", "bezirk_name",
                         "raumplanungsregion_code", "raumplanungsregion_name"))
  expect_equal(result$gemeinde_name,
               c("Thalheim an der Thur", "Thalwil"))
  expect_equal(result$bezirk_name, c("Andelfingen", "Horgen"))
  expect_equal(result$raumplanungsregion_name, c("Weinland", "Zimmerberg"))
})

test_that("parse_search includes query column when .include_query = TRUE", {
  body <- fixture("gemeinden_suche_tha.json")
  result <- zhgebiet:::parse_search(body, .include_query = TRUE)

  expect_s3_class(result, "tbl_df")
  expect_true("query" %in% names(result))
  expect_equal(result$query, c("Tha", "Tha"))
})

test_that("parse_search returns empty tibble for empty treffer", {
  body <- fixture("gemeinden_suche_no_results.json")
  result <- zhgebiet:::parse_search(body)

  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 0L)
  expect_named(result, c("gemeinde_code", "gemeinde_name",
                         "bezirk_code", "bezirk_name",
                         "raumplanungsregion_code", "raumplanungsregion_name"))
})

test_that("parse_search empty with .include_query = TRUE has query column", {
  body <- fixture("gemeinden_suche_no_results.json")
  result <- zhgebiet:::parse_search(body, .include_query = TRUE)

  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 0L)
  expect_true("query" %in% names(result))
})
