% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/string_api.R
\name{saveNetworkPlot}
\alias{saveNetworkPlot}
\title{Save a network plot showing functional dependencies.}
\usage{
saveNetworkPlot(identifiers, species_ncbi_id, path, highres = FALSE, ...)
}
\arguments{
\item{identifiers}{Character array of protein identifiers or stringIDs.}

\item{species_ncbi_id}{The NCBI identification of the organism.}

\item{path}{Where to save the image. It must have a 'png' or 'svg' extension.}

\item{highres}{Download high resolution image?}
}
\value{
data.table with translated entries.
}
\description{
Save a network plot showing functional dependencies.
}
