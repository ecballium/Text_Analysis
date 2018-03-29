#'
#' Tested approaches (none of these worked):
#' - setting locale (either within script or in .Rprofile)
#' - saving file with UTF-8 encoding
#' 
#' Failure occured with the following methods for output generation:
#' - knitr::spin()
#' - rmarkdown::render()
#' 
#' 
#' 的一了是他
#+

Sys.setlocale(locale = "Chinese") #Choose Chinese

#library(shiny)
#print("的一了是他")
#print.listof("的一了是他")
#x <- as.character("的一了是他", encoding = "UTF-8")
#print(x)


t <- readLines("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Data_Files/Sample_Text_Files/test_ch_utf.txt", encoding = "UTF-8")

#print(t)
#t

#print.listof(t, locale = locale(encoding = "UTF-8"))
renderPrint(t)