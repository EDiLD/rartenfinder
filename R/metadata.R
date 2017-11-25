#' Query available taxagroups
#' @import httr jsonlite
#' @param is_animal logical; should animals (TRUE) or plants (FALSE) be queried.
#'     NULL (default returns both).
#' @return a data.frame with id (OSIRIS taxagroup ID), name_deutsch (german name), and is_animal.
#' @note A maximum of 1000 entries is returned.
#' @examples
#' get_taxagroups()
#' get_taxagroups(is_animal = FALSE)
#'
#' @export
get_taxagroups <- function(is_animal = NULL) {
  qurl <- 'http://artenfinder.rlp.de/api/v2/artengruppen'
  qurl <- modify_url(qurl, query = list(limit = 1000,
                                        is_animal = is_animal))
  resp <- GET(qurl)
  ret <- jsonlite::fromJSON(content(resp, "text"))$result
  return(ret)
}

#' Query available taxa
#' @import httr jsonlite
#' @param is_animal logical; should animals (TRUE) or plants (FALSE) be queried.
#'     NULL (default returns both).
#' @param taxagroup character; filter by german name of OSIRIS taxagroups (e.g. from \code{\link{get_taxagroups}}).
#' @param gid numeric; filter by OSIRIS taxagroup ID (e.g. from \code{\link{get_taxagroups}}).
#' @param name_regexp_ci character; a Regular Expression  (POSIX, Case Insensitive) to filter german or scientific name
#' @return a data.frame with id, eu_guid, name_wissenschaftlich (scientific name),
#'     name_deutsch (german name), artengruppe (taxagroup-name), gid (taxagroup id), is_animal
#'
#' @note A maximum of 1000 entries is returned.
#' @examples
#' get_taxa()
#'
#' @export
get_taxa <- function(is_animal = NULL, taxagroup = NULL, gid = NULL, name_regexp_ci = NULL) {
  qurl <- 'http://artenfinder.rlp.de/api/v2/arten'
  qurl <- modify_url(qurl, query = list(limit = 1000,
                                        is_animal = is_animal,
                                        artengruppe = taxagroup,
                                        gid = gid,
                                        name_regexp_ci = name_regexp_ci))
  resp <- GET(qurl)
  ret <- jsonlite::fromJSON(content(resp, "text"))$result
  return(ret)
}
