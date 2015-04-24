# Analysis of the ToothGrowth dataset in R

## Basic summary of the data
First, let's understand what the dataset contains by using R's very useful help function `?ToothGrowth`. The help file tells us that the dataset contains data on the length of odontoblasts (teeth) in each of 10 guinea pigs at each of three dose levels of Vitamin C (0.5, 1, and 2 mg) with each of two delivery methods (orange juice or ascorbic acid). The dataset contains 60 observations on 3 variables.

Variable name   | Data Type     | Definition
:-------------- | :-------------| :-------------
len             | numeric       | (0 = No; 1 = Yes)  
supp            | factor        | Supplement type (VC or OJ).
dose            | numeric       | Dose in milligrams

Now let's get a summary of the data using R's `summary` function.
```
> summary(ToothGrowth)
      len        supp         dose      
 Min.   : 4.20   OJ:30   Min.   :0.500  
 1st Qu.:13.07   VC:30   1st Qu.:0.500  
 Median :19.25           Median :1.000  
 Mean   :18.81           Mean   :1.167  
 3rd Qu.:25.27           3rd Qu.:2.000  
 Max.   :33.90           Max.   :2.000  
 ```
Seems like that it would be interesting to explore whether there is a change in the length of the tooth of the guinea pig given different supplements and dosage - let's make a chart to look at this visually! We will use the R's amazing `ggplot2` library to help us with this.
```
library (ggplot2)
ggplot(data=ToothGrowth, aes(x=as.factor(dose), y=len, fill=supp)) +
    geom_bar(stat="identity",) +
    facet_grid(. ~ supp) +
    xlab("Dosage (in mg)") +
    ylab("Length of Tooth") +
    guides(fill=guide_legend(title="Supplement Type"))
```
![Histogram of means of 40 exponentials](https://github.com/dannychan0510/coursera-datascience-statistical-inference-project/blob/master/toothgrowthplot.png?raw=true)
As we can see, guinea pigs which were given 0.5mg and 1mg dosages of OJ supplement seems to experience more tooth growth than those guinea pigs which were given the same dosages of VC treatment. There does not seem to be a noticeable difference (at least visually) between the tooth growth between guinea pigs who were given 2mg dosages of OJ vs. guinea pigs who were given 2mg dosages of VC. 

Let's test for whether this really is the case using proper statistical inference.

## Statistical inference
### 1. Testing between supplement groups
Let us test first whether there is any statistical differences between the two supplement groups. To achieve this, we can conduct a non-paired t-test.
```
> # Conducting a t-test for difference between supplement groups, and putting it in a table for display
> t1 <- t.test(len ~ supp, paired = F, var.equal = F, data = ToothGrowth)
> t1.summary <- data.frame("p-value" = c(t1$p.value), "CI-Lower" = c(t1$conf[1]), "CI-Upper" = c(t1$conf[2]), row.names = c("OJ vs. VC:  "))
> round(t1.summary, 4)
             p.value CI.Lower CI.Upper
OJ vs. VC:    0.0606   -0.171    7.571
```
The null hypothesis of this test is that there is no difference between the length of tooth between guinea pigs on supplement OJ and the guinea pigs on the supplement VC. As the p-value is greater than 0.05, we fail to reject the null hypothesis at the 95% confidence interval, meaning that there is no evidence of a difference between the length of tooth between the two groups.

### 2. Testing between dosage groups
Let us test first whether there is any statistical differences between dosage groups. To achieve this, we can conduct a non-paired t-test between each of the dosage groups (0.5mg vs 1.0mg, 0.5mg vs 2.0mg, 1.0mg vs 2.0mg).
```
> # Conducting a t-test for difference between dosage groups, and putting it in a table for display
> df05 <- subset(ToothGrowth, ToothGrowth$dos == .5)
> df10 <- subset(ToothGrowth, ToothGrowth$dose == 1)
> df20 <- subset(ToothGrowth, ToothGrowth$dose == 2)
> 
> t0510<- t.test(df05$len, df10$len, paired=F, var.equal=F)
> t0520<- t.test(df05$len, df20$len, paired=F, var.equal=F)
> t1020<- t.test(df10$len, df20$len, paired=F, var.equal=F)
> 
> t2.summary <- data.frame("p-value"=c(t0510$p.value, t0520$p.value, t1020$p.value), "CI-Lower"=c(t0510$conf[1], t0520$conf[1], t1020$conf[1]), "CI-Upper" = c(t0510$conf[2], t0520$conf[2], t1020$conf[2]), row.names=c("Test 1: 0.5mg vs 1mg: ", "Test 2: 0.5mg vs 2mg: ","Test 3: 1mg vs 2mg: "))
> round(t2.summary, 6)
                       p.value   CI.Lower   CI.Upper
Test 1: 0.5mg vs 1mg:  0.0e+00 -11.983781  -6.276219
Test 2: 0.5mg vs 2mg:  0.0e+00 -18.156167 -12.833833
Test 3: 1mg vs 2mg:    1.9e-05  -8.996481  -3.733519
```
The null hypothesis of the first test is that there is no difference between the length of teeth between the guinea pigs that have been administered 0.5mg of supplements vs. guinea pigs that have been administered 1mg of supplements. Similar interpretations of the null hypothesis can be made for Tests 2 and 3 (with the dosage amount changing). As the p-values for all 3 tests are extremely small (in fact, smaller than 0.05 in all 3 cases), we can reject all 3 null hypotheses - i.e., teeth length between the guinea pigs vary by the dosage amounts of supplements administered to the guinea pigs.

### 3. Testing between supplement groups within a given dosage
Now let us test first whether there is any statistical differences between supplement groups *within* a given dosage groups. To achieve this, we can conduct a non-paired t-test between each of the supplement groups within the 0.5mg, 1.0mg and 2.0mg sample.
```
> # Conducting a t-test for difference between supplement groups within each dosage group, and putting it in a table for display
> t05 <- t.test(len ~ supp, paired = F, var.equal = F, data = df05)
> t10 <- t.test(len ~ supp, paired = F, var.equal = F, data = df10)
> t20 <- t.test(len ~ supp, paired = F, var.equal = F, data = df20)
> 
> t3.summary <- data.frame("p-value" = c(t05$p.value, t10$p.value, t20$p.value), "CI-Lower"=c(t05$conf[1], t10$conf[1], t20$conf[1]), "CI-Upper"=c(t05$conf[2], t10$conf[2], t20$conf[2]), row.names=c("Test 1: 0.5mg OJ vs. VC: ", "Test 2: 1mg OJ vs. VC: ","Test 3: 2mg OJ vs. VC: "))
> round(t3.summary, 6)
                           p.value  CI.Lower CI.Upper
Test 1: 0.5mg OJ vs. VC:  0.006359  1.719057 8.780943
Test 2: 1mg OJ vs. VC:    0.001038  2.802148 9.057852
Test 3: 2mg OJ vs. VC:    0.963852 -3.798070 3.638070
```
The null hypothesis of the first test is that there is no difference between the length of teeth between the guinea pigs that have been administered 0.5mg OJ vs 0.5mg VC.  Similar interpretations of the null hypothesis can be made for Tests 2 and 3 (with the dosage amount changing). As the p-values for the first two tests are extremely small ( fact, smaller than 0.05 in both cases), we can reject the first two null hypotheses - i.e., teeth length between the guinea pigs vary between supplement groups (within 0.5mg and 1.0mg samples). The p-value for the third test is very high, so we fail to reject the null hypothesis that teeth length between guinea pigs who have been administered 2mg of OJ is different from those who have been administered 2mg of VC at the 95% level.
