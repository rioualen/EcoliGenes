#' @title Read the reference gene file
#' @name read_master_gene_file
#'
#' @return a data.frame
#'
#' @export
#'
#' @examples
read_master_gene_file <- function() {
	master_gene_file <- system.file("extdata", "GeneProduct-IDs.tsv", package = "EcoliGenes")
	master_gene_table <- read.delim(master_gene_file, comment.char = "#", header = T, stringsAsFactors = F)
	master_gene_table
}
