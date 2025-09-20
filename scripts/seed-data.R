library(tidyverse)
library(readxl)
library(janitor)

raw_arunachal <- read_excel('raw_data/SDGPreferences_Arunachal.xlsx') |>
  # clean up names
  clean_names()

write_csv(raw_arunachal, 'dbt_project/seeds/seed_arunachal.csv')

raw_tehri <- read_delim('raw_data/Dam_and_You_-_all_versions_-_labels_-_2023-06-21-12-49-55.csv') |>
  clean_names()

write_csv(raw_tehri, 'dbt_project/seeds/seed_tehri.csv')

# classifying columns by questions
# this is a horrible data structure

get_excel_col <- function(col_number) {
  excel_col <- ""
  while (col_number > 0) {
    remainder <- (col_number - 1) %% 26
    excel_col <- paste0(LETTERS[remainder + 1], excel_col)
    col_number <- (col_number - 1) %/% 26
  }
  return(excel_col)
}


tehri_cols <- tibble(
  # SQL column name
  clean_column_name = colnames(raw_tehri),
  # Human readable column name
  raw_column_name = colnames(read_delim('raw_data/Dam_and_You_-_all_versions_-_labels_-_2023-06-21-12-49-55.csv'))
) |>
  mutate(
    # column number
    col_number = row_number(),
    # excel column number
    excel_col = map_chr(col_number, get_excel_col),
    # classify columns by questions
    question = case_when(
      col_number %in% c(1,2) ~ 'response_timerange',
      col_number %in% seq(3, 11) ~ 'respondent_group',
      col_number %in% c(12,13) ~ 'affect',
      col_number == 14 ~ 'purpose',
      col_number == 15 ~ 'consent',
      col_number == 16 ~ 'river_importance',
      col_number %in% seq(17,27) ~ 'river_use',
      col_number == 28 ~ 'forest_importance', 
      col_number %in% seq(29,39) ~ 'forest_use',
      col_number == 40 ~ 'received_compensation',
      col_number == 41 ~ 'compensation_happy_decision',
      col_number == 42 ~ 'compensation_method',
      col_number == 43 ~ 'compensation_happy_amount',
      col_number == 44 ~ 'compensation_happy_timing',
      col_number == 45 ~ 'electricity_access',
      col_number %in% seq(46, 50) ~ 'dam_services',
      col_number == 51 ~ 'dam_benefits_feelings',
      col_number == 52 ~'land_impacted',
      col_number == 53 ~ 'construction_notification',
      col_number == 54  ~ 'decision_participation_opportunity',
      col_number %in% c(55, 56) ~ 'decision_participation_method',
      col_number == 57 ~ 'decisionmakers_listened',
      col_number == 58 ~ 'environment_change',
      col_number == 59 ~ 'wildlife_change',
      col_number == 60 ~ 'dam_society_balance',
      col_number %in% seq(61, 66) ~ 'theme_importance',
      col_number %in% seq(67, 70) ~ 'theme_importance_2',
      col_number == 71 ~ 'age',
      col_number == 72 ~'gender',
      col_number == 73 ~ 'highest_education',      
      col_number %in% c(74,75) ~ 'current_occupation',
      col_number %in% seq(76, 82) ~ 'current_occupation_attributes',
      col_number %in% c(83, 84) ~ 'predam_occupation',
      col_number %in% seq(85, 91) ~ 'predam_occupation_attributes',
      col_number == 92 ~ 'months_salary',
      col_number == 93 ~ 'household_n_people',
      col_number == 94 ~ 'household_n_salaried',
      col_number %in%  seq(95, 115) ~ 'household_assets',
      col_number == 116 ~ 'country_residence',
      col_number == 117 ~ 'highest_formal_education',
      col_number %in% seq(118, 127) ~ 'survey_meta',
      TRUE ~ NA
    )
  ) |>
  select(
    clean_column_name,
    excel_col,
    col_number,
    question,
    raw_column_name
  )

write_csv(tehri_cols, 'raw_data/tehri_cols.csv')

# used vsc extension to convert csv to md for lookup table