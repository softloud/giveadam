with tehri_sdg as (
  select id_respondent, sdg_tehri
  from {{ ref('sem_top3_tehri_long') }}
),
sdg_distinct as (
  select distinct sdg_tehri from tehri_sdg
)
select 
  sdg_tehri,
  case
    when sdg_tehri = 'Sustainable use of water and sanitation for all' then 6
    when sdg_tehri = 'Access to clean energy' then 7
    when sdg_tehri = 'Regulate climate change' then 13
    when sdg_tehri = 'Peaceful and inclusive society' then 16
    when sdg_tehri = 'Health and wellbeing' then 3
    when sdg_tehri = 'Protect biodiversity and environment' then 15
    when sdg_tehri = 'Education' then 4
    when sdg_tehri = 'Sustainable cities and human development' then 11
    when sdg_tehri = 'Better infrastructure' then 9
    when sdg_tehri = 'Sustainable economic growth and employment opportunities' then 8
    when sdg_tehri = 'Global partnerships' then 17
    when sdg_tehri = 'Livelihood and economy' then 1
    when sdg_tehri = 'Food security' then 2
    when sdg_tehri = 'Reduce inequality among and within countries' then 10
    when sdg_tehri = 'Sustainable use of natural resources' then 12
    when sdg_tehri like 'Gender equality and women%' then 5
    else null
  end as sdg_number,
  concat('SDG ', sdg_number::varchar) as sdg_arunachal,
  case 
    when sdg_number = 1 then 'No Poverty'
    when sdg_number = 2 then 'Zero Hunger'
    when sdg_number = 3 then 'Good Health and Well-being'
    when sdg_number = 4 then 'Quality Education'
    when sdg_number = 5 then 'Gender Equality'
    when sdg_number = 6 then 'Clean Water and Sanitation'
    when sdg_number = 7 then 'Affordable and Clean Energy'
    when sdg_number = 8 then 'Decent Work and Economic Growth'
    when sdg_number = 9 then 'Industry, Innovation and Infrastructure'
    when sdg_number = 10 then 'Reduced Inequality'
    when sdg_number = 11 then 'Sustainable Cities and Communities'
    when sdg_number = 12 then 'Responsible Consumption and Production'
    when sdg_number = 13 then 'Climate Action'
    when sdg_number = 14 then 'Life Below Water'
    when sdg_number = 15 then 'Life on Land'
    when sdg_number = 16 then 'Peace, Justice and Strong Institutions'
    when sdg_number = 17 then 'Partnerships for the Goals'
    else null end as sdg_label
from sdg_distinct
order by sdg_number