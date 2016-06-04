# Steps of data preparation
1) Data loading:
origData <- read.csv2('.\\data\\raw_201501.csv', sep=',', header=TRUE)

2) Row count:
nrow(origData)

3) Data filtering:
airports <- c('ATL', 'LAX', 'ORD', 'DFW', 'JFK', 'SFO', 'CLT', 'LAS', 'PHX')
filteredData <- subset(origData, DEST %in% airports & ORIGIN %in% airports)

4) Retrieve the first 2 rows
head(filteredData, 2)

5) Retrieve the last 2 rows
tail(filteredData, 2)

6) Remove unnecessary columns which not used, no values, duplicates (eg: column X)
filteredData$X <- NULL

7) Remove redundant correlated columns (same information in a different format such as ID and value associated with ID) which add little infor and can cause algorithms to get confused
a) check correlation
cor(filteredData[c('ORIGIN_AIRPORT_ID', 'ORIGIN_AIRPORT_SEQ_ID')])
cor(filteredData[c('DEST_AIRPORT_ID', 'DEST_AIRPORT_SEQ_ID')])
b) drop columns
filteredData$ORIGIN_AIRPORT_SEQ_ID <- NULL
filteredData$DEST_AIRPORT_SEQ_ID <- NULL
c) check mismatched
mismatched <- filteredData[filteredData$CARRIER != filteredData$UNIQUE_CARRIER,]
nrow(mismatched)
d) drop UNIQUE_CARRIER
filteredData$UNIQUE_CARRIER <- NULL

8) Data fixing
a) Arr_Del15 and Dep_Del15 (Only retrieve rows that has value 0 or 1. May contain NA or "")
onTimeData <- filteredData[!is.na(filteredData$ARR_DEL15) & filteredData$ARR_DEL15!="" & !is.na(filteredData$DEP_DEL15) & filteredData$DEP_DEL15!="",]
b) Convert string to integer
onTimeData$DISTANCE <- as.integer(onTimeData$DISTANCE)
onTimeData$CANCELLED <- as.integer(onTimeData$CANCELLED)
onTimeData$DIVERTED <- as.integer(onTimeData$DIVERTED)
c) Convert string to factor (factor???)
onTimeData$ARR_DEL15 <- as.factor(onTimeData$ARR_DEL15)
onTimeData$DEP_DEL15 <- as.factor(onTimeData$DEP_DEL15)
onTimeData$ORIGIN_AIRPORT_ID <- as.factor(onTimeData$ORIGIN_AIRPORT_ID)
onTimeData$DEST_AIRPORT_ID <- as.factor(onTimeData$DEST_AIRPORT_ID)
onTimeData$DAY_OF_WEEK <- as.factor(onTimeData$DAY_OF_WEEK)
onTimeData$ORIGIN <- as.factor(onTimeData$ORIGIN)
onTimeData$DEST <- as.factor(onTimeData$DEST)
onTimeData$DEP_TIME_BLK <- as.factor(onTimeData$DEP_TIME_BLK)
onTimeData$CARRIER <- as.factor(onTimeData$CARRIER)

9) Find out distribution of the data (How many % of delayed flights)
tapply(onTimeData$ARR_DEL15, onTimeData$ARR_DEL15, length) 
Result: 20%
    0.00  1.00 
   NA 25664  6460 
6460/(6460 + 25664) = 0.2010958



