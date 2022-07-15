#' @title Check if TF name is valid
#' @name is_tf
#' @param tf_list A character vector
#' @return A logical vector
#' @export
#' @examples
is_tf <- function(tf_list) {
	tf_list %in% get_all_tfs()
}
#' @title Check if TF name is valid
#' @name is_confirmed_tf
#' @param tf_list A character vector
#' @return A logical vector
#' @export
#' @examples
is_confirmed_tf <- function(tf_list) {
	tf_list %in% get_confirmed_tfs()
}

#' @title Check if TF is predicted (from either Perez-Rueda 2015, Flores-Bautista 2020, Kim 2020)
#' @name is_predicted_tf
#' @param tf_list A character vector
#' @return A logical vector
#' @export
#' @examples
is_predicted_tf <- function(tf_list) {
	tf_list %in% get_predicted_tfs()
}

