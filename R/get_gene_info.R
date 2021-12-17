#' @title Get gene start
#' @name get_gene_start
#'
#' @param list_genes A character vector of bnumbers (previously checked/converted)
#'
#' @return A character vector of same size as `list_genes`
#'
#' @export
#'
#' @examples
get_gene_start <- function(list_genes) {
	master_gene_table <- read_master_gene_file()

	gene_list_by_bnum <- split(master_gene_table, master_gene_table$Consensus_bnumber)

	get_start <- function(x) {
		ifelse(!is.null(gene_list_by_bnum[[x]]$Consensus_start[1]), gene_list_by_bnum[[x]]$Consensus_start[1], NA)
	}
	list_start <- sapply(list_genes, FUN=get_start)
	unname(list_start)
}

#' @title Get gene stop
#' @name get_gene_stop
#'
#' @param list_genes A character vector of bnumbers (previously checked/converted)
#'
#' @return A character vector of same size as `list_genes`
#'
#' @export
#'
#' @examples
get_gene_stop <- function(list_genes) {
	master_gene_table <- read_master_gene_file()

	gene_list_by_bnum <- split(master_gene_table, master_gene_table$Consensus_bnumber)

	get_stop <- function(x) {
		ifelse(!is.null(gene_list_by_bnum[[x]]$Consensus_stop[1]), gene_list_by_bnum[[x]]$Consensus_stop[1], NA)
	}
	list_stop <- sapply(list_genes, FUN=get_stop)
	unname(list_stop)
}

#' @title Get gene strand
#' @name get_gene_strand
#'
#' @param list_genes A character vector of bnumbers (previously checked/converted)
#'
#' @return A character vector of same size as `list_genes`
#'
#' @export
#'
#' @examples
get_gene_strand <- function(list_genes) {
	master_gene_table <- read_master_gene_file()

	gene_list_by_bnum <- split(master_gene_table, master_gene_table$Consensus_bnumber)

	get_strand <- function(x) {
		ifelse(!is.null(gene_list_by_bnum[[x]]$Consensus_strand[1]), gene_list_by_bnum[[x]]$Consensus_strand[1], NA)
	}
	list_strand <- sapply(list_genes, FUN=get_strand)
	unname(list_strand)
}

#' @title Get info from the master table for a given vector of bnumbers
#' @name get_gene_consensus_info
#'
#' @param list_genes A character vector of gene names, bnumbers, symbols
#'
#' @return A dataframe where ncol = 6 and nrow = the number of valid genes provided as input
#'
#' @import dplyr
#' @export
#'
#' @examples
get_gene_consensus_info <- function(list_genes) {
	master_gene_table <- read_master_gene_file()

	## Check that provided list of genes are valid bnumbers, or can be converted into them
	list_bnum <- get_gene_bnumber(list_genes)

	result <- master_gene_table %>%
		dplyr::filter(Consensus_bnumber %in% list_bnum) %>%
		dplyr::select(matches("Consensus_"), gene_synonyms, product_synonyms)
	result
}

#' @title Get gene synonyms from the master table for a given vector of genes
#' @name get_gene_synonyms
#'
#' @param list_genes A character vector of gene names, bnumbers, symbols
#'
#' @return A character vector of same size as `list_genes` with comma-separated synonyms

#'
#' @import dplyr
#' @export
#'
#' @examples
get_gene_synonyms <- function(list_genes) {
	master_gene_table <- read_master_gene_file()

	gene_list_by_bnum <- split(master_gene_table, master_gene_table$Consensus_bnumber)

	## Check that provided list of genes are valid bnumbers, or can be converted into them
	list_bnum <- get_gene_bnumber(list_genes)

	gene_synonyms <- function(x) {
		ifelse(!is.na(x), gene_list_by_bnum[[x]]$gene_synonyms, NA)
	}
	list_synonyms <- sapply(list_bnum, FUN = gene_synonyms)
	unname(list_synonyms)
}

