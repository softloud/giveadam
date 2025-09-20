select
  concat('respondent-', (row_number() over ())::varchar, '-tehri') as id_respondent,
  * 
from {{ ref('seed_tehri') }}