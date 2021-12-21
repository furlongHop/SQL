--문제 1.
select  em.employee_id,
        em.first_name,
        de.department_name
from employees em, departments de
where em.department_id = de.department_id
order by de.department_name asc, em.employee_id desc;

--문제 2.
select  em.employee_id,
        em.first_name,
        em.salary,
        de.department_name,
        jo.job_title
from employees em, departments de, jobs jo
where em.department_id = de.department_id
and em.job_id = jo.job_id
order by em.employee_id asc;

--문제 2-1)left outer  join
select  em.employee_id,
        em.first_name,
        em.salary,
        de.department_name,
        jo.job_title
from employees em, departments de, jobs jo
where em.department_id = de.department_id(+)
and em.job_id = jo.job_id
order by em.employee_id asc;

--문제 3.
select  co.country_id,
        co.country_name,
        de.department_name,
        de.department_id
from departments de, locations lo, countries co
where de.location_id = lo.location_id
and lo.country_id = co.country_id
order by co.country_id asc;

--문제 3-1)
select  co.country_id,
        co.country_name,
        de.department_name,
        de.department_id
from departments de, locations lo, countries co
where de.location_id(+) = lo.location_id
and lo.country_id = co.country_id
order by co.country_id asc;

--문제 4.
select  re.region_name,
        co.country_name
from countries co, regions re
where co.region_id = re.region_id
order by re.region_name asc, co.country_name desc;

--문제 5.
select  em.employee_id,
        em.first_name,
        em.hire_date,
        ma.first_name maNAmae,
        ma.hire_date maHireDate
from employees em, employees ma
where em.hire_date < ma.hire_date--직원 입사일이 매니저 입사일보다 더 빠름(숫자 크기가 작음)
and em.manager_id = ma.employee_id;--직원의 담당 매니저 아이디와 매니저의 직원 아이디가 일치

--문제 6.
select  co.country_name,
        co.country_id,
        lo.location_id,
        de.department_name,
        de.department_id
from departments de, locations lo, countries co
where de.location_id = lo.location_id
and lo.country_id = co.country_id
order by co.country_name asc;

--문제 7.
select  jh.employee_id,
        em.first_name||' '||last_name as name,
        jh.job_id,
        jh.start_date,
        jh.end_date
from employees em, job_history jh
where jh.job_id = 'AC_ACCOUNT'
and em.employee_id = jh.employee_id;

--문제 8.
select  de.department_id,
        de.department_name,
        ma.first_name,
        lo.city,
        co.country_name,
        re.region_name
from employees ma, departments de, locations lo, countries co, regions re
where de.manager_id = ma.employee_id
and de.location_id = lo.location_id
and lo.country_id = co.country_id
and co.region_id = re.region_id;

--문제 9.
select  em.employee_id,
        em.first_name,
        de.department_name,
        ma.first_name as maNAme
from employees em, employees ma, departments de
where em.manager_id = ma.employee_id
and em.department_id = de.department_id(+);