#Packages
library(DSI)
library(DSOpal)
library(dsBaseClient)
library(dsOmicsClient)

#Connection to the opal server

builder <- DSI::newDSLoginBuilder()
builder$append(server = "study1", url = "http://192.168.56.100:8080/", 
               user = "administrator", password = "datashield_test&", 
               resource = "OMICS.data", driver = "OpalDriver")

logindata <- builder$build()

conns <- datashield.login(logins = logindata, assign = TRUE, 
                          symbol = "res")

ds.class(x = "res", datasources = conns)

#coerce the resource to an ExpressionSet

datashield.assign.expr(conns = conns, 
                       symbol = "rse",
                       expr = quote(as.resource.object(res)))

ds.class(x = "rse", datasources = conns)

# Calculate number of features and samples 

ds.dim(x = "rse", type = "split", datasources = conns)

#Feature names

feature.names<-ds.featureNames(object = "rse", datasources = conns)
lapply(X = feature.names,  FUN = head)

#Variables names

ds.varLabels(object = "rse", datasources = conns)

#Create age histogram 

ds.histogram(x = "rse$age", datasources = conns)

#Calculate age mean, variance and standard deviation

ds.mean(x = "rse$age", datasources = conns)
(variance<-ds.var(x = "rse$age", datasources = conns))
sqrt(variance[[1]][1])

#Levels of gender covariate

gender.table<-ds.table( "rse$gender", datasources = conns)
gender.table$output.list$TABLE_rvar.by.study_counts

#Differential expression analysis

(results<-ds.limma(model =  ~ gender, Set = "rse"))

#Select differentially expressed genes 

keep.sta.sig<-which(results$study1$adj.P.Val < 0.01)
results.sta.sig<-results$study1[keep.sta.sig,]

#Up regulated genes

keep.up.reg.genes<-which(results.sta.sig$logFC > 1)
(up.reg.genes<-results.sta.sig[keep.up.reg.genes,])

#Down regulated genes

keep.down.reg.genes<-which(results.sta.sig$logFC < (-1))
(down.reg.genes<-results.sta.sig[keep.down.reg.genes,])



# Clear the Datashield R sessions and logout

DSI::datashield.logout(conns)