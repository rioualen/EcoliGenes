#' @title Convert gene names. IDs or else to reference gene symbols or bnumbers
#' @name convert_gene
#'
#' @param genes A character vector
#' @param to A character string
#'
#' @return A character vector of same size as `genes`
#'
#' @import tidyverse
#' @export
#'
#' @examples
convert_gene <- function(genes, to = "bnumber") {

	if(!to %in% c("bnumber", "symbol")) {
		warning("Unknown parameter ", to, ", will default to 'bnumber'", immediate. = T , call. = F)
		to <- "bnumber"
	}

	gene_list_by_synonyms <- read_master_gene_file() %>%
		tidyr::separate_rows(gene_synonyms, sep = ",") %>%
		plyr::dlply("gene_synonyms", identity)

	convert <- function(x, to) {
		if(!x %in% names(gene_list_by_synonyms)) {
			warning("Unknown gene ", x)
			NA
		} else if(x %in% names(gene_list_by_synonyms) && nrow(gene_list_by_synonyms[[x]]) > 1) {
			warning("Duplicate entry for gene ", x, immediate. = T , call. = F)
			NA
		} else {
			gene_list_by_synonyms[[x]][[paste0("Reference_", to)]]
		}
	}
	mapply(genes, to, FUN = convert)
}

#' @title Convert gene (symbol, ID, or else) to consensus bnumber [deprecatd]
#' @name get_gene_bnumber
#' @param list_genes A character vector
#' @return A character vector of same size as `list_genes`
#' @export
#' @examples
get_gene_bnumber <- function(list_genes) {
	convert_gene(list_genes, to = "bnumber")
}

#' @title Convert any name or id to gene symbols [deprecated]
#' @name get_gene_symbol
#' @param list_genes A character vector
#' @return A character vector of same size as `list_genes`
#' @export
#' @examples
get_gene_symbol <- function(list_genes) {
	convert_gene(list_genes, to = "symbol")
}
