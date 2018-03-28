
Tested approaches (none of these worked):
- setting locale (either within script or in .Rprofile)
- saving file with UTF-8 encoding

Failure occured with the following methods for output generation:
- knitr::spin()
- rmarkdown::render()


的一了是�<U+393C><U+3E36>


```r
Sys.setlocale(locale = "Chinese") #Choose Chinese
```

```
## [1] "LC_COLLATE=Chinese (Simplified)_People's Republic of China.936;LC_CTYPE=Chinese (Simplified)_People's Republic of China.936;LC_MONETARY=Chinese (Simplified)_People's Republic of China.936;LC_NUMERIC=C;LC_TIME=Chinese (Simplified)_People's Republic of China.936"
```

```r
#library(shiny)
#print("的一了是�<U+393C><U+3E36>")
#print.listof("的一了是�<U+393C><U+3E36>")
#x <- as.character("的一了是�<U+393C><U+3E36>", encoding = "UTF-8")
#print(x)


t <- readLines("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Data_Files/Sample_Text_Files/test_ch_utf.txt", encoding = "UTF-8")
```

```
## Warning in readLines("C:/Users/Ania/Documents/Medycyna/Clinical School/Word
## count/Data_Files/Sample_Text_Files/test_ch_utf.txt", : incomplete final
## line found on 'C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/
## Data_Files/Sample_Text_Files/test_ch_utf.txt'
```

```r
#print(t)
#t

#print.listof(t, locale = locale(encoding = "UTF-8"))
renderPrint(t)
```

<!--html_preserve--><pre id="outf8fc22af34bd1288" class="shiny-text-output noplaceholder"></pre><!--/html_preserve-->

