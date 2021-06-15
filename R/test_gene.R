#' @title Check if genes are valid bnumbers
#' @name is_valid_bnumber
#'
#' @param bnum_list A character vector
#' @return A logical vector
#'
#' @export
#'
#' @examples
is_valid_bnumber <- function(bnum_list) {
	master_gene_table <- read_master_gene_file()

	bnum_list %in% get_all_genes()
}

#' @title Check if genes are TF-coding
#' @name is_tf_gene
#'
#' @param bnum_list A character vector
#' @param source Optional, one of c("all", "zika", "regulondb")
#' @return A logical vector
#'
#' @export
#'
#' @examples
is_tf_gene <- function(bnum_list,  source = "all") {
	master_gene_table <- read_master_gene_file()

	bnum_list %in% get_tf_genes(source)
}
