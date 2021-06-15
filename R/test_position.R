#' @title Check if a position or vector of positions are genic
#' @name is_genic
#'
#' @param positions A numeric vector
#'
#' @return A vector of logicals of size `length(positions)`
#'
#' @import dplyr
#' @export
#'
#' @examples
is_genic <- function(positions) {
	master_gene_table <- read_master_gene_file()

	check_genic <- function(x) {
		lo <- x >= master_gene_table$Consensus_start
		hi <- x <= master_gene_table$Consensus_stop
		check <- lo * hi
		introw <- which(check == 1)
		length(introw) == 1
	}
	sapply(positions, FUN=check_genic)
}

#' @title Check in which gene
#' @name where_genic
#'
#' @param positions A numeric vector
#'
#' @return A character vector of same size
#'
#' @import dplyr
#' @export
#'
#' @examples
where_genic <- function(positions) {
	master_gene_table <- read_master_gene_file()
	# genic_positions <- positions[which(is_genic(positions)==TRUE)]
	check_genic_with_pos <- function(x) {
		lo <- x >= master_gene_table$Consensus_start
		hi <- x <= master_gene_table$Consensus_stop
		check <- lo * hi
		df <- master_gene_table[which(check == 1),]
		if(nrow(df) == 0 ){
			NA
		} else {
			paste(df$Consensus_bnumber)
		}
	}
	list_genes <- sapply(positions, FUN=check_genic_with_pos)
	unname(list_genes)
}
