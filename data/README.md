# Data Directory

This directory contains analysis-ready datasets derived from survey data on the social impacts of dams in North India. Data were collected by Dr. Garima Gupta and curated by Charles T. Gray using open source data pipeline tools.

## Datasets

### `respondents.csv`
**Description:** Individual respondent demographics and displacement status across both survey regions.

**Rows:** 157 respondents (excluding header)

**Columns:**
- `id_respondent` - Unique identifier for each survey respondent
- `age` - Age of respondent in years
- `gender` - Self-reported gender (Male, Female, Prefer not to say)
- `displacement_status` - Impact classification related to dam construction
  - "Displaced" - Physically relocated due to dam
  - "Affected but not displaced (nearby village)" - Impacted but not relocated
  - "Not affected (near to dam)" - Minimal impact despite proximity
  - "NA" - Status not available
- `region` - Survey location (tehri, arunachal)

**Geographic Coverage:** Tehri Dam region (Uttarakhand) and Arunachal Pradesh, India

### `SDG_rankings.csv`
**Description:** Respondent rankings of their top 3 UN Sustainable Development Goals (SDGs) by priority, with associated demographic information.

**Rows:** 471 rankings (excluding header)

**Columns:**
- `id_respondent` - Unique identifier linking to respondents table
- `rank` - Priority ranking (1=highest, 2=medium, 3=lowest priority)
- `sdg_number` - UN SDG number (1-17)
- `sdg_label` - Full name of the Sustainable Development Goal
- `age` - Age of respondent in years
- `gender` - Self-reported gender
- `displacement_status` - Dam impact classification (see respondents.csv)
- `region` - Survey location (tehri, arunachal)

**Structure:** Each respondent contributes 3 rows (their top 3 SDG preferences)

## Data Provenance

### Source Data
- **Tehri Survey:** Community impact assessment in Tehri Dam region, Uttarakhand
- **Arunachal Pradesh Survey:** SDG preference research in Arunachal Pradesh
- **Collector:** Dr. Garima Gupta
- **Raw Data Location:** [`raw_data/`](../raw_data/)

### Processing Pipeline
Data transformation and quality assurance performed using:
- **dbt (data build tool)** for SQL-based transformations
- **DuckDB** for local data processing
- **Automated testing** for data quality validation

For detailed methodology see:
- **Pipeline Documentation:** [`dbt_project/`](../dbt_project/) 
- **Observability Report:** [`observability/obs.pdf`](../observability/obs.pdf)
- **Project Overview:** [Main README](../README.md)

### Data Quality
- ✅ Unique respondent identifiers validated
- ✅ Referential integrity between datasets maintained
- ✅ Value constraints enforced (e.g., SDG rankings 1-3)
- ✅ Geographic consistency verified

## Usage Guidelines

### Research Applications
- Social impact analysis of large infrastructure projects
- Community preference studies for sustainable development
- Displacement and resettlement research
- Regional comparison of development priorities

### Citation
When using this data, please cite:
- **Data Collector:** Garima Gupta
- **Data Curator:** Charles T. Gray
- **Repository:** https://github.com/softloud/giveadam

### Data Validation
Community review and validation of this research data is welcomed. Please [open an issue](https://github.com/softloud/giveadam/issues/new) for:
- Data quality concerns or inconsistencies
- Methodology questions or suggestions
- Additional context or corrections

## Technical Details

**Format:** CSV (Comma-separated values)  
**Encoding:** UTF-8  
**Missing Values:** Coded as "NA"  
**Generated:** From dbt pipeline in [`dbt_project/`](../dbt_project/)  
**Last Updated:** Check git commit history for latest changes