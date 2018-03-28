
A <- readLines(con <- file("test_eng_utf.txt", encoding = "UTF-8"))

C <- readLines(con <- file("test_ch_utf.txt", encoding = "UTF-8"))

C1 <- readLines(con <- file("ch1.txt", encoding = "UTF-8"))

T <- readLines(con <- file("ogt_utf.txt", encoding = "UTF-8"))

#Do single word stats - which characters most common?
#unlist(strsplit(T, split=""))

single_counts <- table(unlist(strsplit(T, split="")))

single_counts <- single_counts[order(single_counts, decreasing = TRUE)]


#Double counts

test <- T[230:240]

x <- test[11]
#x <- "ABCDEFG"

ch2split <- function(x){
  if (length(x)>1){
    stop("Vectors are not allowed")
  }
  if (nchar(x)!=0){
    x1 <- unlist(strsplit(x, split=""))
    x2 <- x1[-1] #Need to take empty vectors into account
    
    w1 <- paste0(x1[c(TRUE, FALSE)], x1[c(FALSE, TRUE)])
    w2 <- paste0(x2[c(TRUE, FALSE)], x2[c(FALSE, TRUE)])
    
    if(length(x1)%%2==1){
      w1 <- w1[1:length(w1)-1]
    }
    
    if(length(x1)%%2==0){
      w2 <- w2[1:length(w2)-1]
    }
    
    #unwanted <- “，！…”
    
    unwanted <- "\\p{P}"
    
    w1 <- w1[!grepl(unwanted, w1, perl=TRUE)]
    w2 <- w2[!grepl(unwanted, w2, perl=TRUE)]
    return(c(w1,w2))
  } else {
    return("")
  }

}


words <- sapply(T, ch2split)
names(words) <- NULL
words <- unlist(words)

words_counts <- table(words)
words_counts <- words_counts[order(words_counts, decreasing = TRUE)]


words_counts <- as.data.frame(words_counts)


#Words which do not contain top 100 characters (i.e. more likely to be actual words rather than frequent combinations of individual characters)

a1 <-as.data.frame(cbind(words=c("A1", "B2", "C3", "D4"), freq=c(1,2,3,4)))

#WRONG
weliminate <- function(elim, x){
  y <- x
  print(y)
  for (e in seq_along(elim)){
    y <- y[!grepl(elim[e], y),]
    print(y)
  }
  return(y)
}



weliminate <- function(elim, x){
  #To include some statements to prevent the possibility of input (x) being a matrix/df
  y <- replicate(length(x), TRUE)
  print(y)
  for (e in seq_along(elim)){
    y <- y & !grepl(elim[e], x)
    print(y)
  }
  return(y)
}



top100 <- single_counts[1:100]
words_counts_no100 <- words_counts
for (e in seq_along(top100)){
  words_counts_no100 <- words_counts_no100[!grepl(top100[e], words_counts_no100),]
}


#top100 <- single_counts[1:100]

top100 <- as.data.frame(single_counts[1:100], stringsAsFactors = FALSE)
colnames(top100) <- c("words", "Freq")
top100 <- top100$words

words_counts_no100 <- words_counts[weliminate(top100, words_counts$words),]


