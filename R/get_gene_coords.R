#' @title Get gene start
#' @name get_gene_start
#'
#' @param list_genes A character vector of bnumbers (previously checked/converted)
#'
#' @return A character vector of same size as `list_genes`
#'
#' @export
#'
#' @examples
get_gene_start <- function(list_genes) {
	master_gene_table <- read_master_gene_file()

	gene_list_by_bnum <- split(master_gene_table, master_gene_table$Consensus_bnumber)

	get_start <- function(x) {
		ifelse(!is.null(gene_list_by_bnum[[x]]$Consensus_start[1]), gene_list_by_bnum[[x]]$Consensus_start[1], NA)
	}
	list_start <- sapply(list_genes, FUN=get_start)
	unname(list_start)
}

#' @title Get gene stop
#' @name get_gene_stop
#'
#' @param list_genes A character vector of bnumbers (previously checked/converted)
#'
#' @return A character vector of same size as `list_genes`
#'
#' @export
#'
#' @examples
get_gene_stop <- function(list_genes) {
	master_gene_table <- read_master_gene_file()

	gene_list_by_bnum <- split(master_gene_table, master_gene_table$Consensus_bnumber)

	get_stop <- function(x) {
		ifelse(!is.null(gene_list_by_bnum[[x]]$Consensus_stop[1]), gene_list_by_bnum[[x]]$Consensus_stop[1], NA)
	}
	list_stop <- sapply(list_genes, FUN=get_stop)
	unname(list_stop)
}

#' @title Get gene strand
#' @name get_gene_strand
#'
#' @param list_genes A character vector of bnumbers (previously checked/converted)
#'
#' @return A character vector of same size as `list_genes`
#'
#' @export
#'
#' @examples
get_gene_strand <- function(list_genes) {
	master_gene_table <- read_master_gene_file()

	gene_list_by_bnum <- split(master_gene_table, master_gene_table$Consensus_bnumber)

	get_strand <- function(x) {
		ifelse(!is.null(gene_list_by_bnum[[x]]$Consensus_strand[1]), gene_list_by_bnum[[x]]$Consensus_strand[1], NA)
	}
	list_strand <- sapply(list_genes, FUN=get_strand)
	unname(list_strand)
}
