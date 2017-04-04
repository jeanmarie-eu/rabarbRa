library(rabarbRa)

services <- rabarbRa()

# new data.frame
services$create(names_array = c("institute","service","version","format","auth_type","endpoint"))

# insert information
services$insert(institute="metno",service="senorge",version="2.0",format="netcdf",auth_type="none",endpoint="none")
services$insert(institute="metno",service="senorge",version="2.1",format="netcdf",auth_type="none",endpoint="none")
services$insert(data.frame(institute="metno",service="senorge",version="2.1",format="netcdf",auth_type="basic",endpoint="none"))

# head
services$heads()

# requests syntaxe
req1 <- query(field="service",fun_sign="==",value="senorge")
req2 <- query(field="version",fun_sign="==",value="2.1")

# requests 1
q <- queries(req1)
services$select(query=q)
services$values(query=q)
services$values(query=q,"service")
services$values(query=q,"format")

# requests 1 AND 2
q <- queries(req1,req2,logic="AND")
services$select(query=q)
services$values(query=q)
services$values(query=q,"service")
services$values(query=q,"format")

# requests 1 OR 2
q <- queries(req1,req2,logic="OR")
services$select(query=q)
services$values(query=q)

#export
services$export()

# save
services$save(normalizePath(file.path("~/","services.json"),  mustWork = FALSE))

#import
test <- rabarbRa()
test$import(filename=normalizePath(file.path("~/","services.json"),  mustWork = FALSE))
test$export()
