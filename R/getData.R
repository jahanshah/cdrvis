#' Read first sheet from an Excel file containing metadata
#'
#' @param input_file input an Excel file
#'
#' @return a data frame
#' @export
#'
#' @examples getData(input_file = "data/TCGA-CDR-SupplementalTableS1.xlsx")
getData <- function(input_file){

  # memory management
  options(java.parameters = c("-XX:+UseConcMarkSweepGC", "-Xmx8192m"))
  gc()

  # load data
  # Retain data from the first sheet of the spreadsheet
  df <- xlsx::read.xlsx(
    input_file,
    1
  # Retain only the data for patients with known tumor status
  )%>% dplyr::filter(
    tumor_status != "NA"
  )
  return(df)
}
