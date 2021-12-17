--문제 1.
select  first_name||' '||last_name as "이름",
        salary as "월급",
        phone_number as "전화번호",
        hire_date as "입사일"
from employees
order by hire_date asc;

--문제 2.
select  job_title as "업무 이름",
        max_salary as "최고 월급"
from jobs
order by max_salary desc;

--문제 3.
select  first_name,
        manager_id,
        commission_pct,
        salary
from employees
where manager_id is not null 
and commission_pct is null
and salary > 3000;

--문제 4.
select  job_title,
        max_salary
from jobs
where max_salary >= 10000
order by max_salary desc
;

--문제 5.
select  first_name,
        salary,
        nvl(commission_pct,0)
from employees
where salary < 14000
and salary >= 10000
order by salary desc;

--문제 6.
select  first_name,
        salary,
        to_char(hire_date,'YYYY-MM'),
        department_id
from employees
where department_id = 10
or department_id = 90
or department_id = 100;

--문제 7.
select  first_name,
        salary
from employees
where first_name like 'S%'
or first_name like '%s%';

--문제 8.
select department_name 
from departments
order by length(department_name) desc;

--문제 9.
select upper(country_name) 
from countries
order by country_name asc;

--문제 10.
select  first_name,
        salary,
        replace(phone_number,'.','-'),
        hire_date
from employees
where hire_date < '03/12/31';