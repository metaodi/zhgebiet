# Gemeindemutationen (municipality mutations) functions

#' List all municipality mutations (Gemeindemutationen)
#'
#' Retrieves all municipality mutations (changes, mergers, etc.) in the
#' Canton of Zurich.
#'
#' @return A [tibble::tibble()] with municipality mutation information.
#' @export
#' @examples
#' \dontrun{
#' zh_gemeindemutationen()
#' }
zh_gemeindemutationen <- function() {
  body <- zh_get("/api/gemeindemutationen")
  parse_list(body, "gemeindemutationen")
}
