with wide as (
  select 
    id_respondent,
    ranked_sdg_first,
    ranked_sdg_second,
    ranked_sdg_third
  from {{ ref('se_top3_arunachal') }}
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