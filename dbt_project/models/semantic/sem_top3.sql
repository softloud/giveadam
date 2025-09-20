with sdg_labels as (
  select * from {{ ref('sem_sdg_labels') }}
),
tehri_rankings as (
  select 
    id_respondent,
    rank,
    sdg_tehri
  from {{ ref('se_top3_tehri') }}
),
arunachal_rankings as (
  select 
    id_respondent,
    rank,
    sdg_arunachal
  from {{ ref('se_top3_arunachal') }}
),
labelled as (
  select 
    tehri_rankings.id_respondent,
    tehri_rankings.rank,
    sdg_labels.sdg_number,
    sdg_labels.sdg_label
  from tehri_rankings
  left join sdg_labels
    on tehri_rankings.sdg_tehri = sdg_labels.sdg_tehri
  union all
  select 
    arunachal_rankings.id_respondent,
    arunachal_rankings.rank,
    sdg_labels.sdg_number,
    sdg_labels.sdg_label
  from arunachal_rankings
  left join sdg_labels
    on arunachal_rankings.sdg_arunachal = sdg_labels.sdg_arunachal
)
select * from labelled