#' @title Get all genes as reference bnumbers
#' @name get_all_genes
#' @return A character vector of bnumbers
#' @import dplyr
#' @export
#' @examples
get_all_genes <- function() {
	all_genes <- read_source_file("genes")
	all_genes$Reference_bnumber
}

#' @title Get TF-coding genes from RegulonDB (does not include putative TFs from other sources; check out get_tfs() functions instead).
#' @name get_tf_genes
#' @return A character vector
#' @import dplyr
#' @export
#' @examples
get_tf_genes <- function() {
	tf_genes <- read_source_file("genes") %>%
		dplyr::filter(!is.na(RegulonDB_tf_id))
	tf_genes$Reference_bnumber
}

#' @title Get pseudo genes from RegulonDB
#' @name get_pseudo_genes
#' @return A character vector
#' @import dplyr
#' @export
#' @examples
get_pseudo_genes <- function() {
	pseudo_genes <- read_source_file("genes") %>%
		dplyr::filter(RegulonDB_type == "Pseudo Gene")
	pseudo_genes$Reference_bnumber
}

#' @title Get phantom genes from RegulonDB
#' @name get_phantom_genes
#' @return A character vector
#' @import dplyr
#' @export
#' @examples
get_phantom_genes <- function() {
	phantom_genes <- read_source_file("genes") %>%
		dplyr::filter(RegulonDB_type == "Phantom Gene")
	phantom_genes$Reference_bnumber
}

