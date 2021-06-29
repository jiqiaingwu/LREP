#' This program takes your data and the significance level as input and returns the critical number for the test, the value of the -2L (deviance) statistic and the decision (Pareto or exponential) as output.
#'
#' @param x Import Raw data
#' @param alpha Significance level. Note: this program works only for the following significance levels: 0.10, 0.075, 0.05, 0.025, 0.01 and 0.005.
#' @return Output the critical number for the test, the value of the -2L (deviance) statistic and the decision (Pareto or exponential) .
#' @examples
#' x<-rexp(1000,0.1)
#' expparetotest(x,0.05)
#' @export
expparetotest<-function(x,alpha)
{
  n<-length(x)
  if (alpha==0.10) {a1=-4.817390
  a2=5.988430
  a3=0.455834
  C=1.642374 } else
    if (alpha==0.075) {a1=-5.698590
    a2=6.193300
    a3=0.464417
    C=2.072251 } else
      if (alpha==0.05) { a1=-6.256970
      a2=5.780480
      a3=0.458182
      C=2.705543} else
        if (alpha==0.025) { a1=-7.563470
        a2=6.315480
        a3=0.459347
        C=3.841459} else
          if (alpha==0.01) {  a1=-9.999120
          a2=8.384410
          a3=0.473707
          C=5.411894 } else
            if (alpha==0.005) { a1=-8.787270
            a2=6.377840
            a3=0.435622
            C=6.634897 }
  critical<-(a1/(n+a2*log(n))^a3+C)
  statistic<-sigmaalphaLREP(x,10^-12)[3]
  cat("Critical value:",critical, "\n")
  cat("Deviance statistic:",statistic, "\n")
  if (statistic<critical) cat("Data is comming from an exponential distribution \n")
  else cat("Data is comming from Pareto distribution \n")
}
