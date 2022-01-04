#' Run the Shiny Application
#'
#' @param ... A series of options to be used inside the app.
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app <- function(
  data_path = NULL,
  ...
) {
  
  if(is.null(data_path) || data_path == "") {
    data_path <- '/Users/danielmartincruz/Documents/japones/data-raw'
  }
  
  data_list <- data_formation(data_path)
  
  server_func <- app_server_factory(data_list)
  
  ui <- app_ui(NULL, data_list[[1]])
  
  with_golem_options(
    app = shinyApp(
      ui = ui, 
      server = server_func
    ), 
    golem_opts = list(...)
  )
}
