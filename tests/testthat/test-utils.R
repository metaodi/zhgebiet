test_that("zh_base_url returns default URL", {
  old <- getOption("zhgebiet.base_url")
  on.exit(options(zhgebiet.base_url = old))

  options(zhgebiet.base_url = NULL)
  expect_equal(
    zhgebiet:::zh_base_url(),
    "https://gebietsstammdaten.statistik.zh.ch"
  )
})

test_that("zh_base_url respects custom option", {
  old <- getOption("zhgebiet.base_url")
  on.exit(options(zhgebiet.base_url = old))

  options(zhgebiet.base_url = "http://localhost:8080/")
  expect_equal(zhgebiet:::zh_base_url(), "http://localhost:8080")
})

test_that("zh_base_url strips trailing slash", {
  old <- getOption("zhgebiet.base_url")
  on.exit(options(zhgebiet.base_url = old))

  options(zhgebiet.base_url = "https://example.com/")
  expect_equal(zhgebiet:::zh_base_url(), "https://example.com")
})
