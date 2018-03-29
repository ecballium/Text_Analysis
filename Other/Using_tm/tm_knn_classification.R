#Based on: https://www.youtube.com/watch?v=j1V2McKbkLo
#From: https://stackoverflow.com/questions/49517770/how-to-export-rstudio-analysis-detail/49546261#49546261

#int
libs <- c("tm", "plyr","class")
lapply(libs, require, character.only = TRUE)

#set options
options(stringsAsFactors = FALSE)

#set parameters
contract <- c("build construction", "other")
pathname <- "C:/Users/dhoward27/Desktop/ML/ContractReview"

#clean text
cleanCorpus <- function(corpus) {
  corpus.tmp <- tm_map(corpus, removePunctuation)
  corpus.tmp <- tm_map(corpus.tmp, stripWhitespace)
  corpus.tmp <- tm_map(corpus.tmp, content_transformer(tolower))
  corpus.tmp <- tm_map(corpus.tmp, removeWords, stopwords("english"))
  corpus.tmp <- tm_map(corpus.tmp, stemDocument)
  return(corpus.tmp)
}

#build TDM

generateTDM <- function(contract, path) {
  c.dir <- sprintf ("%s/%s", path, contract)
  c.cor <- VCorpus(DirSource(directory = c.dir), readerControl = list(reader=readPlain))
  c.cor.cl <- cleanCorpus(c.cor)
  c.tdm <- TermDocumentMatrix(c.cor.cl)
  
  c.tdm <- removeSparseTerms(c.tdm, .07)
  result <- list(name = contract, tdm = c.tdm)
}

tdm <- lapply(contract, generateTDM, path = pathname)

# attach name

bindcontractToTDM <- function(tdm) {
  c.mat <-t(data.matrix(tdm[["tdm"]]))
  c.df <- as.data.frame(c.mat, stringsAsFactors = FALSE)
  
  c.df <- cbind(c.df, rep(tdm[["name"]], nrow(c.df)))
  colnames(c.df) [ncol(c.df)] <- "targetcontract"
  return(c.df)
}

contractTDM <- lapply(tdm, bindcontractToTDM)

#stack if you have more than one dataframe
tdm.stack <- do.call(rbind.fill, contractTDM)
tdm.stack[is.na(tdm.stack)] <-0

#hold-out
train.idx <- sample(nrow(tdm.stack), ceiling(nrow(tdm.stack)* 0.7))
test.idx <- (1:nrow(tdm.stack))[- train.idx]

#model - knn
tdm.contract <-tdm.stack[, "targetcontract"]
tdm.stack.nl <- tdm.stack[, !colnames(tdm.stack) %in% "targetcontract"]

knn.pred <- knn(tdm.stack.nl[train.idx, ], tdm.stack.nl[test.idx, ], tdm.contract[train.idx])

#accuracy

conf.mat <- table("predictions"= knn.pred, Actual = tdm.contract[test.idx])

(accuracy <- sum(diag(conf.mat)) / length(test.idx)*100)