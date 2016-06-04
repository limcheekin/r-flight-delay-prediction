origData <- read.csv2('.\\data\\raw_201501.csv', sep=",", header=TRUE)
nrow(origData)
airports <- c('ATL', 'LAX', 'ORD', 'DFW', 'JFK', 'SFO', 'CLT', 'LAS', 'PHX')
filteredData <- subset(origData, DEST %in% airports & ORIGIN %in% airports)
nrow(filteredData)
head(filteredData, 2)
tail(filteredData, 2)
filteredData$X <- NULL
tail(filteredData, 2)
head(filteredData, 2)
cor(filteredData[c('ORIGIN_AIRPORT_ID', 'ORIGIN_AIRPORT_SEQ_ID')])
cor(filteredData[c('DEST_AIRPORT_ID', 'DEST_AIRPORT_SEQ_ID')])
filteredData$ORIGIN_AIRPORT_SEQ_ID <- NULL
filteredData$DEST_AIRPORT_SEQ_ID <- NULL
head(filteredData, 2)
mismatched <- filteredData[filteredData$CARRIER != filteredData$UNIQUE_CARRIER,]
filteredData$UNIQUE_CARRIER <- NULL
head(filteredData, 2)
onTimeData <- filteredData[!is.na(filteredData$ARR_DEL15) & filteredData$ARR_DEL15!="" & !is.na(filteredData$DEP_DEL15) & filteredData$DEP_DEL15!="",]
onTimeData$DISTANCE <- as.integer(onTimeData$DISTANCE)
onTimeData$CANCELLED <- as.integer(onTimeData$CANCELLED)
onTimeData$DIVERTED <- as.integer(onTimeData$DIVERTED)
onTimeData$ARR_DEL15 <- as.factor(onTimeData$ARR_DEL15)
onTimeData$DEP_DEL15 <- as.factor(onTimeData$DEP_DEL15)
onTimeData$ORIGIN_AIRPORT_ID <- as.factor(onTimeData$ORIGIN_AIRPORT_ID)
onTimeData$DEST_AIRPORT_ID <- as.factor(onTimeData$DEST_AIRPORT_ID)
onTimeData$DAY_OF_WEEK <- as.factor(onTimeData$DAY_OF_WEEK)
onTimeData$ORIGIN <- as.factor(onTimeData$ORIGIN)
onTimeData$DEST <- as.factor(onTimeData$DEST)
onTimeData$DEP_TIME_BLK <- as.factor(onTimeData$DEP_TIME_BLK)
onTimeData$CARRIER <- as.factor(onTimeData$CARRIER)
tapply(onTimeData$ARR_DEL15, onTimeData$ARR_DEL15, length)
6460/(6460 + 25664)
