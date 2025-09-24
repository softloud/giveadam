oselibrary(tidyverse)
library(xtable)
library(glue)
library(gt)
library(kableExtra)

dbt_models <- read_csv('observability/create-obs-tables/models.csv')

dbt_tests <- read_csv('observability/create-obs-tables/tests.csv')


extract_layer <- function(model_name) {
  case_when(
    str_detect(model_name, '^base_') ~ 'base',
    str_detect(model_name, '^se_') ~ 'source entities',
    str_detect(model_name, '^sem_') ~ 'semantic',
    str_detect(model_name, '^ana_') ~ 'analytic',
    TRUE ~ 'other'
  )}


models_cleaned <- dbt_models |>
  mutate(
    model = str_remove(node, 'model.dbt_project.'),
    layer = extract_layer(model) |>
      factor(levels = c('base', 'source entities', 'semantic', 'analytic')),
  ) |>
  select(layer, model, description) |>
  arrange(desc(layer), model)


# function to look at a string and extract the model name
# based on the models in the models table
extract_model_name <- function(test_node, models_cleaned) {
  
  # get the list of models
  model_name <- models_cleaned$model

  model_name[which(sapply(model_name, function(x) str_detect(test_node, x)))][1]
}

tests_cleaned <- dbt_tests |>
  mutate(
    test_node = str_remove(test_node, 'test.dbt_project.')
  ) |>
  select(test_node, result) |>
  mutate(
    test = case_when(
      str_detect(test_node, '^not_null') ~ 'not_null',
      str_detect(test_node, '^unique') ~ 'unique',
      str_detect(test_node, '^accepted_values') ~ 'accepted_values',
      str_detect(test_node, '^dbt_utils_unique_combination_of_columns') ~ 'dbt_utils_unique_combination_of_columns',
      TRUE ~ NA_character_
    ),
    # remove the test prefix and test id
    test_stripped = str_remove(test_node, glue('^{test}_')) |>
      str_remove('.[\\d|\\w]+$'),
    model_name = map_chr(test_stripped, extract_model_name, models_cleaned = models_cleaned),
    tested_details = str_remove(test_stripped, glue('^{model_name}_')),
    test = str_remove(test, '^dbt_utils_'),
    layer = extract_layer(model_name)  |>
      factor(levels = c('base', 'source entities', 'semantic', 'analytic'))
  ) |>
  separate(tested_details, into = c('tested_columns', 'test_arguments'), sep = '__', extra = "merge") |>
  select(layer, model_name, test, tested_columns, test_arguments, result) |>
  arrange(desc(layer), model_name, test)

# check all tests were categorized
tests_cleaned |> filter(is.na(test))

# check the model names have been extracted
tests_cleaned |> pull(model_name) |> unique() |> sort()

# take a look
# tests_cleaned |> gt(rowname_col = 'model_name', groupname_col = 'layer')

# greate we now have two tables cleaned up and ready to be written to tex
head(models_cleaned)
head(tests_cleaned)

# write to tex in observability/tables
# Using kableExtra for better LaTeX control and text wrapping

models_caption <- "Data Build Tool (DBT) models created by dbt\\_project, ordered by observability layer."
tests_caption <- "Data Build Tool (DBT) tests applied to dbt\\_project models, ordered by observability layer."
models_label <- "dbt_models"
tests_label <- "dbt_tests"

# Create models table with text wrapping and full text width
models_tex <- models_cleaned |>
  select(model, description) |>
  kbl(format = "latex", 
      caption = models_caption,
      label = models_label,
      booktabs = TRUE,
      col.names = c("Model", "Description"),
      escape = TRUE) |>
  kable_styling(latex_options = c("striped", "hold_position"), 
                font_size = 8) |>
  column_spec(1, width = "0.18\\\\textwidth") |>
  column_spec(2, width = "0.75\\\\textwidth") |>
  pack_rows("Analytic Models", 1, sum(models_cleaned$layer == "analytic"), bold = TRUE) |>
  pack_rows("Semantic Models", sum(models_cleaned$layer == "analytic") + 1, 
            sum(models_cleaned$layer %in% c("analytic", "semantic")), bold = TRUE) |>
  pack_rows("Source Entity Models", sum(models_cleaned$layer %in% c("analytic", "semantic")) + 1,
            sum(models_cleaned$layer %in% c("analytic", "semantic", "source entities")), bold = TRUE) |>
  pack_rows("Base Models", sum(models_cleaned$layer %in% c("analytic", "semantic", "source entities")) + 1,
            nrow(models_cleaned), bold = TRUE)

# Create tests table with text wrapping and full text width
tests_tex <- tests_cleaned |>
  select(model_name, test, tested_columns, test_arguments, result) |>
  kbl(format = "latex",
      caption = tests_caption, 
      label = tests_label,
      booktabs = TRUE,
      col.names = c("Model", "Test", "Columns", "Arguments", "Result"),
      escape = TRUE) |>
  kable_styling(latex_options = c("striped", "hold_position"), 
                font_size = 8) |>
  column_spec(1, width = "0.20\\\\textwidth") |>
  column_spec(2, width = "0.20\\\\textwidth") |>
  column_spec(3, width = "0.10\\\\textwidth") |>
  column_spec(4, width = "0.25\\\\textwidth") |>
  column_spec(5, width = "0.10\\\\textwidth") |>
  pack_rows("Analytic Model Tests", 1, sum(tests_cleaned$layer == "analytic"), bold = TRUE) |>
  pack_rows("Semantic Model Tests", sum(tests_cleaned$layer == "analytic") + 1, 
            sum(tests_cleaned$layer %in% c("analytic", "semantic")), bold = TRUE) |>
  pack_rows("Source Entity Tests", sum(tests_cleaned$layer %in% c("analytic", "semantic")) + 1,
            sum(tests_cleaned$layer %in% c("analytic", "semantic", "source entities")), bold = TRUE) |>
  pack_rows("Base Model Tests", sum(tests_cleaned$layer %in% c("analytic", "semantic", "source entities")) + 1,
            nrow(tests_cleaned), bold = TRUE)

# Write to files

writeLines(models_tex, "observability/tables/obs-tab-models.tex")
writeLines(tests_tex, "observability/tables/obs-tab-tests.tex")

cat("LaTeX tables written to observability/tables/\n")
