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
	# test <- master_gene_table %>% dplyr::rowwise() %>% dplyr::mutate(test = (position >= GENE_POSLEFT) && (position <= GENE_POSRIGHT)) %>% ungroup()
	# test <- master_gene_table %>% dplyr::rowwise() %>% dplyr::mutate(test = between(position, GENE_POSLEFT, GENE_POSRIGHT)) %>% ungroup()
	# test <- test %>% filter(test == T)
	# nrow(test) == 1

	check_genic <- function(x) {
		lo <- x >= master_gene_table$GENE_POSLEFT
		hi <- x <= master_gene_table$GENE_POSRIGHT
		check <- lo * hi
		introw <- which(check == 1)
		length(introw) == 1
	}
	sapply(positions, FUN=check_genic)
}


# position <- c(10, 20, 50, 70, 155, 190, 400) # vector of values to checkdaa
# lo2 <- sapply(position, function(x) x >= df$left)
# hi2 <- sapply(position, function(x) x <= df$right)
# check2 <- lo2 * hi2
# introws <- apply(check2, 2, function(x) which(x == 1))
# introws #vector of intervals for each input value
#
# introws
# 2 5 1 3 4
# final <- cbind(value = z2, interval = introws)
# final
# value interval
# [1,]   356        2
# [2,]   934        5
# [3,]   134        1
# [4,]   597        3
# [5,]   771        4



# df <- data.frame(id = c("A", "B", "C"), left = c(0, 50, 150), right = c(15, 78, 190))
# position <- 191
#
#
# lo <- position >= df$left
# hi <- position <= df$right
# check <- lo * hi
# introw <- which(check == 1)
#
# introw
# 3
#
# z2 <- c(356, 934, 134, 597, 771) # vector of values to check
# lo2 <- sapply(z2, function(x) x >= df$left)
# hi2 <- sapply(z2, function(x) x <= df$right)
# check2 <- lo2 * hi2
# introws <- apply(check2, 2, function(x) which(x ==1))
# introws #vector of intervals for each input value
# introws
# 2 5 1 3 4

# my_function <- function(x) {
# 	test <- df %>% dplyr::rowwise() %>%
# 		dplyr::mutate(test = between(x,left,right)) %>% ungroup()
# 	test <- test %>% filter(test == T)
# 	nrow(test) == 1
# }

#' @title Check where in gene
#' @name where_genic
#'
#' @param positions A numeric vector
#'
#' @return A character vector
#'
#' @import dplyr
#' @export
#'
#' @examples
where_genic <- function(positions) {
	master_gene_table <- read_master_gene_file()
	genic_positions <- positions[which(is_genic(positions)==TRUE)]
	check_genic_with_pos <- function(x) {
		lo <- x >= master_gene_table$GENE_POSLEFT
		hi <- x <= master_gene_table$GENE_POSRIGHT
		check <- lo * hi
		df <- master_gene_table[which(check == 1),]
		# data.frame(position = x, bnumber = df$BNUMBER, left = df$GENE_POSLEFT, right = df$GENE_POSRIGHT)
		paste(df$BNUMBER)
	}
	sapply(genic_positions, FUN=check_genic_with_pos)
}

# all.genes.regu <- read.delim("RegulonDB/GeneProductSet.txt", header=FALSE, sep="\t", comment.char = "#")
# colnames(all.genes.regu) <- c("Gene.ID", "Gene.name", "B.num", "start", "end", "strand", "product", "evidence", "PMID", "confidence")
#
# all.genes.regu.bed <- cbind.data.frame(rep("NC_000913.3", nrow(all.genes.regu)), all.genes.regu$start, all.genes.regu$end, all.genes.regu$Gene.name, all.genes.regu$B.num, all.genes.regu$strand)
# colnames(all.genes.regu.bed) <- c("Chromosome", "start", "end", "gene.name", "gene.id", "strand")
# all.genes.regu.bed <- all.genes.regu.bed %>% arrange(start)
