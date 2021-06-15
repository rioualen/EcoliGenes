#' @title Read the reference gene file
#' @name read_master_gene_file
#'
#' @return a data.frame
#'
#' @export
#'
#' @examples
read_master_gene_file <- function() {
	master_gene_file <- system.file("extdata", "master_gene_file_2021-06-14.tsv", package = "EcoliGenes")
	master_gene_table <- read.delim(master_gene_file, comment.char = "#", header = T, stringsAsFactors = F)
	master_gene_table
}

#' #' @title Add info into the master table. Deprecated.
#' #' @name complete_master_gene_file
#' #'
#' #' @import dplyr
#' #' @export
#' #'
#' #' @examples
#' complete_master_gene_file <- function() {
#' 	master_gene_table <- read_master_gene_file()
#'
#' 	master_bis <- master_gene_table %>%
#' 		arrange(Consensus_start) %>%
#' 		dplyr::mutate(left_bnumber = lag(Consensus_bnumber, default = NA),
#' 									right_bnumber = lead(Consensus_bnumber, default = NA))
#' 	write_master_gene_file(master_bis)
#' }
#'
#' #' @title Overwrite the reference gene file. Meant to be used with `complete_master_gene_file()`
#' #' @name write_master_gene_file
#' #'
#' #' @return a data.frame
#' #'
#' #' @export
#' #'
#' #' @examples
#' write_master_gene_file <- function(data) {
#' 	write.table(data, file = "inst/extdata/master_gene_file_2021-06-08.tsv", col.names = T, row.names = F, quote = F, sep = "\t")
#' }
