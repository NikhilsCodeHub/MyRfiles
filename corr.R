corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    
    
    ##  Begin Program
    ##
    ##  Run complete function and store results in dataframe
    ##  Filter dataframe for values greater than threshold
    ##  Loop through each monitor that meets the threshold
    ##      calculate Correlation
    ##      store in a vector
    ##  Output result
    
    
    fileName<-""
    filedata<-""
    bigdata<-c()
    
    ##  Run complete function and store results in dataframe
    df<-complete("specdata")
    
    ##  Filter dataframe for values greater than threshold
    id<-df[df[,"nobs"]>threshold,1]
    ##print(id)
    
    ##  Loop through each monitor that meets the threshold
    for(i in id){
        if (i<10){
            fileName<-(paste("/00",toString(i),".csv", sep=""))
        }
        else if (i>9 & i<100){
            fileName<-(paste("/0",toString(i),".csv", sep=""))
        }
        else {
            fileName<-(paste("/",toString(i),".csv", sep=""))
        }
        fileName<-paste(directory,fileName,sep="") 
        #print(paste("Getting data for: ", fileName))
        
        ### Retrive data from each file for corresponding ID
        filedata<-read.csv(fileName)
        #print(dim(filedata))
        
        
        ##      calculate Correlation
        if (length(bigdata)==0){
            bigdata<-c(cor(filedata[complete.cases(filedata),2], filedata[complete.cases(filedata),3]))
        }
        else {
            bigdata<-c(bigdata, cor(filedata[complete.cases(filedata),2], filedata[complete.cases(filedata),3]))
        }
        
    }
    ##  Output result
    return(bigdata)
    
}
