> setwd("~/Documents/GitHub/coursera-datascience-statistical-inference-project")

lamda <- 0.2

set.seed(100)
mns = NULL
for (i in 1 : 1000) mns = c(mns, mean(rexp(40, lamda)))

mean(mns)
hist(mns)


var(mns)
