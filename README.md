# rabarbRa

[![Travis-CI Build Status](https://travis-ci.org/jeanmarielepioufle/rabarbRa.svg?branch=master)](https://travis-ci.org/jeanmarielepioufle/rabarbRa)

The R-package gathers functions and a object to quickly manipulate data.frame and related files (json,...).

The package has three purposes:
1. Easily and quickly manipulate data.frames and related files.
2. Identify processes that are memory and cpu eaters for further improvements.
3. Developing solution to 2.

The package is under active development. Its code and syntax might change greatly.

## Installation

```R
# install.packages("devtools")
devtools::install_github("jeanmarielepioufle/rabarbRa")
```

## Usage

```R
library(rabarbRa)


##########
# BASICS #
##########

# https://community.watsonanalytics.com/wp-content/uploads/2015/03/WA_Fn-UseC_-Telco-Customer-Churn.csv
ci <- rabarbRa(url="https://community.watsonanalytics.com/wp-content/uploads/2015/03/WA_Fn-UseC_-Telco-Customer-Churn.csv")

# manipulation
str(ci[])
names(ci[])
levels(ci[,2])
levels(ci[,2])<-c("A","B")
dim(ci)
length(ci[,1])

ci[1,"tenure"]
ci[1,"tenure"] <- 100
ci[1,"tenure"]
ci[1,] <- ci[2,]

# WARNING:
# Keep the brackets in order to manipulate the intern data.frame
ci[] <- ci[-1,]
class(ci)
dim(ci)

# ... OR you will destroy ci, and only keep the data.frame
# ci <- ci[-1,]
# class(ci) # data.frame

#############
# SELECTION #
#############

# rem: a selection is only valid for one action

select(ci,~gender=="A",~Churn)
ci[]

select(ci,variable=~Churn)
ci[]

select(ci,subset=~gender=="A")
ci[,1:3]

select(ci,variable = ~c(tenure,Contract))
ci[1:10,]

select(ci, ~InternetService == "No",~-tenure)
ci[]

select(ci, variable=~-(gender:tenure))
ci[]

select(ci, subset= ~ gender=="A" & InternetService == "No", variable=~-(gender:tenure))
ci[]

##############
# EXPRESSION #
##############
contingency <- ci$expression(~table(Churn,tenure,Contract,InternetService))
contingency[1,1,,]

# simple example
tmp <- ci$expression(~glm(Churn ~ tenure + PhoneService + PaymentMethod + MonthlyCharges + TotalCharges,family=binomial(link="logit")))

##############
# SAMPLES    #
##############
sample_n(ci,n=10)

```
I am working on making vignettes.

## Questions and remarks
Don't hesitate to contact me for more details and suggestions.
