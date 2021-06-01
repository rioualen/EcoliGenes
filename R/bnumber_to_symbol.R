#' @title Convert bnumbers to gene symbols
#' @name bnumber_to_symbol
#'
#' @param list_bnumbers A character vector
#'
#' @return A character vector of same size as `list_bnumbers`
#'
#' @import tidyr
#' @export
#'
#' @examples
bnumber_to_symbol <- function(list_bnumbers) {
	master_gene_table <- read_master_gene_file()

	gene_list_by_bnum <- split(master_gene_table, master_gene_table$Consensus_bnumber)
	gene_list_by_synonyms <- master_gene_table %>% tidyr::separate_rows(gene_synonyms, sep = ",")
	gene_list_by_synonyms <- split(gene_list_by_synonyms, gene_list_by_synonyms$gene_synonyms)
	gene_list_by_bnum_or_synonym <- c(gene_list_by_bnum, gene_list_by_synonyms)

	convert_bnumbers <- function(x) {
		ifelse(!is.null(gene_list_by_bnum_or_synonym[[x]]$Consensus_symbol[1]), "", warning(paste0("This bnumber is unknown and will be converted to `NA`: ", x), call. = NA))
		ifelse(!is.null(gene_list_by_bnum_or_synonym[[x]]$Consensus_symbol[1]), gene_list_by_bnum_or_synonym[[x]]$Consensus_symbol[1], NA)
	}
	list_symbols <- sapply(list_bnumbers, FUN=convert_bnumbers)
	unname(list_symbols)
}


