% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot.R
\name{obs_as_sf}
\alias{obs_as_sf}
\title{Turn observations into a sf object}
\usage{
obs_as_sf(obs)
}
\arguments{
\item{obs}{data.frame with observations as returned by (see \code{\link{get_observations}})}
}
\value{
a sf with POINTS
}
\description{
Turn observations into a sf object
}
\examples{
df <- get_observations(scientific_name = 'Gonepteryx rhamni', year = 2017)
head(obs_as_sf(df))
}
