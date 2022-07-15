#' @title Convert genomic coordinates from 96.2 to 96.3
#' @name convert_coords
#'
#' @param coords A integer vector
#'
#' @return A integer vector of same size as `coords`
#'
#' @export
#'
#' @examples
convert_coords <- function(coords) {

	coords_df <- read_source_file("coords")
	coords_list <- split(coords_df$v3, coords_df$v2)

	convert <- function(x) {
		coords_list[[as.character(x)]]
	}
	mapply(coords, FUN = convert)
}
