test_that("parse_list returns correct tibble for gemeinden fixture", {
  body <- fixture("gemeinden.json")
  result <- zhgebiet:::parse_list(body, "gemeinden")

  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 2L)
  expect_named(result, c("gebietstyp_code", "gemeinde_code", "gemeinde_name"))
  expect_equal(result$gemeinde_name, c("Aeugst am Albis", "Affoltern am Albis"))
  expect_equal(result$gemeinde_code, c(1L, 2L))
})

test_that("parse_list returns correct tibble for bezirke fixture", {
  body <- fixture("bezirke.json")
  result <- zhgebiet:::parse_list(body, "bezirke")

  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 2L)
  expect_named(result, c("gebietstyp_code", "bezirk_code", "bezirk_name"))
  expect_equal(result$bezirk_name, c("Affoltern", "Andelfingen"))
})

test_that("parse_list returns correct tibble for raumplanungsregionen fixture", {
  body <- fixture("raumplanungsregionen.json")
  result <- zhgebiet:::parse_list(body, "raumplanungsregionen")

  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 2L)
  expect_named(result, c("gebietstyp_code", "raumplanungsregion_code",
                         "raumplanungsregion_name"))
})

test_that("parse_list returns correct tibble for gemeindezuweisungen fixture", {
  body <- fixture("gemeindezuweisungen.json")
  result <- zhgebiet:::parse_list(body, "gemeindezuweisungen")

  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 2L)
  expect_named(result, c("gemeinde_code", "gemeinde_name", "bezirk_code",
                         "bezirk_name", "raumplanungsregion_code",
                         "raumplanungsregion_name"))
  expect_equal(result$raumplanungsregion_name,
               c("Knonaueramt", "Knonaueramt"))
})

test_that("parse_list returns empty tibble for unknown key", {
  result <- zhgebiet:::parse_list(list(), "gemeinden")
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 0L)
})
