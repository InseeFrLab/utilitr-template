% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{include_image}
\alias{include_image}
\title{Include a compressed image from filepath}
\usage{
include_image(x, compression = TRUE, ratio_compression = 2, ...)
}
\arguments{
\item{x}{Filepath}

\item{compression}{Logical including whether we want to compress image
(default) or not (in that case, standard
\code{knitr::\link{include_graphics}()}
is used)}

\item{ratio_compression}{Compression ratio that should be applied}

\item{...}{Arguments to pass to \code{magick::\link{image_scale}()}}
}
\description{
Include a compressed image from filepath
}
