with raw as (
  select * from {{ ref('base_tehri')}}
),
wide as (
  select 
    id_respondent,
    TRIM(x1st_choice_62) as ranked_sdg_first,
    TRIM(x2nd_choice_63) as ranked_sdg_second,
    TRIM(x3rd_choice_70) as ranked_sdg_third
  from raw
),
long as (
  select 
    id_respondent,
    1 as rank,
    ranked_sdg_first as sdg_tehri
  from wide
  union all
  select 
    id_respondent,
    2 as rank,
    ranked_sdg_second as sdg_tehri
  from wide
  union all
  select 
    id_respondent,
    3 as rank,
    ranked_sdg_third as sdg_tehri
  from wide
)
select * from long
