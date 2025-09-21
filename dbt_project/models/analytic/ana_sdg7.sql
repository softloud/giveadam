with long as ( select 
  id_respondent,
  case when sdg_number = 7 then 1 else 0 end as sdg_7_chosen
from {{ ref('sem_top3') }}
),
sdg_7 as (
  select 
    id_respondent,
    max(sdg_7_chosen) as sdg_7_chosen
  from long
  group by id_respondent
),
respondents as (
  select 
    id_respondent,
    age,
    gender,
    displacement_status,
    region,
    displacement_group
  from {{ ref('sem_respondents') }}
),
joined as (
  select 
    sdg_7.id_respondent,
    sdg_7.sdg_7_chosen,
    respondents.region,
    respondents.age,
    respondents.gender,
    respondents.displacement_group,
    respondents.displacement_status
  from sdg_7
  left join respondents on sdg_7.id_respondent = respondents.id_respondent
)
select * from joined