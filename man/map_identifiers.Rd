% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/string_api.R
\name{map_identifiers}
\alias{map_identifiers}
\title{Map identifiers to string-db format.}
\usage{
map_identifiers(identifiers, species_ncbi_id, format = "tsv",
  echo_query = 1, ...)
}
\arguments{
\item{identifiers}{Character array of protein identifiers.}

\item{species_ncbi_id}{The NCBI identification of the organism.}

\item{format}{Change to 'json' or 'xml' if 'tsv' does not work.}

\item{echo_query}{1 - identifiers are appended to the output table. 0 - they ain't.}
}
\value{
data.table with translated entries. Some might be MISSING or there might be MULTIPLE VALID TRANSLATIONS. So think what about what you do.
}
\description{
Map identifiers to string-db format.
}
