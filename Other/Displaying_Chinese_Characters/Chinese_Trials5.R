#' Some text. 
#' 
#' 还有汉字
#' 
#' 还有汉字
#' 
#+ 
Sys.setlocale(locale = "Chinese") #Choose Chinese
t <- readRDS("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Chinese_fragment.Rda")
Encoding(t) <- "UTF-8"

head(t)
print.listof(t, locale = locale(encoding = "UTF-8"))
#'
#' More stuff
#' 
#' Created using:
#' rmarkdown::render("Other/Displaying_Chinese_Characters/Chinese_Trials5.R", encoding = "UTF-8")
#' 
#' (in-text characters are displayed correctly, but not the ones printed by code)