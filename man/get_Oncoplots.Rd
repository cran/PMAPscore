% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_Oncoplots.R
\name{get_Oncoplots}
\alias{get_Oncoplots}
\title{draw an GenePathwayOncoplots}
\usage{
get_Oncoplots(
  maffile,
  path_gene,
  mut_status,
  risk_score,
  cut_off,
  final_signature,
  pathway_name,
  isTCGA = FALSE,
  top = 20,
  clinicalFeatures = "sample_group",
  annotationColor = c("red", "green"),
  sortByAnnotation = TRUE,
  removeNonMutated = FALSE,
  drawRowBar = TRUE,
  drawColBar = TRUE,
  leftBarData = NULL,
  leftBarLims = NULL,
  rightBarData = NULL,
  rightBarLims = NULL,
  topBarData = NULL,
  logColBar = FALSE,
  draw_titv = FALSE,
  showTumorSampleBarcodes = FALSE,
  fill = TRUE,
  showTitle = TRUE,
  titleText = NULL
)
}
\arguments{
\item{maffile}{A data of MAF format.}

\item{path_gene}{User input pathways geneset list.}

\item{mut_status}{The mutations matrix,generated by `get_mut_matrix`.}

\item{risk_score}{Samples' PTMB-related risk score,which could be a biomarker for survival analysis and immunotherapy prediction.}

\item{cut_off}{A threshold value(the median risk score as the default value).Using this value to divide the sample into high and low risk groups with different overall survival.}

\item{final_signature}{The pathway signature,use to map gene in the GenePathwayOncoplots.}

\item{pathway_name}{The name of the pathway that you want to visualize.For example "Gap junction"}

\item{isTCGA}{Is input MAF file from TCGA source. If TRUE uses only first 12 characters from Tumor_Sample_Barcode.}

\item{top}{How many top genes to be drawn,genes are arranged from high to low depending on the frequency of mutations. defaults to 20.}

\item{clinicalFeatures}{Columns names from 'clinical.data' slot of MAF to be drawn in the plot. Dafault "sample_group".}

\item{annotationColor}{Custom colors to use for sample annotation-"sample_group". Must be a named list containing a named vector of colors. Default "red" and "green".}

\item{sortByAnnotation}{Logical sort oncomatrix (samples) by provided 'clinicalFeatures'. Sorts based on first 'clinicalFeatures'. Defaults to TRUE. column-sort.}

\item{removeNonMutated}{Logical. If TRUE removes samples with no mutations in the GenePathwayOncoplots for better visualization. Default FALSE.}

\item{drawRowBar}{Logical. Plots righ barplot for each gene. Default TRUE.}

\item{drawColBar}{Logical plots top barplot for each sample. Default TRUE.}

\item{leftBarData}{Data for leftside barplot. Must be a data.frame with two columns containing gene names and values. Default 'NULL'.}

\item{leftBarLims}{Limits for 'leftBarData'. Default 'NULL'.}

\item{rightBarData}{Data for rightside barplot. Must be a data.frame with two columns containing to gene names and values. Default 'NULL' which draws distibution by variant classification. This option is applicable when only 'drawRowBar' is TRUE.}

\item{rightBarLims}{Limits for 'rightBarData'. Default 'NULL'.}

\item{topBarData}{Default 'NULL' which draws absolute number of mutation load for each sample. Can be overridden by choosing one clinical indicator(Numeric) or by providing a two column data.frame contaning sample names and values for each sample. This option is applicable when only 'drawColBar' is TRUE.}

\item{logColBar}{Plot top bar plot on log10 scale. Default FALSE.}

\item{draw_titv}{Logical Includes TiTv plot. Default FALSE}

\item{showTumorSampleBarcodes}{Logical to include sample names.}

\item{fill}{Logical. If TRUE draws genes and samples as blank grids even when they are not altered.}

\item{showTitle}{Default TRUE.}

\item{titleText}{Custom title. Default 'NULL'.}
}
\value{
No return value
}
\description{
Load the data in MAF format and draws an GenePathwayOncoplots.
}
\examples{
#obtain the risksciore
data(km_data)
risk_score<-km_data$multiple_score
names(risk_score)<-rownames(km_data)
cut_off<-median(risk_score)
#load the dtata
data(final_signature,path_gene,mut_status,maffile)
##draw an GenePathwayOncoplots
get_Oncoplots(maffile,path_gene,mut_status,risk_score,cut_off,final_signature,"Gap junction")

}
