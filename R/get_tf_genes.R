#' @title Get TF-coding genes
#' @name get_tf_genes
#'
#' @return A character vector
#'
#' @import dplyr
#' @export
#'
#' @examples
get_tf_genes <- function() {
	master_gene_table <- read_master_gene_file()

	tfs <- master_gene_table %>% dplyr::filter(TF_regulondb == "yes")
	tfs$BNUMBER
}
#' @title Check if genes are TF-coding
#' @name is_tf_gene
#'
#' @return A logical vector
#'
#' @export
#'
#' @examples
is_tf_gene <- function(bnum_list) {
	master_gene_table <- read_master_gene_file()

	list_bnum %in% get_tf_genes()
}
