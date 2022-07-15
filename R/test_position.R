#' @title Check if a position or vector of positions are genic
#' @name is_genic
#' @param positions A vector of integers
#' @param strand A character vector of size 1 or same size as `positions`
#' @return A vector of logicals of same size as `positions`
#' @import dplyr
#' @export
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

#' @title Check in which gene falls a given position
#' @name is_genic_which
#' @param positions A vector of integers
#' @param strand A character vector of size 1 or same size as `positions`
#' @return A character vector of same size as `positions`
#' @import dplyr
#' @export
#' @examples
is_genic_which <- function(positions, strand) {
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
			paste(df$Reference_bnumber, collapse = ",")
		}
	}
	mapply(positions, strand, FUN = check_genic_which_gene)
}


#' @title Check where in gene (relative position from 0 to 1, 0 being the start codon position)
#' @name is_genic_where
#' @param positions A numeric vector
#' @param strand A character vector of same size as `positions`
#' @return A numeric vector of same size as `positions`
#' @import tidyr
#' @import dplyr
#' @export
#' @examples
is_genic_where <- function(positions, strand) {

	# master_gene_table <- read_master_gene_file()

	check_genic_with_rel_pos <- function(x, y) {
		gene <- where_genic(x, y)

		if(!is.na(gene)){
			gene_bnum <- get_gene_bnumber(gene)
			gene_start <- get_gene_start(gene_bnum)
			gene_stop <- get_gene_stop(gene_bnum)
			relative_pos <- ifelse(y == "-", round((gene_stop - x)/(gene_stop - gene_start), 2),
														ifelse(y == "+", round((x - gene_start)/(gene_stop - gene_start), 2), NA))
		} else {
			relative_pos <- NA
		}
		relative_pos
	}
	mapply(positions, strand, FUN = check_genic_with_rel_pos)
}

#' @title Get closest genes from genomic positions given a strand
#' @name closest_gene
#' @param positions A vector of integers
#' @param strand A character vector of size 1 or same size as `positions`
#' @return A character vector of same size as `positions`
#' @import stringr
#' @import dplyr
#' @export
#' @examples
closest_gene <- function(positions, strand = "+-") {
	master_gene_table <- read_master_gene_file() %>%
		dplyr::mutate(aug = ifelse(Reference_strand == "+", Reference_start, ifelse(Reference_strand == "-", Reference_stop, NA)))

	get_closest <- function(x, y) {
		strd <- c(stringr::str_split(y, "", simplify = T))
		df <- master_gene_table %>% dplyr::filter(Reference_strand %in% strd)
		gene <- df %>%
			dplyr::filter(abs(x - aug) == min(abs(x - df$aug)))
		gene$Reference_bnumber[1] ## OJO there can be more than one answer!
	}
	mapply(positions, strand, FUN = get_closest)
}

