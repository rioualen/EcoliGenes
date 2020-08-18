
# EcoliGenes

<!-- badges: start -->
<!-- badges: end -->

The goal of EcoliGenes is to perform verifications and conversions of gene symbols and bnumbers. Indeed, we have noticed a number of discrepancies between the annotations in different databases of reference such as [RegulonDB](http://regulondb.ccg.unam.mx), [Ecocyc](https://ecocyc.org/), or [GenBank](https://www.ncbi.nlm.nih.gov/genbank/). We use an internal file with up-to-date gene symbols and bnumbers, as well as lists of synonyms commonly found accross databases, in order to uniformize gene sets for downstream treatments. 

## Installation

``` r
remotes::install_github("rioualen/EcoliGenes")
```

 
## Example

This is a basic example which shows you how to convert a list of genes:

``` r
library(EcoliGenes)

## basic example data
list_symbols <- c("lexA", "fruR")
list_symbols_test <- c("lexA", "fruR", "abcD")

list_bnumbers <- c("b0001", "b4338")
list_bnumbers_test <- c("b0001", "b4338", "b8000")

list_tfs <- c("LexA", "Cra")
list_tfs_test <- c("LexA", "Cra", "AbcD")

## conversions
bnumber_to_symbol(list_bnumbers)
bnumber_to_symbol(list_bnumbers_test)

symbol_to_bnumber(list_symbols)
symbol_to_bnumber(list_symbols_test)

tf_to_bnumber(list_tfs)
tf_to_bnumber(list_tfs_test)

## get all tf genes / target genes from regulonDB
get_target_genes()
get_tf_genes()

## Check if a list of genes are TFs or potential target genes
is_target_gene(list_bnumbers)
is_tf_gene(list_bnumbers)
```

## To be added

``` r
show_synonyms(list_bnumbers)
show_synonyms(list_symbols)
show_synonyms(list_tfs)
get_sRNA(list_bnumbers)
...
get_coords(list_bnumbers)
```

