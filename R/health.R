# Health check function

#' Check API health
#'
#' Calls the API health endpoint and returns the result as a tibble.
#'
#' @return A [tibble::tibble()] with API health information.
#' @export
#' @examples
#' \dontrun{
#' zh_health()
#' }
zh_health <- function() {
  body <- zh_get("/api/health")
  # The health endpoint may return various shapes; coerce to tibble.
  if (is.data.frame(body)) {
    return(tibble::as_tibble(body))
  }
  if (is.list(body) && length(body) > 0) {
    return(tibble::as_tibble(as.data.frame(body, stringsAsFactors = FALSE)))
  }
  tibble::tibble(status = as.character(body))
}
