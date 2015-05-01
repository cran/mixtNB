\name{wald.test}
\alias{wald.test}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Wald test for performing DE analysis}
\description{
This function implements the Wald test for performing DE according to three statistics: difference, ratio and logratio}
\usage{
wald.test(out, statistic = "diff", quiet = FALSE, alpha = 0.01)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{out }{
The fit of mixtNB
}
  \item{statistic }{
The statistic to be used: "diff" (difference, the default), "ratio" and "logratio"
}
  \item{quiet }{
Logical to indicate if the DE genes should be printed}
  \item{alpha }{
the significance level to detect DE genes}
}
\details{
This function implements the Wald test for performing DE according to three statistics: difference, ratio and logratio. It returns the statistics, the p-values and the adjusted p-values according to the Benjamini and Hochberg (1995)}
\value{A list containing
\item{stat }{The value of the Wald test}
\item{pvalue }{nominal p-values for each gene}
\item{pvalueadj }{adjusted p-values according to the Benjamini and Hochberg (1995)}
\item{var }{estimated variances of the genes}
\item{gname }{Positions of the filtered genes}
}

\references{
E. Bonafede, F. Picard, S. Robin and C. Viroli (2015), Modelling overdispersion heterogeneity in differential expression analysis using mixtures, under revision. 
}
\author{
Elisabetta Bonafede, Cinzia Viroli
}

\examples{
lambda.de<-matrix(runif(100,0,250),100)
lambda.de=cbind(lambda.de,lambda.de/exp(rnorm(100,0.5,0.125)))
lambda<-rbind(lambda.de,matrix(runif(900,0,250),900,2))
a<-runif(1000,0.5,600)
cr<-rep(1:2,each=5)
y<-matrix(0,1000,10)
for (i in 1:1000) for (l in 1:10) y[i,l]<-rnbinom(1,mu=lambda[i,cr[l]],size=a[i])
fit=fit.mixtNB(y,cr,K=3)
DE.genes=wald.test(fit)
}
\keyword{RNA-Seq data}
\keyword{Wald test}
