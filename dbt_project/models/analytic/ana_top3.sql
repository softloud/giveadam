with responses as (
  select 
    id_respondent,
    rank,
    sdg_number,
    sdg_label
  from {{ ref('sem_top3') }}
),
respondents as (
  select 
    id_respondent,
    age,
    gender,
    displacement_status,
    displacement_group,
    region
  from {{ ref('sem_respondents') }}
),
joined as (
  select
    responses.id_respondent,
    responses.rank,
    responses.sdg_number,
    responses.sdg_label,
    respondents.region,
    respondents.displacement_group,
    respondents.age,
    respondents.gender,
    respondents.displacement_status
  from responses
  join respondents on responses.id_respondent = respondents.id_respondent
)
select * from joined
order by id_respondent, rank