df <- read.csv("KDDTrain.csv")
set.seed(123)
dfNormal <- df[df$class == 'normal',]
dfAnomaly <- df[df$class == 'anomaly',]


dfNormalSample <- dfNormal[sample(nrow(dfNormal), 15000, replace = FALSE), ]
dfAnomalySample <- dfAnomaly[sample(nrow(dfAnomaly), 15000, replace = FALSE), ]


df <- rbind(dfNormalSample, dfAnomalySample)
# View(df)
df <- df[sample(nrow(df)), ]
write.csv(df,"15kpointsofeachclassfinal.csv",row.names = FALSE)