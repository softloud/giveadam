library(tidyverse)
library(treemapify)

source('scripts/get_dbdat.R')
source('vis-scripts/sdg_palette.R')



sdgs <- get_dbdat('ana_sdg')


margin_param <- 20

# generate x and y for plotting
x_y_sdgs <- sdgs %>%
  mutate(
    x = (sdg_number - 1) %% 6,
    y = -(sdg_number) %/% 6,
    sdg_label = str_wrap(sdg_label, width = 10),
    sdg_color = sdg_number |> as.character()
  )

# but perhaps is not needed for barplot
sdgs %>%
  mutate(
    sdg_label = str_wrap(sdg_label, width = 10),
    sdg_color = sdg_number |> as.character(),
    y = 1
  ) %>%
  ggplot(
    aes(x = sdg_label, y = y, fill = sdg_color, label=sdg_label)
  ) +
  geom_col() +
  geom_text(
    aes(label = sdg_label, y = y),
    hjust = 0,
    vjust = 1,
    color = "white",
    nudge_x = -0.4,  # Pushes text slightly to the right
    nudge_y = -0.1,
    size = 10,
    fontface = "italic"
    ) +
  geom_text(
    aes(label = sdg_number, y = y),
    vjust = 0.5,
    hjust = 0.5,
    nudge_y = -0.5,
    color = "white",
    size = 50,
    fontface = "bold",
    alpha = 0.3
  ) +
  facet_wrap(~sdg_number, scale = "free", nrow = 3, ncol = 6) +
  scale_fill_manual(values = sdg_colors) +
  theme_void(base_size = 15) +
    theme(
    plot.title = element_text(hjust = 0.5, size = 30),
    panel.spacing = unit(0.5, "lines"),
    legend.position = 'none',
    plot.margin = margin(margin_param, margin_param, margin_param, margin_param, "pt"),
    strip.text = element_blank()
    ) +
  labs(title = "UN Sustainable Development Goals (UN SDGs)")



ggsave(filename = 'figures_and_tables/sdgs.svg', width = 24, height = 12)