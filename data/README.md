# Data Directory

This directory contains analysis-ready datasets derived from survey data on the social impacts of dams in North India. Data were collected by Garima Gupta and curated by Charles T. Gray using open source data pipeline tools.

## Datasets

### `respondents.csv`
**Description:** Individual respondent demographics and displacement status across both survey regions.

**Rows:** 157 respondents (excluding header), 21 from Arunachal Pradesh and 136 from Tehri Dam region.

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

**Data Cleaning:** 2 test rows were excluded from the Tehri dataset due to:
- Substantial missingness and clear test data indicators
- Free-text responses containing 'test' entries
- Missing displacement status (marked as 'NA')
- See [`dbt_project/analyses/tehri_rows_excluded.sql`](../dbt_project/analyses/tehri_rows_excluded.sql) for exclusion criteria

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
- **Collector:** Garima Gupta
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

## Citation & Licensing

### How to Cite This Dataset

**APA Style:**
```
Gupta, G., & Gray, C. T. (2025). Social impacts of dams in North India: Survey data on displacement and sustainable development preferences [Dataset]. GitHub. https://github.com/softloud/giveadam
```

**BibTeX:**
```bibtex
@dataset{gupta_gray_2025_giveadam,
  author       = {Gupta, Garima and Gray, Charles T.},
  title        = {Social impacts of dams in North India: Survey data on 
                  displacement and sustainable development preferences},
  year         = {2025},
  publisher    = {GitHub},
  url          = {https://github.com/softloud/giveadam},
  note         = {Data collected in Tehri Dam region, Uttarakhand and 
                  Arunachal Pradesh, India}
}
```

### License

This dataset is licensed under [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

**You are free to:**
- **Share** — copy and redistribute the material in any medium or format
- **Adapt** — remix, transform, and build upon the material for any purpose, even commercially

**Under the following terms:**
- **Attribution** — You must give appropriate credit, provide a link to the license, and indicate if changes were made

### Digital Object Identifier (DOI)

*DOI pending* - These data will be published on the beta rollout of Frontiers FAIR data platform.

### Additional Citation Elements

**Research Context:** These data support research on social impacts of large infrastructure development projects in India, with focus on community displacement and sustainable development priorities.

**Funding:** *[Funding information pending]*

**Data Collection Period:** *[Collection timeframe pending]*

**Geographic Bounds:** 
- Tehri Dam region, Uttarakhand, India
- Arunachal Pradesh, India

**Ethical Considerations:** Survey data collected with participant consent. Personal identifiers removed for privacy protection.

### Recommended Citation for Publications

When using this data in academic publications, please cite both the dataset and the methodology:

1. **Dataset Citation:** (See BibTeX above)
2. **Methodology Reference:** Gray, C. T. (2025). Automated data pipeline documentation for transparent social impact research. *[Preprint]*

### Data Availability Statement Template

For use in academic papers:
```
"The datasets supporting the conclusions of this article are available in the 
giveadam repository, https://github.com/softloud/giveadam. Survey data on dam 
impacts and SDG preferences are provided under CC BY 4.0 license with full 
methodology documentation and automated quality assurance reports."
```