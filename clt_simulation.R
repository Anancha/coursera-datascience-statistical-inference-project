> setwd("~/Documents/GitHub/coursera-datascience-statistical-inference-project")

# Setting the value of lambda
lambda <- 0.2

# Obtaining the distribution of the averages of 40 exponentials
set.seed(123)
mns = NULL
for (i in 1 : 1000) mns = c(mns, mean(rexp(40, lambda)))

# Plotting out a histogram of the distribution
library(ggplot2)
dB <- as.data.frame(mns)
ggplot(dB, aes(mns)) + geom_histogram(binwidth = 0.3, colour = "white", fill = "skyblue4") + labs(y = "Frequency", x = "Mean") + geom_vline(xintercept = 1 / lambda)

ggsave("histogram2.png")

# Exporting as "histogram1.png"
ggsave(file="histogram1.png")

# Obtaining the sample mean
mean(mns)

# Overlaying normal distribution on top of histogram
ggplot(dB, aes(mns)) + geom_histogram(aes(y = ..density..), binwidth = 0.3, colour = "white", fill = "skyblue4") + labs(y = "Density", x = "Mean") + geom_vline(xintercept = 1 / lambda) + stat_function(fun = dnorm, args = list(mean = 5, sd = (0.625)^0.5))

ggsave("histogram2.png")

# q-q plot
qqnorm(mns); qqline(mns)

