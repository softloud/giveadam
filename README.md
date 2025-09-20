# giveadam

This project provisions data for analysis of the social impacts of dams in North India as measured by two surveys, using open source tools including dbt, DuckDB, R and Python.

## Project Structure

### Data Directories

- **`data/`** - Published, processed datasets (output from dbt pipeline)
  - Clean, analysis-ready data tables
  - Derived metrics and aggregations
  - Ready to be imported via url into Python or R analyses. 

- **`raw_data/`** - Original survey data files provided by Garima Gupta
  - Tehri (raw Kobo export) and Arunachal Pradesh (provenance currently to be provided by Garima Gupta) survey responses
  - Column mapping helper for Tehri dataset

### Data Pipeline
- **`dbt_project/`** - dbt data transformation pipeline
  - `models/` - SQL transformations organized by layer (source, semantic, analytic)
  - `seeds/` - Static reference data
  - `tests/` - Data quality tests
  - See [dbt project README](dbt_project/README.md) for detailed pipeline documentation

### Analysis & Visualization
- **`scripts/`** - Data processing and analysis scripts
  - R scripts for data preparation and exploration
- **`vis-scripts/`** - Visualization generation scripts
  - Treemap visualizations for displacement and top-3 preferences
- **`figure_and_tables/`** - Generated visualizations and tables for publication

### Documentation & Observability
- **`observability/`** - Data methodology documentation and pipeline observability
  - Automated documentation of dbt models and tests
  - LaTeX-generated methodology reports
  - See [observability README](observability/README.md) for details

## Getting Started

### Prerequisites
- Python 3.12+
- R 4.0+
- [uv](https://docs.astral.sh/uv/) package manager

### Setup
1. **Install Python dependencies:**
   ```bash
   uv sync
   ```

2. **Install dbt packages:**
   ```bash
   cd dbt_project
   dbt deps
   ```

3. **Run the data pipeline:**
   ```bash
   dbt build
   ```

### Data Flow
1. **Raw data** (`raw_data/`) → **dbt seeds** (`dbt_project/seeds/`)
2. **dbt transformations** create cleaned and aggregated datasets
3. **Published data** output to `data/` directory
4. **Analysis scripts** consume published data for visualization and reporting

## Data Sources

### Survey Data
- **Tehri Dam region** - Community impact survey responses
- **Arunachal Pradesh** - SDG preference survey data
- **Methodology** - See `observability/obs.pdf` for detailed data processing documentation

### Geographic Coverage
- North India dam-affected communities
- Focus on social and environmental impacts
- SDG (Sustainable Development Goals) preference analysis

## Output Data

The `data/` directory contains analysis-ready datasets including:
- Cleaned respondent demographics and responses
- Aggregated community preferences and priorities
- Top-3 SDG preferences by region
- Displacement and impact metrics

## Documentation

- **Pipeline observability:** `observability/` - Automated documentation of data transformations
- **Raw data provenance:** `raw_data/README.MD` - Source data documentation
- **Analysis methodology:** Available in generated reports and documentation

## Contributing

This project uses:
- **dbt** for data transformations and testing
- **DuckDB** for local data processing
- **R** for statistical analysis and visualization
- **Python** for data extraction and automation
- **LaTeX** for methodology documentation

Data lineage and quality are automatically documented through the observability system.

## Data Validation & Feedback

**Data validation is most welcome!** This research involves complex social survey data, and we value community review and validation.

### How to Help
- **Review the methodology:** Check `observability/obs.pdf` for data processing details
- **Validate outputs:** Examine datasets in `data/` for accuracy and completeness
- **Check transformations:** Review dbt models in `dbt_project/models/` for logical consistency
- **Test assumptions:** Run your own analysis on the published data

### Report Issues
Found something that doesn't look right? **Please open an issue!**

- **Data quality concerns** - Unexpected values, missing data, or inconsistencies
- **Methodology questions** - Unclear transformations or analysis steps
- **Documentation gaps** - Missing context or unclear explanations
- **Reproducibility issues** - Problems running the pipeline or scripts

[**→ Open an Issue**](https://github.com/softloud/giveadam/issues/new)

Your feedback helps ensure the integrity and reliability of this research data. No observation is too small - we appreciate all contributions to data quality and transparency.
