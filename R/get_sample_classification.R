#' @title get_sam_cla
#' @description Function `get_sample_classification` This function is used to judge the classification of samples.
#' @param mut_sam The sample somatic mutation data.
#' @param gene_Ucox  Results of gene univariate Cox regression.
#' @param symbol_Entrez A data table containing gene symbol and gene Entrez ID.
#' @param path_cox_data Pathways of Cancer-specifical obtained from the training set.
#' @param sur The data contains survival time and survival state of all samples
#' @param path_Ucox_mul Multivariate Cox regression results of  Cancer-specifical pathways.
#' @param data.dir Location of the "organism"SPIA.RData file containing the pathways data. If set to NULL will look for this file in the extdata folder of the PMAPscore library.
#' @param cut_off Threshold of classification.
#' @param organism A three letter character designating the organism. See a full list at ftp://ftp.genome.jp/pub/kegg/xml/organisms.
#' @param sig Cancer-specific dysregulated signal pathways. It can be generated by the function `get_final_signature`.
#' @param sur This data contains survival status and survival time of each sample.
#' @param TRAIN Logical,if set FLASE,we need to load the result of multivariate Cox regression of cancer specific pathways into the training set.
#' @export
#' @return Return a data frame, the sample's risk score and the sample's risk group.
#' @examples
#' #Load the data.
#' data(mut_sam,gene_Ucox,symbol_Entrez,path_cox_data,sur,path_Ucox_mul)
#' #perform function `get_sample_cla`.
#' \donttest{get_sam_cla(mut_sam,gene_Ucox,symbol_Entrez,path_cox_data,sur,path_Ucox_mul,sig,cut_off=-0.986)}


get_sam_cla<-function(mut_sam,gene_Ucox,symbol_Entrez,
                                    path_cox_data,sur,path_Ucox_mul,sig,
                                    cut_off=-0.986,data.dir=NULL,organism="hsa",TRAIN=FALSE){
  a<-colnames(mut_sam)
  rownames(mut_sam)<-gsub(pattern = "-",replacement = ".",rownames(mut_sam))
  mut_sam<-as.matrix(mut_sam[match(rownames(gene_Ucox)[which(gene_Ucox$HR<1)],rownames(mut_sam)),])
  mut_sam<-get_Entrez_ID(mut_sam,symbol_Entrez,Entrez_ID=TRUE)
  mut_sample<-as.matrix(mut_sam)
  colnames(mut_sample)<-a
  path_matrix<-as.numeric(mut_sample[,1])
  names(path_matrix)<-rownames(mut_sample)
  path_matrix<-path_matrix[which(path_matrix!=0)]
  if(length(path_matrix[which(path_matrix!=0)])>0){
    res<-newspia(de=path_matrix[which(path_matrix!=0)],all=rownames(mut_sample),organism="hsa",
                 beta=NULL,verbose=FALSE,data.dir=data.dir)
  }
  .myDataEnv <- new.env(parent = emptyenv())
  datload <- paste(organism, "SPIA", sep = "")
  if (is.null(data.dir)) {
    if (!paste(datload, ".RData", sep = "") %in%
        dir(system.file("extdata", package = "PMAPscore"))) {
      cat("The KEGG pathway data for your organism is not present in the extdata folder of the SPIA package!!!")
      cat("\n")
      cat("Please generate one first using makeSPIAdata and specify its location using data.dir argument or copy it in the extdata folder of the SPIA package!")
    }
    else {
      load(file = paste(system.file("extdata", package = "PMAPscore"),
                        paste("/", organism, "SPIA", sep = ""),
                        ".RData", sep = ""),envir = .myDataEnv)
    }
  }
  if (!is.null(data.dir)) {
    if (!paste(datload, ".RData", sep = "") %in%
        dir(data.dir)) {
      cat(paste(data.dir, " does not contin a file called ",
                paste(datload, ".RData", sep = "")))
    }
    else {
      load(file = paste(data.dir, paste(datload, ".RData",
                                        sep = ""), sep = ""), envir = .myDataEnv)
    }
  }
  path.info = .myDataEnv[["path.info"]]
  pathname<-c()
  for (j in 1:length(path.info)) {
    pathname<-c(pathname,path.info[[j]]$title)
  }
  pfs_score<-matrix(data=0,nrow = length(pathname),ncol = dim(mut_sample)[2])
  rownames(pfs_score)<-pathname
  colnames(pfs_score)<-a
  loc2<-match(res[,1],rownames(pfs_score))
  pfs_score[loc2,1]<-res[,3]
  km_data<-get_risk_score(sig,pfs_score,path_Ucox_mul,sur,TRAIN=TRAIN)
  km_data<-as.data.frame(km_data)
  result<-c()
  for (i in 1:dim(km_data)[1]) {
    if(km_data[i,dim(km_data)[2]]>cut_off){
      newdata<-cbind(rownames(km_data)[i],km_data[i,dim(km_data)[2]],"high")
    }else
    {newdata<-cbind(rownames(km_data)[i],km_data[i,dim(km_data)[2]],"low")}
    result<-rbind(result,newdata)
  }
  colnames(result)<-c("sample","risk_score","class")
  rownames(result)<-result[,1]
  return(result)
  }
