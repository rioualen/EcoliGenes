#' @title Read source file
#' @name read_source_file
#' @return a data.frame
#'
#' @export
#' @examples
read_source_file <- function(source = "genes") {
	if (source == "genes") {
		file = "master_gene_file.tsv"
	} else if (source == "tfs") {
		file = "master_tf_file.tsv"
	} else if (source == "coords") {
		file = "map-coords.tsv"
	} else {
		warning("Unknown value for parameter 'source': ", source, ", using default value 'genes' instead", immediate. = T , call. = F)
		file = "master_gene_file.tsv"
	}
	read_source_file <- system.file("extdata", file, package = "EcoliGenes")
	source_info_df <- read.delim(read_source_file, comment.char = "#", header = T, stringsAsFactors = F)
	source_info_df
}
#' @title Read the reference gene file [obsolete]
#' @name read_master_gene_file
#' @return a data.frame
#' @export
#' @examples
read_master_gene_file <- function() {
	read_source_file("genes")
}
#' @title Read the reference tf file [obsolete]
#' @name read_master_tf_file
#' @return a data.frame
#' @export
#' @examples
read_master_tf_file <- function() {
	read_source_file("tfs")
}
#' @title Read the file that contains genomic coordinates correspondence between 96.3 and 96.2
#' @name read_coords_file
#' @return a data.frame
#' @export
#' @examples
read_coords_file <- function() {
	coords_file <- system.file("extdata", "map-coords.tsv", package = "EcoliGenes")
	coords_table <- read.delim(coords_file, comment.char = "#", header = T, stringsAsFactors = F)
	coords_table
}
