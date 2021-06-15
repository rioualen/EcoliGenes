#' @title Convert gene symbols to bnumbers
#' @name get_gene_bnumber
#'
#' @param list_genes A character vector
#'
#' @return A character vector of same size as `list_genes`
#'
#' @import tidyr
#' @export
#'
#' @examples
get_gene_bnumber <- function(list_genes) {
	master_gene_table <- read_master_gene_file()

	gene_list_by_symbol <- split(master_gene_table, master_gene_table$Consensus_symbol)
	gene_list_by_synonyms <- master_gene_table %>% tidyr::separate_rows(gene_synonyms, sep = ",")
	gene_list_by_synonyms <- split(gene_list_by_synonyms, gene_list_by_synonyms$gene_synonyms)
	gene_list_by_symbol_or_synonym <- c(gene_list_by_symbol, gene_list_by_synonyms)

	convert_symbols <- function(x) {
		ifelse(!is.null(gene_list_by_symbol_or_synonym[[x]]$Consensus_bnumber[1]), "", warning(paste0("This gene is unknown and will be converted to `NA`: ", x), call. = NA))
		ifelse(!is.null(gene_list_by_symbol_or_synonym[[x]]$Consensus_bnumber[1]), gene_list_by_symbol_or_synonym[[x]]$Consensus_bnumber[1], NA)
	}
	list_bnumbers <- sapply(list_genes, FUN=convert_symbols)
	unname(list_bnumbers)
}

#' @title Convert bnumbers to gene symbols
#' @name get_gene_symbol
#'
#' @param list_genes A character vector
#'
#' @return A character vector of same size as `list_genes`
#'
#' @import tidyr
#' @export
#'
#' @examples
get_gene_symbol <- function(list_genes) {
	master_gene_table <- read_master_gene_file()

	gene_list_by_bnum <- split(master_gene_table, master_gene_table$Consensus_bnumber)
	gene_list_by_synonyms <- master_gene_table %>% tidyr::separate_rows(gene_synonyms, sep = ",")
	gene_list_by_synonyms <- split(gene_list_by_synonyms, gene_list_by_synonyms$gene_synonyms)
	gene_list_by_bnum_or_synonym <- c(gene_list_by_bnum, gene_list_by_synonyms)

	convert_bnumbers <- function(x) {
		ifelse(!is.null(gene_list_by_bnum_or_synonym[[x]]$Consensus_symbol[1]), "", warning(paste0("This gene is unknown and will be converted to `NA`: ", x), call. = NA))
		ifelse(!is.null(gene_list_by_bnum_or_synonym[[x]]$Consensus_symbol[1]), gene_list_by_bnum_or_synonym[[x]]$Consensus_symbol[1], NA)
	}
	list_symbols <- sapply(list_genes, FUN=convert_bnumbers)
	unname(list_symbols)
}


### todo
## check unicity of synonyms
