#' @import data.table
#' @importFrom googlesheets4 read_sheet 
data_formation <- function(link_excel) {
  japo_file <- googlesheets4::read_sheet(link_excel)
  setDT(japo_file)
  japo_file <- japo_file[, id := .I]
  
  setcolorder(japo_file, "id")

  return(list(japo_file))
}