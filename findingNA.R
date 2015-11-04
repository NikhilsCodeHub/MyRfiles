total.missing<- function(dataset){ sapply(dataset, function(df){sum(is.na(df));}); }
percent.missing<-function(dataset){ sapply(dataset, function(df){sum(is.na(df))/length(df);}); }
