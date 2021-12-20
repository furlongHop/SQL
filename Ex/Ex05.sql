/*join*/
--table 두 개를 잇는 것

--카티전 프로덕트(Cartesian Product): 두 릴레이션을 그대로 합한 것
--column: 15개(4+11), row: 2889개(27*107)
select * 
from employees, departments;

--c04 r27
select * 
from departments;

--c11 r107
select * 
from employees;

--join 조건을 올바르게 기입
select  employee_id,
        first_name,
        salary,
        department_name
from employees, departments
where employees.department_id = departments.department_id;
--employees의 department_id랑 departments의 department_id가 같을 경우에만 출력한다.

--join 오류 잡기(두 테이블을 합쳤을 경우 발생할 수 있는 오류)
--합친 테이블 양쪽 모두 포함한 컬럼일 경우 어느 쪽 컬럼인지 명확히 표기해야 한다.
--단, 테이블 한 곳에만 존재하는 컬럼일 경우 포함된 테이블명을 표기하지 않아도 된다.
select  employee_id, --이 경우에도 정확히 표기하려면 employees.employee_id라고 쓰는 게 맞다.
        first_name,
        salary,
        department_name,
        employees.department_id,--department_id는 employees 테이블에도 deprtments 테이블에도 존재한다.
        departments.department_id --어떤 테이블에 속한 department_id인지 정확하게 명시해줘야 오류가 나지 않는다.
from employees, departments
where employees.department_id = departments.department_id;

--테이블에 별명 붙이기
select  employee_id, 
        first_name,
        salary,
        department_name,
        em.department_id,
        de.department_id 
from employees em, departments de --테이블 이름이 너무 길 경우 별명을 지어준다.(as 붙이면 오류 발생. 주의)
where em.department_id = de.department_id; --별명을 붙였을 경우 별명으로 표기해야 한다.

--모든 직원이름, 부서이름, 업무명 을 출력하세요
select  em.first_name,
        de.department_name,
        j.job_title
from employees em, departments de, jobs j
where em.department_id = de.department_id
and em.job_id = j.job_id;

--106개>null이 1개 있다는 의미
select  count(*)
from employees em, departments de, jobs j
where em.department_id = de.department_id
and em.job_id = j.job_id;