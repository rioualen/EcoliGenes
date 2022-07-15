#' @title Get reference info from the master table for a given list of genes
#' @name get_gene_info
#' @param list_genes A character vector of gene names, bnumbers, symbols
#' @return A dataframe where ncol = 7 and nrow = the number of valid genes provided as input
#' @import dplyr
#' @export
#' @examples
get_gene_info <- function(list_genes) {
	## Check that provided list of genes are valid bnumbers, or can be converted into them
	list_bnum <- convert_gene(list_genes, "bnumber")
	result <- read_source_file("genes") %>%
		dplyr::filter(Reference_bnumber %in% list_bnum) %>%
		dplyr::select(matches("Reference_"), gene_synonyms, product_synonyms)
	result
}

#' @title Get gene start
#' @name get_gene_start
#' @param list_genes A character vector of valid bnumbers (previously checked/converted with convert_gene(to = "bnumber"))
#' @return An integer vector of same size as `list_genes` (unknown input genes result in NA)
#' @export
#' @examples
get_gene_start <- function(list_genes) {
	master_gene_table <- read_source_file("genes")
	gene_list_by_bnum <- split(master_gene_table, master_gene_table$Reference_bnumber)

	get_start <- function(x) {
		ifelse(!is_valid_bnumber(x), warning("Unknown bnumber '", x, "'; try to use convert_gene('", x, "', to = 'bnumber') first."), NA)
		ifelse(!is.null(gene_list_by_bnum[[x]]$Reference_start[1]), gene_list_by_bnum[[x]]$Reference_start[1], NA)
	}
	list_start <- sapply(list_genes, FUN = get_start)
	unname(list_start)
}

#' @title Get gene stop
#' @name get_gene_stop
#' @param list_genes A character vector of valid bnumbers (previously checked/converted with convert_gene(to = "bnumber"))
#' @return An integer vector of same size as `list_genes` (unknown input genes result in NA)
#' @export
#' @examples
get_gene_stop <- function(list_genes) {
	master_gene_table <- read_source_file("genes")
	gene_list_by_bnum <- split(master_gene_table, master_gene_table$Reference_bnumber)

	get_stop <- function(x) {
		ifelse(!is_valid_bnumber(x), warning("Unknown bnumber '", x, "'; try to use convert_gene('", x, "', to = 'bnumber') first."), NA)
		ifelse(!is.null(gene_list_by_bnum[[x]]$Reference_stop[1]), gene_list_by_bnum[[x]]$Reference_stop[1], NA)
	}
	list_stop <- sapply(list_genes, FUN = get_stop)
	unname(list_stop)
}

#' @title Get gene strand
#' @name get_gene_strand
#' @param list_genes A character vector of valid bnumbers (previously checked/converted with convert_gene(to = "bnumber"))
#' @return A character vector of same size as `list_genes` (unknown input genes result in NA)
#' @export
#' @examples
get_gene_strand <- function(list_genes) {
	master_gene_table <- read_source_file("genes")
	gene_list_by_bnum <- split(master_gene_table, master_gene_table$Reference_bnumber)

	get_strand <- function(x) {
		ifelse(!is_valid_bnumber(x), warning("Unknown bnumber '", x, "'; try to use convert_gene('", x, "', to = 'bnumber') first."), NA)
		ifelse(!is.null(gene_list_by_bnum[[x]]$Reference_strand[1]), gene_list_by_bnum[[x]]$Reference_strand[1], NA)
	}
	list_strand <- sapply(list_genes, FUN = get_strand)
	unname(list_strand)
}

