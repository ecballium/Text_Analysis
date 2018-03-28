#'
#' # HSK Lists
#' 
#' ## Info
#' 
#' A short script, which imports HSK1-6 lists and transforms them into lists of individual characters.
#' 
#' NOTE: characters that reappear in higher levels are discarded - a given character is listed under the lowest HSK to which it belongs.
#' 
#' 
#' ## Import word lists
#'
#+
HSK1_words <- readLines(con <- file("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Data_Files/HSK_Word_Lists/HSK1.txt", encoding = "UTF-8"))
HSK2_words <- readLines(con <- file("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Data_Files/HSK_Word_Lists/HSK2.txt", encoding = "UTF-8"))
HSK3_words <- readLines(con <- file("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Data_Files/HSK_Word_Lists/HSK3.txt", encoding = "UTF-8"))
HSK4_words <- readLines(con <- file("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Data_Files/HSK_Word_Lists/HSK4.txt", encoding = "UTF-8"))
HSK5_words <- readLines(con <- file("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Data_Files/HSK_Word_Lists/HSK5.txt", encoding = "UTF-8"))
HSK6_words <- readLines(con <- file("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Data_Files/HSK_Word_Lists/HSK6.txt", encoding = "UTF-8"))


#' ## Create character lists
#'
#' ### HSK1
#+

HSK1_characters <- unique(unlist(strsplit(HSK1_words, split = "")))
length(HSK1_characters)

#' ### HSK2
#' 
#+

HSK2_characters <- unique(unlist(strsplit(HSK2_words, split = "")))
length(HSK2_characters)
HSK2_characters <- HSK2_characters[!(HSK2_characters%in%HSK1_characters)]
length(HSK2_characters)

#' 
#' ### HSK3
#' 
#+

HSK3_characters <- unique(unlist(strsplit(HSK3_words, split = "")))
length(HSK3_characters)
HSK3_characters <- HSK3_characters[!(HSK3_characters%in%HSK2_characters)]
length(HSK3_characters)
HSK3_characters <- HSK3_characters[!(HSK3_characters%in%HSK1_characters)]
length(HSK3_characters)

#' 
#' ### HSK4
#' 
#+

HSK4_characters <- unique(unlist(strsplit(HSK4_words, split = "")))
length(HSK4_characters)
HSK4_characters <- HSK4_characters[!(HSK4_characters%in%HSK3_characters)]
length(HSK4_characters)
HSK4_characters <- HSK4_characters[!(HSK4_characters%in%HSK2_characters)]
length(HSK4_characters)
HSK4_characters <- HSK4_characters[!(HSK4_characters%in%HSK1_characters)]
length(HSK4_characters)

#' 
#' ### HSK5
#' 
#+

HSK5_characters <- unique(unlist(strsplit(HSK5_words, split = "")))
length(HSK5_characters)
HSK5_characters <- HSK5_characters[!(HSK5_characters%in%HSK4_characters)]
length(HSK5_characters)
HSK5_characters <- HSK5_characters[!(HSK5_characters%in%HSK3_characters)]
length(HSK5_characters)
HSK5_characters <- HSK5_characters[!(HSK5_characters%in%HSK2_characters)]
length(HSK5_characters)
HSK5_characters <- HSK5_characters[!(HSK5_characters%in%HSK1_characters)]
length(HSK5_characters)

#'
#' ### HSK6
#' 
#+

HSK6_characters <- unique(unlist(strsplit(HSK6_words, split = "")))
length(HSK6_characters)
HSK6_characters <- HSK6_characters[!(HSK6_characters%in%HSK5_characters)]
length(HSK6_characters)
HSK6_characters <- HSK6_characters[!(HSK6_characters%in%HSK4_characters)]
length(HSK6_characters)
HSK6_characters <- HSK6_characters[!(HSK6_characters%in%HSK3_characters)]
length(HSK6_characters)
HSK6_characters <- HSK6_characters[!(HSK6_characters%in%HSK2_characters)]
length(HSK6_characters)
HSK6_characters <- HSK6_characters[!(HSK6_characters%in%HSK1_characters)]
length(HSK6_characters)

#'
#' ## Save results
#' 
#' Remove the first character
#+

HSK1_characters <- HSK1_characters[-1]

#'
#+
saveRDS(HSK1_characters, "HSK1_characters.Rda")
saveRDS(HSK2_characters, "HSK2_characters.Rda")
saveRDS(HSK3_characters, "HSK3_characters.Rda")
saveRDS(HSK4_characters, "HSK4_characters.Rda")
saveRDS(HSK5_characters, "HSK5_characters.Rda")
saveRDS(HSK6_characters, "HSK6_characters.Rda")
#'
#'
#'
#'