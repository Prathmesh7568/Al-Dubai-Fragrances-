	--1.Load_data
USe _hr

--2.Find the number of employees working in the ‘Sales’ department. (Use sub-query).

with abc as (
Select e.EMPLOYEE_ID,d.DEPARTMENT_NAME 
From department_data d join employees_data e
on d.DEPARTMENT_ID=e.DEPARTMENT_ID)

select EMPLOYEE_ID,DEPARTMENT_NAME 
from abc
where DEPARTMENT_NAME= 'Sales';

--3.Join the 3 tables and find the country-id wise count of employees and the avg salary. Which country has the maximum number of employees and which country has the maximum average salary?

with a as(
Select e.EMPLOYEE_ID,avg(e.SALARY)  avg_salary,l.COUNTRY_ID
From department_data d join employees_data e
on d.DEPARTMENT_ID=e.DEPARTMENT_ID
join locations_data_u l
on d.LOCATION_ID=l.LOCATION_ID)  

select COUNTRY_ID , max(EMPLOYEE_ID) , max(avg_salary)
from a
group by COUNTRY_ID;


 --4.Find the top 5 managers according to their salary.

Select e.FIRST_NAME,e.LAST_NAME, d.MANAGER_ID,e.SALARY
From department_data d join employees_data e
on d.DEPARTMENT_ID=e.DEPARTMENT_ID
group by 1,2
having max(SALARY) 
order by SALARY desc
limit 5 ;

--5.Find the department name-wise percentage of employees working under each department. Which department is having the maximum percentage of employees?

with employee as(
select b.DEPARTMENT_NAME as dept_name , count(a.EMPLOYEE_ID)as num_emp from employees_data as a
join department_data as b  
	on a.DEPARTMENT_ID=b.DEPARTMENT_ID
group by b.DEPARTMENT_NAME)

select dept_name,round(num_emp / sum(num_emp) over() * 100,2) as per_emp_dept from employee
group by dept_name 
order by per_emp_dept desc;


--6 Find the number of people working under each manager

select MANAGER_ID ,count(EMPLOYEE_ID) as cnt from employees_data
group by MANAGER_ID order by cnt desc;


--7 Find the eomployees First_name ,DEPARTMENT, and country_id of employees whose salary is greater than equal to 12000

select e.First_NAME,d.DEPARTMENT_NAME,l.COUNTRY_ID,e.SALARY from employees_data as e
join department_data as d
	on d.DEPARTMENT_ID=e.DEPARTMENT_ID
	join locations_data_u l
		on d.LOCATION_ID=l.LOCATION_ID
where SALARY >=12000
group by 1,2
order by SALARY desc;


