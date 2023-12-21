select
    *
from {{ source('schema', 'studentmarks') }}
