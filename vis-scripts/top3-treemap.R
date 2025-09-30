library(tidyverse)
library(treemapify)
library(glue)

sdg_colors <- c(
  "1"  = "#E5243B",
  "2"  = "#DDA63A",
  "3"  = "#4C9F38",
  "4"  = "#C5192D",
  "5"  = "#FF3A21",
  "6"  = "#26BDE2",
  "7"  = "#FCC30B",
  "8"  = "#A21942",
  "9"  = "#FD6925",
  "10" = "#DD1367",
  "11" = "#FD9D24",
  "12" = "#BF8B2E",
  "13" = "#3F7E44",
  "14" = "#56C02B",
  "15" = "#00689D",
  "16" = "#19486A"
)

source('scripts/get_dbdat.R')

top3 <- get_dbdat('ana_top3') |> 
  mutate(
    region = if_else(region == "arunachal", "arunachal pradesh", region),
    region = str_to_title(region),
    sdg_label = str_wrap(sdg_label, width = 10),
    sdg_number = as.character(sdg_number)
  )

top3 |>
  pull(sdg_label) |> unique()


top3 |>
  group_by(region) |>
  mutate(region = glue("{region} ({n_distinct(id_respondent)})")) |>
  ungroup() |>
  group_by(region, sdg_label, sdg_number) |>
  summarise(
    sdg_count = n_distinct(id_respondent)
  ) |>
  mutate(
    sdg_count_label = glue("respondents = {sdg_count}")
  ) |>
  ungroup() |>
  ggplot(aes(area = sdg_count, fill = sdg_number)) +
  geom_treemap() +
  geom_treemap_text(
    aes(label = sdg_count_label),
    size = 15,
    alpha = 0.5,
    fontface = "italic",
    place = "bottomright", 
    colour = "white") +
  geom_treemap_text(
    aes(label = sdg_label),
    fontface = "italic",
    size = 30, 
    alpha = 0.7,
    colour = "white") +
  geom_treemap_text(
    aes(label = sdg_number),
    size = 80,
    # alpha = 0.5,
    place = "center", 
    fontface = "bold", 
    colour = "white") +   
  facet_wrap(~region) + 
  scale_fill_manual(values = sdg_colors) +
  labs(title = "UN SDG priorities in Arunachal Pradesh and Tehri",
      subtitle = "Affordable & clean energy (SDG 7) more urgent in Tehri, in spite of the development of the dam 20 years ago"|> str_wrap(70),
      caption = "Sized by the number of respondents who prioritised (in top 3) each UN SDG.") +
  theme_minimal(base_size = 20) +
  theme(
    strip.text = element_text(size = 30),
    legend.position = "none"
  )

ggsave('figures_and_tables/top3-treemap.svg', width = 12, height = 8)



top3 |>
  filter(gender %in% c('Male', 'Female')) |>
  group_by(region) |>
  mutate(
    region = glue("{region} ({n_distinct(id_respondent)})"),
  ) |>
  ungroup() |>
  group_by(gender) |>
  mutate(gender = glue("{gender} ({n_distinct(id_respondent)})")) |>
  ungroup() |>
  group_by(region, sdg_label, sdg_number, gender) |>
  summarise(
    sdg_count = n_distinct(id_respondent)
  ) |>
  mutate(
    sdg_count_label = glue("respondents = {sdg_count}")
  ) |>
  ungroup() |>
  ggplot(aes(area = sdg_count, fill = sdg_number)) +
  geom_treemap() +
  geom_treemap_text(
    aes(label = sdg_count_label),
    size = 15,
    alpha = 0.5,
    fontface = "italic",
    place = "bottomright", 
    colour = "white") +
  geom_treemap_text(
    aes(label = sdg_label),
    fontface = "italic",
    size = 30, 
    alpha = 0.7,
    colour = "white") +
  geom_treemap_text(
    aes(label = sdg_number),
    size = 80,
    # alpha = 0.5,
    place = "center", 
    fontface = "bold", 
    colour = "white") +   
  facet_grid(gender~region) + 
  scale_fill_manual(values = sdg_colors) +
  labs(title = "UN SDG priorities in Arunachal Pradesh and Tehri, by gender",
      subtitle = "Little difference between male and female respondents' priorities"|> str_wrap(70),
      caption = "Sized by the number of respondents who prioritised (in top 3) each UN SDG. One respondent chose 'Prefer not to say' and is excluded from this visualisation." |> str_wrap(80))  +
  theme_minimal(base_size = 20) +
  theme(
    strip.text = element_text(size = 30),
    legend.position = "none"
  )

