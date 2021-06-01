#' @title Convert gene symbols to bnumbers
#' @name symbol_to_bnumber
#'
#' @param list_symbols A character vector
#'
#' @return A character vector of same size as `list_symbols`
#'
#' @import tidyr
#' @export
#'
#' @examples
symbol_to_bnumber <- function(list_symbols) {
	master_gene_table <- read_master_gene_file()

	gene_list_by_symbol <- split(master_gene_table, master_gene_table$Consensus_symbol)
	gene_list_by_synonyms <- master_gene_table %>% tidyr::separate_rows(gene_synonyms, sep = ",")
	gene_list_by_synonyms <- split(gene_list_by_synonyms, gene_list_by_synonyms$gene_synonyms)
	gene_list_by_symbol_or_synonym <- c(gene_list_by_symbol, gene_list_by_synonyms)

	convert_symbols <- function(x) {
		ifelse(!is.null(gene_list_by_symbol_or_synonym[[x]]$Consensus_bnumber[1]), "", warning(paste0("This gene symbol is unknown and will be converted to `NA`: ", x), call. = NA))
		ifelse(!is.null(gene_list_by_symbol_or_synonym[[x]]$Consensus_bnumber[1]), gene_list_by_symbol_or_synonym[[x]]$Consensus_bnumber[1], NA)
	}
	list_bnumbers <- sapply(list_symbols, FUN=convert_symbols)
	unname(list_bnumbers)
}
