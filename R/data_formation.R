#' @import data.table
#' @importFrom googlesheets4 read_sheet 
data_formation <- function(path_OUTPUT) {
  # FILE_JAPO <- 'japo_data.csv'
  # japo_file <- fread(file.path(path_OUTPUT, FILE_JAPO), header = TRUE)
  japo_file <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1ABE1eIsWzC_koKSSarSQ4mBZM-c8_lAb5hgwN3qxIxM/edit#gid=0")
  setDT(japo_file)
  japo_file <- japo_file[, id := .I]
  
  setcolorder(japo_file, "id")

  return(list(japo_file))
}