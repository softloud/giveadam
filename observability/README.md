# Observability

This directory contains data methodology documentation and observability artifacts for the giveadam project.

## Contents

### Documentation
- **`obs.tex`** - LaTeX source document for data methodology and observability report
- **`obs.pdf`** - Compiled PDF documentation (generated from `obs.tex`)
- **`README.md`** - This file

### Data Generation Scripts
- **`create-obs-tables/`** - Scripts to generate observability tables from dbt artifacts
  - `get-obs-dat.py` - Python script to extract model and test data from dbt manifest and run results
  - `obs-table.R` - R script to format extracted data into LaTeX tables
  - `models.csv` - Extracted dbt model metadata (generated)
  - `tests.csv` - Extracted dbt test results (generated)

### Generated Tables
- **`tables/`** - LaTeX table files included in the main document
  - `obs-tab-models.tex` - Table of dbt models with descriptions
  - `obs-tab-tests.tex` - Table of dbt test results

### Images
- **`img/`** - Images and diagrams for documentation
  - `dbt-dag.png` - dbt DAG (Directed Acyclic Graph) visualization

### Build Artifacts
- **`logs/`** - Build logs and temporary files
- Various LaTeX auxiliary files (`.aux`, `.fls`, `.synctex.gz`, etc.) - automatically generated during compilation

## Workflow

To regenerate the observability documentation:

1. **Run dbt** to ensure fresh artifacts:
   ```bash
   cd ../dbt_project
   dbt build
   ```

2. **Extract data** from dbt artifacts:
   ```bash
   cd create-obs-tables
   python get-obs-dat.py
   ```

3. **Generate LaTeX tables**:
   ```bash
   Rscript obs-table.R
   ```

4. **Compile the document**:
   ```bash
   pdflatex obs.tex
   ```

## Purpose

This observability documentation provides:
- **Data lineage transparency** - Clear documentation of all dbt models and their relationships
- **Test coverage visibility** - Complete overview of data quality tests and their results
- **Methodology documentation** - Detailed explanation of data processing approach
- **Reproducibility** - All artifacts can be regenerated from source data and scripts

The documentation is automatically generated from dbt artifacts to ensure it stays current with the actual data pipeline implementation.

