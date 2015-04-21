# A simulation of the exponential distribution in R to explore the characteristics of the Central Limit Theorem
## by Danny Chan
### Overview
In this exercise, I will invistigate the exponential distribution and compare it with the the Central Limit Theorem. In this exercise, I will investigate **the distribution of the averages of 40 exponentials**. In particular, I will show the following:

1. I will show the sample mean of the distribution (of the averages of 40 exponentials), and compare it to the theoretical mean of the distribution;
2. I will show how variable the sample (of the averages of 40 exponentials) is, and compare it to the theoretical vairance of the distribution; and
3. I will show that the distribution of the averages of 40 exponentials is approximately normal.

### Simulation
I used R to simualate 1000 times the average of the averages of 40 exponentials. The mean and variance of exponential distribution is 1/λ. For the purpose of this exercise, I have set λ = 0.2 for all 1000 simulations. I used the following R code to obtain the distribution of the averages of 40 exponentials.
```
# Setting the value of lambda
lambda <- 0.2

# Obtaining the distribution of the averages of 40 exponentials
set.seed(100)
mns = NULL
for (i in 1 : 1000) mns = c(mns, mean(rexp(40, lambda)))
```

### 1. Sample Mean vs. Theoretical Mean
The chart below shows the histogram of the averages of our 1000 simulated means of 40 exponentials. The black line indicates the theoretical mean of the distribution, which is 5 (remember, the theoretical mean of an exponential distribution is 1/λ, and λ = 0.2 currently).

![Histogram of means of 40 exponentials](https://github.com/dannychan0510/coursera-datascience-statistical-inference-project/blob/master/histogram1.png?raw=true)

