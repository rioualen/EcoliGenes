#' @title Get bnumbers from genes entirely comprised in a given interval of coordinates
#' @name what_genes
#' @param start A numeric vector of size s
#' @param stop A numeric vector of size s
#' @param strand A character from c("+", "-", "+-")
#' @return A vector of characters of of size s
#' @import dplyr
#' @export
#' @examples
what_genes <- function(start, stop, strand) {
	master_gene_table <- read_master_gene_file()

	get_genes <- function(x, y, z) {
		strd <- c(stringr::str_split(z, "", simplify = T))
		genes <- master_gene_table %>%
			dplyr::filter(Reference_start >= x,
										Reference_stop <= y,
										Reference_strand %in% strd)
		# genes <- ifelse(z == "-",
										# paste0(rev(unique(na.omit(genes$Reference_bnumber))), collapse = ','),
										# paste0(unique(na.omit(genes$Reference_bnumber)), collapse = ','))
		paste0(unique(na.omit(genes$Reference_bnumber)), collapse = ',')
	}
	mapply(start, stop, strand, FUN = get_genes)
}
