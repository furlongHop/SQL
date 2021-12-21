--(Ex05+Ex06)
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

--equi join=inner join
--Equal 연산자(=)를 이용하여 양쪽에 다 존재하는 값만 결과로 출력하는 join
--테이블에 별명 붙이기
select  employee_id, 
        first_name,
        salary,
        department_name,
        em.department_id,
        de.department_id 
from employees em, departments de --테이블 이름이 너무 길 경우 별명을 지어준다.(as 붙이면 오류 발생. 주의)
where em.department_id = de.department_id; --별명을 붙였을 경우 별명으로 표기해야 한다.
--employees의 department_id를 보는 게 아니라 새로 이름을 붙인 em의 department_id를 보고 있기 때문이다. 

--모든 직원이름, 부서이름, 업무명을 출력하세요
select  em.first_name,
        de.department_name,
        jo.job_title
from employees em, departments de, jobs jo
where em.department_id = de.department_id
and em.job_id = jo.job_id;

--106개>null이 1개 있다는 의미
select  count(*)
from employees em, departments de, jobs j
where em.department_id = de.department_id
and em.job_id = j.job_id;

--outer join: 어느 한 쪽의 데이터를 모두 출력(조건에 맞지 않는 데이터는 null로 표기)
--left outer join: 왼쪽에 있는 데이터 전부 출력
select  em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_name
from employees em left outer join departments de
on em.department_id = de.department_id;

--전부 출력을 명한 데이터가 아닌 데이터쪽에 (+)표기(oracle 문법)
select  *
from employees em, departments de
where em.department_id = de.department_id(+);
--and em.employee_id = 178; --부서 아이디 등 null이 포함된 직원의 직원 아이디

--right outer join
select  em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_name
from employees em right outer join departments de
on em.department_id = de.department_id;--사용되지 않고 있는 16개 부서(직원 없음)도 null로 출력

--oracle 문법: null 표기가 출력되는 쪽에 (+)를 붙인다.
select * 
from employees em, departments de
where em.department_id(+) = de.department_id;

--right outer join > left outer join
select  em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_name
from departments de, employees em
where de.department_id = em.department_id(+);
/*
 department_id와 department_name는 총 27종이지만 그 중 16개는 사용되지 않는다. (직원이 존재하지 않는다.) 
 따라서 employee를 기준으로 join한 것을 department 기준으로 바꾸면(employee 전부 출력>department 전부 출력)
 직원이 존재하지 않는 department_id와 department_name 항목도 전부 출력된다.
 이때 직원이 없는 부서 아이디, 즉 employee의 em.department_id는 존재하지 않지만(null)
 부서 테이블의 부서 아이디, de.department_id는 전부 출력을 명령받았으므로 null이 아닌 실제 값이 출력된다. 
 */


--full outer join: 양쪽 데이터 모두 출력
select  em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_name
from employees em full outer join departments de
on em.department_id = de.department_id;--oracle 문법 (+)으로는 불가능하다.

--self join: 같은 내용을 가진 두 데이터를 다른 별명을 붙여 새로 메모리에 로딩, 출력
select  em.employee_id,
        em.first_name,
        em.salary,
        em.phone_number,
        em.manager_id,
        ma.employee_id,
        ma.first_name,
        ma.phone_number,
        ma.email
from employees em, employees ma -- self join 때는 같은 테이블을 사용하므로 별명이 필수
where em.manager_id = ma.employee_id;

/*
1. 해당 직원의 담당 매니저 정보도 직원 정보와 같은 행에 출력되길 원함.
2. em 테이블 복사, manager용 employee 테이블도 복사하여 ma라는 별명을 붙여줌.
3. 직원 출력용 employee em 테이블에서의 매니저 아이디, 
매니저 출력용 employee ma 테이블에서의 직원 아이디를 where 조건절로 같다고 둔다.
-->매니저도 결국 직원이므로 ma 테이블의 직원 아이디를 사용해야 한다.
-->같은 테이블 속 정보를 같은 행에 출력하고 싶을 경우 self join 사용.
-->어떤 조건을 같다고 둬야 할지 잘 생각해보기!
*/

--문법적 오류는 없으나 논리적으로 맞지 않는 조인. 우연의 일치로 조인을 사용하는 일이 없도록 하자.
select  em.employee_id,
        em.first_name,
        em.salary,
        lo.location_id,
        lo.city
from employees em, locations lo
where em.salary = lo.location_id;