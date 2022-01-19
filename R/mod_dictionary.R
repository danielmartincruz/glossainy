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
#' @import shi18ny

#' @importFrom shiny NS tagList 
mod_dictionary_ui <- function(id, japo_table){
  ns <- NS(id)
  tagList(
 
    shi18ny::useShi18ny(),
    
    # Language selector input
    shi18ny::langSelectorInput(ns("lang"), position = "fixed"),
    
    # UI elements
    # Text can be translated directly from the UI, using the ui_ function:
    h1(ui_(ns("hello"))),
    # OR by using uiOutput:
    uiOutput(ns("results"))
    
    
    

  )
}
    
#' tabla_base Server Function
#'
#' @noRd 
mod_dictionary_server <- function(input, output, session, data){
  ns <- session$ns
  # Configure shi18ny
  i18n <- list(
    defaultLang = "en",
    availableLangs = c("es", "en", "pt")
  )
  
  # Call language module to get currently selected language and save it in a reactive
  lang <- callModule(langSelector, "lang", i18n = i18n, showSelector = TRUE)
  
  # Update UI translation
  observeEvent(lang(),{
    uiLangUpdate(input$shi18ny_ui_classes, lang())
  })
  
  # Render translations by passing the text and the active (selected) language as the lang() parameter to the i_ function
  output$results <- renderUI({
    list(
      h1(i_("world", lang())), 
      br(), 
      h4(i_("language", lang()))
    )
  })
 
}
    
## To be copied in the UI
# mod_dictionary_ui("tabla_base_ui_1")
    
## To be copied in the server
# callModule(mod_dictionary_server, "tabla_base_ui_1")
 
