--subquery:하나의 SQL 질의문 속에 다른 SQL 질의문이 포함되어 있는 형태

--1)전체 Query문 구조
select  first_name,
        salary
from employees
where salary >= 'Den의 급여';
--Q.Den의 급여를 따로 찾아 숫자 형식으로 조건문에 달아도 되지 않을까?
--A.하지만 Den의 급여가 오른다면? Den보다 급여를 더 받는 사람을 매번 새로 구해야할지도 모른다.

--2) Den의 급여
select  salary
from employees
where first_name = 'Den';

--3) subquery 추가, Query문 완성 (들여쓰기 주의)
select  salary
from employees
where salary >= (select salary 
                 from employees
where first_name = 'Den');


--급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
select  first_name,
        salary,
        employee_id
from employees
where salary = (select min(salary)
                from employees);

SELECT min(salary)
FROM employees;
    
--평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요.
select  first_name,
        salary
from employees
where salary < (select avg(salary)
                from employees);