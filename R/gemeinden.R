# Gemeinden (municipalities) functions

#' List all municipalities (Gemeinden)
#'
#' Retrieves all municipalities in the Canton of Zurich.
#'
#' @param jahr Optional integer. Year to retrieve historical municipality data.
#'   If `NULL` (default), returns current municipalities.
#' @return A [tibble::tibble()] with columns:
#'   `gebietstyp_code`, `gemeinde_code`, `gemeinde_name`.
#' @export
#' @examples
#' \dontrun{
#' zh_gemeinden()
#' zh_gemeinden(jahr = 1992)
#' }
zh_gemeinden <- function(jahr = NULL) {
  query <- if (!is.null(jahr)) list(jahr = jahr) else NULL
  body <- zh_get("/api/gemeinden", query = query)
  parse_list(body, "gemeinden")
}

#' Get a single municipality by code
#'
#' @param gemeinde_code Integer or character. The municipality code.
#' @param jahr Optional integer. Year to retrieve historical municipality data.
#'   If `NULL` (default), returns current municipality data.
#' @return A one-row [tibble::tibble()] with municipality details.
#' @export
#' @examples
#' \dontrun{
#' zh_gemeinde(261)  # Zürich
#' zh_gemeinde(261, jahr = 1992)
#' }
zh_gemeinde <- function(gemeinde_code, jahr = NULL) {
  path <- paste0("/api/gemeinden/", gemeinde_code)
  query <- if (!is.null(jahr)) list(jahr = jahr) else NULL
  body <- zh_get(path, query = query)
  parse_detail(body, "gemeinde")
}

#' Search municipalities by name
#'
#' @param gemeindename Character scalar. (Partial) name to search for.
#' @param .include_query Logical. If `TRUE`, a `query` column with the
#'   search term is added. Default `FALSE`.
#' @return A [tibble::tibble()] with columns `gemeinde_code`,
#'   `gemeinde_name`, `bezirk_code`, `bezirk_name`,
#'   `raumplanungsregion_code`, `raumplanungsregion_name`
#'   (and optionally `query`).
#' @export
#' @examples
#' \dontrun{
#' zh_gemeinden_suche("Tha")
#' zh_gemeinden_suche("Tha", .include_query = TRUE)
#' }
zh_gemeinden_suche <- function(gemeindename, .include_query = FALSE) {
  body <- zh_get("/api/gemeinden/gemeindename",
                 query = list(gemeindename = gemeindename))
  parse_search(body, .include_query = .include_query)
}
