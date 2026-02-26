# Parsing helpers

#' Parse a list endpoint response into a tibble
#'
#' List endpoints return `{ "<plural_key>": [ {...}, {...} ] }`.
#'
#' @param body Parsed JSON list (from `zh_get()`).
#' @param key Character scalar: the plural top-level key to extract.
#' @return A [tibble::tibble()].
#' @keywords internal
parse_list <- function(body, key) {
  records <- body[[key]]
  if (is.null(records) || length(records) == 0L) {
    return(tibble::tibble())
  }
  tibble::as_tibble(do.call(rbind, lapply(records, as.data.frame,
                                          stringsAsFactors = FALSE)))
}

#' Parse a detail endpoint response into a single-row tibble
#'
#' Detail endpoints return `{ "<singular_key>": { ... } }`.
#'
#' @param body Parsed JSON list (from `zh_get()`).
#' @param key Character scalar: the singular top-level key to extract.
#' @return A one-row [tibble::tibble()].
#' @keywords internal
parse_detail <- function(body, key) {
  record <- body[[key]]
  if (is.null(record)) {
    return(tibble::tibble())
  }
  tibble::as_tibble(as.data.frame(record, stringsAsFactors = FALSE))
}

#' Parse a search endpoint response into a tibble
#'
#' Search endpoints return:
#' ```
#' { "name": "<query>", "treffer": [ { "gemeinde": {...}, "bezirk": {...},
#'   "raumplanungsregion": {...} }, ... ] }
#' ```
#' Each hit is flattened to a single row with columns:
#' `gemeinde_code`, `gemeinde_name`, `bezirk_code`, `bezirk_name`,
#' `raumplanungsregion_code`, `raumplanungsregion_name`.
#'
#' @param body Parsed JSON list (from `zh_get()`).
#' @param .include_query Logical. If `TRUE` a `query` column (from the
#'   top-level `name` field) is prepended.
#' @return A [tibble::tibble()].
#' @keywords internal
parse_search <- function(body, .include_query = FALSE) {
  treffer <- body[["treffer"]]
  if (is.null(treffer) || length(treffer) == 0L) {
    cols <- c(
      "gemeinde_code", "gemeinde_name",
      "bezirk_code", "bezirk_name",
      "raumplanungsregion_code", "raumplanungsregion_name"
    )
    if (.include_query) cols <- c("query", cols)
    empty <- as.data.frame(
      matrix(nrow = 0, ncol = length(cols),
             dimnames = list(NULL, cols)),
      stringsAsFactors = FALSE
    )
    # Set proper column types for empty result
    empty[["gemeinde_code"]] <- integer(0)
    empty[["bezirk_code"]] <- integer(0)
    empty[["raumplanungsregion_code"]] <- integer(0)
    return(tibble::as_tibble(empty[cols]))
  }

  query_val <- body[["name"]]

  rows <- lapply(treffer, function(hit) {
    g <- hit[["gemeinde"]]
    b <- hit[["bezirk"]]
    r <- hit[["raumplanungsregion"]]
    row <- list(
      gemeinde_code             = g[["gemeinde_code"]],
      gemeinde_name             = g[["gemeinde_name"]],
      bezirk_code               = b[["bezirk_code"]],
      bezirk_name               = b[["bezirk_name"]],
      raumplanungsregion_code   = r[["raumplanungsregion_code"]],
      raumplanungsregion_name   = r[["raumplanungsregion_name"]]
    )
    if (.include_query) row <- c(list(query = query_val), row)
    row
  })

  tibble::as_tibble(do.call(rbind, lapply(rows, as.data.frame,
                                          stringsAsFactors = FALSE)))
}
