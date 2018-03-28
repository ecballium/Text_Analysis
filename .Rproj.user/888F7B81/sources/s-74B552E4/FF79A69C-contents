#' ## Explorations into entropy
#' For use in word frequency
#' 
#' ### Function
#+

entr <- function(x, base = 2){
  xlog <- log(x,base = base)
  return(sum(-x*xlog))
}

#' ### Sample calculations
#+

entr(c(0.1,0.1, 0.1))
entr(c(0.2,0.2, 0.2))
entr(c(0.3,0.3, 0.3))
entr(c(0.3,0.2, 0.1))
entr(c(0.3,0.01,0.01))
entr(c(0.9,0.01,0.01))
entr(c(0.01,0.01,0.01))

#' The highest values are in case when probability is consistently high, and when probability is consistent.
#' Therefore, if entropy is to be used for stopword identification, the stopwords would have highest entropy.