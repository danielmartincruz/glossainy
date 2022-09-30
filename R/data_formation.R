#' @import data.table
#' @importFrom googlesheets4 read_sheet 
data_formation <- function(link_excel) {
  # path_json <- file.path(getwd(), "gs4.json")
  # options(gargle_verbosity = "debug")
  # list.files(".secrets/")
  # futile.logger::flog.info("Connecting to gs")
  # googlesheets4::gs4_auth(path = path_json)

  # futile.logger::flog.info("Connected to gs!")

  japo_file <- googlesheets4::read_sheet(link_excel)
  setDT(japo_file)
  japo_file <- japo_file[, id := .I]

  setcolorder(japo_file, "id")

  # japo_file <- as.data.table(iris)
  # japo_file[, type := "tipo"]
  # japo_file[, id := .I]
  return(list(japo_file))
}