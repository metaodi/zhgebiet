# Raumplanungsregionen (spatial planning regions) functions

#' List all spatial planning regions (Raumplanungsregionen)
#'
#' Retrieves all spatial planning regions in the Canton of Zurich.
#'
#' @return A [tibble::tibble()] with columns:
#'   `gebietstyp_code`, `raumplanungsregion_code`,
#'   `raumplanungsregion_name`.
#' @export
#' @examples
#' \dontrun{
#' zh_raumplanungsregionen()
#' }
zh_raumplanungsregionen <- function() {
  body <- zh_get("/api/raumplanungsregionen")
  parse_list(body, "raumplanungsregionen")
}

#' Get a single spatial planning region by code
#'
#' @param region_code Integer or character. The region code.
#' @return A one-row [tibble::tibble()] with region details.
#' @export
#' @examples
#' \dontrun{
#' zh_raumplanungsregion(101)  # Stadt Zürich
#' }
zh_raumplanungsregion <- function(region_code) {
  path <- paste0("/api/raumplanungsregionen/", region_code)
  body <- zh_get(path)
  parse_detail(body, "raumplanungsregion")
}

#' Search spatial planning regions by name
#'
#' @param raumplanungsregionname Character scalar. (Partial) name to
#'   search for.
#' @param .include_query Logical. If `TRUE`, a `query` column with the
#'   search term is added. Default `FALSE`.
#' @return A [tibble::tibble()] with columns `gemeinde_code`,
#'   `gemeinde_name`, `bezirk_code`, `bezirk_name`,
#'   `raumplanungsregion_code`, `raumplanungsregion_name`
#'   (and optionally `query`).
#' @export
#' @examples
#' \dontrun{
#' zh_raumplanungsregionen_suche("Zürich")
#' zh_raumplanungsregionen_suche("Zürich", .include_query = TRUE)
#' }
zh_raumplanungsregionen_suche <- function(raumplanungsregionname,
                                          .include_query = FALSE) {
  body <- zh_get(
    "/api/raumplanungsregionen/raumplanungsregionname",
    query = list(raumplanungsregionname = raumplanungsregionname)
  )
  parse_search(body, .include_query = .include_query)
}
