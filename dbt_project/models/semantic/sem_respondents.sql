with respondents as (
  select
    id_respondent,
    age,
    gender,
    displacement_status,
    region
  from {{ ref('se_respondents_tehri') }}
  union all
  select
    id_respondent,
    age,
    gender,
    displacement_status,
    region
  from {{ ref('se_respondents_arunachal') }}
)
select *
from respondents