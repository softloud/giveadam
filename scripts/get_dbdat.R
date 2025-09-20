
#' Retrieve a table from the DuckDB database as a data frame
#'
#' This function connects to the project's DuckDB database, retrieves all rows from the specified table
#' in the 'main' schema, and returns the result as a data frame. The connection is automatically closed
#' after the query completes. Intended for use in R analysis scripts and notebooks.
#'
#' @param table_name Character. The name of the table to retrieve (must exist in the 'main' schema).
#' @return A data frame containing all rows from the specified table.
#' @examples
#' dailies <- get_dbdat("ana_dailies")
#' head(dailies)
get_dbdat <- function(table_name) {
  # Path to the DuckDB database file (relative to project root)
  db_path <- "database/dat.duckdb"

  # Open a connection to the DuckDB database
  con <- DBI::dbConnect(duckdb::duckdb(), dbdir = db_path)

  # Compose a SQL query to select all columns from the specified table in the 'main' schema
  df_query <- sprintf("SELECT * FROM main.%s", table_name)

  # Execute the query and fetch the results as a data frame
  df <- DBI::dbGetQuery(con, df_query)

  # Close the database connection to free resources
  DBI::dbDisconnect(con)

  # Return the resulting data frame
  return(df)
}

