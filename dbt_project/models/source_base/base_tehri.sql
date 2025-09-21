select
  concat('respondent-', (row_number() over ())::varchar, '-tehri') as id_respondent,
  * 
from {{ ref('seed_tehri') }}
  --- see analyses/tehri_rows_excluded.sql for rows excluded
  where not (other_specify_13 like '%test%' or 
  how_was_the_respondent_affected_by_the_construction_of_the_dam = 'NA')