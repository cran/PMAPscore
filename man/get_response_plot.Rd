% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_response_plot.R
\name{get_response_plot}
\alias{get_response_plot}
\title{Plot the response column diagram}
\usage{
get_response_plot(km_data, response, cut_point, TRAIN = TRUE)
}
\arguments{
\item{km_data}{A data frame, including survival status, survival time, and risk score of each sample. The data frame can be generated by the function `get_risk_score`.}

\item{response}{Response status of the sample to the drug.}

\item{cut_point}{The threshold uses to classify patients into two subgroups with different OS.}

\item{TRAIN}{Logical,if set to TRUE,the 'cut_point' is generated by the median of the risk score; Otherwise,'cut_point' can be customized.}
}
\value{
Comparison of the objective response rate between the high-risk and low-risk groups, plot the bar graph and return the p value.
}
\description{
The function `get_response_plot` uses to plot the column diagram of drug response.
}
\examples{
#Load the data.
data(km_data,response)
#perform the function `get_response_plot`.
get_response_plot(km_data,response,cut_point,TRAIN=TRUE)
}
