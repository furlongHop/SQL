--문제 1.
select  count(salary) 
from employees
where salary < (select avg(salary)
                 from employees);
                 
--문제 2.
select  employee_id,
        first_name,
        salary
from employees
where salary >= (select avg(salary)
                 from employees)
and salary <= (select max(salary)
               from employees)
order by salary asc;

--문제 3.
select  lo.location_id,
        lo.street_address,
        lo.postal_code,
        lo.city,
        lo.state_province,
        lo.country_id
from locations lo, departments de
where department_id = (select department_id
                      from employees
                      where first_name = 'Steven'
                      and last_name = 'King')
and lo.location_id = de.location_id;

--문제 4.
select  employee_id,
        first_name,
        salary
from employees
where salary < any(select salary
                from employees
                where job_id = 'ST_MAN')
order by salary desc;

--문제 5.
--1) 조건절 비교
select  employee_id,
        first_name,
        salary,
        department_id
from employees
where (salary,department_id) in (select max(salary),
                                        department_id
                                 from employees
                                 group by department_id)
order by salary desc;

--2) 테이블 조인
select  em.employee_id,
        em.first_name,
        em.salary,
        di.department_id,
        di.ms        
from employees em ,(select  max(salary) ms,
                              department_id
                      from employees
                      group by department_id)di
where em.department_id = di.department_id
and em.salary = di.ms
order by em.salary desc;


--문제 6.
select  mst.job_id,
        jo.job_title,
        sums --'각 업무별' 연봉 총합
from jobs jo, (select  job_id, --해당 연봉 총합이 어느 업무의 것인지 명시
                       sum(salary) sums
               from employees
               group by job_id --업무 별로 묶기
                )mst
where jo.job_id = mst.job_id --하나하나 확인하는 과정에서 정렬이 엉망이 되므로 정렬은 마지막에!
order by sums desc; --연봉 총합 순으로 정렬


                                
--문제 7.
select  em.employee_id,
        em.first_name,
        em.salary --직원의 급여이므로 em 테이블의 salary
from employees em, (select  department_id, avg(salary) asa --부서별 평균 급여
                    from employees
                    group by department_id --부서별로 묶는다
                    )t
where em.department_id = t.department_id --두 테이블의 중복 제거(필요한 것끼리만 묶는다)
and em.salary > t.asa; --해당 직원이 속한 부서의 평균 급여보다 직원의 급여가 높다


--문제 8.
select  r,
        employee_id,
        first_name,
        salary,
        hire_date
from (select  rownum r, employee_id, first_name, salary, hire_date
      from (select  employee_id, first_name, salary, hire_date
            from employees
            order by hire_date asc)
     )
where r <= 15
and r >= 11;


