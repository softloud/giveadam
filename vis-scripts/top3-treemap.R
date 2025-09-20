library(tidyverse)
library(treemapify)

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
    region = str_to_sentence(region),
    sdg_label = str_wrap(sdg_label, width = 10),
    sdg_number = as.character(sdg_number)
  )

top3 |>
  pull(sdg_label) |> unique()


top3 |>
  group_by(region, sdg_label, sdg_number) |>
  summarise(sdg_count = n()) |>
  ggplot(aes(area = sdg_count, fill = sdg_number, label = sdg_label)) +
  geom_treemap() +
  geom_treemap_text(
    size = 15, 
    colour = "white") +
  geom_treemap_text(
    aes(label = sdg_number),
    size = 60,
    alpha = 0.7,
    place = "center", 
    fontface = "bold", 
    colour = "white") +
  facet_wrap(~region) + 
  scale_fill_manual(values = sdg_colors) +
  labs(title = "UN SDG priorities in Arunachal and Tehri",
      subtitle = "Affordable & clean energy (SDG 7) more urgent in Tehri, in spite of the development of the dam"|> str_wrap(70),
      caption = "Count of SDGs selected in top 3 priorities by respondents in Arunachal and Tehri") +
  theme_minimal(base_size = 20) +
  theme(
    strip.text = element_text(size = 30),
    legend.position = "none"
  )

ggsave('figures_and_tables/top3-treemap.png', width = 12, height = 8)


top3 |>
  group_by(region, sdg_label, gender, sdg_number) |>
  filter(gender %in% c("Male", "Female")) |>
  summarise(sdg_count = n()) |>
  ggplot(aes(area = sdg_count, fill = sdg_number)) +
  geom_treemap() +
  geom_treemap_text(size = 20,aes(label = sdg_label), alpha = 0.6) +
  geom_treemap_text(size = 30, aes(label = sdg_number), place = "center", fontface = "bold", colour = "white") +
  facet_grid(gender~region) +
  scale_fill_manual(values = sdg_colors) +
  labs(title = "SDG priorities in Arunachal and Tehri",
       subtitle = "Count of SDGs ranked in top 3 by respondents in Arunachal and Tehri") +
  theme_minimal(base_size = 15) +
  theme(
    strip.text = element_text(size = 30),
    legend.position = "none"
  )

ggsave('figures_and_tables/top3-gender-treemap.png', width = 12, height = 12)

top3 |>
  group_by(region, sdg_label)

