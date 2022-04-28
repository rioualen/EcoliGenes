#' @title Get TF family
#' @name get_tf_family
#'
#' @param list_tfs
#'
#' @return A character vector of same size as `list_tfs`
#'
#' @export
#'
#' @examples
get_tf_family <- function(list_tfs) {
	master_tf_table <- read_master_tf_file()

	tf_list_by_bnum <- split(master_tf_table, master_tf_table$Reference_bnumber)

	get_fam <- function(x) {
		ifelse(!is.null(tf_list_by_bnum[[x]]$RegulonDB_tf_family[1]), tf_list_by_bnum[[x]]$RegulonDB_tf_family[1], NA)
	}
	list_fam <- sapply(list_tfs, FUN=get_fam)
	unname(list_fam)
}


#' @title Get tf synonyms from the master table for a given vector of tfs
#' @name get_tf_synonyms
#'
#' @param list_tfs A character vector of tf names
#'
#' @return A character vector of same size as `list_tfs` with comma-separated synonyms

#'
#' @import dplyr
#' @export
#'
#' @examples
get_tf_synonyms <- function(list_tfs) {
	master_tf_table <- read_source_file("tfs")

	tf_list_by_bnum <- split(master_tf_table, master_tf_table$Reference_name)

	# ## Check that provided list of genes are valid bnumbers, or can be converted into them
	# list_bnum <- get_gene_bnumber(list_genes)

	tf_synonyms <- function(x) {
		ifelse(!is.na(x), gene_list_by_bnum[[x]]$protein_synonyms, NA)
	}
	list_synonyms <- sapply(list_tfs, FUN = tf_synonyms)
	unname(list_synonyms)
}


