#' @title Read the reference gene file
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

	gene_list_by_symbol <- split(master_gene_table, master_gene_table$GENE_NAME)
	gene_list_by_synonyms <- master_gene_table %>% tidyr::separate_rows(GENE_SYNONYMS, sep = ",")
	gene_list_by_synonyms <- split(gene_list_by_synonyms, gene_list_by_synonyms$GENE_SYNONYMS)
	gene_list_by_symbol_or_synonym <- c(gene_list_by_symbol, gene_list_by_synonyms)

	convert_symbols <- function(x) {
		ifelse(!is.null(gene_list_by_symbol_or_synonym[[x]]$BNUMBER[1]), "", warning(paste0("This gene symbol is unknown and will be converted to `FALSE`: ", x), call. = FALSE))
		ifelse(!is.null(gene_list_by_symbol_or_synonym[[x]]$BNUMBER[1]), gene_list_by_symbol_or_synonym[[x]]$BNUMBER[1], FALSE)
	}
	list_bnumbers <- sapply(list_symbols, FUN=convert_symbols)
	unname(list_bnumbers)
}
