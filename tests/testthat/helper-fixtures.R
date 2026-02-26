# Helper to load a JSON fixture as a parsed list (same as httr2 would produce)
fixture <- function(name) {
  path <- system.file("fixtures", name, package = "zhgebiet")
  if (!nzchar(path)) {
    # Fallback when running tests from source tree (devtools::test())
    path <- file.path(
      dirname(dirname(dirname(testthat::test_path()))),
      "inst", "fixtures", name
    )
  }
  jsonlite::fromJSON(path, simplifyVector = FALSE)
}
