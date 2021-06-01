#' @title Convert bnumbers to gene symbols
#' @name get_gene_length
#'
#' @param bnumbers A character vector
#'
#' @return A integer vector of same size as `bnumbers`
#'
#' @import tidyr
#' @export
#'
#' @examples
get_gene_length <- function(bnumbers) {
	master_gene_table <- read_master_gene_file()

	gene_length <- function(x) {
		ifelse((!is.null(master_gene_table %>% filter(BNUMBER==x) %>% select(gene_length)) && (x != "-")),
					 unlist(master_gene_table %>% filter(BNUMBER==x) %>% select(gene_length)),
					 0)
	}
	list_lengths <- sapply(bnumbers, FUN=gene_length)
	unname(list_lengths)
}
#' @title Convert bnumbers to gene symbols
#' @name get_gene_leftpos
#'
#' @param bnumbers A character vector
#'
#' @return A vector of integers of same size as `bnumbers`
#'
#' @import tidyr
#' @export
#'
#' @examples
get_gene_leftpos <- function(bnumbers) {
	master_gene_table <- read_master_gene_file()

	gene_left <- function(x) {
		ifelse((!is.null(master_gene_table %>% filter(BNUMBER==x) %>% select(GENE_POSLEFT)) && (x != "-")),
					 unlist(master_gene_table %>% filter(BNUMBER==x) %>% select(GENE_POSLEFT)),
					 0)
	}
	list_lefts <- sapply(bnumbers, FUN=gene_left)
	unname(list_lefts)
}
#' @name get_gene_rightpos
#'
#' @param bnumbers A character vector
#'
#' @return A vector of integers of same size as `bnumbers`
#'
#' @import tidyr
#' @export
#'
#' @examples
get_gene_rightpos <- function(bnumbers) {
	master_gene_table <- read_master_gene_file()

	gene_right <- function(x) {
		ifelse((!is.null(master_gene_table %>% filter(BNUMBER==x) %>% select(GENE_POSRIGHT)) && (x != "-")),
					 unlist(master_gene_table %>% filter(BNUMBER==x) %>% select(GENE_POSRIGHT)),
					 0)
	}
	list_rights <- sapply(bnumbers, FUN=gene_right)
	unname(list_rights)
}
#' #' @name get_gene_strand
#' #'
#' #' @param bnumbers A character vector
#' #'
#' #' @return A vector of char of same size as `bnumbers`
#' #'
#' #' @import tidyr
#' #' @export
#' #'
#' #' @examples
#' get_gene_strand <- function(bnumbers) {
#' 	master_gene_table <- read_master_gene_file()
#'
#' 	gene_dir <- function(x) {
#' 		ifelse((!is.null(master_gene_table %>% filter(BNUMBER==x) %>% select(GENE_STRAND)) && (x != "-")),
#' 					 unlist(master_gene_table %>% filter(BNUMBER==x) %>% select(GENE_STRAND)),
#' 					 "-")
#' 	}
#' 	list_strands <- sapply(bnumbers, FUN=gene_dir)
#' 	unname(list_strands)
#' }
#' @name get_left_gene
#'
#' @param bnumbers A character vector
#'
#' @return A vector of char of same size as `bnumbers`
#'
#' @import tidyr
#' @export
#'
#' @examples
get_left_gene <- function(bnumbers) {
	master_gene_table <- read_master_gene_file()

	gene_left <- function(x) {
		ifelse((!is.null(master_gene_table %>% filter(BNUMBER==x) %>% select(left_bnumber)) && (x != "-")),
					 unlist(master_gene_table %>% filter(BNUMBER==x) %>% select(left_bnumber)),
					 "-")
	}
	list_left <- sapply(bnumbers, FUN=gene_left)
	unname(list_left)
}
#' @name get_right_gene
#'
#' @param bnumbers A character vector
#'
#' @return A vector of char of same size as `bnumbers`
#'
#' @import tidyr
#' @export
#'
#' @examples
get_right_gene <- function(bnumbers) {
	master_gene_table <- read_master_gene_file()

	gene_right <- function(x) {
		ifelse((!is.null(master_gene_table %>% filter(BNUMBER==x) %>% select(right_bnumber)) && (x != "-")),
					 unlist(master_gene_table %>% filter(BNUMBER==x) %>% select(right_bnumber)),
					 "-")
	}
	list_right <- sapply(bnumbers, FUN=gene_right)
	unname(list_right)
}
#' @name get_gene_symbol
#'
#' @param bnumbers A character vector
#'
#' @return A vector of char of same size as `bnumbers`
#'
#' @import tidyr
#' @export
#'
#' @examples
get_gene_symbol <- function(bnumbers) {
	master_gene_table <- read_master_gene_file()

	gene_sym <- function(x) {
		ifelse((!is.null(master_gene_table %>% filter(BNUMBER==x) %>% select(GENE_NAME)) && (x != "-")),
					 unlist(master_gene_table %>% filter(BNUMBER==x) %>% select(GENE_NAME)),
					 "-")
	}
	list_sym <- sapply(bnumbers, FUN=gene_sym)
	unname(list_sym)
}
#' @name get_gene_coords
#'
#' @param bnumbers A character vector
#'
#' @return A vector of char of same size as `bnumbers`
#'
#' @import tidyr
#' @export
#'
#' @examples
get_gene_coords <- function(bnumbers) {
	master_gene_table <- read_master_gene_file()

	gene_coords <- function(x) {
		ifelse((!is.null(master_gene_table %>% filter(BNUMBER==x) %>% select(gene_coords)) && (x != "-")),
					 unlist(master_gene_table %>% filter(BNUMBER==x) %>% select(gene_coords)),
					 "-")
	}
	list_coords <- sapply(bnumbers, FUN=gene_coords)
	unname(list_coords)
}
###################################################################################



