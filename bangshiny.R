#devtools::install_github('rstudio/shinyapps')
library("shiny")
library("shinyapps")

wd <- "/Users/eric.keen/" # for mac
# wd <- "C:/Users/RV Bangarang/" # for samsung

setwd(paste(wd,"Dropbox/Bangarang Docs/R Bangarang/shiny",sep=""))


shinyapps::setAccountInfo(name='bangarang', 
                          token='6F3FC1A905B80C49616C0B24DEC7E993', 
                          secret='YRbdkKXocHafJvIovrXpJrZAQV5a/NWiv3d5FYEY')


runApp()

#deployApp(appName="nightly")
#deployApp(appName="season2")



