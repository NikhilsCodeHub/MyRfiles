
library(randomForest)
library(caret)
library(dplyr)



dtrain <- read.csv("train.csv", stringsAsFactors = TRUE, na.strings = c(" ", "NaN", "NA", "Inf"))
dim(dtrain)
## 260753    299

## Identify columns having NA values
na.cols <- sapply(dtrain[,1:dim(dtrain)[2]],anyNA)

na.cols <- data.frame(AnyNA = na.cols)

## Identify each column as factor or continuous variable

  ## If Factor then identify if NA values should be factor 0
  ##  OR be imputed based on other factors.
  ##
  ## If columns have more than 50 factors then
  ##  identify ways to split the data and create new columns and refactor.
  ##    Eg : XG, XA, YB, YD   split values to :>  X | G, X | A, Y | B  so on..
  ##
  ## unfactor any columns with nlevels > 15


##  Methods to approach this running models
##
##  1. Groupd Similar columns together and run PCH.
##    a. Run RandomForest on the combo
##    b. Run GLM on the compbo
##  2. Run GLM on the entire Dataset
##  3. Run RandomForest on the entire Dataset
##

table(dtrain$GeographicField63, useNA = "ifany")




ntrain <- tbl_df(dtrain)
ntrain <- select(ntrain, -PersonalField84, -PropertyField29, -Original_Quote_Date, -PersonalField7, -GeographicField63)

## unfactor those columns as they have more than 50 factors
ntrain$PersonalField16 <- as.character(ntrain$PersonalField16)
ntrain$PersonalField17 <- as.character(ntrain$PersonalField17)
ntrain$PersonalField18 <- as.character(ntrain$PersonalField18)
ntrain$PersonalField19 <- as.character(ntrain$PersonalField19)
ntrain$PropertyField7 <- as.character(ntrain$PropertyField7)
ntrain$QuoteConversion_Flag <- factor(ntrain$QuoteConversion_Flag)

# ntrain$GeographicField63 <- as.character(ntrain$GeographicField63)
# ntrain$GeographicField63[is.na(ntrain$GeographicField63)] <- ""
# ntrain$GeographicField63 <- factor(ntrain$GeographicField63)


## Starting with RandomForest
set.seed(2016)

glm_fit <- glm(QuoteConversion_Flag~., data=ntrain, family=binomial("logit"))





## Load Test Data

dtest <- read.csv("test.csv", stringsAsFactors = FALSE)


## Clean Test Data

dtest <- select(dtest, -PersonalField84, -PropertyField29, -Original_Quote_Date, -PersonalField7, -GeographicField63)

dtest$PersonalField16 <- as.character(dtest$PersonalField16)
dtest$PersonalField17 <- as.character(dtest$PersonalField17)
dtest$PersonalField18 <- as.character(dtest$PersonalField18)
dtest$PersonalField19 <- as.character(dtest$PersonalField19)
dtest$PropertyField7 <- as.character(dtest$PropertyField7)
dtest$QuoteConversion_Flag <- factor(dtest$QuoteConversion_Flag)


## Predct Test Data

set.seed(2016)
pred_rf <- predict(glm_fit, dtest)


# Create a data frame with two columns: PassengerId & Survived. Survived contains your predictions
my_solution <- data.frame(QuoteNumber = dtest$QuoteNumber, QuoteConversion_Flag = pred_rf)

# Write your solution away to a csv file with the name my_solution.csv
write.csv(my_solution, file=paste0("Titanic_Submission_", format(Sys.time(), "%m%d%Y%H%M"),".csv") , row.names=FALSE)




