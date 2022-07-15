#' @title Get TF  names.
#' @name convert_tf
#'
#' @param tfs A character vector
#' @param to A character string
#'
#' @return A character vector of same size as `tfs`
#'
#' @import tidyr
#' @import dplyr
#' @export
#'
#' @examples
convert_tf <- function(tfs, to = "name") {

	if(!to %in% c("bnumber", "symbol", "name")) {
		warning("Unknown parameter ", to, ", will default to 'name'", immediate. = T , call. = F)
		to <- "name"
	}

	tf_list_by_synonyms <- read_source_file("tfs") %>%
		tidyr::separate_rows(TF_synonyms, sep = ",") %>%
		plyr::dlply("TF_synonyms", identity)

	convert <- function(x, to) {
		if(!x %in% names(tf_list_by_synonyms)) {
			warning("Unknown TF ", x)
			NA
		} else if(x %in% names(tf_list_by_synonyms) && nrow(tf_list_by_synonyms[[x]]) > 1) {
			warning("Duplicate entry for TF ", x, ", shortest will be kept (likely subunit)", immediate. = T , call. = F)
			dups <- tf_list_by_synonyms[[x]][[paste0("Reference_", to)]]
			dups[order(nchar(dups), dups)][1]
		} else {
			tf_list_by_synonyms[[x]][[paste0("Reference_", to)]]
		}
	}
	mapply(tfs, to, FUN = convert)
}

#' @title Convert TF protein names into symbols [deprecated]
#' @name get_tf_name
#' @param list_tfs A character vector
#' @return A character vector of same size as `list_tfs`
#' @export
#' @examples
get_tf_name <- function(list_tfs) {
	convert_tf(list_tfs, to = "name")
}

#' @title Convert TF protein names into gene bnumbers [deprecated]
#' @name get_tf_bnumber
#' @param list_tfs A character vector
#' @return A character vector of same size as `list_tfs`
#' @export
#' @examples
get_tf_bnumber <- function(list_tfs) {
	convert_tf(list_tfs, to = "bnumber")
}

#' @title Convert TF protein names into gene symbols [deprecated]
#' @name get_tf_symbol
#' @param list_tfs A character vector
#' @return A character vector of same size as `list_tfs`
#' @export
#' @examples
get_tf_symbol <- function(list_tfs) {
	convert_tf(list_tfs, to = "symbol")
}
