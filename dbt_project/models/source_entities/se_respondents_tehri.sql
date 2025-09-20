with base as (
  select * from {{ ref('base_tehri') }}
  --- see analyses/tehri_rows_excluded.sql for rows excluded
  where not (other_specify_13 like '%test%' or 
  how_was_the_respondent_affected_by_the_construction_of_the_dam = 'NA')),

extracted as (
  select 
    id_respondent,
    what_is_your_age as age,
    case 
      when trim(what_gender_do_you_identify_with) = 'Man' then 'Male'
      when trim(what_gender_do_you_identify_with) = 'Woman' then 'Female'
      else 'Prefer not to say'
    end as gender,
    how_was_the_respondent_affected_by_the_construction_of_the_dam as displacement_status,
    'tehri' as region
  from base
)

select *
from extracted
