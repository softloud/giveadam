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
)
select * from wide