#' @title Read the reference gene file
#' @name read_master_gene_file
#'
#' @return a data.frame
#'
#' @export
#'
#' @examples
read_master_gene_file <- function() {
	master_gene_file <- system.file("extdata", "master_gene_file_2021-05-31.tsv", package = "EcoliGenes")
	master_gene_table <- read.delim(master_gene_file, comment.char = "#", header = T, stringsAsFactors = F)
	master_gene_table
}
#' @title Write the reference gene file
#' @name write_master_gene_file
#'
#' @return a data.frame
#'
#' @export
#'
#' @examples
write_master_gene_file <- function(data) {
	write.table(data, file = "inst/extdata/master_gene_file.tsv", col.names = T, row.names = F, quote = F, sep = "\t")
}
