% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_gene_info.R
\name{get_gene_strand}
\alias{get_gene_strand}
\title{Get gene strand}
\usage{
get_gene_strand(list_genes)
}
\arguments{
\item{list_genes}{A character vector of valid bnumbers (previously checked/converted with convert_gene(to = "bnumber"))}
}
\value{
A character vector of same size as \code{list_genes} (unknown input genes result in NA)
}
\description{
Get gene strand
}
