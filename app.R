# Version 0.1.0
# Laboratory of analysis biochemical and instrumental
# UGA LAngebio
# authors: Héctor Guillén Alonso Robert Winkler

library(shiny)
library(MALDIquant)
library(MALDIquantForeign)

options(shiny.maxRequestSize = 1000*1024^2)

ui <- fluidPage(
  titlePanel("MassView Assistant"),
  h2("Summary"),
  p("MassView Assistant is developed as tool of", strong("MQ_Assitant,"), "a MALDIquant based tools for Mass Spectrometry (MS), 
        MassView Assistant is the continuation of the MQ_Assistant developing, you can know more about it", a("here", href = "https://doi.org/10.1002/rcm.9590")),
  img(src = "Logo_LABI chico.png", height = 50, align = "center"),
  p("MassView Assistant is a product of", a("LABI", href ="http://www.lababi.bioprocess.org")),
  
  sidebarLayout(
    sidebarPanel(
      
      helpText(""),
      
      fluidRow(
        fileInput("mzMLfile", label = h3("Upload a mzML file"), multiple = FALSE, accept = ".mzML")
      ),
      
      fluidRow(
        sliderInput("microscan", label = h3("Microscan selector"), min = 1, 
                    max = 10, value = 1, step = 1)
      ),
      
      p(h2("Exporting")),
      
      fluidRow(
        downloadLink('downloadPDF', 'Save as PDF')
      ),

            
      ),
     
    mainPanel(
      textOutput("microscanNumber"),
      plotOutput("massSpectra")
      
    )
  )
  
)

# Define server logic ----
server <- function(input, output, session) {
  
  
  observe({
    
    file <- input$mzMLfile
    
    if (is.null(file))
      return(NULL)

    updateSliderInput(session, "microscan", value = 1)
    spectra <- import(file$datapath)
    updateSliderInput(session, "microscan", max = length(spectra))
  
    output$massSpectra <- renderPlot({
      plot(spectra[[input$microscan]])
      })
    
    ##### Exportar como PDF #####
    output$downloadPDF <- downloadHandler(
      filename = function() {
        paste(gsub(".mzML", "", input$mzMLfile$name), '.pdf', sep='')
      },
      content = function(file) {
        pdf(file, width = 9, height = 7.3125)
        plot(spectra[[input$microscan]])
        dev.off()
      })

   
  })

  output$microscanNumber <- renderText({ 
    paste("Microscan selected:", input$microscan)
  })
  
  

}

# Run the app ----
shinyApp(ui = ui, server = server)