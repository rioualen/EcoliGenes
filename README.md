
# EcoliGenes

<!-- badges: start -->
<!-- badges: end -->

The goal of EcoliGenes is to perform verifications and conversions of gene symbols and bnumbers. Indeed, we have noticed a number of discrepancies between the annotations in different databases of reference such as [RegulonDB](http://regulondb.ccg.unam.mx), [Ecocyc](https://ecocyc.org/), or [GenBank](https://www.ncbi.nlm.nih.gov/genbank/). We use an internal file with up-to-date gene symbols and bnumbers, as well as lists of synonyms commonly found accross databases, in order to uniformize gene sets for downstream treatments. 

## Installation

``` r
remotes::install_github("rioualen/EcoliGenes")
```

 
## Example

A few basic examples of the functions currently available. The functions are vectorized, so they can be applied to a single character variable, a vector, or a dataframe column: the output has the same size as the input. 

``` r
library(EcoliGenes)

## basic example data
list_symbols <- c("lexA", "fruR")
list_symbols_test <- c("lexA", "fruR", "abcD")

list_bnumbers <- c("b0001", "b2697")
list_bnumbers_test <- c("b0001", "b2697", "b8000")

list_tfs <- c("LexA", "Cra")
list_tfs_test <- c("LexA", "Cra", "AbcD")

## conversions
get_gene_symbol(list_bnumbers)
get_gene_symbol(list_bnumbers_test)

get_gene_bnumber(list_symbols)
get_gene_bnumber(list_symbols_test)

get_tf_bnumber(list_tfs)
get_tf_bnumber(list_tfs_test)

## get coordinates
get_gene_start(list_bnumbers)
get_gene_stop(list_bnumbers)
get_gene_strand(list_bnumbers)

```

## Structure of the package

![Flowchart.png](EcoliGenes library diagram)


