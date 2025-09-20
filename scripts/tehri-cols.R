library(tidyverse)

tehri_cols <- read_csv('analysis_data/tehri_cols.csv')


tehri_cols |>
  select(question) |>
  distinct() |>
  filter(str_detect(question, ''))
