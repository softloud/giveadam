with sdgs as (
  select 
    replace(sdg_arunachal, ' ', '_') as sdg_id,  
    sdg_number,
    sdg_label
  from {{ ref('sem_sdg_labels') }}

  union all

  select 
    'SDG_14' as sdg_id,
    14 as sdg_number,
    'Life Below Water' as sdg_label
)

select * from sdgs
order by sdg_number