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

services <- rabarbRa()
services$create(names_array = c("service","version","format","auth_type","endpoint"))
services$insert(service="metno_radarnowcasting",version="mos.pcappi",format="netcdf",auth_type="none",endpoint="none")
services$insert(service="metno_radarnowcasting",version="gridpp",format="netcdf",auth_type="none",endpoint="none")
services$insert(service="metno_senorge",version="2.0",format="netcdf",auth_type="none",endpoint="none")
services$insert(service="metno_senorge",version="2.1",format="netcdf",auth_type="none",endpoint="none")
services$export("~\\x.json",format="json")

services$import(filename="~\\x.json")

services$values(j=1)
services$values(field="format")
services$values(i=1,j=4)

services$delete(j=4)
services$values(i=1)

# process a function on the whole data.frame
services$process(dim)

# process an expression in-between columns of the data.frame
contingency <- services$expression(~table(service,version))

# queries
req1 <- query(field="service",fun_sign="==",value="metno_senorge")
services$select(query=queries(req1))

req2 <- query(field="version",fun_sign="==",value="2.1")
q <- queries(req1,req2,logic="OR")
services$select(query=q)
services$values(query=q)

services

```
I am working on making vignettes.

## Questions and remarks
Don't hesitate to contact me for more details and suggestions.
