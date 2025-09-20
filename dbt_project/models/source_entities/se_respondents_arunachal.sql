select 
  id_respondent,
  age,
  gender,
  'NA' as displacement_status,
  'arunachal' as region
from {{ ref('base_arunachal') }} 