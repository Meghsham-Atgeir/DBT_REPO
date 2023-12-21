{{
  config(
    materialized='table'
    
  )
}}
-- materialized='view'

with student_data_raw as (
    select * from {{ ref('stg_student') }}
),
student_data as (
    select 
    Studentid,
    First_Name,
    Last_Name,
    Birth_Date,
    Height_in_CM/100 as Height_in_Meter,
    Weight_in_Pounds * 0.45360 as Weight_in_Kg,
    Maths_Marks ,
    Science_Marks ,
    Marathi_Marks ,
    English_Marks ,
    Hindi_Marks  
    from student_data_raw  
)




select * from student_data
