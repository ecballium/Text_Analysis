
T <- readLines(con <- file("ogt_utf.txt", encoding = "UTF-8"))

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




#STH WENT WRONG (remove the PV2 sections)
#- find out about ranges for variance
#- comment the code
#- maybe go back to the orginal small reproducible example?
#- check column naming
#- calculate the variance for some of the words manually
#- correct the bug
#- check the values for entropy etc.
#- eventually remove the punctuation marks, letters, numbers etc.


test <- data.frame(words = c("a", "b", "c", "a", "b", "b", "d"),
                   freq = c(5, 3, 4, 2, 3, 8, 2), 
                   doc = c(rep("i", 3), rep("ii", 2), rep("iii", 2)))



#test <- counts_df

#$words <- as.factor(test$words)

test <- test %>% group_by(doc) %>% mutate(Doc_size = sum(freq))


test <- test %>% group_by(words) %>% mutate(Prob_word_in_doc = freq/Doc_size) #%>% mutate(MP = sum(Prob_word_in_doc)/N) #This didn't work


test <- test %>% group_by(words) %>% mutate(MP = sum(Prob_word_in_doc)/N)


#Check this out
test$VP_int <- (test$Prob_word_in_doc - test$MP)^2 #interim calculation for word variance
test <- test %>% group_by(words) %>% mutate(VP = sum(VP_int)/N)

#And this
test$VP2 <- -(((test$Prob_word_in_doc)^2)/N - (test$MP)/N)
#test$VP <- test$VP * 100

#test$SAT <- test$MP / test$VP
test$SAT <- test$MP / test$VP2

test$H_int <- -(test$Prob_word_in_doc * log(test$Prob_word_in_doc, base = 2))

test <- test %>% group_by(words) %>% mutate(H = sum(H_int))

#test_sum <- test %>% select(words, MP, VP, SAT, H)
test_sum <- test %>% select(words, MP, VP2, SAT, H)

test_sum <- unique(test_sum)

if (dim(test_sum)[1]!=(length(unique(test_sum$words)))){
  stop("Something went wrong in the processing")
}

#test_sum$words <- as.character(test_sum$words)


test_sum <- as.data.frame(test_sum)
test_sum <- test_sum %>% mutate(SAT_Rank = dense_rank(desc(SAT)))
test_sum <- as.data.frame(test_sum)
test_sum <- test_sum %>% mutate(H_Rank = dense_rank(desc(H)))
test_sum$Total_Score <- test_sum$SAT_Rank + test_sum$H_Rank


#test_sum <- test_sum %>% arrange(desc(H)) %>% mutate(H_Rank = 1:w)
