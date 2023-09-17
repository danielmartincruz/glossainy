filter_jap_table <- function(data, columnas_filter, type_filter, leccion_filter){
  if(is.null(data)){stop("No data")}
  if(is.null(columnas_filter)){stop("No columns selected")}
  
  columnas_filter <- c("id",columnas_filter)
  if(is.null(type_filter)){type_filter <- unique(data$type)}
  if(is.null(leccion_filter)){leccion_filter <- unique(data$Lesson)}
  # Create a pattern for filtering
  pattern <- paste(leccion_filter, collapse = "|")
  
  data <- data %>%
    .[type %in% type_filter] %>%
    .[,..columnas_filter] %>%
    .[grepl(pattern, Lesson)]
  
  return(data)
}
