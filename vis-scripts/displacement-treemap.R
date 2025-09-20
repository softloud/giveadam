library(tidyverse)
library(treemapify)

source('scripts/get_dbdat.R')

respondents <- get_dbdat('ana_respondents')

respondents |>
  group_by(displacement_status) |>
  summarise(
    n_respondents = n()
  ) |>
  mutate(
    affected = case_when(
      str_detect(displacement_status, '^Affected|Displaced') ~ 'Affected',
      displacement_status == 'Potential displacement' ~ 'Potentially affected',
      TRUE ~ 'Not affected'
    ),
    displacement_status = str_wrap(displacement_status, width = 20) 
  ) |>
  ggplot(aes(
    area = n_respondents,
    fill = displacement_status,
    subgroup = affected,
    label = displacement_status
  )) +
  geom_treemap(alpha = 0.8) +
  geom_treemap_text(size = 25) +
  theme_minimal() +
  theme(
    legend.position = 'none'
  )

ggsave('figures_and_tables/displacement-treemap.png', width = 8, height = 6)
