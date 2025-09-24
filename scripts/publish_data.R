library(tidyverse)

source('scripts/get_dbdat.R')

# Extract all analytic tables from dbt project
respondents <- get_dbdat('ana_respondents')
responses <- get_dbdat('ana_top3')
sdg_labels <- get_dbdat('ana_sdg')
sdg7_analysis <- get_dbdat('ana_sdg7')

# Write all tables to data directory
write_csv(respondents, 'data/respondents.csv')
write_csv(responses, 'data/SDG_rankings.csv')
write_csv(sdg_labels, 'data/SDG_labels.csv')
write_csv(sdg7_analysis, 'data/SDG7_analysis.csv')
