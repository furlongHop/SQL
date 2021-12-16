/*그룹함수*/

--오류 발생: 출력을 명령한 컬럼이 가진 row 개수가 맞지 않기 때문이다.
select  avg(salary), --급여의 평균(row:1개)
        first_name --급여의 평균은 한 칸, 직원은 107칸을 차지하기 때문에 함께 출력할 수 없다.
from employees;

--그룹함수 avg():평균 구하기
select  round(avg(salary))
from employees;

--그룹합수 count():개수 구하기(null 값 제외)
select  count(*),
        count(commission_pct),--commission_pct 중 null이 아닌 유효한 값의 개수를 세어준다. 
        count(department_id)
from employees;

select  count(salary) --salary를 가진 row 수 출력
from employees
where salary > 16000; --where 조건절로 인해 salary가 16000을 넘는 직원 한정

--부서 번호가 100인 직원의 수를 세시오.
select count(department_id)
from employees
where department_id = 100;

--그룹함수 sum()
select sum(salary), count(*), avg(salary) 
from employees;

select sum(salary), count(*), avg(salary) 
from employees
where salary > 16000;

--그룹함수 avg(): null 값이 있을 경우 제외한다.
select  sum(salary), 
        count(*), 
        avg(salary) 
from employees;

select  count(*),
        sum(salary),
        avg(nvl(salary,0)) --null 값을 포함한 경우도 평균 계산 때 필요할 경우: null을 0으로 변환 후 계산
from employees;

--그룹함수 -max()/min() :최댓값 최소값 구하기
select  count(*),
        max(salary),
        min(salary)
from employees;


/*group by*/
select avg(salary)
from employees
group by department_id;
