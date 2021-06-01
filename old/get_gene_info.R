#' @title Get info from the master table for a given vector of bnumbers
#' @name get_gene_info
#'
#' @param bnumbers A character vector
#'
#' @return A dataframe
#'
#' @import dplyr
#' @export
#'
#' @examples
get_gene_info <- function(bnumbers) {
	master_gene_table <- read_master_gene_file()
	result <- master_gene_table %>% dplyr::filter(BNUMBER %in% bnumbers) %>% dplyr::select(c("GENE_NAME", "BNUMBER", "GENE_SYNONYMS", "REGULONDB_ID"))
	result
}
#' @title Add info into the master table and over-write it. Takes a while, to do just once.
#' @name complete_gene_info
#'
#' @import dplyr
#' @export
#'
#' @examples
complete_gene_info <- function() {
	master_gene_table <- read_master_gene_file()

	master_bis <- master_gene_table %>%
		arrange(GENE_POSLEFT) %>%
		dplyr::mutate(left_bnumber = lag(BNUMBER, default = "-"),   ## attention aux "-", essayer de boucler sur le df?
					 right_bnumber = lead(BNUMBER, default = "-"),
					 left_symbol = lag(GENE_NAME),
					 right_symbol = lead(GENE_NAME),
					 left_posleft = lag(GENE_POSLEFT),
					 right_posleft = lead(GENE_POSLEFT),
					 left_posright = lag(GENE_POSRIGHT),
					 right_posright = lead(GENE_POSRIGHT),
					 gene_coords = ifelse(GENE_STRAND == "forward",
					 										 paste0(GENE_POSLEFT, sprintf('\u25BA'), GENE_POSRIGHT),
					 										 ifelse(GENE_STRAND == "reverse",
					 										 			 paste0(GENE_POSLEFT, sprintf('\u25C4'), GENE_POSRIGHT),
					 										 			 NA)),
					 left_coords = ifelse(lag(GENE_STRAND) == "forward",
					 										 paste0(lag(GENE_POSLEFT), sprintf('\u25BA'), lag(GENE_POSRIGHT)),
					 										 ifelse(lag(GENE_STRAND) == "reverse",
					 										 			 paste0(lag(GENE_POSLEFT), sprintf('\u25C4'), lag(GENE_POSRIGHT)),
					 										 			 NA)),
					 right_coords = ifelse(lead(GENE_STRAND) == "forward",
					 										 paste0(lead(GENE_POSLEFT), sprintf('\u25BA'), lead(GENE_POSRIGHT)),
					 										 ifelse(lead(GENE_STRAND) == "reverse",
					 										 			 paste0(lead(GENE_POSLEFT), sprintf('\u25C4'), lead(GENE_POSRIGHT)),
					 										 			 NA)),
					 gene_length = GENE_POSRIGHT - GENE_POSLEFT,
					 left_length = lag(GENE_POSRIGHT) - lag(GENE_POSLEFT),
					 right_length = lead(GENE_POSRIGHT) - lead(GENE_POSLEFT))
  write_master_gene_file(master_bis)
}
