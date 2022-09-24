#' Function to prepare data for visualization and plot a boxplot.
#'
#' @param cancer_type (character vector): rows of interest (single or multiple; data from the ‘type’ column)
#' @param patient_id (character vector) - IDs of patients of interest (data from the ‘bcr_patient_barcode’ column)
#' @param data
#'
#' @return a boxplot and a data frame
#' @export
#'
#' @examples getPlot(data = data, cancer_type = 'SKCM|SARC|READ|COAD')
#' @examples getPlot(data = data, patient_id = 'TTCGA-5N-A9KM|TCGA-BL-A0C8|TCGA-BL-A13I|TCGA-BL-A13J|TCGA-BL-A3JM|TCGA-BL-A5ZZ|TCGA-BT-A0S7|TCGA-BT-A0YX|TCGA-BT-A20J|TCGA-BT-A20N|TCGA-OR-A5J1|TCGA-OR-A5J2|TCGA-OR-A5J3|TCGA-OR-A5J4|TCGA-OR-A5J5|TCGA-OR-A5J6|TCGA-OR-A5J7|TCGA-OR-A5J8|TCGA-OR-A5J9|TCGA-OR-A5JA')
getPlot <- function(data, cancer_type="", patient_id=""){
  stopifnot("cancer_type must be character!" = is.character(cancer_type))
  stopifnot("patient_id must be character!" = is.character(patient_id))

  switch(
    rlang::check_exclusive(cancer_type, patient_id, .require = FALSE),
    cancer_type = message("`cancer_type` was supplied."),
    patient_id = message("`patient_id` was supplied."),
    message("No arguments were supplied")
  )


  if(cancer_type != ""){
    df_plot <- data %>% dplyr::filter(
      grepl(cancer_type, type)
    )
  }

  if(patient_id != ""){
    df_plot <- data %>% dplyr::filter(
      grepl(patient_id, bcr_patient_barcode)
    )
  }


  # Plot the datframe
  p <- ggpubr::ggboxplot(df_plot, x = "type", y = "OS.time",
                color = "type",
                add = "jitter",
                title = "",
                subtitle = "",
                caption = "Source: ggpubr",
                xlab ="Cancer Type", ylab = "Overal Survival (days)")
  p <- p + ggpubr::rremove("legend")

  return(p)
  return(df_plot)

}
