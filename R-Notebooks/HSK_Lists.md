
# HSK Lists

## Info

A short script, which imports HSK1-6 lists and transforms them into lists of individual characters.

NOTE: characters that reappear in higher levels are discarded - a given character is listed under the lowest HSK to which it belongs.


## Import word lists



```r
HSK1_words <- readLines(con <- file("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Data_Files/HSK_Word_Lists/HSK1.txt", encoding = "UTF-8"))
```

```
## Warning in readLines(con <- file("C:/Users/Ania/Documents/Medycyna/Clinical
## School/Word count/Data_Files/HSK_Word_Lists/HSK1.txt", : incomplete final
## line found on 'C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/
## Data_Files/HSK_Word_Lists/HSK1.txt'
```

```r
HSK2_words <- readLines(con <- file("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Data_Files/HSK_Word_Lists/HSK2.txt", encoding = "UTF-8"))
```

```
## Warning in readLines(con <- file("C:/Users/Ania/Documents/Medycyna/Clinical
## School/Word count/Data_Files/HSK_Word_Lists/HSK2.txt", : incomplete final
## line found on 'C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/
## Data_Files/HSK_Word_Lists/HSK2.txt'
```

```r
HSK3_words <- readLines(con <- file("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Data_Files/HSK_Word_Lists/HSK3.txt", encoding = "UTF-8"))
HSK4_words <- readLines(con <- file("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Data_Files/HSK_Word_Lists/HSK4.txt", encoding = "UTF-8"))
HSK5_words <- readLines(con <- file("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Data_Files/HSK_Word_Lists/HSK5.txt", encoding = "UTF-8"))
HSK6_words <- readLines(con <- file("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Data_Files/HSK_Word_Lists/HSK6.txt", encoding = "UTF-8"))
```

```
## Warning in readLines(con <- file("C:/Users/Ania/Documents/Medycyna/Clinical
## School/Word count/Data_Files/HSK_Word_Lists/HSK6.txt", : incomplete final
## line found on 'C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/
## Data_Files/HSK_Word_Lists/HSK6.txt'
```

## Create character lists

### HSK1


```r
HSK1_characters <- unique(unlist(strsplit(HSK1_words, split = "")))
length(HSK1_characters)
```

```
## [1] 175
```

### HSK2



```r
HSK2_characters <- unique(unlist(strsplit(HSK2_words, split = "")))
length(HSK2_characters)
```

```
## [1] 209
```

```r
HSK2_characters <- HSK2_characters[!(HSK2_characters%in%HSK1_characters)]
length(HSK2_characters)
```

```
## [1] 173
```


### HSK3



```r
HSK3_characters <- unique(unlist(strsplit(HSK3_words, split = "")))
length(HSK3_characters)
```

```
## [1] 400
```

```r
HSK3_characters <- HSK3_characters[!(HSK3_characters%in%HSK2_characters)]
length(HSK3_characters)
```

```
## [1] 346
```

```r
HSK3_characters <- HSK3_characters[!(HSK3_characters%in%HSK1_characters)]
length(HSK3_characters)
```

```
## [1] 270
```


### HSK4



```r
HSK4_characters <- unique(unlist(strsplit(HSK4_words, split = "")))
length(HSK4_characters)
```

```
## [1] 717
```

```r
HSK4_characters <- HSK4_characters[!(HSK4_characters%in%HSK3_characters)]
length(HSK4_characters)
```

```
## [1] 618
```

```r
HSK4_characters <- HSK4_characters[!(HSK4_characters%in%HSK2_characters)]
length(HSK4_characters)
```

```
## [1] 540
```

```r
HSK4_characters <- HSK4_characters[!(HSK4_characters%in%HSK1_characters)]
length(HSK4_characters)
```

```
## [1] 447
```


### HSK5



```r
HSK5_characters <- unique(unlist(strsplit(HSK5_words, split = "")))
length(HSK5_characters)
```

```
## [1] 1208
```

```r
HSK5_characters <- HSK5_characters[!(HSK5_characters%in%HSK4_characters)]
length(HSK5_characters)
```

```
## [1] 982
```

```r
HSK5_characters <- HSK5_characters[!(HSK5_characters%in%HSK3_characters)]
length(HSK5_characters)
```

```
## [1] 821
```

```r
HSK5_characters <- HSK5_characters[!(HSK5_characters%in%HSK2_characters)]
length(HSK5_characters)
```

```
## [1] 724
```

```r
HSK5_characters <- HSK5_characters[!(HSK5_characters%in%HSK1_characters)]
length(HSK5_characters)
```

```
## [1] 621
```


### HSK6



```r
HSK6_characters <- unique(unlist(strsplit(HSK6_words, split = "")))
length(HSK6_characters)
```

```
## [1] 2078
```

```r
HSK6_characters <- HSK6_characters[!(HSK6_characters%in%HSK5_characters)]
length(HSK6_characters)
```

```
## [1] 1722
```

```r
HSK6_characters <- HSK6_characters[!(HSK6_characters%in%HSK4_characters)]
length(HSK6_characters)
```

```
## [1] 1406
```

```r
HSK6_characters <- HSK6_characters[!(HSK6_characters%in%HSK3_characters)]
length(HSK6_characters)
```

```
## [1] 1216
```

```r
HSK6_characters <- HSK6_characters[!(HSK6_characters%in%HSK2_characters)]
length(HSK6_characters)
```

```
## [1] 1096
```

```r
HSK6_characters <- HSK6_characters[!(HSK6_characters%in%HSK1_characters)]
length(HSK6_characters)
```

```
## [1] 978
```


## Save results

Remove the first character


```r
HSK1_characters <- HSK1_characters[-1]
```




```r
saveRDS(HSK1_characters, "HSK1_characters.Rda")
saveRDS(HSK2_characters, "HSK2_characters.Rda")
saveRDS(HSK3_characters, "HSK3_characters.Rda")
saveRDS(HSK4_characters, "HSK4_characters.Rda")
saveRDS(HSK5_characters, "HSK5_characters.Rda")
saveRDS(HSK6_characters, "HSK6_characters.Rda")
```





