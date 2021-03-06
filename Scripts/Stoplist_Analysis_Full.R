#'
#' # Stoplist Analysis
#' 
#' ## Setup
#+

library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(wordcloud)

Sys.setlocale(locale = "Chinese") #Choose Chinese

source("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Scripts/Helpful_Functions.R")

#coul = brewer.pal(4, "BuPu")
#coul = colorRampPalette(coul)

#' 
#' ## Test case
#'
#+

#N <- 3
#test <- data.frame(words = c("a", "b", "c", "a", "b", "b", "d"),
#                   freq = c(5, 3, 4, 2, 3, 8, 2), 
#                   doc = c(rep("i", 3), rep("ii", 2), rep("iii", 2)))

#Improved example
#test <- data.frame(words = c("a", "b", "c", "e", "a", "b", "b", "d"),
#                   freq = c(3, 5, 4, 1, 2, 3, 8, 2), 
#                   doc = c(rep("i", 4), rep("ii", 2), rep("iii", 2)))


#'
#' ## Data Preprocessing
#' 
#' 
#+


T <- readLines(con <- file("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/ogt_utf_cr.txt", encoding = "UTF-8"))
#T <- readLines(con <- file("ogt_utf.txt", encoding = "UTF-8"))

N <- 10
Tp <- divideCharVector(T, N)

counts_df <- data.frame()

#for (i in 1){
for (i in 1:N){
  c <- table(unlist(strsplit(Tp[[i]], split="")))
  c <- c[order(c, decreasing = TRUE)]
  c <- as.data.frame(c, stringsAsFactors = FALSE)
  c$doc <- i
  colnames(c) <- c("words", "freq", "doc")
  counts_df <- rbind(counts_df, c)
}


remove_char_groups <- c("[[:blank:]]","[[:punct:]]", "[[:digit:]]", "[A-z]")
weliminate_cont(remove_char_groups, counts_df$words[1:100])
print.listof(weliminate_cont(remove_char_groups, counts_df$words[1:100]), locale = locale(encoding = "UTF-8"))
print("�������n��")


counts_df <- counts_df[weliminate(remove_char_groups, counts_df$words),]

test <- counts_df

#'
#'
#'
#' ## Calculations
#' 
#+

#Calculate Doc_size (sum freq within a doc)
test <- test %>% group_by(doc) %>% mutate(Doc_size = sum(freq))

#Calculate Tot_freq (sum freq within a word)
test <- test %>% group_by(words) %>% mutate(Tot_freq = sum(freq))

#Calculate Num_doc and Perc_doc (The percentage of docs a word appears in)
test <- test %>% group_by(words) %>% mutate(Num_doc = n())
test <- test %>% group_by(words) %>% mutate(Perc_doc = n()/N )

#Calculate Prob_word_in_doc (freq/Doc_size)
test <- test %>% group_by(words) %>% mutate(Prob_word_in_doc = freq/Doc_size)

#Calculate MP ((sum of prob)/N)
test <- test %>% group_by(words) %>% mutate(MP = sum(Prob_word_in_doc)/N)

#Calculate Variance (divided by the number of documents)
test <- test %>% group_by(words) %>% mutate(VP = var(Prob_word_in_doc)/N)

#Calculate SAT
#test <- mutate(test, SAT = MP/VP) #Does not work very well
#test <- mutate(test, SAT = MP/(VP^0.5))
test <- mutate(test, SAT = MP*(VP^0.5))

#Calculate Entropy (in two steps)
#test <- mutate(test, H_int = -(Prob_word_in_doc * log(Prob_word_in_doc, base = 2)))
#test <- test %>% group_by(words) %>% mutate(H2 = sum(H_int))

#Calculate Entropy
test <- test %>% group_by(words) %>% mutate(H = sum(-Prob_word_in_doc * log(Prob_word_in_doc, base = 2)))


test_sum <- test %>% select(words, Tot_freq, Perc_doc, MP, VP, SAT, H)

test_sum <- distinct(test_sum)

if (dim(test_sum)[1]!=(length(unique(test_sum$words)))){
  stop("Something went wrong in the processing")
}

test_sum <- test_sum %>% mutate(SAT=replace(SAT, is.na(SAT), 0))

test_sum <- as.data.frame(test_sum) #Seems to be necessary
test_sum <- test_sum %>% arrange(desc(SAT), desc(MP)) %>% mutate(SAT_Rank = row_number())

