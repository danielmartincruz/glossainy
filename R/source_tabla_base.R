filter_jap_table <- function(data, columnas_filter, type_filter){
  columnas_filter <- c("id",columnas_filter)
  if(is.null(type_filter)){type_filter <- unique(data$type)}
  
  data <- data %>%
    .[type %in% type_filter] %>%
    .[,..columnas_filter]
  
  return(data)
}
