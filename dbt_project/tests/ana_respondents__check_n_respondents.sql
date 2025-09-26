with counts as (
  select region, count(id_respondent) as n_respondents
  from {{ ref('ana_respondents') }}
  group by region
),
checked as (
  select 
    case when region = 'arunachal' and n_respondents != 21 then 'Check Arunachal n_respondents'
        when region = 'tehri' and n_respondents != 136 then 'Check Tehri n_respondents'
        else 'OK'
    end as counted
  from counts
)
select * from checked
where counted != 'OK'