#' @title Get gene synonyms from the master table for a given vector of genes
#' @name get_protein_synonyms
#'
#' @param list_genes A character vector of gene names, bnumbers, symbols
#'
#' @return A character vector of same size as `list_genes` with comma-separated synonyms

#'
#' @import dplyr
#' @export
#'
#' @examples
get_protein_synonyms <- function(list_genes) {
	master_gene_table <- read_master_gene_file()

	gene_list_by_bnum <- split(master_gene_table, master_gene_table$Consensus_bnumber)

	## Check that provided list of genes are valid bnumbers, or can be converted into them
	list_bnum <- get_gene_bnumber(list_genes)

	protein_synonyms <- function(x) {
		ifelse(!is.na(x), gene_list_by_bnum[[x]]$protein_synonyms, NA)
	}
	list_synonyms <- sapply(list_bnum, FUN = protein_synonyms)
	unname(list_synonyms)
}

#' @title Get gene nucleotide length
#' @name get_gene_length
#'
#' @param list_genes A character vector of gene names, bnumbers, symbols
#'
#' @return A integer vector of same size as `list_genes`
#'
#' @export
#'
#' @examples
get_gene_length <- function(list_genes) {
	master_gene_table <- read_master_gene_file()
	gene_list_by_bnum <- split(master_gene_table, master_gene_table$Consensus_bnumber)

	## Check that provided list of genes are valid bnumbers, or can be converted into them
	list_bnum <- get_gene_bnumber(list_genes)

	gene_length <- function(x) {
		ifelse(!is.na(x), gene_list_by_bnum[[x]]$Consensus_stop - gene_list_by_bnum[[x]]$Consensus_start, NA)
	}
	list_lengths <- sapply(list_bnum, FUN = gene_length)
	unname(list_lengths)
}

#' @title Get previous genes bnumbers for a given vector of genes, with respect to strand orientation
#' @name get_previous_gene
#'
#' @param list_genes A character vector of gene names, bnumbers, symbols
#'
#' @return A vector of same size as `bnumbers
#'
#' @import dplyr
#' @export
#'
#' @examples
get_previous_gene <- function(list_genes) {
	master_gene_table <- read_master_gene_file()

	## Check that provided list of genes are valid bnumbers, or can be converted into them
	list_bnum <- get_gene_bnumber(list_genes)

	master_bis <- master_gene_table %>%
		arrange(Consensus_start) %>%
		mutate(lag = lag(Consensus_bnumber), lead = lead(Consensus_bnumber))

	previous_gene <- function(x) {
		if(!is.na(x) & get_gene_strand(x) == "+") {
			pv <- master_bis[master_bis$Consensus_bnumber==x,"lag"]
		}else if(!is.na(x) & get_gene_strand(x) == "-") {
			pv <- master_bis[master_bis$Consensus_bnumber==x,"lead"]
		} else {
			pv <- NA
		}
		pv
	}
	sapply(list_bnum, FUN = previous_gene)
}


#' @title Get next genes bnumbers for a given vector of bnumbers, with respect to strand orientation
#' @name get_next_gene
#'
#' @param list_genes A character vector of gene names, bnumbers, symbols
#'
#' @return A vector of same size as `bnumbers
#'
#' @import dplyr
#' @export
#'
#' @examples
get_next_gene <- function(list_genes) {
	master_gene_table <- read_master_gene_file()

	## Check that provided list of genes are valid bnumbers, or can be converted into them
	list_bnum <- get_gene_bnumber(list_genes)

	master_bis <- master_gene_table %>%
		arrange(Consensus_start) %>%
		mutate(lag = lag(Consensus_bnumber), lead = lead(Consensus_bnumber))

	next_gene <- function(x) {
		if(!is.na(x) & get_gene_strand(x) == "+") {
			nx <- master_bis[master_bis$Consensus_bnumber==x,"lead"]
		}else if(!is.na(x) & get_gene_strand(x) == "-") {
			nx <- master_bis[master_bis$Consensus_bnumber==x,"lag"]
		} else {
			nx <- NA
		}
		nx
	}
	sapply(list_bnum, FUN = next_gene)
}

