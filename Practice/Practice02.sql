--문제 1.
select  count(*) as "haveMngCnt"
from employees
where manager_id is not null;

--문제 2.
select  max(salary) as "최고 임금",
        min(salary) as "최저 임금",
        max(salary)-min(salary) as "최고임금 - 최저임금"
from employees;

--문제 3.
select  to_char(max(hire_date),'YYYY"년" MM"월" DD"일"')
from employees;

--문제 4.
select  department_id,
        avg(salary),
        max(salary),
        min(salary)
from employees
group by department_id
order by department_id desc;

--문제 5.
select  job_id,
        avg(salary),
        max(salary),
        min(salary)
from employees
group by job_id
order by min(salary) desc, round(avg(salary)) asc;

--문제 6.
--가장 오래 근속한 직원 = 입사일이 가장 오래된 직원
select  to_char(min(hire_date),'YYYY-MM-DD day')
from employees;

--문제 7.
select  department_id,
        avg(salary),
        min(salary),
        avg(salary)-min(salary)
from employees
group by department_id
having avg(salary)-min(salary) < 2000
order by avg(salary)-min(salary) desc;

--문제 8.
select  max(salary)-min(salary) 
from employees
group by job_id
order by max(salary)-min(salary) desc;

--문제 9.
select  avg(salary),
        min(salary),
        max(salary)
from employees
group by manager_id
having avg(salary) >= 5000
order by round(avg(salary),0) desc;

--문제 10.
/*아래회사는 보너스 지급을 위해 직원을 입사일 기준으로 나눌려고 합니다. 
입사일이 02/12/31일 이전이면 '창립맴버, 03년은 '03년입사’, 04년은 ‘04년입사’ 
이후입사자는 ‘상장이후입사’ optDate 컬럼의 데이터로 출력하세요.
정렬은 입사일로 오름차순으로 정렬합니다.
*/
select  first_name, 
        case when hire_date <= '02/12/31' then '창립멤버'
             when hire_date <= '03/12/31' then '03년입사'
             when hire_date <= '04/12/31' then '04년입사'
             else '상장이후입사'
        end optDate
from employees
order by hire_date asc;