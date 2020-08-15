#' @title Get TF-coding genes
#' @name get_target_genes
#'
#' @return A character vector
#'
#' @import dplyr
#' @export
#'
#' @examples
get_target_genes <- function() {
	master_gene_table <- read_master_gene_file()

	target_genes <- master_gene_table %>%
		dplyr::filter(BNUMBER != "-") %>%
		dplyr::filter( !GENE_TYPE %in% c("Phantom Gene", "Pseudo Gene") ) %>%
		dplyr::filter(! PRODUCT_TYPE %in% c("small RNA", "tRNAs", "rRNA"))
	target_genes$BNUMBER
}
#' @title Check if genes are TF-coding
#' @name is_target_gene
#'
#' @param bnum_list A character vector
#' @return A logical vector
#'
#' @export
#'
#' @examples
is_target_gene <- function(bnum_list) {
	master_gene_table <- read_master_gene_file()

	bnum_list %in% get_target_genes()
}
