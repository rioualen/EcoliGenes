#' @title Convert TF protein names into symbols
#' @name tf_to_symbol
#'
#' @param list_proteins A character vector
#'
#' @return A character vector of same size as `list_proteins`
#'
#' @import tidyr
#' @export
#'
#' @examples
tf_to_symbol <- function(list_proteins) {
	master_gene_table <- read_master_gene_file()

	tf_list_by_synonyms <- master_gene_table %>% tidyr::separate_rows(product_synonyms, sep = ",")
	tf_list_by_synonyms <- split(tf_list_by_synonyms, tf_list_by_synonyms$product_synonyms)

	convert_proteins <- function(x) {
		ifelse(!is.null(tf_list_by_synonyms[[x]]$Consensus_symbol[1]), "", warning(paste0("This protein name is unknown and will be converted to `NA`: ", x), call. = NA))
		ifelse(!is.null(tf_list_by_synonyms[[x]]$Consensus_symbol[1]), tf_list_by_synonyms[[x]]$Consensus_symbol[1], NA)
	}
	list_symbols <- sapply(list_proteins, FUN=convert_proteins)
	unname(list_symbols)
}
