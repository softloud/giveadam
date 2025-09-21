select distinct count(*) as n_sdgs
from {{ ref('ana_sdg') }}
having n_sdgs != 17