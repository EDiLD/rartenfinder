#' Query Observations
#' @import httr jsonlite dplyr
#' @importFrom rlang .data
#' @importFrom magrittr "%>%"
#' @param is_animal logical; should animals (TRUE) or plants (FALSE) be queried.
#'     NULL (default returns both).
#' @param german_name character; filter by german name.
#' @param scientific_name characher; filter by scienctific name.
#' @param eu_guid numeric; filter by eu_guid (see \code{\link{get_taxa}}).
#' @param id numeric; filter by taxon id (see \code{\link{get_taxa}}).
#' @param taxagroup characher; filter by taxagroup
#' @param year numeric; filter by year of observation
#' @param from character; earliest date in format DD.MM.YYYY
#' @param to character; latest date in format DD.MM.YYYY
#' @param bbox numeric; vector of corner of bounding box to filter (ETRS89/UTM zone 32N)
#'    with xmin, ymin, xmax and ymax values
#' @param limit numeric; Number of observations to retrieve (max 1000).
#' @return a data.frame with one oberservation per row:
#' \describe{
#'   \item{id}{Observation ID}
#'   \item{bereich}{Observation group}
#'   \item{status}{Observation status}
#'   \item{anzahl}{number of observed taxa}
#'   \item{lat}{latitude (ETRS89/UTM zone 32N)}
#'   \item{lon}{longitude (ETRS89/UTM zone 32N)}
#'   \item{datum}{date}
#'   \item{titel_deutsch}{German name}
#'   \item{titel_wissenschaftlich}{Scientific Name}
#'   \item{bemerkung}{comment}
#'   \item{phaenogramm}{observation suitable for a phenogramm? (e.g. imagines)}
#'   \item{lanis_rlp_osiris_art_id}{taxon id (see \code{\link{get_taxa}})}
#'   \item{is_rasterized}{flag if observation has been assigned to midpoint of raster, see note.}
#' }
#' @note Sensible taxa have been assigned to their raster midpoints.
#' @examples
#' mil1 <- get_observations(scientific_name='milvus milvus', year = 2017)
#' head(mil1)
#' @export
get_observations <- function(is_animal = NULL,
                             german_name = NULL, scientific_name = NULL,
                             eu_guid = NULL, id = NULL, taxagroup = NULL,
                             year = NULL, from = NULL, to = NULL,
                             bbox = NULL,
                             limit = 1000) {

  if (!is.null(bbox)) {
    stopifnot(length(bbox) == 4)
    bbox <- paste(bbox, collapse = ',')
  }
  qurl <- 'http://artenfinder.rlp.de/api/v2/sichtbeobachtungen'
  qurl <- modify_url(qurl, query = list(limit = limit,
                                        bereich = 'oeffentlich',
                                        titel_deutsch = german_name,
                                        titel_wissenschaftlich = scientific_name,
                                        eu_guid = eu_guid,
                                        lanis_rlp_osiris_art_id = id,
                                        lanis_rlp_osiris_artengruppe_id = taxagroup,
                                        jahr = year, datum_von = from,
                                        datum_bis = to, bbox = bbox
                                        ))
  resp <- GET(qurl)
  ret <- jsonlite::fromJSON(content(resp, "text"))$result
  if (nrow(ret) == 1000)
    warning('Limit of 1000 reached. Not all records are returned.')
  ret <- ret %>%
    mutate(datum = as.Date(.data$datum, format = '%d.%m.%Y')) %>%
    select(-starts_with('foto'), -starts_with('biotop'), -starts_with('audio'))
  return(ret)
}
