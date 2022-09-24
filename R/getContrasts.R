#' Function to test cancer types.
#'
#' @param test.method the type of test. group1,group2: the compared groups in the pairwise tests. Available only when method = "t.test" or method = "wilcox.test".
#' @param data
#'
#' @return table of test results
#' @export
#'
#' @examples getContrasts(data = df_plot, test.method = "t.test")
getContrasts <- function(data, test.method = "t.test"){

  tests <- ggpubr::compare_means(OS.time ~ type, data = data, method = test.method)

  return(tests)
}

