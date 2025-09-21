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
select *, 
  case
    when displacement_status = 'Displaced' then 'Displaced'
    when displacement_status like 'Affected%' then 'Affected'
    when displacement_status like 'Not affected%' then 'Not Affected'
    when region = 'arunachal' then 'Dam not yet constructed'
    when displacement_status = 'None of the above' then 'None of the above'
    else 'error, check data lineage'
  end as displacement_group
from respondents