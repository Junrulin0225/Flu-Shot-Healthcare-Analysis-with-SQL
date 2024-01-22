SELECT * FROM public.immunizations


SELECT * 
FROM encounters
WHERE encounterclass IN ('inpatient','ambulatory')



SELECT description,
	COUNT(*) AS counst_of_cond
FROM PUBLIC.conditions
WHERE description != 'Body Mass Index 30.0-30.9, adult'
GROUP BY description
HAVING COUNT(*) > 5000
ORDER BY counst_of_cond DESC


SELECT * FROM patients
WHERE city = 'Boston'


SELECT *
FROM PUBLIC.conditions
WHERE code IN ('585.1', '585.2', '585.3', '585.4')


------------------
-- This query gives me the count of all patients
------------------
SELECT city, COUNT(city)
FROM patients
WHERE city != 'Boston'
GROUP BY city
HAVING count(city) >= 100
ORDER BY count desc



SELECT t2.first,
	t2.last,
	t2.birthdate,
	t1.*
	
FROM public.immunizations AS t1
LEFT JOIN public.patients AS t2
on t1.patient = t2.id


/*
Objectives
Create a flu shots dashboard for 2022 that does the following
1.) Total % of patients getting flu shots stratified by
	a.) Age
	b.) Race
	c.) County (on a map)
	d.) overall
2.) Running Total of Flu Shots over the course of 2022
3.) Total number of Flu shots given in 2022
4.) A list of patients that show whether or not they received the flu shots

Requirements
Patients must have "Active at our hospital" (should kick out thr patients that are not alive, coming,...)

*/
select * from encounters

with active_patient as 
(	
	select patient
	from encounters as e
	join patients as pat
	on e.patient = pat.id
	where start between '2020-01-01 00:00' and '2022-12-31 23:59'
	and pat.deathdate is null
	and extract (month from age('12-31-2022', pat.birthdate)) >=6
),

flu_shot_2022 as
(
select distinct patient, min(date) as earliest_flu_shot_2022
from immunizations
where code = '5302'
and date between '2022-01-01 00:00' and '2022-12-31 23:59'
group by patient
	)
	
select pat.birthdate,
		pat.race,
		pat.county,
		pat.id,
		pat.first,
		flu.earliest_flu_shot_2022,
		flu.patient,
		case when flu.patient is not null then 1 else 0
		end as flu_shot_2022
from patients as pat

left join flu_shot_2022 as flu
	on pat.id = flu.patient
where 1=1
	and pat.id in (select patient from active_patient)
			  
			  
			  
			  
			  
			  
			  
			  
			  
			  
			  
			  
			  
			  
			  
			  
			  
			  
			  
