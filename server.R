# Choose Working Directory First!
#wd <- "C:/Users/RV Bangarang/" # "Samsung 1" 
#wd <-  "D:/"                   # "Samsung 2" 
wd <- "/Users/eric.keen/"       # "Mac"  

library(shiny)
library(reshape2)

setwd(paste(wd,"Dropbox/Bangarang Docs/R Bangarang/shiny",sep=""))
cdir <- getwd()
setwd(cdir)
source("nightly.R")

console <- "Hi!"

shinyServer(function(input,output) {

  cstir <- "Make sure you do all the non-R tasks first! (See tab)"
  console <- paste(console,cstir,sep="<br/>")
  output$console <- renderUI({HTML(console)})
  
  output$rawrub <- renderText({"No rub file has been loaded."})
  output$siw <- renderText({"The Whale Sightings haven't been exported yet."})
  output$dvm <- renderText({"The DVM data haven't been exported and processed yet."})
  output$nonrtasks <- renderText({"this is awesome"}) 

  ################################################
  ################# Process#######################
  ################################################
  observe({
    input$process
    if(input$process==0){
      return()
    }
    isolate({
      if(input$date == ""){
         cstir <- paste(Sys.time()," : Select a date first!",sep="")
         console <- paste(console,cstir,sep="<br/>")
         output$console <- renderUI({HTML(console)})
         return()
      }
      ##########################
      steps <- 0
      starttime <- Sys.time()
      cstir <- paste(Sys.time()," : Here we go...",sep="")
      console <- paste(console,cstir,sep="<br/>")
      output$console <- renderUI({HTML(console)})
      ####################################################
      ####################################################
      ####################################################
      ####################################################     
      #wd <- input$wd
      date <- input$date
      range <- input$range
      ####################################################
      ####################################################
      ####################################################
      ####################################################
      if(input$rub==TRUE){
      steps <- steps + 1
      cstir <- paste(Sys.time()," : Loading RUB file...",sep="")
      console <- paste(console,cstir,sep="<br/>")
      output$console <- renderUI({HTML(console)})
      ##############
      rub <- datefilter14(date,date,wd)
      ##############
      cstir <- paste(Sys.time()," : Done! RUB file for date ",date," has ",nrow(rub)," rows.",sep="")
      console <- paste(console,cstir,sep="<br/>")
      output$console <- renderUI({HTML(console)})
      ##############
      if(nrow(rub)==0){
         cstir <- paste(Sys.time()," : WAIT! This RUB file has 0 rows! Abort!",sep="")
         console <- paste(console,cstir,sep="<br/>")
         output$console <- renderUI({HTML(console)})  
         return()
      }
      ##############
      cstir <- paste(Sys.time()," : Now review this RUB file for COM, REV and other mistakes.",sep="")
      console <- paste(console,cstir,sep="<br/>")
      output$console <- renderUI({HTML(console)})
      ##############
      ################# RAW RUB TAB ##################
      output$poseff <- renderDataTable({
        #data.frame(c(1:5),c(1:5)) # this isn't working yet
        #rub[1:10,1:10]
      })
      output$cond <- renderDataTable({
        data.frame(c(1:5),c(1:5)) # this isn't working yet
      })
      output$env <- renderDataTable({
        data.frame(c(1:5),c(1:5)) # this isn't working yet
      })
      output$sit <- renderDataTable({
        data.frame(c(1:5),c(1:5)) # this isn't working yet
      })
      output$com <- renderDataTable({
        data.frame(c(1:5),c(1:5)) # this isn't working yet
      })     
      ################################################
      
      }
      ####################################################
      ####################################################
      if(input$siw==TRUE){
        steps <- steps + 1
        cstir <- paste(Sys.time()," : Exporting Whale Sightings csv...",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
        siw14(date,date,wd)
        ##############
        cstir <- paste(Sys.time()," : Done!",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
        cstir <- paste(Sys.time()," : Now review this SIW data for missing data; change the RUB file and re-start this process if you find mistakes.",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
      }
      ####################################################
      ####################################################
      if(input$dvmday==TRUE){
        steps <- steps + 1
        cstir <- paste(Sys.time()," : Exporting raw DVM .csv's for each focal follow...",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
        dvmday(date,wd) # output csv of raw dvm data from focal follows, a file for each sighting of the day.
        ##############
        cstir <- paste(Sys.time()," : Done!",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
        cstir <- paste(Sys.time()," : Now review these DVM files for dumb data; change the RUB file and re-start this process if you find mistakes.",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
        
      }
      ####################################################
      ####################################################
      if(input$dvmproc==TRUE){
        steps <- steps + 1
        cstir <- paste(Sys.time()," : Processing DVM .csv's...",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
        dvm.process(date,wd)  # output csv of processed metrics, a file for each sighting of the day.
        ##############
        cstir <- paste(Sys.time()," : Done!",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
        cstir <- paste(Sys.time()," : Now review these DVMproc data for dumb data; if you find mistakes, change the RUB file and re-start this process.",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
      }
      ####################################################
      ####################################################
      if(input$hexparse==TRUE){
        steps <- steps + 1
        cstir <- paste(Sys.time()," : Converting lined HEX echo files to ASCII...",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
        newhexparse(date,date,wd) # convert lined hex files into a ASCII .csv file in R.##### 
        ##############
        cstir <- paste(Sys.time()," : Done!",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
      }
      ####################################################
      ####################################################
      if(input$survass==TRUE){
        steps <- steps + 1
        cstir <- paste(Sys.time()," : Assigning survey/effort data to echo .csv's...",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
        newsurvass(date,date,wd) # assign survey effort data to the echo csv's in R.  
        ##### THESE are the UNCOMPRESSED ORIGINAL DATA before data reduction, filtering or processing occurs. 
        ##############
        cstir <- paste(Sys.time()," : Done!",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
      }
      ####################################################
      ####################################################
      if(input$echobind==TRUE){
        steps <- steps + 1
        cstir <- paste(Sys.time()," : Combining all echo .csv's into a single file...",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
        echobind(date,wd) #  Bind all non-reduced survass echo csvs for a single date into a single day mega file.
        ##############
        cstir <- paste(Sys.time()," : Done!",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
      }
      ####################################################
      ####################################################
      if(input$echoavg==TRUE){
        steps <- steps + 1
        cstir <- paste(Sys.time()," : Reducing echo file to a 1 for 1 match with RUB daily",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
        echoavg(date,wd,1) # Create a rub-resolution csv (and jpg) that reduces the echodata to a single ping entry for each RUB line. Ideal for habitat use analyses?
        ##############
        cstir <- paste(Sys.time()," : Done!",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
      }
      ####################################################
      ####################################################
      if(input$trnecho==TRUE){
        steps <- steps + 1
        cstir <- paste(Sys.time()," : Isoldating echo data from transect effort only...",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
        trnecho(date,wd,1) # Isolate transect-only echo data. Output the day's transect csv and a jpeg visualizing the file.
        ##############
        cstir <- paste(Sys.time()," : Done!",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
      }
      ####################################################
      ####################################################
      if(input$wiwecho==TRUE){
        steps <- steps + 1
        cstir <- paste(Sys.time()," : Isolating echo data for each focal follow...",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
        wiwecho(date,wd,1) # Isolate WIW-focal follow data for the day. Output a csv and jpeg for each sighting.
        ##############
        cstir <- paste(Sys.time()," : Done!",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
      }
      ####################################################
      ####################################################
      if(input$wiwmap==TRUE){
        steps <- steps + 1
        cstir <- paste(Sys.time()," : Mapping echo data from each focal follow...",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
        wiwmap(date,wd) # Map the focal follow tracks
        ##############
        cstir <- paste(Sys.time()," : Done!",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
      }
      ####################################################
      ####################################################
      if(input$geotrn==TRUE){
        steps <- steps + 1
        cstir <- paste(Sys.time()," : Georectifying transect echo data...",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
        georectify(date,"TRN","RAW",wd) # georectify transect data
        ##############
        cstir <- paste(Sys.time()," : Done!",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
      }
      ####################################################
      ####################################################
      if(input$geowiw==TRUE){
        steps <- steps + 1
        cstir <- paste(Sys.time()," : Georectifying WIW echo data...",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
        ##############
        georectify(date,"WIW","RAW",wd) #georectify WIW dAte
        ##############
        cstir <- paste(Sys.time()," : Done!",sep="")
        console <- paste(console,cstir,sep="<br/>")
        output$console <- renderUI({HTML(console)})
      }
      ####################################################
      ####################################################
      ####################################################
      ####################################################
      cstir <- paste(Sys.time()," : Finished with the whole process!",sep="")
      console <- paste(console,cstir,sep="<br/>")
      output$console <- renderUI({HTML(console)})
      endtime <- Sys.time()
      diff <- difftime(endtime,starttime,units="mins")
      cstir <- paste(Sys.time()," : ",steps," steps completed in ",diff," minutes!",sep="")
      console <- paste(console,cstir,sep="<br/>")
      output$console <- renderUI({HTML(console)})
      ####################################################
      ####################################################
      }) # end isolate 
  }) # end observe of Process Action
  
  ################################################
  ################################################
  ################################################
  ################################################
  ################# NON-R TASKS###################
  ################################################   
  output$nonrtasks <- renderUI({
    s1 <- "Before processing:"
    s2 <- "You gotta do this"
    HTML(paste(s1, s2, sep = '<br/>'))
  })
  ################################################
  ################################################
  ################################################
  
})
