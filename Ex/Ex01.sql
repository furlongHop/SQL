/*
<여러 줄 짜리 주석>
select 문
    select 절
    from 절;
*/

--한 줄 짜리 주석

--직원 table 전체 조회(*=전체 조회)
select * from employees;

--부서 테이블 전체 조회
select * 
from departments;

--원하는 특정 컬럼만 조회
select  employee_id,
        first_name,
        last_name
from employees;


select first_name,
       phone_number,
       hire_date,
       salary 
from employees;

--출력할 컬렴명 별명 적용하기
--특수문자(띄어쓰기 포함)는 오류가 나므로 쌍따옴표를 붙여 사용한다.
--대소문자 구별 또한 쌍따옴표로 구별하게 만든다.
--as를 생략해도 괜찮다.

select  employee_id as empNo,
        first_name as "f-name",
        salary as "연 봉"
from employees;


select  first_name as 이름,
        phone_number as 전화번호,
        hire_date as 입사일,
        salary as 급여
from employees;

select  employee_id as 사원번호,
        first_name as 이름,
        last_name as 성,
        salary as 급여,
        phone_number as 전화번호,
        email as 이메일,
        hire_date as 입사일
from employees;


--연결 연산자로 컬럼들 붙이기
select  first_name, last_name
from employees;

select  first_name || last_name
from employees;

--띄어쓰기 ||와 || 사이에 무언가 넣을 때는 따옴표를 쓴다.
select  first_name || ' ' || last_name
from employees;

select  first_name || ' ' || last_name as name
from employees;

select  first_name ||' hire date is '|| hire_date
from employees;

--산술 연산자 사용하기
select  first_name,
        salary,
        salary /*같은 칼럼명 사용 가능,출력시 시스템이 자동으로 이름(실제x보이는 것)을 바꾼다.*/
from employees;

select  first_name,
        salary as 월급,
        salary*12 as 연봉,/*계산도 가능*/
        (salary+300)*12
from employees;

select job_id*12 --jod_id가 숫자가 아니므로 오류가 난다.
from employees;

select  first_name||'-'||last_name "성명" ,
        salary as "급 여",
        salary*12 as 연봉,
        (salary*12)+5000 as 연봉2,
        phone_number as 전화번호
from employees;

/*where 절*/
--비교연산자
select  first_name, 
        last_name,
        salary,
        department_id
from employees
where department_id > 10;

select  first_name,
        salary
from employees
where salary*12 >= 5000;

select  first_name,
        hire_date
from employees
where hire_date > '07/01/01'; --'07-01-01' 이런 형식도 가능하다.

select salary*12
from employees
where first_name = 'Lex';

select  first_name,
        salary
from employees
where salary >=14000
and salary <=17000;

--between(이상, 이하의 의미>초과, 미만 표현 불가),부등호보다 속도가 느리다
select  first_name,
        salary
from employees
where salary between 14000 and 17000
;

--IN 연산자로 여러 조건을 검사하기
select  first_name,
        last_name,
        salary
from employees
where first_name = 'Neena'
or first_name = 'Lex'
or first_name = 'John';

select  first_name,
        last_name,
        salary
from employees
where first_name in ('Neena','Lex','John');

select  first_name,
        salary
from employees
where salary in (2100,3100,4100,5100);

/*
''안에 넣으면 문자가 된다. 숫자 기입시 주의.
select  first_name,
        salary
from employees
where salary in ('2100','3100','4100','5100');
*/


SELECT  first_name,
        hire_date
FROM employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31';

--Like 연산자로 비슷한 것들 모두 찾기
select  first_name,
        last_name,
        salary
from employees
where first_name like 'L%' --L로 시작하는 이름
;

select  first_name,
        salary
from employees
where first_name like '%am%' --위치 상관없이 am이 들어가는 이름
;

select  first_name,
        salary
from employees
where first_name like '_a%' --두 번째 글자가 a인 이름
;

select   first_name,
        salary
from employees
where first_name like '___a%' --네 번째 글자가 a인 이름
;

select first_name
from employees
where first_name like '__a_'; --이름이 네 글자인 이름 중 끝에서 두 번째 글자가 a인 사람

/*
_: 한 글자 짜리 공간, %:어떤 글자가 몇 글자가 오든 상관없음 
*/

--NULL을 포함한 산술식은 NULL
select  first_name, 
        salary, 
        commission_pct, 
        salary*commission_pct --Michael commission_pct가 null이므로 이 값 또한 null
from employees
where salary between 13000 and 15000;

--영업 수익을 가진 영업부 목록 불러오기
select * 
from employees
where commission_pct is null;


--커미션비율이 있는 사원의 이름과 연봉 커미션 비율을 출력하세요
select  first_name,
        salary,
        commission_pct
from employees
where commission_pct is not null;

--담당매니저가 없고 커미션 비율이 없는 직원의 이름을 출력하세요
select first_name
from employees
where manager_id is null
and commission_pct is null;

/*ORDER BY 절(특정 기준으로 순서 정렬)*/
select * 
from employees
order by salary desc --내림차순
;

select * 
from employees
order by salary asc --오름차순
;

--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select  department_id,
        salary,
        first_name
from employees
order by department_id asc
;

--급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select  first_name,
        salary
from employees
where salary >= 10000
order by salary desc;

--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요  
select  department_id,
        salary,
        first_name
from employees
order by department_id asc, salary desc;