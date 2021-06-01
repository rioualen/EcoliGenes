#' @title Read the reference gene file
#' @name read_master_tf_file
#'
#' @return a data.frame
#'
#' @export
#'
#' @examples
read_master_tf_file <- function() {
	master_tf_file <- system.file("extdata", "master_tf_file_2020-08-14.tsv", package = "EcoliGenes")
	master_tf_table <- read.delim(master_tf_file, comment.char = "#", header = T, stringsAsFactors = F)
	master_tf_table
}
## deprecated, use read_master_gene_file()
