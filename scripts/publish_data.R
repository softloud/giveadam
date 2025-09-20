library(tidyverse)

source('scripts/get_dbdat.R')

respondents <- get_dbdat('ana_respondents')
responses <- get_dbdat('ana_top3')

write_csv(respondents, 'data/respondents.csv')
write_csv(responses, 'data/SDG_rankings.csv')
