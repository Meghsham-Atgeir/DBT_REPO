with student_data as (
    select * from {{ ref('stg_student') }}
),

student_transform as (
    select
        Studentid as Roll_No,
        First_Name,
        Last_Name,
        CONCAT(First_Name, ' ', Last_Name) as Full_Name,
        (Maths_Marks + Science_Marks + Marathi_Marks + English_Marks + Hindi_Marks) as Total_Marks,
        ((Maths_Marks + Science_Marks + Marathi_Marks + English_Marks + Hindi_Marks) / 500.0) * 100 as Percentage
    from student_data
)

select * from student_transform