### TODO
## same function for other attributes
## then re install and load
## then rewrite large steps using where_genic()


###################################################################################




#' #' @title Get following genes bnumbers for a given vector of bnumbers
#' #' @name get_next_gene
#' #'
#' #' @param bnumbers A character vector
#' #'
#' #' @return A vector of same size as `bnumbers
#' #'
#' #' @import dplyr
#' #' @export
#' #'
#' #' @examples
#' get_next_gene <- function(bnumbers) {
#' 	master_gene_table <- read_master_gene_file()
#'
#'   master_bis <- master_gene_table %>%
#'   	# mutate(left = ifelse(GENE_STRAND == "forward", GENE_POSLEFT, ifelse(GENE_STRAND == "reverse", GENE_POSRIGHT, NA)),
#'   	# 			 right = ifelse(GENE_STRAND == "forward", GENE_POSRIGHT, ifelse(GENE_STRAND == "reverse", GENE_POSLEFT, NA))) %>%
#'   	arrange(GENE_POSLEFT) %>%
#'   	mutate(lag = lag(BNUMBER), lead = lead(BNUMBER))
#'
#' 	next_gene <- function(x) {
#' 		if(x == "-") {
#' 			nx <- NA
#' 		} else if(master_bis[master_bis$BNUMBER == x ,"GENE_STRAND"] == "forward") {
#' 			nx <- master_bis[master_bis$BNUMBER==x,"lead"]
#' 		}else if(master_bis[master_bis$BNUMBER == x ,"GENE_STRAND"] == "reverse") {
#' 			nx <- master_bis[master_bis$BNUMBER==x,"lag"]
#' 		}
#' 	nx
#' 	}
#' 	sapply(bnumbers, FUN=next_gene)
#' }
#' #' @title Get previous genes bnumbers for a given vector of bnumbers
#' #' @name get_next_gene
#' #'
#' #' @param bnumbers A character vector
#' #'
#' #' @return A vector of same size as `bnumbers
#' #'
#' #' @import dplyr
#' #' @export
#' #'
#' #' @examples
#' get_prev_gene <- function(bnumbers) {
#' 	master_gene_table <- read_master_gene_file()
#'
#' 	master_bis <- master_gene_table %>%
#' 		# mutate(left = ifelse(GENE_STRAND == "forward", GENE_POSLEFT, ifelse(GENE_STRAND == "reverse", GENE_POSRIGHT, NA)),
#' 		# 			 right = ifelse(GENE_STRAND == "forward", GENE_POSRIGHT, ifelse(GENE_STRAND == "reverse", GENE_POSLEFT, NA))) %>%
#' 		arrange(GENE_POSLEFT) %>%
#' 		mutate(lag = lag(BNUMBER), lead = lead(BNUMBER))
#'
#' 	prev_gene <- function(x) {
#' 		if(x == "-") {
#' 			pv <- NA
#' 		} else if(master_bis[master_bis$BNUMBER == x ,"GENE_STRAND"] == "forward") {
#' 			pv <- master_bis[master_bis$BNUMBER==x,"lag"]
#' 		}else if(master_bis[master_bis$BNUMBER == x ,"GENE_STRAND"] == "reverse") {
#' 			pv <- master_bis[master_bis$BNUMBER==x,"lead"]
#' 		}
#' 		pv
#' 	}
#' 	sapply(bnumbers, FUN=prev_gene)
#' }
#' #' @title Get neighbour genes bnumbers for a given vector of bnumbers
#' #' @name get_neighbour_gene
#' #'
#' #' @param bnumbers A character vector
#' #'
#' #' @return A list of 2 vectors of same size as `bnumbers`
#' #'
#' #' @import dplyr
#' #' @export
#' #'
#' #' @examples
#' get_neighbour_gene <- function(bnumbers) {
#' 	master_gene_table <- read_master_gene_file()
#'
#' 	master_bis <- master_gene_table %>%
#' 		# mutate(left = ifelse(GENE_STRAND == "forward", GENE_POSLEFT, ifelse(GENE_STRAND == "reverse", GENE_POSRIGHT, NA)),
#' 		# 			 right = ifelse(GENE_STRAND == "forward", GENE_POSRIGHT, ifelse(GENE_STRAND == "reverse", GENE_POSLEFT, NA))) %>%
#' 		arrange(GENE_POSLEFT) %>%
#' 		mutate(lag = lag(BNUMBER), lead = lead(BNUMBER))
#'
#' 	neighbour_gene <- function(x) {
#' 		if(x == "-") {
#' 			prev_bnumber <- NA
#' 			next_bnumber <- NA
#' 		} else if(master_bis[master_bis$BNUMBER == x ,"GENE_STRAND"] == "forward") {
#' 			prev_bnumber <- master_bis[master_bis$BNUMBER==x,"lag"]
#' 			next_bnumber <- master_bis[master_bis$BNUMBER==x,"lead"]
#' 		}else if(master_bis[master_bis$BNUMBER == x ,"GENE_STRAND"] == "reverse") {
#' 			prev_bnumber <- master_bis[master_bis$BNUMBER==x,"lead"]
#' 			next_bnumber <- master_bis[master_bis$BNUMBER==x,"lag"]
#' 		}
#' 		cbind.data.frame(prev_bnumber, next_bnumber)
#' 	}
#' 	neighbours <- sapply(bnumbers, FUN=neighbour_gene)
#' 	t(neighbours)
#' 	# next_bnumber <- sapply(bnumbers, FUN=next_gene)
#' 	# data.frame(prev_bnumber, next_bnumber)
#' }
#' #' @title Get gene length for a given vector of bnumbers
#' #' @name get_gene_length
#' #'
#' #' @param bnumbers A character vector
#' #'
#' #' @return A vector of same size as `bnumbers`
#' #'
#' #' @import dplyr
#' #' @export
#' #'
#' #' @examples
#' get_gene_length <- function(bnumbers) {
#' 	master_gene_table <- read_master_gene_file()
#' 	result <- master_gene_table %>%
#' 		dplyr::filter(BNUMBER %in% bnumbers) %>%
#' 		dplyr::mutate(gene_length = GENE_POSRIGHT-GENE_POSLEFT) %>%
#' 		dplyr::select(gene_length)
#' 	result
#' }
