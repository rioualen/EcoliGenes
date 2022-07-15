#' @title Get all TFs
#' @name get_all_tfs
#'
#' @return A character vector of TF names
#'
#' @import dplyr
#' @export
#'
#' @examples
get_all_tfs <- function() { #
	all_tfs <- read_source_file("tfs") %>%
		dplyr::select(Reference_name) %>%
		dplyr::arrange(Reference_name)

	all_tfs$Reference_name
}

#' @title Get all confirmed TFs from RegulonDB
#' @name get_confirmed_tfs
#'
#' @return A character vector of TF names
#'
#' @import dplyr
#' @export
#'
#' @examples
get_confirmed_tfs <- function() { #
	confirmed_tfs <- read_source_file("tfs")  %>%
		dplyr::filter(RegulonDB_TF == 1) %>%
		dplyr::select(Reference_name) %>%
		dplyr::arrange(Reference_name)

	confirmed_tfs$Reference_name
}

#' @title Get predicted TFs from the literature (Perez-Rueda 2015, Flores-Bautista 2020, Kim 2020)
#' @name get_predicted_tfs
#'
#' @return A character vector of TF names
#'
#' @import dplyr
#' @export
#'
#' @examples
get_predicted_tfs <- function() { #
	predicted_tfs <- read_source_file("tfs")  %>%
		dplyr::filter(Predicted_TF_2015 == 1 | Predicted_TF_2020 == 1| Predicted_TF_2021 == 1 ) %>%
		dplyr::select(Reference_name) %>%
		dplyr::arrange(Reference_name)

	predicted_tfs$Reference_name
}

#' @title Get TFs from a specific family
#' @name get_tfs_by_family
#'
#' @return A character vector of TF names
#'
#' @import dplyr
#' @export
#'
#' @examples
get_tfs_by_family <- function(family) {
	all_tfs <- read_source_file("tfs")
	if(! family %in% all_tfs$RegulonDB_tf_family){
		warning("Unknown family ", family)
		result <- NA
	} else {
		tf_family <- all_tfs %>%
			dplyr::filter(RegulonDB_tf_family == family) %>%
			dplyr::arrange(Reference_name)
		result <- tf_family$Reference_name
	}

	result
}
