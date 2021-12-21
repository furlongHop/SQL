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
                


/*다중행 SubQuery*/  
--결과값이 두 줄 이상일 경우(혹은 없거나, 결과 개수를 예측할 수 없을 때) 사용하는 subquery
--단일행 subquery: 반드시 결과값이 한 줄이다.

--1.부서번호가 110인 직원의 급여 리스트
select  employee_id,
        first_name,
        salary,
        department_id
from employees
where department_id = 110;

/*
--'or'로 묶는다.
110	Shelley	12008> salary가 12008인 직원
110	William	8300> salary가 8300인 직원
*/
   
--2. 급여를 12008 or 8300 받는 직원 리스트
--방식 1)
select  employee_id,
        first_name,
        salary
from employees
where salary = 12008
or salary = 8300;

--방식 2)
select  employee_id,
        first_name,
        salary
from employees
where salary in (12008, 8300);

/*
--조건에 충족하는 직원 총 3명
108	Nancy	12008
205	Shelley	12008
206	William	8300
*/

--3. 부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력(두 식을 조합)
select  employee_id,
        first_name,
        salary
from employees
where salary in (select salary
                 from employees
                 where department_id = 110);--in(select문 입력)
-->in자리에 =,<,> 사용 불가. 논리적으로 맞지 않는다. 

--각 부서별로 최고 급여를 받는 사원을 출력하세요.
--1. 각 부서의 최고 급여 리스트
--first_name은 표현할 수 없다.
select  department_id,
        max(salary) 
from employees
group by department_id
order by department_id asc;

/*
부서 아이디를 아용해 각 부서의 최고 급여를 알아낸 다음,
최고 급여와 동일한 급여를 받는 직원을 찾아내 부서별 최고 급여 직원 리스트를 뽑는다.
이 방법은 일일이 확인해야할 뿐만 아니라 급여만 같은 다른 부서 아이디의 결과도 도출된다.
결국 정확한 값을 얻기 위해서는 최고 급여와 해당 부서 아이디, 총 두 가지 정보(조건)가 필요하다.
*/

--2. 식 합치기
--1) 이 경우, 최고 급여와 급여가 동일하기만 할 뿐인 직원 정보도 출력된다.(다른 부서 아이디)
select  first_name,
        salary,
        department_id
from employees
where salary in (select max(salary)
                 from employees
                 group by department_id);
--where 조건절 속 select문을 출력하면 부서별 최고 급여만 출력된다.
--즉, (부서별)'최고 급여'만 조건으로 인식된다.

--2)where절 작성시 주의사항: 괄호, 순서, 들여쓰기
select  first_name,
        salary,
        department_id
from employees
where (department_id, salary) in (select department_id,
                                         max(salary)
                                  from employees
                                  group by department_id);
--where 조건절 속 select문을 출력하면 부서 아이디와 해당 부서의 최고 급여가 출력된다.
--즉, '해당 부서의 최고 급여'가 조건이 된다.
                                
/*
그룹(부서)별 최고 급여> 사원 테이블에서 그룹(부서) 번호와 급여가 같은 직원을 구한다.(조건 2개)
1. 최고 급여 2. 부서 번호
*/

--any 연산자
/*부서번호가 110인 직원의 급여 보다 큰 모든 직원의 
사번, 이름, 급여를 출력하세요.(or연산--> 8300보다 큰)*/

--1. 부서 번호가 110인 직원의 급여 리스트
select  employee_id,
        first_name,
        salary
from employees
where department_id = 110;

--2. 부서 번호가 110인 직원보다 급여가 큰 직원 리스트(12008,8300보다 큰 급여)
select  employee_id,
        first_name,
        salary
from employees
where salary > 12008
or salary > 8300;

--3. 두 식 조합(any: or),두 조건의 합집합
select  employee_id,
        first_name,
        salary
from employees
where salary > any (select salary
                    from employees
                    where department_id = 110);
                    
--all 연산자
/*부서번호가 110인 직원의 급여 보다 큰 모든 직원의 
사번, 이름, 급여를 출력하세요.(and연산--> 12008보다 큰)*/

--1. 부서 번호가 110인 직원의 급여 리스트
select  employee_id,
        first_name,
        salary
from employees
where department_id = 110;

--2. 부서 번호가 110인 직원보다 급여가 큰 직원 리스트(12008과 8300보다 큰 급여)
--즉 12008보다 수가 큰 급여를 구하는 것. 두 조건의 교집합.
select  employee_id,
        first_name,
        salary
from employees
where salary > 12008
and salary > 8300;

--3.조합(all: and)
select  employee_id,
        first_name,
        salary
from employees
where salary > all (select salary
                    from employees
                    where department_id = 110);
        