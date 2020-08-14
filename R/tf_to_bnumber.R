#' @title Convert TF protein names into bnumbers
#' @name tf_to_bnumber
#'
#' @param list_proteins A character vector
#'
#' @return A character vector of same size as `list_proteins`
#'
#' @import tidyr
#' @export
#'
#' @examples
tf_to_bnumber <- function(list_proteins) {
	master_tf_table <- read_master_tf_file()

	tf_list_by_synonyms <- master_tf_table %>% tidyr::separate_rows(PROTEIN.SYNONIMS.ECO.v23, sep = ",")
	tf_list_by_synonyms <- split(tf_list_by_synonyms, tf_list_by_synonyms$PROTEIN.SYNONIMS.ECO.v23)

	convert_proteins <- function(x) {
		ifelse(!is.null(tf_list_by_synonyms[[x]]$BNUMBER.ECO.v23[1]), "", warning(paste0("This protein name is unknown and will be converted to `FALSE`: ", x), call. = FALSE))
		ifelse(!is.null(tf_list_by_synonyms[[x]]$BNUMBER.ECO.v23[1]), tf_list_by_synonyms[[x]]$BNUMBER.ECO.v23[1], FALSE)
	}
	list_bnumbers <- sapply(list_proteins, FUN=convert_proteins)
	unname(list_bnumbers)
}
