# rabarbRa

[![Travis-CI Build Status](https://travis-ci.org/jeanmarielepioufle/rabarbRa.svg?branch=master)](https://travis-ci.org/jeanmarielepioufle/rabarbRa)

The R-package gathers functions and a object to quickly manipulate data.frame and related files (json,...).

The package has two purposes:
1. Easily and quickly manipulate data.frames and related files.
2. Identify processes that are memory and cpu eaters for further improvements.

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

ci <- rabarbRa()

# import
#https://community.watsonanalytics.com/wp-content/uploads/2015/03/WA_Fn-UseC_-Telco-Customer-Churn.csv
ci$import(url="https://community.watsonanalytics.com/wp-content/uploads/2015/03/WA_Fn-UseC_-Telco-Customer-Churn.csv",filename=NULL)

# manipulation
str(ci[])
names(ci)
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

# variable selection
# the selection is reset after every action (get values, process formula, ...etc)
select_var(ci,"tenure")
ci[]

select_var(ci,c("tenure","Contract"))
ci[1:10]

# row selection
req <- query(variable="InternetService",fun_sign="==",value="No")
q <- queries(req)
select_row(ci,q)
select_var(ci,"tenure")
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
