#' @title Get TF-coding genes
#' @name get_tfs
#'
#' @return A character vector
#' @import dplyr
#' @export
#'
#' @examples
get_tfs <- function() {
	master_gene_table <- read_master_gene_file()

	tfs <- master_gene_table %>% dplyr::filter(TF == "yes")
	tfs$BNUMBER
}
