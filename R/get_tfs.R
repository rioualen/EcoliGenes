#' @title Get all TFs from regulonDB
#' @name get_all_tfs
#'
#' @return A character vector of TF names
#'
#' @import dplyr
#' @export
#'
#' @examples
get_all_tfs <- function() { #
	master_tf_table <- read_source_file("tfs")

	all_tfs <- master_tf_table %>%
		dplyr::filter(!is.na(RegulonDB_tf_id)) %>%
		dplyr::select(Reference_name) %>%
		dplyr::arrange(Reference_name)

	all_tfs$Reference_name
}
