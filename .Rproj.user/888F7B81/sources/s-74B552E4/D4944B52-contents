#' Functions for text analysis 
#' - ch2split - for spliting strings into bigrams
#' - weliminate - for finding indices of interest (eliminating unwanted ones)
#' Copied from OGT_Words (and will be maintained here)
#' 
#' - divideCharacterVector

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




weliminate <- function(elim, x){
  #To include some statements to prevent the possibility of input (x) being a matrix/df
  
  if (!is.null(dim(x))){
    stop("Object cannot be multidimensional")
  }
  
  y <- replicate(length(x), TRUE)
  for (e in seq_along(elim)){
    y <- y & !grepl(elim[e], x)
  }
  return(y)
}



weliminate_cont <- function(elim, x){
  #To include some statements to prevent the possibility of input (x) being a matrix/df
  
  if (!is.null(dim(x))){
    stop("Object cannot be multidimensional")
  }
  
  y <- replicate(length(x), TRUE)
  for (e in seq_along(elim)){
    y <- y & !grepl(elim[e], x)
  }
  
  if (sum(y)==0){
    stop("Everything was eliminated!")
  }
  
  return(x[y])
}


divideCharVector <- function(x, n, max_ratio = NULL, max_diff = NULL){
  # x - character vector
  # n - number of parts to be obtained
  # max_ratio - maximum allowed ratio of sd/mean in character count of parts
  # max_diff - maximum allowed difference in character count of parts (as proportion of mean character count)
  # Function to divide vector x into n parts
  # Returns a list of n character vectors
  # If the character cannot be divided into equal parts, the first part is made appropriately larger and the remaining ones are made equal
  
  # FUTURE: do something if unequal distribution of characters occurs
  
  if (is.null(max_ratio)){
    max_ratio <- 0.3
  }
  if (is.null(max_diff)){
    max_diff <- 0.4
  }

  
  if (is.character(x)!=TRUE){
    stop("Input needs to be a character vector")
  }
  
  L <- length(x)
  
  if (L<n){
    stop("Specified value of n cannot be larger than vector length")
  }
  
  each <- L %/% n #Size of each division (except first)
  first <- each + L %% n #Size of the first division
  
  y <- list()
  counts <- integer()
  
  for (a in 1:n){
    
    if (a ==1){
      y[[a]] <- x[1:first]
    } else if (a == 2){
      y[[a]] <- x[(1+first):(first+each)]
    } else if (a > 2){
      y[[a]] <- x[(1+first+(a-2)*each):(first+(a-1)*each)]
    }
    counts[a] <- sum(nchar(y[[a]]))
  }
  
  
  print(counts)
  
  condition1 <- (sd(counts)/mean(counts)) > max_ratio
  condition2 <- ((max(counts) - min(counts))/mean(counts)) > max_diff
  
  if (condition1 | condition2){
    warning("Data is not equally spread")
  }

  
  return(y)
  
}


