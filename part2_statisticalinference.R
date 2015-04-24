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

ggsave("toothgrowth.png")