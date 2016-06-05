# Predict Flight Delay using R
Use the Machine Learning Workflow to process and transform DOT data to create a prediction model. This model must predict whether a flight would arrive 15+ minutes after the scheduled arrival time with 70+% accuracy.

## Download data
Download 2015 January raw data in csv file from the following URL:
http://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236&DB_Short_Name=On-Time

The downloaded data stored in [raw_201501.csv](data/raw_201501.csv).

## Preparing data
Find out more from [Steps of Data Preparation](doc/data-preparation.md) and it's corresponding [source file](src/data-preparation.R).

## Selecting algorithm
The selected initial algorithm is Logistic Regression as it is simple(easy to understand), fast(up to 100x faster) and stable to data changes.

Next, switched to Random Forest to improve prediction result.

## Train model
 * Training the model using caret package
   ```R
   install.packages('caret')
   library(caret)
   ```
 * Set the seed so that the random number generated in the same sequence to yield the same training results
   ```R
   set.seed(12345)
   ```
 * Retrieve feature columns only
   ```R
   featureColumns <- c('ARR_DEL15', 'DAY_OF_WEEK', 'CARRIER', 'DEST', 'ORIGIN', 'DEP_TIME_BLK')
   onTimeDataFiltered <- onTimeData[,featureColumns]
   ```
 * Retrieve 70% of data for training
   ```R
   trainRows <- createDataPartition(onTimeDataFiltered$ARR_DEL15, p=0.7, list=FALSE)
   head(trainRows, 10)
   trainData <- onTimeDataFiltered[trainRows,]
   ```
 * Retrieve the remaining 30% of data for testing
   ```R
   testData <- onTimeDataFiltered[-trainRows,]
   ```
 * Simple verification
   ```R
   nrow(trainData)/(nrow(trainData) + nrow(testData))
   nrow(testData)/(nrow(trainData) + nrow(testData))
   ```
 * Train the model with train data
   ```R
   logisticRegModel <- train(ARR_DEL15 ~ ., data=trainData, method="glm", family="binomial")
   ```
   ```
   Error in train.default(x, y, weights = w, ...) : 
   One or more factor levels in the outcome has no data: ''
   ```   



