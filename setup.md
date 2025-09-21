## Prerequisites

This project utilises the following open source tools:

- uv package manager: [Install uv](https://uv.run/docs/getting-started/installation)
- dbt: [Install dbt](https://docs.getdbt.com/dbt-cli/install)
- duckdb: [Install duckdb](https://duckdb.org/docs/installation)
- R: [Install R](https://cran.r-project.org/mirrors.html)
- R packages: `DBI`, `duckdb`, `tidyverse`.
- Python 3.8+ (via uv virtual environment)

## VSC users

Ensure VSC workspace python interpreter is pointed at .venv to invoke uv. Go to **File > Preferences > Settings**, choose Workspace (not User) tab, then Set the Python Interpreter for the Workspace to `${workspaceFolder}/.venv/bin/python`. Otherwise, preface commands with `uv run`.