cname <- "C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Other/Using_tm/Trump_Speeches_UTF-8/"
files <- DirSource(directory = cname, encoding = "UTF-8")
docs <- VCorpus(files)

docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, tolower)
docs <- tm_map(docs, PlainTextDocument)

DocsCopy <- docs

docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, removeWords, c("syllogism", "tautology"))  


##This is important!!! Seems to suggest that elements of the corpus retain character-like properties

for (j in seq(docs))
{
  docs[[j]] <- gsub("fake news", "fake_news", docs[[j]])
  docs[[j]] <- gsub("inner city", "inner-city", docs[[j]])
  docs[[j]] <- gsub("politically correct", "politically_correct", docs[[j]])
}
docs <- tm_map(docs, PlainTextDocument)
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, PlainTextDocument)


dtm <- DocumentTermMatrix(docs)
tdm <- TermDocumentMatrix(docs)

#Obtaining frequency table
freq <- colSums(as.matrix(dtm))
ord <- order(freq)

freq <- sort(colSums(as.matrix(dtm)), decreasing=TRUE)  

wf <- data.frame(word=names(freq), freq=freq) #in df form



dtms <- removeSparseTerms(dtm, 0.2) # This makes a matrix that is 20% empty space, maximum.   


m <- as.matrix(dtm) #Many, many columns! Rows are documents


findFreqTerms(dtm, lowfreq=50) #Returns terms with frequency of 50 or more


findAssocs(dtm, c("country" , "american"), corlimit=0.85) # specifying a correlation limit of 0.85

inspect(dtm)
as.matrix(dtm)
as.matrix(tdm)

writeLines(as.character(docs[1]))
inspect(docs[1])
