> setwd("~/Documents/GitHub/coursera-datascience-statistical-inference-project")

# Setting the value of lambda
lambda <- 0.2

# Obtaining the distribution of the averages of 40 exponentials
set.seed(123)
mns = NULL
for (i in 1 : 1000) mns = c(mns, mean(rexp(40, lambda)))

# Plotting out a histogram of the distribution
library(ggplot2)
mns <- as.data.frame(mns)
ggplot(mns, aes(mns)) + geom_histogram(binwidth = 0.3, colour = "white", fill = "skyblue4") + labs(y = "Frequency", x = "Mean") + geom_vline(xintercept = 1 / lambda)

# Exporting as "histogram1.png"
ggsave(file="histogram1.png")
