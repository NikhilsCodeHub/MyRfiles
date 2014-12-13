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
    
    ### Loop For Given List of IDs
    
    
    
    fileName<-""
    filedata<-""
    bigdata<-""
    pollutantId<-0
    
    for(i in id){
        
        if (i<10){
            fileName<-(paste("00",toString(i),".csv", sep=""))
        }
        else {
            fileName<-(paste("0",toString(i),".csv", sep=""))
        }
        fileName<-paste("~/CloudStorage/GoogleDrive/Online Learning/Coursera/R Programming/week2/specdata/",fileName,sep="")
        print(paste("Getting data for: ", fileName))
        
        ### Retrive data from each file for corresponding ID
        filedata<-read.csv(fileName)
        print(dim(filedata))
        
        ### RBind Data for each ID to form one big matrix
        if (length(bigdata)==1){
            bigdata<-filedata
        }
        else {
            bigdata<-rbind(bigdata, filedata)
        }
                
    }
    print("Big Data")
    print(dim(bigdata))
    
    if (pollutant=="sulfate"){
        pollutantId=2   ## --- Corresponds to Suphate column in the dataset
    }
    if (pollutant=="nitrate"){
        pollutantId=3   ## --- Corresponds to Nitrate column in the dataset
    }
    if(poluutantId==0){
        ##Throw Error
    }
    ### remove NA for given column
    print(dim(file1[!is.na(file1[pollutantId]),pollutantId]))
    
    ### Calculate Mean for given column
    mean(file1[!is.na(file1[pollutantId]),pollutantId])
}