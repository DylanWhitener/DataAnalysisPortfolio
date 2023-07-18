SELECT *
FROM
  patients
  /*
   Start by selecting a question by pressing 'Start' or 'View All Questions'.
   Use the resources and information about the database from the left panel to help.
   Press the run button to execute the query.
   Question is automatically validated every time you execute the query.
   Make your output match the expected output.
   
   
   Keybinds:
   [ctrl + enter]: Execute the SQL
   [ctrl + j]: Auto-format the SQL
   */
SELECT
  first_name,
  last_name
FROM patients
WHERE weight between 100 AND 120

update patients
SET allergies = 'NKA'
WHERE allergies IS null

select 
	concat(first_name, ' ', last_name) as full_name
from patients

select 
	first_name, 
    last_name,
    province_name
FROM patients
join province_names
	on patients.province_id = province_names.province_id
    
SELECT
	COUNT(birth_date) AS num_of_patients
FROM patients
WHERE year(birth_date) = 2010

SELECT
	first_name,
    last_name,
    MAX(height) as tallest_person
FROM patients

select *
from patients
Where
	patient_id IN (1,45,534,879,1000)

select 
	COUNT(*) as total_admissions
from admissions

select *
FROM admissions
WHERe
	admission_date = discharge_date

SELECT 
	patient_id,
    COUNT(*) AS total_admissions
FROM admissions
WHERE
	patient_id = 579

SELECT 
	distinct city AS unique_cities
FROM patients
WHERE
	province_id = 'NS'

SELECT
	first_name,
    last_name,
    birth_date
FROM patients
WHERE
	height > 160 
    AND weight > 70

select
	first_name,
    last_name,
    allergies
FROm patients
where
	city = 'Hamilton'
    AND allergies is not null

SELECT
	DISTINCT city
FROM patients
Where
	city LIKE 'a%' OR 
    city LIKE 'e%' or
    city LIKE 'i%' or
    city LIKE 'o%' or
    city LIKE 'u%'
order by city

SELECT
	distinct(YEAR(birth_date)) AS birth_year
FROM patients
order by birth_year

/* Come back and check this one out again Medium question 2 */
select
	 first_name
From patients
group by first_name
having count(*) = 1

---------------------------------------------------
-- Question 3 Med
select
	patient_id,
    first_name
from patients
where
	first_name like 's____%s'
    
-- Alternative --
SELECT
  patient_id,
  first_name
FROM patients
WHERE
  first_name LIKE 's%s'
  AND len(first_name) >= 6;
-----------------------------------------------------

select
	patients.patient_id,
    first_name,
    last_name
from patients
join admissions
	ON patients.patient_id = admissions.patient_id
where
	diagnosis = 'Dementia'
    
select
	first_name
FROM patients
order by 
	len(first_name), first_name
------------------------------------------------------------------------
--COME back to q5
SELECT
	(SELECT count(*) FRom patients where gender = 'M') As male_count,
    (SELECT count(*) FRom patients where gender = 'F') AS female_count
    
select
	sum(gender = 'M') as male_count,
    sum(gender = 'F') as female_counnt
from patients
-------------------------------------------------------------------------

select
	first_name,
    last_name,
    allergies
from patients
where 
	allergies in ('Penicillin','Morphine')
order by
	allergies, first_name, last_name

select
     patient_id,
     diagnosis
FROM admissions
group by
	patient_id,
	diagnosis
having 
	count(*) >1

select
	city,
    COUNT(*) as total_patients
from patients
group by
	city
order by 
	total_patients desc,
    city
    
select 
	first_name,
    last_name,
    'Patient' AS role
From patients
union ALL
select 
	first_name,
    last_name,
    'Doctor' AS role
from doctors

select
	allergies,
    count(*) as total_diagnosis
from patients
Where allergies is not null
group by allergies
order by total_diagnosis desc

select
	first_name,
    last_name,
    birth_date
from patients
where
	year(birth_date) between 1970 AND 1979
order by birth_date

select
	concat(upper(last_name),',',lower(first_name)) as full_name
from patients
order by first_name desc

select
	province_id,
    SUM(height) as total_height
from patients
group by province_id
having total_height >= 7000

select
	(max(weight) - min(weight)) as weight_delta
from patients
where last_name = 'Maroni'

select
	day(admission_date) as day_num,
    COunt(*) as num_admissions
from admissions
group by day_num
order by num_admissions desc

select *
from admissions
where 
	patient_id = 542
group by patient_id
having
	admission_date = max(admission_date)
    
-- Review this question med 18
select
	patient_id,
    attending_doctor_id,
    diagnosis
from admissions
where
	(
      patient_id % 2 != 0 
      AND attending_doctor_id IN (1,5,19)
    ) 
    OR
    (
      attending_doctor_id LIKE '%2%' 
      AND len(patient_id) = 3
    )
    
select 
	doc.first_name,
    doc.last_name,
    count(*) as total_attended
from admissions as adm
join doctors as doc
	on adm.attending_doctor_id = doc.doctor_id
group by adm.attending_doctor_id

select 
	doc.doctor_id,
    concat(doc.first_name, ' ', last_name) AS full_name,
    Min(admission_date) as first_admission,
    max(admission_date) AS last_admission
from admissions as adm
join doctors as doc
	on adm.attending_doctor_id = doc.doctor_id
group by full_name

select
	prov.province_name,
	count(*) as total_patients
From patients pat
join province_names prov
	on pat.province_id = prov.province_id
group by prov.province_name
order by total_patients desc

select
	concat(pat.first_name, ' ', pat.last_name) as patients_fullname,
    diagnosis,
    concat(dr.first_name, ' ', dr.last_name) AS dr_fullname
from patients pat
join admissions ad
	on pat.patient_id = ad.patient_id
join doctors dr
	on ad.attending_doctor_id = dr.doctor_id

select
	first_name,
    last_name,
    Count(*) as num_duplicates
from patients
group by 
	first_name, 
    last_name
having 
	Count(*) > 1
    
select
	concat(first_name, ' ', last_name) as patients_fullname,
    round(height / 30.48 , 1) as 'height in "feet"',
    round(weight * 2.205) As 'weight in "Pounds"',
    birth_date,
    case
    	when gender = 'M' Then 'MALE'
        else 'FEMLAE'
    end as gender_long
from patients
------------------------------------------
--Starting of the hard questions

select 
	count(*) as patients_in_group,
	floor(weight /10) * 10 as weight_group    
from patients
group by weight_group
order by weight_group desc

select 
	patient_id,
    weight,
    height,
    
    (case
    	WHEn weight / (power(height / 100.0,2) ) >= 30 Then 1
        else 0
    end) as isObese
From patients

select
	pat.patient_id,
    pat.first_name,
    pat.last_name,
    dr.specialty
from patients pat
join admissions adm on pat.patient_id = adm.patient_id
join doctors dr on adm.attending_doctor_id = dr.doctor_id
where
	adm.diagnosis = 'Epilepsy' 
    AND dr.first_name = 'Lisa'
    
select
	DISTINCT pat.patient_id,
    concat(pat.patient_id,LEN(pat.last_name),year(pat.birth_date)) AS temp_password
From patients pat
join admissions adm
	on pat.patient_id = adm.patient_id

select
    (case
     	when patient_id % 2 = 0 then 'Yes'
     	else 'No'
     END) as has_insurance
from admissions
group by has_insurance

select
	(case WHEN patient_id % 2 = 0 then 'Yes'
         else 'No'
     END) as has_insurance,
    sum(case when patient_id % 2 = 0 Then 10
        else 50
        end) as admission_total
From admissions
group by has_insurance


