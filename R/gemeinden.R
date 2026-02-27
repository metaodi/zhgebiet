# Gemeinden (municipalities) functions

#' List all municipalities (Gemeinden)
#'
#' Retrieves all municipalities in the Canton of Zurich.
#'
#' @return A [tibble::tibble()] with columns:
#'   `gebietstyp_code`, `gemeinde_code`, `gemeinde_name`.
#' @export
#' @examples
#' \dontrun{
#' zh_gemeinden()
#' }
zh_gemeinden <- function() {
  body <- zh_get("/api/gemeinden")
  parse_list(body, "gemeinden")
}

#' Get a single municipality by code
#'
#' @param gemeinde_code Integer or character. The municipality code.
#' @return A one-row [tibble::tibble()] with municipality details.
#' @export
#' @examples
#' \dontrun{
#' zh_gemeinde(261)  # Zürich
#' }
zh_gemeinde <- function(gemeinde_code) {
  path <- paste0("/api/gemeinden/", gemeinde_code)
  body <- zh_get(path)
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
