# Predict Flight Delay using R
Use the Machine Learning Workflow to process and transform DOT data to create a prediction model. This model must predict whether a flight would arrive 15+ minutes after the scheduled arrival time with 70+% accuracy.

## Download data
Download 2015 January raw data in csv file from the following URL:
http://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236&DB_Short_Name=On-Time

The downloaded data stored in [raw_201501.csv](data/raw_201501.csv)

## Preparing data
Find out more from [Steps of Data Preparation](doc/data-preparation.md) and it's corresponding [source file](src/data-preparation.R)

## Selecting Algorithm
The selected algorithm is Logistic Regression as it is simple(easy to understand), fast(up to 100x faster) and stable to data changes.

