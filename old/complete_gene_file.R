## load gene file
genes <- read.delim("inst/extdata/GeneProduct-IDs.tsv", header=T, stringsAsFactors = F)

## add columns conting TFs
tf_patterns <- c("DNA-binding", "transcriptional regulator", "transcriptional repressor", "transcriptional activator", "transcriptional dual regulator")

genes_tfs <- genes  %>% dplyr::mutate (TF_regulondb = ifelse(grepl(paste(tf_patterns, collapse="|"), genes$PRODUCT_NAME), "yes",
																									 ifelse(grepl(paste(tf_patterns, collapse="|"), genes$PRODUCT_SYNONYMS), "yes", "")))

sum(genes_tfs$TF_regulondb == "yes")

## add tfs from zika
zika_tfs <- read.csv("inst/extdata/TFs_zika.csv", header=T, stringsAsFactors = F)

# convert_sym <- zika_tfs %>% dplyr::mutate(new_symbol = bnumber_to_symbol(zika_tfs$bnumber)) %>% mutate(test_symbol = (symbol == new_symbol))
# convert_sym <- convert_sym %>% dplyr::mutate(new_bnumber = symbol_to_bnumber(zika_tfs$symbol)) %>% mutate(test_bnumber = (bnumber == new_bnumber))
# write.table(convert_sym %>% filter(test_symbol == F), file = "inst/extdata/TFs_zika_update.tsv", col.names = T, row.names = F, quote = F, sep = "\t")

genes_tfs <- genes_tfs  %>% dplyr::mutate (TF_zika = ifelse(BNUMBER %in% zika_tfs$bnumber, "yes", ""))
sum(genes_tfs$TF_zika == "yes")

# write.table(genes_tfs, file = "inst/extdata/Genes_TFs_zika_update.tsv", col.names = T, row.names = F, quote = F, sep = "\t")

# write.table(genes_tfs, file = "inst/extdata/master_gene_file.tsv", col.names = T, row.names = F, quote = F, sep = "\t")


## add tfs from TFSet
tfset_tfs <- read.delim("inst/extdata/TFSet.txt", header=F, stringsAsFactors = F, comment.char = "#")
tfset_tfs <- tfset_tfs %>% tidyr::separate_rows(V3, sep=", ")
tfset_tfs_sym <- tfset_tfs$V3
tfset_tfs_bnum <- EcoliGenes::symbol_to_bnumber(tfset_tfs_sym)

genes_tfs <- genes_tfs  %>% dplyr::mutate (TFSet = ifelse(BNUMBER %in% tfset_tfs_bnum, "yes", ""))
sum(genes_tfs$TFSet == "yes")


## add tf predicted in regulondb

tfset_pred <- read.delim("inst/extdata/TF_predicted.txt", header=T, stringsAsFactors = F, comment.char = "#")
# tfset_pred <- tfset_pred %>% tidyr::separate_rows(V3, sep=", ")
# tfset_pred_sym <- tfset_pred$V3
tfset_pred_sym <- tfset_pred$Gene.Name
tfset_pred_bnum <- EcoliGenes::symbol_to_bnumber(tfset_pred_sym)
tfset_pred_bnum <- tfset_pred_bnum[!tfset_pred_bnum==FALSE]

# tfset_tfs_bnum <- tfset_pred$Locus

genes_tfs <- genes_tfs  %>% dplyr::mutate (TF_pred = ifelse(BNUMBER %in% tfset_pred_bnum, "yes", ""))
sum(genes_tfs$TF_pred == "yes")




write.table(genes_tfs, file = "inst/extdata/master_gene_file.tsv", col.names = T, row.names = F, quote = F, sep = "\t")

write.table(genes_tfs %>% dplyr::filter(TF_zika == "yes" | TF_regulondb == "yes" | TFSet == "yes" | TF_pred == "yes"), file = "inst/extdata/tf_file.tsv", col.names = T, row.names = F, quote = F, sep = "\t")




