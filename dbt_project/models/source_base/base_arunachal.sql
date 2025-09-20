select 
  concat('respondent-', respondents::varchar, '-arunachal') as id_respondent,
  *
from {{ ref('seed_arunachal') }}