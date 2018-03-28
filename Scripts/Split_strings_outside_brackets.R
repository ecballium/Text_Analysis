#Answer to the problem from: https://stackoverflow.com/questions/49522274/r-regex-to-split-string-by-character-and-retaining-content-inside-square-bracke/49523284#49523284

#Used approach from: https://stackoverflow.com/questions/15573887/split-string-with-regex
x <- "[a] + [bc] + 1"
x <- gsub("\\[",",[",x)
x <- gsub("\\]","],",x)
strsplit(x,",")



x <- "[a] + [bc] + 1"

foo <- function(x){
  #Mark square brackets with commas
  x <- gsub("\\[",",[",x)
  x <- gsub("\\]","],",x)
  
  #Separate the string based on commas
  x <- unlist(strsplit(x,","))
  
  #Find which vector elements contain brackets
  ind <- grepl("\\[.*\\]", x)
  
  y <- character()
  for (a in seq_along(x)){
    if (nchar(x[a])!=0){
      if (ind[a]){
        y <- c(y, x[a]) #Store original character
      } else {
        y <- c(y, unlist(strsplit(x[a], ""))) #Store split character
      }
    }
  }
  
  #Remove the brackets
  y <- gsub("\\[", "", y)
  y <- gsub("\\]", "", y)
  return(y)
}



