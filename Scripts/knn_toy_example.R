
counts_df <- readRDS("C:/Users/Ania/Documents/Medycyna/Clinical School/Word count/Data_files/counts_df_knn.Rda")
temp <- counts_df %>% filter(freq >65)
x <- "的一了他她是个不这"
x <- unlist(strsplit(x, split = ""))
temp <- (temp[weliminate(x, temp$words),])

temp2 <- as.data.frame(with(temp, model.matrix(~words + 0)))
colnames(temp2) <- gsub("words", "", colnames(temp2))
temp <- cbind(temp[, c("doc")], temp2)

colnames(temp)[1] <- "doc"

temp <- as.data.frame(temp)

tempu <- temp[, !colnames(temp) %in% "doc"]
templ <- temp[, "doc"]

set.seed(0)
train.idx <- sample(nrow(temp), ceiling(nrow(temp)*0.7))
test.idx <- (1:nrow(temp))[-train.idx]
knn.pred <- knn(tempu[train.idx, ], tempu[test.idx, ], templ[train.idx])

conf.mat <- table("predictions"= knn.pred, Actual = templ[test.idx])