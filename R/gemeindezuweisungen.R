# Gemeindezuweisungen (municipality assignments) functions

#' List all municipality assignments (Gemeindezuweisungen)
#'
#' Retrieves the full assignment table linking each municipality to its
#' district and spatial planning region.
#'
#' @return A [tibble::tibble()] with columns:
#'   `gemeinde_code`, `gemeinde_name`, `bezirk_code`, `bezirk_name`,
#'   `raumplanungsregion_code`, `raumplanungsregion_name`.
#' @export
#' @examples
#' \dontrun{
#' zh_gemeindezuweisungen()
#' }
zh_gemeindezuweisungen <- function() {
  body <- zh_get("/api/gemeindezuweisungen")
  parse_list(body, "gemeindezuweisungen")
}

#' Get municipality assignment for a single municipality
#'
#' Returns the district and spatial planning region assignment for the
#' given municipality code.
#'
#' @param gemeinde_code Integer or character. The municipality code.
#' @return A one-row [tibble::tibble()] with assignment details.
#' @export
#' @examples
#' \dontrun{
#' zh_gemeindezuweisung(261)  # Zürich
#' }
zh_gemeindezuweisung <- function(gemeinde_code) {
  path <- paste0("/api/gemeindezuweisungen/", gemeinde_code)
  body <- zh_get(path)
  parse_detail(body, "gemeindezuweisung")
}
