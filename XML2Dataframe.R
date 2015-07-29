## Converting XML into Dataframe


cddata <- xmlParse("C:\\Users\\l9535\\Documents\\TechLab\\RProject\\cd_catalog.xml")

col1<-cddata["//CD[YEAR>1988]/TITLE"]
col2<-cddata["//CD[YEAR>1988]/ARTIST"]
col3<-cddata["//CD[YEAR>1988]/COUNTRY"]

dt<-data.frame(Title=sapply(col1, xmlValue),Artist=sapply(col2, xmlValue), Country=sapply(col3, xmlValue))