#' @title Get gene synonyms from the master table for a given vector of genes
#' @name get_gene_synonyms
#' @param list_genes A character vector of valid bnumbers (previously checked/converted with convert_gene(to = "bnumber"))
#' @return A character vector of same size as `list_genes` with comma-separated synonyms (unknown input genes result in NA)
#' @import dplyr
#' @export
#' @examples
get_gene_synonyms <- function(list_genes) {
	master_gene_table <- read_source_file("genes")
	gene_list_by_bnum <- split(master_gene_table, master_gene_table$Reference_bnumber)

	gene_synonyms <- function(x) {
		ifelse(!is_valid_bnumber(x), warning("Unknown bnumber '", x, "'; try to use convert_gene('", x, "', to = 'bnumber') first."), NA)
		ifelse(!is.na(x), gene_list_by_bnum[[x]]$gene_synonyms, NA)
	}
	list_synonyms <- sapply(list_genes, FUN = gene_synonyms)
	unname(list_synonyms)
}

#' @title Get gene nucleotide length
#' @name get_gene_length
#' @param list_genes A character vector of valid bnumbers (previously checked/converted with convert_gene(to = "bnumber"))
#' @return An integer vector of same size as `list_genes` (unknown input genes result in NA)
#' @export
#' @examples
get_gene_length <- function(list_genes) {
	master_gene_table <- read_source_file("genes")
	gene_list_by_bnum <- split(master_gene_table, master_gene_table$Reference_bnumber)

	gene_length <- function(x) {
		ifelse(!is_valid_bnumber(x), warning("Unknown bnumber '", x, "'; try to use convert_gene('", x, "', to = 'bnumber') first."), NA)
		ifelse(!is.na(x), gene_list_by_bnum[[x]]$Reference_stop - gene_list_by_bnum[[x]]$Reference_start, NA)
	}
	list_lengths <- sapply(list_genes, FUN = gene_length)
	unname(list_lengths)
}

#' @title Get previous genes bnumbers for a given vector of genes, with respect to strand orientation
#' @name get_upstream_gene
#' @param list_genes A character vector of valid bnumbers (previously checked/converted with convert_gene(to = "bnumber"))
#' @return A vector of same size as `list_genes` (unknown input genes result in NA)
#' @import dplyr
#' @export
#' @examples
get_upstream_gene <- function(list_genes) {
	master_gene_table <- read_source_file("genes")
	master_bis <- master_gene_table %>%
		arrange(Reference_start) %>%
		mutate(lag = lag(Reference_bnumber), lead = lead(Reference_bnumber))

	upstream_gene <- function(x) {
		if(!is_valid_bnumber(x)){
			warning("Unknown bnumber '", x, "'; try to use convert_gene('", x, "', to = 'bnumber') first.")
			pv <- NA
		} else if(get_gene_strand(x) == "+") {
			pv <- master_bis[master_bis$Reference_bnumber==x,"lag"]
		} else if(get_gene_strand(x) == "-") {
			pv <- master_bis[master_bis$Reference_bnumber==x,"lead"]
		} else {
			pv <- NA
		}
		pv
	}
	sapply(list_genes, FUN = upstream_gene)
}


#' @title Get next genes bnumbers for a given vector of bnumbers, with respect to strand orientation
#' @name get_downstream_gene
#' @param list_genes A character vector of valid bnumbers (previously checked/converted with convert_gene(to = "bnumber"))
#' @return A vector of same size as `bnumbers
#' @import dplyr
#' @export
#' @examples
get_downstream_gene <- function(list_genes) {
	master_gene_table <- read_source_file("genes")
	master_bis <- master_gene_table %>%
		arrange(Reference_start) %>%
		mutate(lag = lag(Reference_bnumber), lead = lead(Reference_bnumber))

	downstream_gene <- function(x) {
		if(!is_valid_bnumber(x)){
			warning("Unknown bnumber '", x, "'; try to use convert_gene('", x, "', to = 'bnumber') first.")
			nx <- NA
		} else if(get_gene_strand(x) == "+") {
			nx <- master_bis[master_bis$Reference_bnumber==x,"lead"]
		} else if(get_gene_strand(x) == "-") {
			nx <- master_bis[master_bis$Reference_bnumber==x,"lag"]
		} else {
			nx <- NA
		}
		nx
	}
	sapply(list_genes, FUN = downstream_gene)
}

