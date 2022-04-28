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

#' @title Check if genes are pseudo genes
#' @name is_pseudogene
#'
#' @param bnum_list A character vector
#' @return A logical vector
#'
#' @import dplyr
#' @export
#'
#' @examples
is_pseudogene <- function(bnum_list) {
	master_gene_table <- read_master_gene_file()

	pseudogenes <- (master_gene_table %>% dplyr::filter(RegulonDB_type == "Pseudo Gene"))$Reference_bnumber

	check_pseudo <- function(x) {
		ifelse(x %in% pseudogenes, 1, 0)
	}
	res <- sapply(bnum_list, FUN = check_pseudo)
	unname(res)
}

#' @title Check if genes are phantom genes
#' @name is_phantomgene
#'
#' @param bnum_list A character vector
#' @return A logical vector
#'
#' @export
#'
#' @examples
is_phantomgene <- function(bnum_list) {
	master_gene_table <- read_master_gene_file()

	phantomgenes <- (master_gene_table %>% dplyr::filter(RegulonDB_type == "Phantom Gene"))$Reference_bnumber

	check_phantom <- function(x) {
		ifelse(x %in% phantomgenes, 1, 0)
	}
	res <- sapply(bnum_list, FUN = check_phantom)
	unname(res)
}
