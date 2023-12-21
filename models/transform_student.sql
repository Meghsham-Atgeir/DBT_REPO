{{
  config(
    materialized='view'
    -- materialized='table'
  )
}}

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
),
student_transform as (
    select
        Studentid as Roll_No,
        First_Name,
        Last_Name,
        CONCAT(First_Name, ' ', Last_Name) as Full_Name,
        (Maths_Marks + Science_Marks + Marathi_Marks + English_Marks + Hindi_Marks) as Total_Marks,
        ((Maths_Marks + Science_Marks + Marathi_Marks + English_Marks + Hindi_Marks) / 500.0) * 100 as Percentage,
        case
            when Percentage >= 90 then 'A+'
            when Percentage >= 80 and Percentage <90 then 'A'
            when Percentage >= 70 and Percentage < 80 then 'B+'
            when Percentage >= 60 and Percentage < 70 then 'B'
            when Percentage >= 50 and Percentage < 60 then 'C+'
            when Percentage >= 40 and Percentage < 50 then 'C'
            else 'Fail'
            
        end as Grade
    from student_data
)
-- student_ranks as (
--     select * 
--     from student_transform 
--     order by Percentage desc
--     limit 3
-- )



select * from student_transform
