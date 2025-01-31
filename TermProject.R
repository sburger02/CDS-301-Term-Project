#####################################
## Name: Suzanne N. Burger
## Assignment: Term Project
#####################################

# The data I am using is a dataset of workers and their gender, job title, age, 
# education level, seniority, base pay, bonus. In this project I will be analyzing 
# if the gender pay gap exists based on differnt factors.
# The question I am trying to answer is does education level and age affect the gender pay gap.
# I found the dataset on https://www.kaggle.com/datasets/nilimajauhari/glassdoor-analyze-gender-pay-gap
# Citation:
# Jauhari, N. (2020). Glassdoor- Analyze Gender Pay Gap [Dataset]. https://www.kaggle.com/datasets/nilimajauhari/glassdoor-analyze-gender-pay-gap


#loading the ggplot2 and plotly libraries 
library(ggplot2)
library(plotly)

#creating a variable to hold the information of the dataset I'm using
mydata <- read.csv("GenderPayGap.csv")

#changing the order of the levels for the Eduacation variable
#I did this in order to have the facets show up in order of how schooling works insetad of alphabetically
#The order of the levels is "High School", then "College", then "Masters", and finally "PhD".
mydata$Education <- factor(mydata$Education, levels = c("High School", "College", "Masters", "PhD"))


#Creating the plot variable
#I began by setting the x and y values and then grouping and coloring by Gender
#The paste function used for the text element in the aes function is used to create the hover feature
#The Job Title of a sample will appear when the mouse is hovered over a point
#I created a scatterplot
#The first geom_smooth creates a black outline for the colored regression lines
#The second geom_smooth creates the colored regression lines
#I created facets based on Education
#I created my own color scheme using scale_color_manual()
p <- ggplot(data = mydata, aes(x = Age, y = BasePay, color = Gender, group = Gender,
                               text = paste("Job Title: ", JobTitle))) +
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", size = 3, se = F, alpha = 2, linetype = "solid", formula = y ~ x, color = "black")+
  geom_smooth(method = "lm", size = 2, se = F, alpha = 2, linetype = "solid", formula = y ~ x) +
  facet_wrap(~Education) +
  labs(title = "The Gender Pay Gap", subtitle = "Based on Age and Grouped by Education", 
       x = "Age", y = "Base Salary") +
  scale_color_manual(values = c("hotpink1", "deepskyblue2")) +
  theme_bw()

#used to display the plot
ggplotly(p, tooltip = "text")
