% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stability.R
\name{stability.value}
\alias{stability.value}
\title{Estimates network stability}
\usage{
stability.value(val.mat, biomasses, losses, efficiencies, growth.rate,
  bioms.prefs = TRUE, bioms.losses = TRUE, ef.level = "prey",
  full.output = FALSE)
}
\arguments{
\item{val.mat}{A matrix describing fluxes between species (usually a result of \code{\link[fluxweb]{fluxing}} function).}

\item{biomasses}{A vector of species biomasses.}

\item{losses}{A vector or an array of species energy losses (excluding predation).}

\item{efficiencies}{A vector or an array of conversion efficiencies of species in the adjacency matrix. These values describe the proportion of consumed energy that is converted to biomass of the consumer.}

\item{growth.rate}{A vector defining growth rate of basal species.}

\item{bioms.prefs}{Logical, if \code{TRUE} (default) preferences are scaled according to species biomasses.}

\item{bioms.losses}{Logical, if \code{TRUE} (default) losses are scaled with biomass.}

\item{ef.level}{Set to \code{"prey"} if efficiences are defined by prey, \code{"pred"} if they are a property of the predator.}

\item{full.output}{Logical, if \code{TRUE} function return supplementary informations.}
}
\value{
Maximum eigenvalue of the jacobian matrix of a Lotka Voltera like system of equations. If full.output, Jacobian eigenvalues and eigenvectors are returned.
}
\description{
Computes resiliance of the system through jacobian eigenvalues.
}
\details{
\itemize{

\item{\code{losses}:} Express species energetic losses not related to consumption. Usually metabolic or death rates.
When an array is provided, losses associated to each species correspond to line sums.

\item{\code{efficiencies}:} Determines how efficient species are to convert energy (see \code{ef.level} for more details).
Providing an array will assume values depending on both prey and predator identity.

\item{\code{growth.rate}:} Growth rates of basal species defined in \code{growth.rate} should appear in the same order as in other arguments.
For example the second value specified in \code{growth.rate} should set the groth rate of the second basal species found in \code{biomasses}.

\item{\code{bioms.pref}:} If \code{TRUE}, preferences \eqn{w_{ij}} of predator j on prey i are scaled according to species biomass unsing the following formula:
\deqn{
w_{i,j} = \frac{mat[i,j] * biomasses[i]}{\sum_k mat[i,k]* biomasses[k]}
}
\item{\code{bioms.losses}:} If \code{TRUE}, function will assume that losses are defined per biomass unit.
Thus, total losses will be thereafter multiplied by biomass values for each species.

\item{\code{ef.level}:} If \code{"prey"} (resp \code{"pred"}), the total amount of energy that can be metabolised from a trophic link
will be determined by prey (resp pred) identity. \code{"link.specific"} assumes that efficiencies are defined for each trophic interaction
and implies \code{efficiencies} parameter to be a matrix

\item{\code{full.output}:} If \code{TRUE}, function result is a list of eigenvalues and eigenvectors of the jacobian matrix.#'
}
}
\examples{
losses = 0.15 * groups.level$bodymasses^(-0.25)

# growth rates of basal sppecies
growth.rates = rep(0.5, length(groups.level$biomasses[colSums(groups.level$mat) == 0]))

val.mat = fluxing(groups.level$mat, groups.level$biomasses, losses, groups.level$efficiencies, bioms.pref = TRUE, ef.level = "pred")
stability.value(val.mat, groups.level$biomasses, losses, groups.level$efficiencies, growth.rates, ef.level = "pred")

}
\author{
Benoit gauzens, \email{benoit.gauzens@gmail.com}
}
