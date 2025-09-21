select *
from {{ ref('seed_tehri') }}
where other_specify_13 like '%test%' or 
  how_was_the_respondent_affected_by_the_construction_of_the_dam = 'NA'