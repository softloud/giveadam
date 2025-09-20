with wide as (
  select 
    id_respondent,
    x1st_preference as ranked_sdg_first,
    x2nd_preference as ranked_sdg_second,
    x3rd_preference as ranked_sdg_third,
    age,
    gender
  from {{ ref('base_arunachal') }}
),
long as (
  select 
    id_respondent,
    1 as rank,
    ranked_sdg_first as sdg_arunachal
  from wide
  union all
  select 
    id_respondent,
    2 as rank,
    ranked_sdg_second as sdg_arunachal
  from wide
  union all
  select 
    id_respondent,
    3 as rank,
    ranked_sdg_third as sdg_arunachal
  from wide
)
select * from long