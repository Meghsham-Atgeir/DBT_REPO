select
    *
from {{ source('student_sources_file', 'studentmarks') }}
