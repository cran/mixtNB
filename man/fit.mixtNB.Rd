\name{fit.mixtNB}
\alias{fit.mixtNB}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Fitting mixtures of Negative Binomials in RNA-Seq data
}
\description{
A mixture of K Negative Binomial distributions is fitted on the data with the aim to cluster the genes according to their dispersions. The number of groups must be known in advance.}
\usage{
fit.mixtNB(y, cr, K, it = 200, eps = 1e-05, init = NULL, seme = 1, 
           filter = TRUE, quiet = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{y }{matrix that contains the (normalized) dataset where the rows contain the set of replicates in the counts in two conditions. Given p the number of genes and n the total number of replicates, the matrix must have dimensions p x n.

}
  \item{cr }{a vector with n elements that contains the numerical labels of the conditions 
}
  \item{K }{the number of mixture components}
  \item{it }{maximum number of iterations for the EM algorithm 
}
  \item{eps }{
a tolerance level for checking the convergence of the EM algorithm
}
  \item{init }{a list that may contain the initial values for the EM algorithm. It may contain: a K-vector 'a' that are the sizes or dispersions of the Negative Binomials, 'w' is the vector with the K initial values for the weights of the components; 'lambda' is the matrix of dimension p x 2 with the initial values of the lambda parameters. If init is NULL, a random initialization will be used.
}
  \item{seme }{
A numerical value to be used in the set.seed function}
  \item{filter }{
Logical to indicate the genes with very small counts should be removed
}
  \item{quiet }{
Logical to indicate if information about the fitting should be provided
}
}
\details{
A mixture of K components is fitted with the aim of clustering the genes according to their dispersions. Genes with too small number of reads across experiments are filtered out. The default is to filter out genes with no more than 5 reads totally across all experiments, AND with no more than 0.5 reads averagely across all experiments. The EM algorithm stops when the maximum number of iterations are reached or the relative increment of log-likelihood is smaller than eps. 
}
\value{A list containing
\item{y }{The filtered data}
\item{K }{The number of components}
\item{cr }{Labels denoting the condition for the replicates}
\item{cl }{Posterior classification of the genes to the components}
\item{likelihood }{Log-likelihood at each iteration}
\item{AIC }{Akaike information criterion}
\item{BIC }{Bayesian information criterion}
\item{a }{Estimated dispersions}
\item{lambda }{Estimated means}
\item{f.z.y }{Estimated posterior probabilities}
\item{time.sec }{Computational time (in seconds)}
\item{variances }{Estimated variances}
\item{gname }{Positions of the filtered genes}

}
\references{
E. Bonafede, F. Picard, S. Robin and C. Viroli (2015), Modelling overdispersion heterogeneity in differential expression analysis using mixtures, under revision. 
}
\author{
Elisabetta Bonafede, Cinzia Viroli
}

\examples{
# create a toy data set with 1000 genes, and 5 samples in each of the two conditions. 
# The first 100 genes are DE expressed. The other 900 genes are null. 
 
lambda.de<-matrix(runif(100,0,250),100)
lambda.de=cbind(lambda.de,lambda.de/exp(rnorm(100,0.5,0.125)))
lambda<-rbind(lambda.de,matrix(runif(900,0,250),900,2))
a<-runif(1000,0.5,600)
cr<-rep(1:2,each=5)
y<-matrix(0,1000,10)
for (i in 1:1000) for (l in 1:10) y[i,l]<-rnbinom(1,mu=lambda[i,cr[l]],size=a[i])
fit=fit.mixtNB(y,cr,K=3)
}
\keyword{mixture}
\keyword{RNA-Seq data}% __ONLY ONE__ keyword per line
