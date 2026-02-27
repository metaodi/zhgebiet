# Internal HTTP client utilities

#' Get the configured base URL
#'
#' @return character scalar base URL (no trailing slash)
#' @keywords internal
zh_base_url <- function() {
  url <- getOption(
    "zhgebiet.base_url",
    default = "https://gebietsstammdaten.statistik.zh.ch"
  )
  sub("/$", "", url)
}

#' Build and perform a GET request
#'
#' @param path API path (starting with `/`)
#' @param query Named list of query parameters, or `NULL`.
#' @return Parsed list from JSON response body.
#' @keywords internal
zh_get <- function(path, query = NULL) {
  url <- paste0(zh_base_url(), path)

  req <- httr2::request(url)
  req <- httr2::req_headers(req, Accept = "application/json")
  req <- httr2::req_timeout(req, 30)
  req <- httr2::req_error(req, body = function(resp) {
    status <- httr2::resp_status(resp)
    paste0(
      "API request failed with HTTP ", status, " for URL: ", url,
      ". Check that the endpoint exists and the base URL is correct."
    )
  })

  if (!is.null(query) && length(query) > 0) {
    req <- do.call(httr2::req_url_query, c(list(req), query))
  }

  resp <- httr2::req_perform(req)
  body <- httr2::resp_body_json(resp, simplifyVector = FALSE)

  # Check if the response contains an error key
  if (!is.null(body[["error"]])) {
    stop("API error: ", body[["error"]], call. = FALSE)
  }

  body
}
