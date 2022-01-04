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
mod_tabla_base_ui <- function(id){
  ns <- NS(id)
  tagList(
 
    fluidRow(
      column(width = 9,
             shinydashboard::box(title = "Japones", collapsible = TRUE, width = NULL, solidHeader = FALSE,
                     DT::dataTableOutput(outputId = ns("japo_table"))
             )
      ),
      column(width = 3,
             shinydashboard::box(title = "Filters", width = NULL, solidHeader = TRUE, status = "warning",
                 selectInput(inputId = ns("canem") ,
                             label = "Canem", choices = c("ajo", "pepe"), selected = "ajo"
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
  filtered_commissions <- reactive({
    data <- data
    
  })
  
  output$japo_table <- DT::renderDataTable({
    temp_data <- filtered_commissions()

    final_table <- temp_data %>%
      datatable(
        extensions = c('FixedColumns',"FixedHeader"),
        options = list(dom = 't',
                       # scrollX = TRUE, scrollY = TRUE,
                       paging = FALSE , class = 'white-space: nowrap',
                       initComplete = JS(c(
                         "function(settings){",
                         "  var table = settings.oInstance.api();",
                         "  var ncols = table.columns().count();",
                         "  var nrows = table.rows().count();",
                         "  for(var i=0; i<nrows; i++){",
                         "    var rowname = table.cell(i,1).data();",
                         "    for(var j=1; j<ncols; j++){",
                         "      var headerName = table.column(j).header().innerText;",
                         "      var cell = table.cell(i,j);",
                         "      cell.node().setAttribute('title', rowname + ', ' + headerName);",
                         "    }",
                         "  }",
                         "}")),
                       fixedColumns = list(leftColumns = 3), autoWidth = FALSE 
        ),
        
        selection=list(mode="single", target="cell"), class = 'cell-border stripe', escape = F
      )
    return(final_table)
  })
  
 
}
    
## To be copied in the UI
# mod_tabla_base_ui("tabla_base_ui_1")
    
## To be copied in the server
# callModule(mod_tabla_base_server, "tabla_base_ui_1")
 
