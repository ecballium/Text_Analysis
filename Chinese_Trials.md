



```r
Sys.setlocale(locale = "Chinese") #Choose Chinese
#print("的一了是�<U+393C><U+3E36>")
#print.listof("的一了是�<U+393C><U+3E36>")
x <- as.character("的一了是�<U+393C><U+3E36>", encoding = "UTF-8")
print(x)
```

```
## Error: invalid multibyte character in parser at line 4
```

