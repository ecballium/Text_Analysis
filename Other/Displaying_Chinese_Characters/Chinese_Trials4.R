#' # Some document
#' 
#' 
#+

Sys.setlocale(locale = "Chinese") #Choose Chinese

#' Chinese characters are not displayed correctly here:
#' 
#' Some text. 
#' 
#' 还有汉字
#' 还有汉字。
#+

Sys.setlocale(locale = "Chinese") #Choose Chinese
readLines("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Data_Files/Sample_Text_Files/test_ch_utf.txt", encoding = "UTF-8")
#'