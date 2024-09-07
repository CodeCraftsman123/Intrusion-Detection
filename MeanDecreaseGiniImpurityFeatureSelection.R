library(randomForest)
library(caret)

df <- read.csv("15kpointsofeachclassfinal.csv")

v <- c("http_2784","aol","harvest","http_8001","tftp_u","pm_dump","red_i","tim_i","urh_i","shell","printer","X11","pop_2","remote_job","rje","ntp_u","IRC")

df <- df[!df$service %in% v, ]

#Pre-processing
df$protocol_type <- as.factor(df$protocol_type)
df$service <- as.factor(df$service)
df$flag <- as.factor(df$flag)
df$class <- as.factor(df$class)
 
set.seed(123)
#Shuffling the dataset before partitioning
df <- df[sample(nrow(df)), ]

trainIndex <- createDataPartition(df$class, p=0.75, list = FALSE)

dfTrain <- df[trainIndex,]
dfTest <- df[-trainIndex,]

actualAnswers <- dfTest$class
dfTest <- subset(dfTest, select = -class)

rfTrain <- randomForest(class ~. , data = dfTrain)

importanceValues <- importance(rfTrain)

decreasingimportanceValuesMatrix  <- importanceValues[order(importanceValues, decreasing = TRUE),]

decreasingimportaceValuesDf <- as.data.frame(decreasingimportanceValuesMatrix)

colnames(decreasingimportaceValuesDf) <- "MeanDecreaseGini"

print(decreasingimportaceValuesDf)

df <- read.csv("15kpointsofeachclassfinal.csv")#The reason why we are reading this file again because there is 53+ category problem and we are removing those categories from df and hence need to read it again

#Pre-processing
df$protocol_type <- as.factor(df$protocol_type)
df$service <- as.factor(df$service)
df$flag <- as.factor(df$flag)
df$class <- as.factor(df$class)
#top 10 features 
v1 <- rownames(decreasingimportaceValuesDf)[1:10]
v1 <- c(v1,"class")
df1 <- df[,v1]

#top 15 features
v2 <- rownames(decreasingimportaceValuesDf)[1:15]
v2 <- c(v2,"class")
df2 <- df[,v2]

v3 <- rownames(decreasingimportaceValuesDf)[1:20]
v3 <- c(v3,"class")
df3 <- df[,v3]

v4 <- rownames(decreasingimportaceValuesDf)[1:25]
v4 <- c(v4,"class")
df4 <- df[,v4]

v5 <- rownames(decreasingimportaceValuesDf)[1:30]
v5 <- c(v5,"class")
df5 <- df[,v5]

v6 <- rownames(decreasingimportaceValuesDf)[1:35]
v6 <- c(v6,"class")
df6 <- df[,v6]
