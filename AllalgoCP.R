source("MeanDecreaseGiniImpurityFeatureSelection.R")
library(caret)
library(kernlab)
allAlgorithm <- function(df){
dfTrain <- df[trainIndex,]
dfTest <- df[-trainIndex,]

actualAnswers <- dfTest$class
dfTest <- subset(dfTest, select = -class)

#Random Forest Algorithm here!

rfTrain <- train(
  class ~ .,
  data = dfTrain,
  method = "rf",
  trControl = trainControl(method = "cv", number = 10),
  tuneGrid = data.frame(mtry = 6),#tuneGrid = data.frame(mtry = c(25, 30, 35))
  ntree = 100
)
print(rfTrain)

predictedValues1 <- predict(rfTrain, newdata = dfTest)
predictedValues1 <- as.factor(predictedValues1)

confusionMatrix1 <- confusionMatrix(predictedValues1, actualAnswers)
print("\nConfusion Matrix of Random Forest on test dataset:\n")
print(confusionMatrix1)

accuracy1 <- confusionMatrix1$overall['Accuracy']
precision1 <- confusionMatrix1$byClass['Pos Pred Value']
recall1 <- confusionMatrix1$byClass['Sensitivity']
f1_score1 <- confusionMatrix1$byClass['F1']
specificity1 <- confusionMatrix1$byClass['Specificity']
cat("\nAccuracy:", accuracy1)
cat("\nPrecision:", precision1)
cat("\nRecall:", recall1)
cat("\n Score:", f1_score1)
cat("\nSpecificity:", specificity1)
print("\n\n\n\n\n")
#SVM with Radial Kernel here!

svmTrain <- train(
  class ~ .,
  data = dfTrain,
  method = "svmRadial",
  trControl = trainControl(method = "cv", number = 10)
)
print(svmTrain)

predictedValues2 <- predict(svmTrain, newdata = dfTest)
predictedValues2 <- as.factor(predictedValues2)

confusionMatrix2 <- confusionMatrix(predictedValues2, actualAnswers)
print("\nConfusion Matrix of SVM with radial Kernel on test dataset:\n")
print(confusionMatrix2)

accuracy2 <- confusionMatrix2$overall['Accuracy']
precision2 <- confusionMatrix2$byClass['Pos Pred Value']
recall2 <- confusionMatrix2$byClass['Sensitivity']
f1_score2 <- confusionMatrix2$byClass['F1']
specificity2 <- confusionMatrix2$byClass['Specificity']
cat("\nAccuracy:", accuracy2)
cat("\nPrecision:", precision2)
cat("\nRecall:", recall2)
cat("\n Score:", f1_score2)
cat("\nSpecificity:", specificity2)
print("\n\n\n\n\n")

#XGboost goes here
train_control <- trainControl(
  method = 'cv', # cross-validation
  number = 10, # number of folds (k = 10)
  returnData = FALSE,
)

xgb_grid <- expand.grid(
  nrounds = 100, # number of estimators
  max_depth = 10, # maximum depth of each tree
  eta = 0.1, # learning rate
  gamma = 0, # minimum loss reduction required to make a further partition on a leaf node of the tree
  colsample_bytree = 0.9, # subsample ratio of columns when constructing each tree
  min_child_weight = 1, # minimum sum of instance weight needed in a child
  subsample = 1 # subsample ratio of the training instance
)

xgboostTrain <- train(
  class ~ . ,
  data = dfTrain,
  method = "xgbTree",
  trControl = train_control,
  tuneGrid = xgb_grid,
  objective = "binary:logistic"
)
print(xgboostTrain)

predictedValues3 <- predict(xgboostTrain, newdata = dfTest)
predictedValues3 <- as.factor(predictedValues3)

confusionMatrix3 <- confusionMatrix(predictedValues3, actualAnswers)
print("\nConfusion Matrix of Xgboost on test dataset:\n")
print(confusionMatrix3)

accuracy3 <- confusionMatrix3$overall['Accuracy']
precision3 <- confusionMatrix3$byClass['Pos Pred Value']
recall3 <- confusionMatrix3$byClass['Sensitivity']
f1_score3 <- confusionMatrix3$byClass['F1']
specificity3 <- confusionMatrix3$byClass['Specificity']
cat("\nAccuracy:", accuracy3)
cat("\nPrecision:", precision3)
cat("\nRecall:", recall3)
cat("\n Score:", f1_score3)
cat("\nSpecificity:", specificity3)
}


df <- read.csv("15kpointsofeachclassfinal.csv")

#Pre-processing
df$protocol_type <- as.factor(df$protocol_type)
df$service <- as.factor(df$service)
df$flag <- as.factor(df$flag)
df$class <- as.factor(df$class)

set.seed(123)

trainIndex <- createDataPartition(df$class, p=0.75, list = FALSE)

allAlgorithm(df1)
