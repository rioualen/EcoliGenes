#' @title Get family info for a given TF or list of TFs
#' @name get_tf_family
#' @param list_tfs
#' @return A character vector of same size as `list_tfs`
#' @export
#' @examples
get_tf_family <- function(list_tfs) {
	master_tf_table <- read_source_file("tfs")

	tf_list_by_name <- split(master_tf_table, master_tf_table$Reference_name)

	get_fam <- function(x) {
		ifelse(!is_tf(x), warning("Unknown TF '", x, "'; try to use convert_tf('", x, "', to = 'name') first."), NA)
		ifelse(!is.null(tf_list_by_name[[x]]$RegulonDB_tf_family[1]), tf_list_by_name[[x]]$RegulonDB_tf_family[1], NA)
	}
	list_fam <- sapply(list_tfs, FUN = get_fam)
	unname(list_fam)
}

#' @title Get tf synonyms from the master table for a given vector of tfs
#' @name get_tf_synonyms
#' @param list_tfs A character vector of tf names
#' @return A character vector of same size as `list_tfs` with comma-separated synonyms
#' @import dplyr
#' @export
#' @examples
get_tf_synonyms <- function(list_tfs) {
	master_tf_table <- read_source_file("tfs")

	tf_list_by_name <- split(master_tf_table, master_tf_table$Reference_name)

	tf_synonyms <- function(x) {
		ifelse(!is_tf(x), warning("Unknown TF '", x, "'; try to use convert_tf('", x, "', to = 'name') first."), NA)
		ifelse(!is.null(tf_list_by_name[[x]]$TF_synonyms), tf_list_by_name[[x]]$TF_synonyms, NA)
	}
	list_synonyms <- sapply(list_tfs, FUN = tf_synonyms)
	unname(list_synonyms)
}

#' @title Get symmetry info for a given TF or list of TFs
#' @name get_tf_symmetry
#' @param list_tfs
#' @return A character vector of same size as `list_tfs`
#' @export
#' @examples
get_tf_symmetry <- function(list_tfs) {
	master_tf_table <- read_source_file("tfs")

	tf_list_by_name <- split(master_tf_table, master_tf_table$Reference_name)

	get_sym <- function(x) {
		ifelse(!is_tf(x), warning("Unknown TF '", x, "'; try to use convert_tf('", x, "', to = 'name') first."), NA)
		ifelse(!is.null(tf_list_by_name[[x]]$RegulonDB_tf_symmetry[1]), tf_list_by_name[[x]]$RegulonDB_tf_symmetry[1], NA)
	}
	list_sym <- sapply(list_tfs, FUN = get_sym)
	unname(list_sym)
}

#' @title Get class info for a given TF or list of TFs
#' @name get_tf_class
#' @param list_tfs
#' @return A character vector of same size as `list_tfs`
#' @export
#' @examples
get_tf_class <- function(list_tfs) {
	master_tf_table <- read_source_file("tfs")

	tf_list_by_name <- split(master_tf_table, master_tf_table$Reference_name)

	get_class <- function(x) {
		ifelse(!is_tf(x), warning("Unknown TF '", x, "'; try to use convert_tf('", x, "', to = 'name') first."), NA)
		ifelse(!is.null(tf_list_by_name[[x]]$RegulonDB_tf_class[1]), tf_list_by_name[[x]]$RegulonDB_tf_class[1], NA)
	}
	list_class <- sapply(list_tfs, FUN = get_class)
	unname(list_class)
}

#' @title Get conformation_type info for a given TF or list of TFs
#' @name get_tf_effect
#' @param list_tfs
#' @return A character vector of same size as `list_tfs`
#' @export
#' @examples
get_tf_effect <- function(list_tfs) {
	master_tf_table <- read_source_file("tfs")

	tf_list_by_name <- split(master_tf_table, master_tf_table$Reference_name)

	get_effect <- function(x) {
		ifelse(!is_tf(x), warning("Unknown TF '", x, "'; try to use convert_tf('", x, "', to = 'name') first."), NA)
		ifelse(!is.null(tf_list_by_name[[x]]$RegulonDB_tf_conformation_type[1]), tf_list_by_name[[x]]$RegulonDB_tf_conformation_type[1], NA)
	}
	list_effect <- sapply(list_tfs, FUN = get_effect)
	unname(list_effect)
}

