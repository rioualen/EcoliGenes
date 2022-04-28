#' @title Get bnumbers from genes entirely comprised in a given interval of coordinates
#' @name what_genes
#'
#' @param start A numeric vector
#' @param stop A numeric vector
#' @param strand A character vector
#'
#' @return A vector of characters of same size as inputs
#'
#' @import dplyr
#' @export
#'
#' @examples
what_genes <- function(start, stop, strand) {
	master_gene_table <- read_master_gene_file()

	get_genes <- function(x, y, z) {
		genes <- master_gene_table %>%
			dplyr::filter(Reference_start >= x,
										Reference_stop <= y,
										Reference_strand == z)
		genes <- ifelse(z == "-",
										paste0(rev(unique(na.omit(genes$Reference_bnumber))), collapse = ','),
										paste0(unique(na.omit(genes$Reference_bnumber)), collapse = ','))

		genes
	}
	sapply(start, stop, strand, FUN = get_genes)
}
