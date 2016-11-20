\name{quasiSamp}
\alias{quasiSamp}
\title{Generates a spatial design using Quasi-random numbers}
\description{ Generates a spatially balanced design for given inclusion probabilities over a grid of potential sampling locations
}
\usage{
 quasiSamp( n, dimension=2, study.area=NULL, potential.sites=NULL, inclusion.probs=NULL)
}
\arguments{
\item{ n}{the number of samples to take}
\item{ dimension}{the number of dimensions that the samples are located in. Equal to 2 for areal sampling. Care should be taken with large dimensions as:1) the number of potential sampling sites needed for effective coverage starts to explode (curse of dimensionality); and 2) the well-spaced behaviour of the Halton sequence starts to deteriorate (but this requires very very many dimensions to be problematic -- included as a warning here for largely academic reasons).}
\item{ study.area}{a numeric matrix with dimension columns. This defines the sampling area from where the sites are selected (each row defines a vertex of the sampling area). If NULL (default), the study.area is defined to be the smallest (hyper-)rectangle that bounds the potential.sites. If potential.sites is also NULL (default), then the study area is taken to be the unit (hyper-)square. This argument is closely related to potential.sites.}
\item{ potential.sites}{a matrix (of size Nxdimension) of the spatial coordinates of the N sampling locations, of which n<<N are taken as the sample. If NULL (default) N=10000 samples are placed on a regular grid. If study.area is defined, then this grid is over the smallest bounding (hyper-)rectangle for the study.area. If study.area is NULL, the grid is over the unit (hyper-)square.}
\item{ inclusion.probs}{a vector specifying the inclusion probability for each of the N potential sampling sites. This is the probability that each site will be included in the final sample. Locations are ordered the same as the potential.sites argument. If NULL (default) equal inclusion probabilities are specified.}
}
\details{ This function is an implementation of the balanced adaptive sampling (BAS) designs presented in Robertson et al. (2013), which forms the basis for the methods in Foster et al (in review). The BAS approach uses Halton sequences of quasi-random numbers, which are evenly spread over space, as the basis for generating spatially balanced designs. In this implementation, we requrie that the inclusion probabilities be given as points in space and the BAS design is the set of these points that lie closest to a continuous-space Halton sequence. Computational speed has been rudimentily optimised, but (of course) it could be done better -- like coding outside of R{}, for example.
}
\value{\item{ The quasiSamp function returns a matrix of (dimension+2) columns. The first columns (of number dimension) are the sampled sites locations. The second to last column contains the inclusion probabilities for the sampled locations. The last column is the row number (of potential.sites) that corresponds to that sampled site.}{}
}
\seealso{\code{\link{alterInclProbs}}, \code{\link{modEsti}}
}
\author{Scott D. Foster}
\references{
\describe{
\item{Robertson, B. L., Brown, J. A., McDonald, T. and Jaksons, P. (2013) BAS}{Balanced Acceptance Sampling of Natural Resources. Biometrics \emph{69}: 776--784 DOI: 10.1111/biom.12059}
}

 Foster, S.D. et al. (in review.) Flexible Spatially-Balanced Designs that Incorporate Legacy Sites.
}
\examples{
#generate samples on a 100 x 100 grid
#jet plane
set.seed(707)
#the number of potential sampling locations
N <- 100^2
#number of samples
n <- 10
#the grid on unit square
X <- as.matrix( expand.grid( 1:sqrt( N), 1:sqrt(N)) / sqrt(N) - 1/(2*sqrt(N)))
#the inclusion probabiltiies with gradient according to non-linear function of X[,1]
p <- 1-exp(-X[,1])
#standardise to get n samples
p <- n * p / sum( p)
#get the sample
samp <- quasiSamp( n=n, dimension=2, potential.sites=X, inclusion.probs=p)
par( mfrow=c(1,3))
plot( samp[,1:2], main="n=10")
#now let's get sillier
n <- 250
#get the sample
samp <- quasiSamp( n=n, dimension=2, potential.sites=X, inclusion.probs=p)
plot( samp[,1:2], main="n=250")
#silly or sublime?
n <- 1000
#get the sample
samp <- quasiSamp( n=n, dimension=2, potential.sites=X, inclusion.probs=p)
plot( samp[,1:2], main="n=1000")
#I'm sure that you get the idea now.
#tidy
rm( N, n, X, p, samp)
}
\keyword{misc}