#' tabla_base UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#'
#' @import DT
#' @import magrittr
#' @import shinydashboard

#' @importFrom shiny NS tagList 
mod_tabla_base_ui <- function(id, japo_table){
  ns <- NS(id)
  tagList(
 
    fluidRow(
      column(width = 9,
             shinydashboard::box(title = "Japones", collapsible = TRUE, width = NULL, solidHeader = FALSE,
                     DT::DTOutput(outputId = ns("japo_table"))
             )
      ),
      column(width = 3,
             shinydashboard::box(title = "Filters", width = NULL, solidHeader = TRUE, status = "warning",
                 selectizeInput(inputId = ns("type_filter") ,
                             label = "type", choices = unique(japo_table$type), selected = NULL, multiple = TRUE
                            ),
                 
                 checkboxGroupInput(
                   inputId = ns("columnas_filter"),
                   label = "Columnas mostradas", choices = unique(names(japo_table))[unique(names(japo_table)) != "id"],
                   selected = unique(names(japo_table))[unique(names(japo_table)) != "id"]
                 )
             )
      )
      )
    
    
    

  )
}
    
#' tabla_base Server Function
#'
#' @noRd 
mod_tabla_base_server <- function(input, output, session, data){
  ns <- session$ns
  filtered_japo_table <- reactive({
    data <- filter_jap_table(data, columnas_filter = input$columnas_filter, type_filter = input$type_filter)
    return(data)
  })
  
  output$japo_table <- DT::renderDT({
    temp_data <- filtered_japo_table()

    final_table <- get_datatable(temp_data)
              
    return(final_table)
  })
  
  observeEvent(input$japo_table_cell_clicked, {
    req(length(input$japo_table_cell_clicked) != 0) #Event must not being executed unless a cell is clicked
    removeModal()
    showModal(modal())
    
  })
  
  modal <- function() {
    ns <- session$ns

    modalDialog(
      p("Detailed table", style = "font-size:25px"),
      DT::dataTableOutput(ns("cell_click_table")),
      size = "l"
    )
    
  }
  
  output$cell_click_table <- DT::renderDataTable({
    
    test_res <- filtered_japo_table()
    row <- input$japo_table_cell_clicked$row
    col <- input$japo_table_cell_clicked$col
    id_clicked <- test_res[row]$id
    col_clicked <- names(test_res[, col, with = F])
    data_clicked <- copy(data) %>%
      .[id == id_clicked] %>%
      .[, id := NULL]
    setcolorder(data_clicked, col_clicked)
    DT::datatable(data_clicked)
    
  })
 
}
    
## To be copied in the UI
# mod_tabla_base_ui("tabla_base_ui_1")
    
## To be copied in the server
# callModule(mod_tabla_base_server, "tabla_base_ui_1")
 
