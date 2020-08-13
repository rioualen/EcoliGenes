
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

## conversions
bnumber_to_symbol(list_bnumbers)
bnumber_to_symbol(list_bnumbers_test)
symbol_to_bnumber(list_symbols)
symbol_to_bnumber(list_symbols_test)
```

## To be added

``` r
is_valid(list_bnumbers)
is_tf(list_bnumbers)

show_synonyms(list_bnumbers)
show_synonyms(list_symbols)

get_tfs(list_bnumbers)
get_coding(list_bnumbers)
get_sRNA(list_bnumbers)
...

get_coords(list_bnumbers)
```

