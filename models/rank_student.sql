{{
  config(
    materialized='view'
    
  )
}}

with student_data as (
    select * from {{ ref('grade_student') }}
),
student_ranks as (
    select * 
    from student_data 
    order by Percentage desc
    limit 3
)

select * from student_ranks