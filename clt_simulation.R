> setwd("~/Documents/GitHub/coursera-datascience-statistical-inference-project")

set.seed(23)
mns = NULL
for (i in 1 : 1000) mns = c(mns, mean(rexp(40, 1/0.2)))
hist(mns)


set.seed(23)
vrc = NULL
for (i in 1 : 1000) vrc = c(vrc, var(rexp(40, 1/0.2)))
hist(vrc, breaks = 50)
