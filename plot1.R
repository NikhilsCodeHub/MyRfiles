

readData<- function ()
{
    

### Reading Filedata
## Loop 1 to 2,075,259
## Read Chunk 10,000
## Convert 1 column to Data/Time
## Discard rows which are not between 2/1/2007 to 2/2/2007
## rbind the rest to Dataframe
## Loop Back
## Exit as End


    totalRows<-2075259
    chunk2read <- 10000
    skipRows<-0
    dateFrom<-strptime("2007-02-01", format="%Y-%m-%d")
    dateTo<-strptime("2007-02-02", format="%Y-%m-%d")
    
    df<-0
    for (i in 0:totalRows)
    {
        data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", skip=skipRows, nrows=chunk2read, na.string=c("?"), colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric" ))
        skipRows<-skipRows+chunk2read
        data<-data[,1:3]
        data[1]<-paste(data[1], data[2])
        data[1]<-strptime(data[1], format="%d/%m/%Y %H:%M:%S")
        (data[1]>=dateFrom & data[1]<=dateTo)
        
        ##if (any(data[1]>=dateFrom & data[1]<=dateTo)==TRUE)
        ##  {
        ##    if (i==0){
        ##        df<-data[(data[1]>=dateFrom & data[1]<=dateTo),]
        ##    } else{
        ##        rbind(df,data[(data[1]>=dateFrom & data[1]<=dateTo),])
        ##    }
        ##}
        
        i<-i+chunk2read
        if (i>40000) {return("Exiting after 40000.")}
        
    }
}