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
