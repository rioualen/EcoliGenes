#' @title Check if a position or vector of positions are genic
#' @name is_genic
#'
#' @param positions A numeric vector
#' @param strand A character vector
#'
#' @return A vector of logicals of size `length(positions)`
#'
#' @import dplyr
#' @export
#'
#' @examples
is_genic <- function(positions, strand) {
	master_gene_table <- read_master_gene_file()

	check_genic <- function(x, y) {
			genes <- master_gene_table %>% filter(Reference_strand == y)
			lo <- x >= genes$Reference_start
			hi <- x <= genes$Reference_stop
		check <- lo * hi
		introw <- which(check == 1)
		length(introw)
	}
	mapply(FUN = check_genic, positions, strand)
}

#' @title Check in which gene
#' @name where_genic
#'
#' @param positions A numeric vector
#' @param strand A character vector
#'
#' @return A character vector of same size
#'
#' @import dplyr
#' @export
#'
#' @examples
where_genic <- function(positions, strand) {
	master_gene_table <- read_master_gene_file()

		check_genic_which_gene <- function(x, y) {
			genes <- master_gene_table %>% filter(Reference_strand == y)
			lo <- x >= genes$Reference_start
			hi <- x <= genes$Reference_stop
			check <- lo * hi
			df <- genes[which(check == 1),]
		if(nrow(df) == 0 ){
			NA
		} else {
			paste(df$Reference_symbol, collapse = ",")
		}
	}
	list_genes <- sapply(positions, strand, FUN = check_genic_which_gene)
	unname(list_genes)
}


#' @title Check where in gene
#' @name where_genic_rel
#'
#' @param positions A numeric vector
#' @param strand A character vector
#'
#' @return A numeric vector of same size
#'
#' @import dplyr
#' @import tidyr
#' @export
#'
#' @examples
where_genic_rel <- function(positions, strand) {

	# master_gene_table <- read_master_gene_file()

	check_genic_with_pos <- function(x, y) {
		genes_sym <- where_genic(x, y)
		df <- data.frame(x, y, genes_sym) %>%
			tidyr::separate_rows(genes_sym, sep = ",") %>%
			dplyr::mutate(
				genes_bnum = get_gene_bnumber(genes_sym),
				gene_start = get_gene_start(genes_bnum),
				gene_stop = get_gene_stop(genes_bnum),
				relative_pos = ifelse(y == "-", round((gene_stop - x)/(gene_stop - gene_start), 2),
															 ifelse(y == "+", round((x - gene_start)/(gene_stop - gene_start), 2), NA))
			) %>%
			dplyr::group_by(x, y)
		paste(df$relative_pos, collapse = ",")

		# genes <- master_gene_table %>% filter(Reference_strand == y)
		# lo <- x >= genes$Reference_start
		# hi <- x <= genes$Reference_stop
		# check <- lo * hi
		# df <- genes[which(check == 1),]
		# if(nrow(df) == 0 ){
		# 	NA
		# } else {
		# 	paste(df$Reference_bnumber, collapse = ",")
		# }
	}
	list_relpos <- sapply(positions, strand, FUN = check_genic_with_pos)
	unname(list_relpos)
}


#' @title Get closest gene bnumber
#' @name closest_gene
#'
#' @param position A numeric vector
#' @param strand A character in c("+", "-", "+-")
#'
#' @return A vector of characters of same size as input
#'
#' @import dplyr
#' @import stringr
#' @export
#'
#' @examples
closest_gene <- function(position, strand = "+-") {
	master_gene_table <- read_master_gene_file()

	get_closest <- function(x, y) {
		strd <- c(stringr::str_split(y, "", simplify = T))
		df <- master_gene_table %>% dplyr::filter(Reference_strand %in% strd)
		gene <- df %>%
			dplyr::filter(abs(x - aug) == min(abs(x - df$aug)))
		gene$Reference_bnumber[1] ## OJO there can be more than one answer!
	}
	mapply(position, strand, FUN = get_closest)
}

