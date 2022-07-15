#' @title Check if bnumbers are valid
#' @name is_valid_bnumber
#' @param bnum_list A character vector
#' @return A logical vector of same size as `bnum_list`
#' @export
#' @examples
is_valid_bnumber <- function(bnum_list) {
	bnum_list %in% get_all_genes()
}

#' @title Check if genes are TF-coding according to RegulonDB
#' @name is_tf_gene
#' @param bnum_list A character vector
#' @return A logical vector
#' @export
#' @examples
is_tf_gene <- function(bnum_list) {
	bnum_list %in% get_tf_genes()
}

#' @title Check if genes are pseudo genes
#' @name is_pseudo_gene
#' @param bnum_list A character vector
#' @return A logical vector
#' @import dplyr
#' @export
#' @examples
is_pseudo_gene <- function(bnum_list) {
	bnum_list %in% get_pseudo_genes()
}

#' @title Check if genes are phantom genes
#' @name is_phantom_gene
#' @param bnum_list A character vector
#' @return A logical vector
#' @export
#' @examples
is_phantom_gene <- function(bnum_list) {
	bnum_list %in% get_phantom_genes()
}
