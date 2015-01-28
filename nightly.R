# Library
#library(PBSmapping)
#library(maps)
#library(maptools)
#data(nepacLLhigh)
#library(RColorBrewer)

#
nightlysource <- function(wd){
setwd(paste(wd,"Dropbox/Bangarang Docs/R Bangarang/2014",sep=""))
source("B14_Functions.R")
source("transectplotday.R")
#source("ctdplot.R")
source("Daily_Functions.R")
source("sitmap-functions.R")
source("SIW14.R")
source("wiw-attach.R")
source("dvm-csv.R")
source("dvm-process.R")
setwd(paste(wd,"Dropbox/Bangarang Docs/R Bangarang/2014/echo",sep=""))
source("echoplotfunctions.R")
source("newhexparse.R")
source("newsurvass.R")
source("echobind.R")
source("echoavg.R")
source("echoplots.R")
source("echofilter.R")
source("wiwfilter.R")
source("echovissimple.R")
source("newplot.R")
source("imgjapply.R")
source("imgj-trn-apply.R")
source("georectify.R")
source("wiwmap.R")
}

nightlysource(wd)

