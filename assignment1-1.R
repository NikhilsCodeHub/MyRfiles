##--Assignment 1

##-- Part 1
pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    
    ##
    ## Begin Program
    ##
    ## Loop For Given List of IDs
    ##      Retrive data from each file for corresponding ID
    ##      RBind Data for each ID to form one big matrix
    ## remove NA for given column
    ## Calculate Mean for given column
    
    
    ### Initialize
    fileName<-""
    filedata<-""
    bigdata<-""
    pollutantId<-0
    
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
            bigdata<-filedata
        }
        else {
            bigdata<-rbind(bigdata, filedata)
        }
                
    }
    #print("Big Data")
    #print(dim(bigdata))
    
    if (pollutant=="sulfate"){
        pollutantId=2   ## --- Corresponds to Suphate column in the dataset
    }
    if (pollutant=="nitrate"){
        pollutantId=3   ## --- Corresponds to Nitrate column in the dataset
    }
    if(pollutantId==0){
        print("Given Pollutant not found.")
        return(0)
    }
    ### remove NA for given column
    #print(length(bigdata[!is.na(bigdata[pollutantId]),pollutantId]))
    
    ### Calculate Mean for given column
    mean(bigdata[!is.na(bigdata[pollutantId]),pollutantId])
}

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
    
    print(bigdata)
    
}