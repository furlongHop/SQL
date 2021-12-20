/*group by 절*/
select  department_id,
        avg(salary) 
from employees
group by department_id
order by department_id asc; --정렬하는 건 보기에 깔끔하지만 자원이 많이 사용된다.
--따라서 테스트 시에는 종종 제외하고 돌리기도 한다. (정렬: 주로 오류 여부 확인에 이용된다.)
--블록 단위로 드래그하여 특정 부분만 돌릴 수 있다.

select  department_id,
        count(*),
        avg(salary)
from employees
group by department_id;

select  department_id,
        job_id,
        count(*),
        avg(salary)
from employees
group by department_id, job_id --(1차)부서별로 묶은 뒤 그 안에서 다시 (2차)업무별로 그룹
order by department_id, --정렬 시 asc,desc 미표기>자동으로 asc 정렬
job_id desc; --부서 아이디를 오름차순으로 먼저 정렬한 뒤, 같은 부서 아이디를 가진 업무는 업무 아이디 기준 내림차순으로 정렬

--연봉(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 급여합계를 출력하세요
select  department_id,
        count(*),
        sum(salary)
from employees
--where sum(salary) >= 20000 : where절은 group 함수와 함께 쓸 수 없다.
group by department_id;

select  department_id,
        count(*),
        sum(salary)
from employees
group by department_id
having sum(salary) >= 20000; --having 절: group 함수 전용 조건절

--조건절: ,가 아니라 and나 or로 조건을 다수 걸 수 있다.


/*CASE~END문*/
--when 조건절을 각각 다르게 적용하기
select  employee_id,
        first_name,
        salary,
        job_id,
        case when job_id = 'AC_ACCOUNT' then salary + salary*0.1
             when job_id = 'SA_REP' then salary + salary*0.2
             when job_id = 'ST_CLERK' then salary + salary*0.3        
             else salary
        end realSalary --조건절로 나온 계산 결과 값의 이름(임의로 지어준 컬럼명)
from employees;

--DECODE(): true, false 함수
select  employee_id,
        first_name,
        salary,
        job_id,--↓조건을 적용시킬 기준 column명(case~end문과 달리 한 번만 표기)
        decode( job_id, 'AC_ACCOUNT', salary + salary * 0.1,
                        'SA_REP',     salary + salary * 0.2,
		                'ST_CLERK',   salary + salary * 0.3,
            salary)as realSalary --else)as column name
from employees;

/*직원의 이름, 부서, 팀을 출력하세요. 팀은 코드로 결정하며 
부서코드가 10~50 이면 ‘A-TEAM’,
60~100이면 ‘B-TEAM’,  
110~150이면 ‘C-TEAM’, 
나머지는 ‘팀없음’ 으로 출력하세요.*/
select  first_name,
        department_id,
        case when department_id >= 10 and department_id <=50 then 'A-TEAM'
             when department_id >= 60 and department_id <=100 then 'B-TEAM'
             when department_id >= 110 and department_id <=150 then 'C-TEAM'
             else '팀없음'
        end as team
from employees;

