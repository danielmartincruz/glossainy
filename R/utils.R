get_datatable <- function(temp_data){
  final_table <- temp_data %>%
    datatable(
      extensions = c('Buttons'),
      options = list(dom = 'Bfrtip',
                     searching = TRUE,
                     ordering = TRUE,
                     buttons = c('copy', 'csv', 'excel', 'pdf'),
                     # scrollX = TRUE, scrollY = TRUE,
                     pageLength = 15, info = FALSE,
                     lengthMenu = list(c(5,15, -1), c("5","15", "All")),
                     class = 'white-space: nowrap',
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
                       "}"))
                     # fixedColumns = list(leftColumns = 3),
                     # autoWidth = FALSE,
                     # columnDefs = list(list(visible=FALSE, targets=1))
      ),
      
      selection=list(mode="single", target="cell"), class = 'cell-border stripe', escape = F,
      filter = list(
        position = 'top', clear = FALSE
      )
    )
  
  return(final_table)
}