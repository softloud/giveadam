select 
  id_respondent,
  age,
  gender,
  displacement_status,
  region
from {{ ref('sem_respondents') }}