#Some hopeless attempts
#test_sum <- as.data.frame(test_sum) #Seems to be necessary
#test_sum <- test_sum %>% mutate(SAT_Rank = dense_rank(c(SAT, MP)) )

#max_SAT_Rank <- max(test_sum$SAT_Rank)
#test_sum <- test_sum %>% mutate(SAT2 = case_when(is.na(SAT) ~ dense_rank(desc(MP))))

#test_sum <- test_sum %>% mutate(SAT3 = dense_rank(interaction(SAT, MP)))

test_sum <- as.data.frame(test_sum)
#test_sum <- test_sum %>% mutate(H_Rank = dense_rank(desc(H)))
test_sum <- test_sum %>% mutate(H_Rank = row_number(desc(H)))


test_sum <- test_sum %>% mutate(Tot_Rank = SAT_Rank+ H_Rank)

test_sum <- test_sum %>% arrange(Tot_Rank)

#' A note on ordering:
#'
#' - decreasing entropy (stopwords have highest entropy)
#' - decreasing SAT_Rank (stopwords have high MP and low VP)
#' NOTE: in case of the same SAT values, MP is taken into account
#' 
#' 
#' 
#' 
#' 
#' ## Visualisation
#' 
#+

#No longer needed atm
#TF_mean <- summary(test_sum$Tot_freq)[4]
#TF_3q <- summary(test_sum$Tot_freq)[5]
#TF_max <- summary(test_sum$Tot_freq)[6]

MP_1q <- summary(test_sum$MP)[2]
MP_3q <- summary(test_sum$MP)[5]
VP_1q <- summary(test_sum$VP)[2]
VP_3q <- summary(test_sum$VP)[5]

test_sum_top50freq <- test_sum %>% arrange(desc(Tot_freq))
test_sum_top50freq <- test_sum_top50freq[1:50,]



ggplot(test_sum_top50freq, aes(x = reorder(words, -Tot_freq), y = Tot_freq)) + geom_bar(stat = "identity") + theme(axis.text.x=element_text(angle=45, hjust=1)) + coord_fixed(ratio = 1/600 )

ggsave(filename = "counts_df_top50freq.png", height = 8, width = 16)

#Other valid plots

#ggplot(test_sum, aes(x = reorder(words, -Tot_freq), y = Tot_freq)) + geom_bar(stat = "identity") + theme(axis.text.x=element_text(angle=45, hjust=1))

#ggplot(subset(test_sum, Tot_freq >400), aes(x = reorder(words, -Tot_freq), y = Tot_freq)) + geom_bar(stat = "identity") + theme(axis.text.x=element_text(angle=45, hjust=1))

#ggplot(subset(test_sum, Tot_freq >240), aes(x = reorder(words, -Tot_freq), y = Tot_freq)) + geom_bar(stat = "identity") + theme(axis.text.x=element_text(angle=45, hjust=1)) + coord_fixed(ratio = 1/600 )



ggplot(test_sum, aes(x = MP, y = VP)) + geom_point(aes(fill = H))

ggplot(test_sum, aes(x = MP, y = VP)) + geom_point(aes(col = H)) + ylim(c(VP_1q, VP_3q)) + xlim(c(MP_1q, MP_3q))+ scale_colour_gradientn(colors = terrain.colors(100))


ggplot(test_sum, aes(x = MP, y = VP)) + geom_point(aes(col = Tot_Rank)) + ylim(c(VP_1q, VP_3q)) + xlim(c(MP_1q, MP_3q)) + scale_colour_gradientn(colors = heat.colors(5))
#heat.colors is a palette from grDevices


ggplot(test_sum, aes(x = SAT_Rank, y = H_Rank)) + geom_point(size = 0.02)

ggplot(test_sum, aes(x = SAT_Rank, y = H_Rank)) + geom_point(size = 0.02, aes(col = MP)) + scale_color_gradient(low = "green", high = "red")

myPalette <- colorRampPalette(rev(brewer.pal(11, "Spectral")))
sc <- scale_colour_gradientn(colours = myPalette(100), limits=c(0, 0.001))


ggplot(test_sum, aes(x = SAT_Rank, y = H_Rank)) + geom_point(size = 0.02, aes(col = MP)) + sc

wordcloud(test_sum$words, test_sum$Tot_freq, max.words = 150, random.order = F)

wordcloud(test_sum$words, test_sum$Tot_freq, max.words = 350, random.order = F, scale = c(4, 0.1))
