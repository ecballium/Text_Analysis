#' # Some document
#' 
#' 
#+

Sys.setlocale(locale = "Chinese") #Choose Chinese

#' Chinese characters are not displayed correctly here:
#' 
#' Some text. 
#' 
#' 还有汉字。
#+
Sys.setlocale(locale = "Chinese") #Choose Chinese
print("Some text")
readLines("Data_Files/Sample_Text_Files/test_ch_utf.txt", encoding = "UTF-8")


#'