% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/newspia.R
\name{newspia}
\alias{newspia}
\title{newspia}
\usage{
newspia(
  de = NULL,
  all = NULL,
  organism = "hsa",
  data.dir = NULL,
  pathids = NULL,
  verbose = TRUE,
  beta = NULL
)
}
\arguments{
\item{de}{A named vector containing the statue of particular genes in a particular sample.The names of this numeric vector are Entrez gene IDs.}

\item{all}{A vector with the Entrez IDs in the reference set. If the data was obtained from a microarray experiment,this set will contain all genes present on the specific array used for the experiment.This vector should contain all names of the de argument.}

\item{organism}{A three letter character designating the organism. See a full list at ftp://ftp.genome.jp/pub/kegg/xml/organisms.}

\item{data.dir}{Location of the "organism"SPIA.RData file containing the pathways data .If set to NULL will look for this file in the extdata folder of the PMAPscore library.}

\item{pathids}{A character vector with the names of the pathways to be analyzed.If left NULL all pathways available will be tested.}

\item{verbose}{If set to TRUE, displays the number of pathways already analyzed.}

\item{beta}{Weights to be assigned to each type of gene/protein relation type.
It should be a named numeric vector of length 23, whose names must be: c("activation","compound","binding/association","expression",
"inhibition","activation_phosphorylation","phosphorylation", "indirect","inhibition_phosphorylation","dephosphorylation_inhibition",
"dissociation","dephosphorylation","activation_dephosphorylation", "state","activation_indirect","inhibition_ubiquination","ubiquination",
"expression_indirect","indirect_inhibition","repression", "binding/association_phosphorylation","dissociation_phosphorylation","indirect_phosphorylation")
If set to null, beta will be by default chosen as: c(1,0,0,1,1,1,0,0,1,1,0,0,1,0,1,1,0,1,1,1,0,0,0).}
}
\value{
Get one Data in data frame format,which cotains pathway's id,pathway's name and PFS_score.
}
\description{
Function `newspia` This function is based on SPIA algorithm to analyse KEGG signal pathway for single sample..
}
