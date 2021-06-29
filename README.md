
<!-- README.md is generated from README.Rmd. Please edit that file -->

# LREP

<!-- badges: start -->
<!-- badges: end -->

The goal of LREP is to estimate the Parameters for the Pareto
Distribution and test Pareto vs. Exponential Distributions

## Installation

You can install the released version of LREP from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("LREP")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jiqiaingwu/LREP")
```

## Introduction

Our test is a likelihood ratio test of the following hypotheses:

Ho: data comes from an exponential distribution, versus the alternative

H1: data comes from a Pareto distribution.

The approach is to consider the ratio of the maxima of the likelihoods
of the observed sample under the Pareto or exponential (in the
numerator) and exponential (in the denominator) models. The logarithm
(natural) of the likelihood ratio, the L statistic, is:

![main
equation](https://latex.codecogs.com/svg.image?L=log%5Cfrac%7Bmax(%5Cunderset%7B%5Calpha%20%3E0,s%3E0%7D%7Bsup%7DL_%7BPareto%7D(%5Cvec%7Bx%7D%7C%5Calpha,s),%5Cunderset%7B%5Csigma%20%3E0%7D%7Bsup%7DL_%7Bexp%7D(%5Cvec%7Bx%7D%20%7C%20%5Csigma%20))%7D%7B%5Cunderset%7B%5Csigma%20%3E0%7D%7Bsup%7DL_%7Bexp%7D(%5Cvec%7Bx%7D%7C%5Csigma%20)%7D)

Where ![Image of Equation
1](https://latex.codecogs.com/svg.image?%5Cvec%7Bx%7D) is the observed
sample of excesses and ![Image of Equation
2](https://latex.codecogs.com/svg.image?L_%7BPareto%7D(%5Cvec%7Bx%7D%7C%5Calpha%20,s))
and ![Image of Equation
3](https://latex.codecogs.com/svg.image?L_%7Bexp%7D(%5Cvec%7Bx%7D%7C%5Csigma%20))
are the likelihood functions of the sample under Pareto and exponential
models, respectively.

We use a Pareto distribution with the survival function ![Image of
Formula
1](https://latex.codecogs.com/svg.image?S(x)=P(X%3Ex)=(%5Cfrac%7B1%7D%7B1+%5Cfrac%7Bx%7D%7Bs%5Calpha%7D%7D)%5E%7Ba%7D)
and exponential distribution with the survival function ![Image of
Formula
2](https://latex.codecogs.com/svg.image?S(x)=P(X%3Ex)=exp(-%20%5Cfrac%7Bx%7D%7B%5Csigma%20%7D)).
To compute L, both likelihoods are maximized first (via maximum
likelihood estimates, MLEs, of the parameters), and then the natural
logarithm of their ratio is taken as the likelihood ratio statistic.
Panorska et al. (2007) provide the necessary theoretical results for the
implementation of the numerical routines necessary for the computation
of L. The properties of the test, proofs and more details on the
optimization process appear separately in Kozubowski et al.(2007)

The ![Image of Equation
4](https://latex.codecogs.com/svg.image?(1%20-%20%5Cgamma)100)
percentiles of L provide the critical numbers for our test on the
significance level ![Image of Equation
5](https://latex.codecogs.com/svg.image?%5Cgamma%20). The test is
one-sided and we reject the null hypothesis if the computed value of the
test statistic exceeds the critical number. We have computed some common
percentiles for the distribution of L under the null hypothesis for
different sample sizes and for the limiting case. The percentiles for
finite sample sizes were computed via Monte Carlo simulation with 10,000
samples of a given size from the exponential distribution (Table below).

![Table 1](man/figures/Table1.png)

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(LREP)
###example when data is Exponential
####################################
x<-rexp(1000,0.000000000005)
1/mean(x)
#> [1] 5.244254e-12
sigmaalphaLREP(x,10^-12)
#>         s.hat     a.hat log.like.ratio
#> [1,] 17535662 0.1148668              0
expparetotest(x,0.05)
#>         s.hat     a.hat log.like.ratio
#> [1,] 17535662 0.1148668              0
#> Critical value: 2.446109 
#> Deviance statistic: 0 
#> Data is comming from an exponential distribution
##asymptotic p-value
1/2*(1-pchisq(0,df=1))
#> [1] 0.5
x<-rexp(1000,0.1)
1/mean(x)
#> [1] 0.09823991
sigmaalphaLREP(x,10^-12)
#>         s.hat    a.hat log.like.ratio
#> [1,] 17256.29 1696.253              0
expparetotest(x,0.05)
#>         s.hat    a.hat log.like.ratio
#> [1,] 17256.29 1696.253              0
#> Critical value: 2.446109 
#> Deviance statistic: 0 
#> Data is comming from an exponential distribution
##asymptotic p-value
1/2*(1-pchisq(1.596044,df=1))
#> [1] 0.1032324
###example when data is Pareto
####################################
pareto.generation<- function(s,a,n)
{
    u<-runif(n)
    x<-s*((1-u)^(-1/a)-1)
    x
}
x<-pareto.generation(10,7,1000)
sigmaalphaLREP(x,10^-12)
#>         s.hat    a.hat log.like.ratio
#> [1,] 8.668065 6.157946       29.34649
expparetotest(x,0.05)
#>         s.hat    a.hat log.like.ratio
#> [1,] 8.668065 6.157946       29.34649
#> Critical value: 2.446109 
#> Deviance statistic: 29.34649 
#> Data is comming from Pareto distribution
##asymptotic p-value
1/2*(1-pchisq(14.43144,df=1))
#> [1] 7.267762e-05
```
