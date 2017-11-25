#' Query available taxagroups
#' @import httr jsonlite
#' @param is_animal logical; should animals (TRUE) or plants (FALSE) be queried.
#'     NULL (default returns both)
#' @return a data.frame with id, name_deutsch (german name), and is_animal
#' @examples
#' get_taxagroups()
#'
#' @export
get_taxagroups <- function(is_animal = NULL) {
  qurl <- 'http://artenfinder.rlp.de/api/v2/artengruppen'
  qurl <- modify_url(qurl, query = list(is_animal = is_animal, limit = 1000))
  resp <- GET(qurl)
  ret <- jsonlite::fromJSON(content(resp, "text"))$result
  return(ret)
}