ggsave('figures_and_tables/top3-gender-treemap.svg', width = 12, height = 12)


top3 |>
  filter(!str_detect(region, 'Arunachal')) |>
  group_by(displacement_group) |>
  mutate(
    displacement_group = glue("{displacement_group} ({n_distinct(id_respondent)})"),
  ) |>
  ungroup() |>
  group_by(displacement_group, sdg_label, sdg_number) |>
  summarise(
    sdg_count = n_distinct(id_respondent)
  ) |>
  mutate(
    sdg_count_label = glue("respondents = {sdg_count}")
  ) |>
  ungroup() |>
  ggplot(aes(area = sdg_count, fill = sdg_number)) +
  geom_treemap() +
  geom_treemap_text(
    aes(label = sdg_count_label),
    size = 15,
    alpha = 0.5,
    fontface = "italic",
    place = "bottomright", 
    colour = "white") +
  geom_treemap_text(
    aes(label = sdg_label),
    fontface = "italic",
    size = 30, 
    alpha = 0.7,
    colour = "white") +
  geom_treemap_text(
    aes(label = sdg_number),
    size = 80,
    # alpha = 0.5,
    place = "center", 
    fontface = "bold", 
    colour = "white") +   
  facet_wrap(~displacement_group) + 
  scale_fill_manual(values = sdg_colors) +
  labs(title = "UN SDG priorities in Tehri, by displacement group",
      subtitle = "Poverty (SDG 1) and hunger (SDG 2) urgent issues for those affected or dispalced by Tehri dam "|> str_wrap(70),
      caption = "Sized by the number of respondents who prioritised (in top 3) each UN SDG." |> str_wrap(80))  +
  theme_minimal(base_size = 20) +
  theme(
    strip.text = element_text(size = 30),
    legend.position = "none"
  )

ggsave('figures_and_tables/top3-displacement-treemap.svg', width = 12, height = 12)

top3 |>
  filter(!str_detect(region, 'Arunachal')) |>
  mutate(displacement_group = if_else(displacement_group == "Affected" |
    displacement_group == "Displaced", "Affected or Displaced", "Not affected")) |> 
  group_by(displacement_group) |>
  mutate(
    displacement_group = glue("{displacement_group} ({n_distinct(id_respondent)})"),
  ) |>
  ungroup() |>
  group_by(displacement_group, sdg_label, sdg_number) |>
  summarise(
    sdg_count = n_distinct(id_respondent)
  ) |>
  mutate(
    sdg_count_label = glue("respondents = {sdg_count}")
  ) |>
  ungroup() |>
  ggplot(aes(area = sdg_count, fill = sdg_number)) +
  geom_treemap() +
  geom_treemap_text(
    aes(label = sdg_count_label),
    size = 15,
    alpha = 0.5,
    fontface = "italic",
    place = "bottomright", 
    colour = "white") +
  geom_treemap_text(
    aes(label = sdg_label),
    fontface = "italic",
    size = 30, 
    alpha = 0.7,
    colour = "white") +
  geom_treemap_text(
    aes(label = sdg_number),
    size = 80,
    # alpha = 0.5,
    place = "center", 
    fontface = "bold", 
    colour = "white") +   
  facet_wrap(~displacement_group) + 
  scale_fill_manual(values = sdg_colors) +
  labs(title = "UN SDG priorities in Tehri, by displacement group",
      subtitle = "Poverty (SDG 1) and hunger (SDG 2) urgent issues for those affected or dispalced by Tehri dam "|> str_wrap(70),
      caption = "Sized by the number of respondents who prioritised (in top 3) each UN SDG." |> str_wrap(80))  +
  theme_minimal(base_size = 20) +
  theme(
    strip.text = element_text(size = 30),
    legend.position = "none"
  )

ggsave('figures_and_tables/top3-displacement-simplified-treemap.svg', width = 12, height = 8)

