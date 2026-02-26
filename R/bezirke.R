# Bezirke (districts) functions

#' List all districts (Bezirke)
#'
#' Retrieves all districts in the Canton of Zurich.
#'
#' @return A [tibble::tibble()] with columns:
#'   `gebietstyp_code`, `bezirk_code`, `bezirk_name`.
#' @export
#' @examples
#' \dontrun{
#' zh_bezirke()
#' }
zh_bezirke <- function() {
  body <- zh_get("/api/bezirke")
  parse_list(body, "bezirke")
}

#' Get a single district by code
#'
#' @param bezirk_code Integer or character. The district code.
#' @return A one-row [tibble::tibble()] with district details.
#' @export
#' @examples
#' \dontrun{
#' zh_bezirk(101)  # Affoltern
#' }
zh_bezirk <- function(bezirk_code) {
  path <- paste0("/api/bezirke/", bezirk_code)
  body <- zh_get(path)
  parse_detail(body, "bezirk")
}

#' Search districts by name
#'
#' @param bezirkname Character scalar. (Partial) name to search for.
#' @param .include_query Logical. If `TRUE`, a `query` column with the
#'   search term is added. Default `FALSE`.
#' @return A [tibble::tibble()] with columns `gemeinde_code`,
#'   `gemeinde_name`, `bezirk_code`, `bezirk_name`,
#'   `raumplanungsregion_code`, `raumplanungsregion_name`
#'   (and optionally `query`).
#' @export
#' @examples
#' \dontrun{
#' zh_bezirke_suche("Affoltern")
#' zh_bezirke_suche("Affoltern", .include_query = TRUE)
#' }
zh_bezirke_suche <- function(bezirkname, .include_query = FALSE) {
  body <- zh_get("/api/bezirke/bezirkname",
                 query = list(bezirkname = bezirkname))
  parse_search(body, .include_query = .include_query)
}
