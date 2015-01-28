
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(
  pageWithSidebar(
  
  # Application title
  headerPanel("2014 Bangarang Daily"),
  
  # Sidebar with a slider input for number of bins
  sidebarPanel(

  textInput("date",label=h4("Enter date here",value="")),
  helpText("e.g., YYYYMMDD"),

  #selectInput("wd", label = h4("Which computer?"), 
  #            choices = list("Samsung 1" = "C:/Users/RV Bangarang/", "Samsung 2" = "D:/", "Mac" = "/Users/eric.keen/"), 
  #            selected = 1),
  
  selectInput("range", label = h4("Choose Range"), 
              choices = list("All" = "ALL", "Verney" = "VER", "McKay" = "MCK","Wright"="WRI","N. Squally"="NSQ","S. Squally"="SSQ","Whale"="WHA","Campania"="CMP","Estevan"="EST","Caamano"="CAA","Gil Island"="GIL","Gribbell Is."="GRI"), 
              selected = 1),
  br(),
  actionButton("process",label=h3("Run it!")),
  br(),
  br(),  
  helpText(h4("Select Procedure")),
  checkboxInput("rub", label = "Download RUB",value=TRUE),  
  checkboxInput("siw", label = "Export Whale Sightings",value=FALSE),
  checkboxInput("dvmday", label = "Export DVMs",value=FALSE),
  checkboxInput("dvmproc", label = "Process DVMs",value=FALSE),
  br(), 
  helpText(h4("Echosounder Processing")),
  checkboxInput("hexparse", label = "Convert to ASCII",value=FALSE),
  checkboxInput("survass", label = "Assign survey data",value=FALSE),
  checkboxInput("echobind", label = "Combine day's files",value=FALSE),
  checkboxInput("echoavg", label = "Create RUB-equal output",value=FALSE),
  checkboxInput("trnecho", label = "Extract transects"),
  checkboxInput("wiwecho", label = "Extract focal follows",value=FALSE),
  checkboxInput("wiwmap", label = "Map focal follows",value=FALSE),
  checkboxInput("geotrn", label = "Georectify transects",value=FALSE),
  checkboxInput("geowiw", label = "Georectify focal follows",value=FALSE),
  br(),  
  downloadButton("daily", label = h4("Build Report")),
  br(),
  br()
  #helpText("Outputs a .csv of the day's sightings."),
  #helpText("Looks or .csv file in Data > 2014 > Dailies"),
  #helpText("Outputs a .csv of raw dvm data for each focal follow."),
  #helpText("Outputs a .csv of processed metrics for each sighting."),
  #helpText("CSV files are saved into folder 4-csv."),
  #helpText("Survey-assigned csv's are output to folder 5-survass."),
  #helpText("Outputs csv's to folder 6-day-bind."),
  #helpText("Reduces echodata (through bin-averaging) to a single ping for each line RUB output."),
  #helpText("Output the day's transect csv and a jpeg visualizing the file."),
  #helpText("Outputs a .csv and jpeg for each sighting."),
  #helpText("Outputs JPEGs to WIW-map-jpg."),
  #helpText("Data are averaged into 6m horizontal bins."),
  #helpText("Data are averaged into 6m horizontal bins.")
  
  
  ),
  

  
  mainPanel(
    tabsetPanel(type = "tabs", 
                tabPanel("Console", 
                         htmlOutput("console")
                         #plotOutput("nameplot")
                ), 
                tabPanel("Non-R Tasks", 
                         htmlOutput('nonrtasks')
                ),
                tabPanel("Raw RUB", 
                         # Create a new Row in the UI for selectInputs
                         fluidRow(
                           column(4, 
                                  selectInput("ev", 
                                              "Event", 
                                              c("All","NO POS","COM","REV","SIW","SIB","JEL","Other Sits","WIW"))
                           ),
                           column(4, 
                                  selectInput("eff", 
                                              "Effort:", 
                                              c("All","AV Transect","A Transect","WIW","T+WIW","Station","Casual","Off")) 
                           )
                         ),
                         tabsetPanel(
                           tabPanel("Position & Effort",dataTableOutput('poseff')),
                           tabPanel("Conditions",dataTableOutput('cond')),
                           tabPanel("Environment",dataTableOutput('env')),
                           tabPanel("Sightings",dataTableOutput('sit')),                           
                           tabPanel("Comments",dataTableOutput('com'))                           
                         )
                ), 
                tabPanel("SIW", 
                         verbatimTextOutput('siw')
                ),
                tabPanel("DVMs", 
                         verbatimTextOutput('dvm')
                )
                
    )
  )


))





