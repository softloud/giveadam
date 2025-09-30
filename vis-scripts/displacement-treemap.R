library(tidyverse)
library(treemapify)

source('scripts/get_dbdat.R')

respondents <- get_dbdat('ana_respondents')

displacement_colors <- c(
  "Not affected"  = "#4173c0",
  "NA"  = "#c4b814",
  "Displaced" = "#c12227",
  "Affected" = "#8f37af"
)


plot <- respondents |>
  group_by(displacement_status) |>
  summarise(
    n_respondents = n()
  ) |>
  mutate(
    displacement_status = if_else(
      displacement_status == 'NA', 'Dam under development', displacement_status
    ),
    affected = case_when(
      str_detect(displacement_status, '^Affected') ~ 'Affected',
      str_detect(displacement_status, '^Displaced') ~ 'Displaced',
      str_detect(displacement_status, '^Not affected') ~ 'Not affected',
      displacement_status == 'Dam under development' ~ 'NA',
      TRUE ~ 'error'
    ),
    displacement_status = str_wrap(displacement_status, width = 20) 
  ) |>
  ggplot(aes(
    area = n_respondents,
    fill = affected,
    colour = 'black',
    subgroup = affected,
    label = displacement_status
  )) +
  geom_treemap(alpha = 0.8) +
  geom_treemap_text(size = 25, colour = 'white') +
  scale_fill_manual(values = displacement_colors) +
  theme_minimal() +
  theme(
    legend.position = 'none'
  )

ggsave(plot = plot, filename = 'figures_and_tables/displacement-treemap.svg', width = 12, height = 6)
