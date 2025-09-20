with source as (
  select * from {{ ref('base_arunachal') }}
),
wide as (
  select 
    id_respondent,
    x1st_preference as ranked_sdg_first,
    x2nd_preference as ranked_sdg_second,
    x3rd_preference as ranked_sdg_third,
    age,
    gender
  from source
)

select * from wide