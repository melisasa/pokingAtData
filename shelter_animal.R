library(plotly)

Sys.setenv("plotly_username"="melisasa")
Sys.setenv("plotly_api_key"="eydqvjk35m")

dataset = read.csv ("train.csv", header=TRUE)
dog = subset(dataset, AnimalType == "Dog")
cat = subset(dataset, AnimalType == "Cat")

for (i in 1:nrow(dog)) {
  time = sub('.*\\ ', '', dog[i,"AgeuponOutcome"])
  num_str = sub("\\ .*", "", dog[i,"AgeuponOutcome"])
  num = strtoi(num_str, base = 0L)
  
  if (time == "year" || time == "years") 
    dog[i,"Age_weeks"] = num*52
  else (time == "month" || time == "months") 
  dog[i,"Age_weeks"] = num*4
  
  dog[i,"Outcome_combined"] = paste(dog[i,"OutcomeType"], dog[i,"OutcomeSubtype"], sep="_") 
}

age_outcome = plot_ly(dog, x=Age_weeks, color=OutcomeType, type="box")
age_outcome 

plotly_POST(age_outcome, filename = "r-docs/Age_and_outcome_for_shelter_dogs")


age_outcome_deets = plot_ly(dog, x=Age_weeks, color=Outcome_combined, type="box")
age_outcome_deets

plotly_POST(age_outcome, filename = "r-docs/Age_and_outcome_for_shelter_dogs")