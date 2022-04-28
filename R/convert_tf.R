#' @title Get TF  names.
#' @name convert_tf
#'
#' @param products A character vector
#' @param to A character string
#'
#' @return A character vector of same size as `products`
#'
#' @import tidyr
#' @import dplyr
#' @import plyr
#' @export
#'
#' @examples
convert_tf <- function(products, to = "name") {

	if(!to %in% c("bnumber", "symbol", "name")) {
		warning("Unknown parameter ", to, ", will default to 'name'", immediate. = T , call. = F)
		to <- "name"
	}

	tf_list_by_synonyms <- read_master_tf_file() %>%
		tidyr::separate_rows(TF_synonyms, sep = ",") %>%
		plyr::dlply("TF_synonyms", identity)

	convert <- function(x, to) {

		if(!x %in% names(tf_list_by_synonyms)) {
			warning("Unknown TF ", x)
			NA
		} else if(x %in% names(tf_list_by_synonyms) && nrow(tf_list_by_synonyms[[x]]) > 1) {
			warning("Duplicate entry for TF ", x, ", shortest will be kept (likely subunit)", immediate. = T , call. = F)
			# paste(tf_list_by_synonyms[[x]][[paste0("Reference_", to)]], collapse = ",")
			dups <- tf_list_by_synonyms[[x]][[paste0("Reference_", to)]]
			dups[order(nchar(dups), dups)][1]
		} else {
			tf_list_by_synonyms[[x]][[paste0("Reference_", to)]]
		}
	}
	mapply(products, to, FUN = convert)
}

#' @title Convert TF protein names into symbols
#' @name get_tf_name
#'
#' @param list_tfs A character vector
#'
#' @return A character vector of same size as `list_tfs`
#'
#' @import tidyr
#' @export
#'
#' @examples
get_tf_name <- function(list_tfs) {

	convert_tf(list_tfs, to = "name")
}

#' @title Convert TF protein names into bnumbers
#' @name get_tf_bnumber
#'
#' @param list_tfs A character vector
#'
#' @return A character vector of same size as `list_tfs`
#'
#' @import tidyr
#' @export
#'
#' @examples
get_tf_bnumber <- function(list_tfs) {

	convert_tf(list_tfs, to = "bnumber")

}

#' @title Convert TF protein names into symbols
#' @name get_tf_symbol
#'
#' @param list_tfs A character vector
#'
#' @return A character vector of same size as `list_tfs`
#'
#' @import tidyr
#' @export
#'
#' @examples
get_tf_symbol <- function(list_tfs) {

	convert_tf(list_tfs, to = "symbol")
}


#' @title Convert TF protein names into symbols
#' @name get_tf_symbol
#'
#' @param list_tfs A character vector
#'
#' @return A character vector of same size as `list_tfs`
#'
#' @import tidyr
#' @export
#'
#' @examples
get_tf_symbol <- function(list_tfs) {

	convert_tf(list_tfs, to = "symbol")
}
