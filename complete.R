##--Assignment 1

##-- Part 2
complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    
    ##
    ## Begin Program
    ##
    ## Loop For Given List of IDs
    ##      Retrive data from each file for corresponding ID
    ##      Run Complete.cases for each datafile
    ##      Append the result to data.frame
    ## Output data.frame
    
    
    ### Initialize
    fileName<-""
    filedata<-""
    bigdata<-""
    
    ### Loop For Given List of IDs
    
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
        
        ### RBind Data for each ID to form one big matrix
        if (length(bigdata)==1){
            bigdata<-data.frame(id=i,nobs=length(filedata[complete.cases(filedata),1]))
        }
        else {
            bigdata<-rbind(bigdata, data.frame(id=i,nobs=length(filedata[complete.cases(filedata),1])))
        }
    }
    
    return(bigdata)
    
}
