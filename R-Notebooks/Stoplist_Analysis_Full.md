
# Stoplist Analysis

## Setup


```r
library(dplyr)
library(ggplot2)
library(RColorBrewer)
coul = brewer.pal(4, "BuPu")
coul = colorRampPalette(coul)
```


## Test case



```r
#N <- 3
#test <- data.frame(words = c("a", "b", "c", "a", "b", "b", "d"),
#                   freq = c(5, 3, 4, 2, 3, 8, 2), 
#                   doc = c(rep("i", 3), rep("ii", 2), rep("iii", 2)))


#test <- data.frame(words = c("a", "b", "c", "e", "a", "b", "b", "d"),
#                   freq = c(3, 5, 4, 1, 2, 3, 8, 2), 
#                   doc = c(rep("i", 4), rep("ii", 2), rep("iii", 2)))
```


## Data Preprocessing




```r
T <- readLines(con <- file("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/ogt_utf.txt", encoding = "UTF-8"))
#T <- readLines(con <- file("ogt_utf.txt", encoding = "UTF-8"))

N <- 10
Tp <- divideCharVector(T, N)
```

```
##  [1] 37047 45101 42835 43772 43144 47679 44919 43315 44702 39191
```

```r
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

test <- counts_df
```




## Calculations



```r
#Calculate Doc_size (sum freq within a doc)
test <- test %>% group_by(doc) %>% mutate(Doc_size = sum(freq))

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


test_sum <- test %>% select(words, MP, VP, SAT, H)

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
```

A note on ordering:

- decreasing entropy (stopwords have highest entropy)
- decreasing SAT_Rank (stopwords have high MP and low VP)
NOTE: in case of the same SAT values, MP is taken into account





## Visualisation



```r
MP_1q <- summary(test_sum$MP)[2]
MP_3q <- summary(test_sum$MP)[5]
VP_1q <- summary(test_sum$VP)[2]
VP_3q <- summary(test_sum$VP)[5]

ggplot(test_sum, aes(x = MP, y = VP)) + geom_point(aes(fill = H))
```

```
## Warning: Removed 567 rows containing missing values (geom_point).
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-1.png)

```r
ggplot(test_sum, aes(x = MP, y = VP)) + geom_point(aes(col = H)) + ylim(c(VP_1q, VP_3q)) + xlim(c(MP_1q, MP_3q))+ scale_colour_gradientn(colors = terrain.colors(100))
```

```
## Warning: Removed 2279 rows containing missing values (geom_point).
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-2.png)

```r
ggplot(test_sum, aes(x = MP, y = VP)) + geom_point(aes(col = Tot_Rank)) + ylim(c(VP_1q, VP_3q)) + xlim(c(MP_1q, MP_3q)) + scale_colour_gradientn(colors = heat.colors(5))
```

```
## Warning: Removed 2279 rows containing missing values (geom_point).
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-3.png)

```r
#heat.colors is a palette from grDevices


ggplot(test_sum, aes(x = SAT_Rank, y = H_Rank)) + geom_point(size = 0.02)
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-4.png)

```r
ggplot(test_sum, aes(x = SAT_Rank, y = H_Rank)) + geom_point(size = 0.02, aes(col = MP)) + scale_color_gradient(low = "green", high = "red")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-5.png)

```r
myPalette <- colorRampPalette(rev(brewer.pal(11, "Spectral")))
sc <- scale_colour_gradientn(colours = myPalette(100), limits=c(0, 0.001))


ggplot(test_sum, aes(x = SAT_Rank, y = H_Rank)) + geom_point(size = 0.02, aes(col = MP)) + sc
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-6.png)

