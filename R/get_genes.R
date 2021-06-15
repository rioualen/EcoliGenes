#' @title Get all genes consensus bnumbers
#' @name get_all_genes
#'
#' @return A character vector of bnumbers
#'
#' @import dplyr
#' @export
#'
#' @examples
get_all_genes <- function() {
	master_gene_table <- read_master_gene_file()

	all_genes <- master_gene_table %>%
		dplyr::filter(!is.na(Consensus_start)|!is.na(Consensus_stop)|!is.na(Consensus_strand)) %>%
		dplyr::select(Consensus_bnumber)

	all_genes$Consensus_bnumber
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
	master_gene_table <- read_master_gene_file()

	if (source == "all") {
		tfs <- master_gene_table %>%
			dplyr::filter(Consensus_TF == 1) %>%
			dplyr::select(Consensus_bnumber)
	} else if (source == "regulondb"){
		tfs <- master_gene_table %>%
			dplyr::filter(RegulonDB_TF == 1) %>%
			dplyr::select(Consensus_bnumber)
	} else {
		stop("Error: 'source' parameter must be one of 'all', 'regulondb' ")
	}
	tfs$Consensus_bnumber
}

#' @title Get potentially TF-regulated genes
#' @name get_target_genes
#'
#' @param source Optional, one of c("all", "regulondb")
#' @return A character vector
#'
#' @import dplyr
#' @export
#'
#' @examples
get_target_genes <- function(source = "all") {
	master_gene_table <- read_master_gene_file()
	## todo
	## Get all genes potentially regulated (remove pseudo genes, phantom, ...?)
}

