#' The program will take your data as input and return three numbers as output: estimate of s, estimate of alpha, and value of the statistic L.
#'
#' @param x Import Raw data
#' @param tolerance Tolerance quantity
#' @importFrom ("stats", "optimize")
#' @return Output three estimates by using maximum likelihood method
#' @field s.hat Output estimate of s
#' @field a.hat estimate of alpha
#' @field log.like.ratio value of the statistic L
#' @examples
#' x<-rexp(1000,0.1)
#' print(sigmaalphaLREP(x,10^-12))
#' @export
sigmaalphaLREP<-function(x,tolerance)
{

  iterations<-0
  z<-1
  tol<-tolerance
  oldz<-0
  n<-length(x)
  u<-function(x, s)
  {
    y<-x*s
    y
    out<- -log(mean(log(1+y)))+log(s)-mean(log(1+y))-1
  }
  while (iterations==0 | abs(z-oldz)>tol)
  {
    oldz<-z
    z<-mean(log(1+(z/min(x))*x))
    iterations=iterations+1
  }

  upper<-z
  upper<-upper/min(x)
  s.hat<-optimize( u,interval=c(10^(-12),upper),maximum=TRUE,x=x)$maximum
  a.hat<-1/mean(log(1+x*s.hat))
  s.hat <- 1/s.hat
  ln.exp.likel<-(-log(mean(x))-1)
  ln.pareto.likel<-(log(a.hat)-log(s.hat)-1-1/a.hat)
  denom<-max(ln.exp.likel,ln.pareto.likel)
  log.like.ratio <- ln.exp.likel-denom
  log.like.ratio<-log.like.ratio*n*(-2)
  result<-cbind(s.hat,a.hat,log.like.ratio)
}
