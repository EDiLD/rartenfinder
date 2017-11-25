#' Plot a phenogram
#' @import ggplot2
#' @importFrom lubridate week month
#' @importFrom rlang .data
#' @param obs data.frame with observations as returned by (see \code{\link{get_observations}})
#' @param grain character; resolution of the pehnogram ('monthly' or 'weekly')
#' @return a ggplot object
#' @export
#' @examples
#' df <- get_observations(scientific_name = 'Gonepteryx rhamni', year = 2017)
#' plot_phaenogram(df)
#' plot_phaenogram(df, 'weekly')
plot_phaenogram <- function(obs, grain = c('monthly','weekly')) {
  grain <- match.arg(grain)
  if (grain == 'weekly') {
    pdf <- obs %>%
      filter(.data$phaenogramm) %>%
      group_by(agg = week(.data$datum)) %>%
      summarize(n = n())
    p <- ggplot(pdf, aes_string(x = 'agg', y = 'n')) +
      geom_bar(stat = 'identity') +
      labs(x = 'week')
  } else {
    pdf <- obs %>%
      filter(.data$phaenogramm) %>%
      group_by(agg = month(.data$datum, label = TRUE)) %>%
      summarize(n = n())
    p <- ggplot(pdf, aes_string(x = 'agg', y = 'n')) +
      geom_bar(stat = 'identity') +
      scale_x_discrete(drop = FALSE) +
      labs(x = 'month')
  }
  return(p)
}

#' Turn observations into a sf object
#' @import sf
#' @return a sf with POINTS
#' @param obs data.frame with observations as returned by (see \code{\link{get_observations}})
#' @export
#' @examples
#' df <- get_observations(scientific_name = 'Gonepteryx rhamni', year = 2017)
#' head(obs_as_sf(df))
obs_as_sf <- function(obs) {
  obs %>%
    st_as_sf(crs = 25832, coords = c('lon', 'lat'))
}

#' Plot a map of observations
#' @import sf mapview
#' @param obs data.frame with observations as returned by (see \code{\link{get_observations}})
#' @return a interactive map
#' @export
#' @examples
#' df <- get_observations(scientific_name = 'Gonepteryx rhamni', year = 2017)
#' plot_mapview(df)
plot_mapview <- function(obs) {
  obs_as_sf(obs) %>%
    mapview()
}

