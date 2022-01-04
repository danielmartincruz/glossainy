#' @import data.table
data_formation <- function(path_OUTPUT) {
  FILE_JAPO <- 'japo_data.csv'

  
  japo_file <- fread(file.path(path_OUTPUT, FILE_JAPO), header = TRUE)

  return(list(japo_file))
}