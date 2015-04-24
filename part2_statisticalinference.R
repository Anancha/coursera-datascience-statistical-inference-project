# Setting the working directory
setwd("~/Documents/GitHub/coursera-datascience-statistical-inference-project")

# Loading up the Tooth Growth dataset
ToothGrowth <- ToothGrowth

# Getting information on the dataset
?ToothGrowth

# Getting a summary of the dataset
summary(ToothGrowth)

# Doing a chart plot of len by supp and dose
library (ggplot2)
ggplot(data = ToothGrowth, aes(x = as.factor(dose), y = len, fill = supp)) +
  geom_bar(stat = "identity",) +
  facet_grid(. ~ supp) +
  xlab("Dosage (in mg)") +
  ylab("Length of Tooth") +
  guides(fill = guide_legend(title = "Supplement Type"))

ggsave("toothgrowth.png"
       
# Conducting a t-test for difference between supplement groups, and putting it in a table for display
t1 <- t.test(len ~ supp, paired = F, var.equal = F, data = ToothGrowth)
t1.summary <- data.frame("p-value" = c(t1$p.value), "CI-Lower" = c(t1$conf[1]), "CI-Upper" = c(t1$conf[2]), row.names = c("OJ vs. VC:  "))
round(t1.summary, 4)

# Conducting a t-test for difference between dosage groups, and putting it in a table for display
df05 <- subset(ToothGrowth, ToothGrowth$dos == .5)
df10 <- subset(ToothGrowth, ToothGrowth$dose == 1)
df20 <- subset(ToothGrowth, ToothGrowth$dose == 2)

t0510<- t.test(df05$len, df10$len, paired=F, var.equal=F)
t0520<- t.test(df05$len, df20$len, paired=F, var.equal=F)
t1020<- t.test(df10$len, df20$len, paired=F, var.equal=F)

t2.summary <- data.frame("p-value"=c(t0510$p.value, t0520$p.value, t1020$p.value), "CI-Lower"=c(t0510$conf[1], t0520$conf[1], t1020$conf[1]), "CI-Upper" = c(t0510$conf[2], t0520$conf[2], t1020$conf[2]), row.names=c("Test 1: 0.5mg vs 1mg: ", "Test 2: 0.5mg vs 2mg: ","Test 3: 1mg vs 2mg: "))
round(t2.summary, 6)

# Conducting a t-test for difference between supplement groups within each dosage group, and putting it in a table for display
t05 <- t.test(len ~ supp, paired = F, var.equal = F, data = df05)
t10 <- t.test(len ~ supp, paired = F, var.equal = F, data = df10)
t20 <- t.test(len ~ supp, paired = F, var.equal = F, data = df20)

t3.summary <- data.frame("p-value" = c(t05$p.value, t10$p.value, t20$p.value), "CI-Lower"=c(t05$conf[1], t10$conf[1], t20$conf[1]), "CI-Upper"=c(t05$conf[2], t10$conf[2], t20$conf[2]), row.names=c("Test 1: 0.5mg OJ vs. VC: ", "Test 2: 1mg OJ vs. VC: ","Test 3: 2mg OJ vs. VC: "))
round(t3.summary, 6)