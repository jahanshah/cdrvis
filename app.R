library(shiny)

data <- getData(input_file = "data/TCGA-CDR-SupplementalTableS1.xlsx")

if (interactive()) {

ui <- fluidPage(
  titlePanel("Overall Survival in Cancer"),
  sidebarLayout(
    sidebarPanel(

  # Selecting samples
  checkboxInput("sample", "Sample"),
  conditionalPanel(
        condition = "input.sample == true",
        selectInput("selection", "Selection Method",
                    list("cancer_type", "patient_id"))
  ),

  conditionalPanel(
    condition = "input.selection == 'cancer_type'",
      textInput("cancer", "Cancer Type", "SKCM|SARC|READ|COAD"),
      verbatimTextOutput("cancer")),

  conditionalPanel(
    condition = "input.selection == 'patient_id'",
    textInput("id", "Patient ID", "TCGA-OR-A5J1|TCGA-OR-A5J2|TCGA-OR-A5J3|TCGA-OR-A5J4|TCGA-OR-A5J5|TCGA-OR-A5J6|TCGA-OR-A5J7|TCGA-OR-A5J8|TCGA-OR-A5J9|TCGA-2F-A9KO|TCGA-2F-A9KP|TCGA-2F-A9KQ|TCGA-2F-A9KR|TCGA-2F-A9KT|TCGA-2F-A9KW|TCGA-4Z-AA7M|TCGA-4Z-AA7N|TCGA-4Z-AA7O|TCGA-4Z-AA7Q|TCGA-3C-AAAU|TCGA-3C-AALI|TCGA-3C-AALJ|TCGA-3C-AALK|TCGA-4H-AAAK|TCGA-5L-AAT0|TCGA-5L-AAT1|TCGA-5T-A9QA|TCGA-A1-A0SB|TCGA-A1-A0SD"),
    verbatimTextOutput("id")),

  # Selecting Statistical test
  checkboxInput("test", "Statistical Test"),
  conditionalPanel(
    condition = "input.test == true",
    selectInput("testMethod", "Method",
                list("t.test", "wilcox.test"))
  )),

  mainPanel(
  plotOutput("boxplot"),
  dataTableOutput('table')
  )

))

server = function(input, output) {

  output$cancer <- renderText({ input$cancer_type })
  output$id <- renderText({ input$patient_id })

output$boxplot <- renderPlot({
  if (input$selection == "cancer_type") {

    print(getPlot(data = data, cancer_type = input$cancer))

    } else {

      print(getPlot(data = data, patient_id = input$id))

    }
  })

output$table <- renderDataTable({
  if (input$selection == "cancer_type") {

    getContrasts(data = getPlot(data = data, cancer_type = input$cancer)$data, test.method = input$testMethod)

  } else {

    getContrasts(data = getPlot(data = data, patient_id = input$id)$data, test.method = input$testMethod)

    }
  })
}



shinyApp(ui, server)
}

