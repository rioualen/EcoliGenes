#' @title Get all genes consensus bnumbers
#' @name get_all_genes
#'
#' @return A character vector of bnumbers
#'
#' @import dplyr
#' @export
#'
#' @examples
get_all_genes <- function() { ## add opt pseudogenes TF and phantomgene TF ## outpout bnumber or opt symbols?
	master_gene_table <- read_source_file("genes")

	all_genes <- master_gene_table %>%
		dplyr::filter(!is.na(Reference_start)|!is.na(Reference_stop)|!is.na(Reference_strand)) %>%
		dplyr::select(Reference_bnumber)

	all_genes$Reference_bnumber
}

#' @title Get TF-coding genes
#' @name get_tf_genes
#'
#' @param source Optional, one of c("all", "regulondb")
#' @return A character vector
#'
#' @import dplyr
#' @export
#'
#' @examples
get_tf_genes <- function(source = "all") {
	master_tf_table <- read_source_file("tfs")

	if (source == "all") {
		tfs <- master_tf_table$Reference_name
	} else if (source == "regulondb"){
		tfs <- master_tf_table %>%
			dplyr::filter(!is.na(RegulonDB_tf_id))
		tfs <- tfs$Reference_name
	} else {
		stop("Error: 'source' parameter must be one of 'all', 'regulondb' ")
	}
	tfs
}
