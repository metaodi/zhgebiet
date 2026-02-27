# Gemeindenhist (historical municipalities) functions

#' List all historical municipalities (Gemeindenhist)
#'
#' Retrieves all historical municipality records across all years in the
#' Canton of Zurich.
#'
#' @return A [tibble::tibble()] with historical municipality information.
#' @export
#' @examples
#' \dontrun{
#' zh_gemeindenhist()
#' }
zh_gemeindenhist <- function() {
  body <- zh_get("/api/gemeindenhist")
  parse_list(body, "gemeindenhist")
}

#' List historical municipalities for a specific year
#'
#' Retrieves all historical municipality records for a given year.
#'
#' @param jahr Integer or character. The year (e.g., 2020).
#' @return A [tibble::tibble()] with historical municipality information for
#'   the specified year.
#' @export
#' @examples
#' \dontrun{
#' zh_gemeindenhist_jahr(2020)
#' }
zh_gemeindenhist_jahr <- function(jahr) {
  path <- paste0("/api/gemeindenhist/", jahr)
  body <- zh_get(path)
  parse_list(body, "gemeinden")
}

#' Get historical municipality detail for a specific year and code
#'
#' Retrieves a single historical municipality record for a given year and
#' municipality code.
#'
#' @param jahr Integer or character. The year (e.g., 2020).
#' @param gemeinde_code Integer or character. The municipality code.
#' @return A one-row [tibble::tibble()] with historical municipality details.
#' @export
#' @examples
#' \dontrun{
#' zh_gemeindenhist_detail(2020, 261)  # Zürich in 2020
#' }
zh_gemeindenhist_detail <- function(jahr, gemeinde_code) {
  path <- paste0("/api/gemeindenhist/", jahr, "/", gemeinde_code)
  body <- zh_get(path)
  parse_detail(body, "gemeindenhist")
}
