/*rownum*/

--Q)급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
--접근 1) 최고 급여와 최고 급여를 받는 사람
select  max(salary)
from employees;
/*최고 급여는 24000이지만 그 급여를 받는 사람의 정보(first_name)는 알 수 없다.
max()는 그룹 함수로 결과가 1개지만 직원 정보는 107개이기 때문이다.*/

--접근 2) 최고 급여인 24000을 받는 사람
select first_name 
from employees
where salary = 24000;
/*접근 1)에서 얻어낸 최고 급여를 where 조건절에 넣어 최고 급여를 받는 사람의 이름을 얻는다.*/

--접근 3) '최고 급여' 자체를 조건절에 넣기
select first_name 
from employees
where salary = (select max(salary)
                from employees);
/*subquery를 이용해 최고 급여 자체를 조건절에 넣었다. 
그러나 출력되는 건 최고 급여를 받는 한 사람 뿐이다.*/

--접근 4) 결과 값의 순서에 따라 번호를 붙여 보기
select  rownum,
        first_name,
        salary
from employees;
/*평소 출력 값과 함께 나오는 가장 왼쪽에 있는 숫자는 의미가 없다. 즉 실제 데이터에는 
포함되지 않는 숫자다. 하지만 rownum을 넣으면 실제 데이터에 각각 숫자가 붙는다.*/

--접근 5) rownum으로 생긴 숫자를 이용해 원하는 값까지만 출력하기
select  rownum,
        first_name,
        salary
from employees
where rownum <= 5
and rownum >= 1;
/*rownum으로 5번까지 출력하는 데에 성공했으나 원하는 순서, 월급순이 아니다. 정렬 필요.*/

--접근 6) 급여순으로 정렬
select  rownum,
        first_name,
        salary
from employees
order by salary desc;
/*급여순으로 정렬하는 데에는 성공했으나 rownum의 순서가 뒤죽박죽이다.
이는 rownum으로 '먼저' 순서에 따라 숫자가 정해진 뒤 그 후에 order by로 정렬되었기 때문이다.
rownum은 from에서 읽어온 테이블 정보를 한 줄씩 읽을 때마다 숫자를 붙여주기 때문에
테이블이 전부 출력되었을 때엔 rownum이 이미 제 할 일을 끝낸 시점이 된다.
따라서 rownum보다 먼저 순서를 정렬하기 위해서는 테이블 위치에 이미 정렬된 테이블을 두어야 한다.*/

--접근 7) 원하는 기준으로 정렬부터 한 후에 rownum 넣어주기
select  rownum,
        first_name,
        salary
from salaryTable; --월급 순으로 정렬된 테이블을 원한다. 그러나 이런 테이블은 존재하지 않는다.

select  rownum,
        first_name,
        salary
from (select first_name,
             salary
      from employees
      order by salary desc);
/*그래서 월급순으로 이미 정렬된 가상의 테이블을 직접 만들어 사용한다.*/

--접근 8) 원하는 값까지만 출력(마무리)
select  rownum,
        first_name,
        salary
from (select first_name,
             salary
      from employees
      order by salary desc)
where rownum <=5
and rownum >=1;

--<가상 테이블 이해하기>
--1) 테이블에 없는 내용은 출력할 수 없다.
--테이블에 salary가 없기 때문에 오류 발생.
select  rownum,
        first_name,
        salary
from (select first_name
      from employees
      order by salary desc);
      
--2) 이름을 맞춰줘야 한다.
--from 테이블의 name과 기본 select문의 first_name은 다르므로 오류 발생.
--쓰고 싶다면 별명으로 사용해야 한다.(name)
select  rownum,
        first_name,
        salary
from (select first_name name,
             salary
      from employees
      order by salary desc);
      
--3) 테이블 취사 선택
--*는 모두 출력이기 때문에 원하는 정보만 뽑아 사용할 수 있다.(월급순으로 정렬된 employees 테이블)
select  rownum,
        first_name,
        salary
from (select *
      from employees
      order by salary desc);
      
      
--급여가 높은 직원 순에서 3등에서 7등까지의 이름과 급여는? 

--접근 1) 배운 대로 정렬된 가상의 테이블을 사용한다.(subquery문)
select  rownum,
        first_name, 
        salary
from (select first_name,
             salary
      from employees
      order by salary desc)
where rownum <=7
and rownum >=3;
/*rownum의 출발점이 2 이상이면 결과가 출력되지 않는다. 출발점이 1일 때만 출력이 가능하다.*/

--접근 2) 출력되는 과정 생각해보기 → 왜 출력이 안 될까?
select  rownum,
        o.first_name,
        o.salary
from (select first_name,
             salary
      from employees
      order by salary desc) o
where rownum <=7
and rownum >=3;
/*정렬된 테이블 o에서 한 줄씩 읽어올 때(그 후 rownum 작동), 
조건에 따라 해당 줄을 사용할지 말지 결정한다.(조건에 부합하지 않는 줄은 버림)
그런데 왜 조건이 2번부터일 경우 출력이 되지 않을까?
첫 줄을 읽어오면 rownum은 그 줄에 1번을 준다. 
이때, where절에 따르면 1번은 조건에 부합하지 않으므로 버린다. 
그런데 1번이 없으므로 다음에 오는 줄에도 rownum이 1번을 준다. 
즉 조건에 충족되는 번호에 해당하는 줄이 생성되지 않으므로 출력 값이 없는 것이다.*/

--접근 3) 새로 번호를 매기기 전에 번호를 미리 매긴다.
select  r.rno,
        r.first_name,
        r.salary
from (select  rownum rno, --별명을 지어주지 않을 경우 고정된 숫자열이 아닌 기능 rownum으로 인식.
        o.first_name,
        o.salary
      from (select first_name,
             salary
            from employees
            order by salary desc) o)r
where rno <=7
and rno >=3;
/*테이블을 읽어오고 rownum을 매기는 과정이 동시에 일어났기 때문에 발생한 일이다.
따라서 테이블을 한 줄씩 읽어오기 전에 rownum이 먼저 작동해 번호를 다 매겨두면 해결된다.
때문에 3단 구조로 만들어 번호를 매기는 테이블(r)과 한 줄씩 읽어오는 테이블(가장 바깥)을 분리해주었다.
쓰지 않는 줄을 버리는 조건절 where가 rownum이 완료된 후 실행되므로 원하는 값만 출력이 가능하다.*/

/*정리*/
--(1) 정렬(원하는 순) (2) rownum 사용(번호 확정) (3) where절 사용(조건 붙이기)


--07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은? 
select  rn,
        first_name,
        salary,
        hire_date
from (select  rownum rn,
              first_name,
              salary,
              hire_date
      from (select  *
            from employees
            where hire_date <= '07/12/31' 
            and hire_date >= '07/01/01'
            order by salary desc) --(1)
        )--(2)
where rn >= 3
and rn <= 7; --(3)

--07년에 입사한 직원 중 급여가 많은 직원 중에서 3등부터 7등까지의 급여, 입사일, 부서명은?
--(1) 부서 null 비포함
select  t.rn,
        t.first_name,
        t.salary,
        t.hire_date,
        t.department_name
from (select  rownum rn,
              o.first_name,
              o.salary,
              o.hire_date,
              o.department_name
      from (select  em.first_name,
                    em.salary,
                    em.hire_date,
                    de.department_name
            from employees em, departments de
            where hire_date <= '07/12/31' 
            and hire_date >= '07/01/01'
            and em.department_id = de.department_id
            order by salary desc)o
        )t
where rn >= 3
and rn <= 7;

--(2) 부서 null 포함(마지막에 다시 한 번 정렬)
select  t.rn,
        t.first_name,
        t.salary,
        t.hire_date,
        de.department_name
from (select  rownum rn,
              o.first_name,
              o.salary,
              o.hire_date,
              o.department_id
      from (select  em.first_name,
                    em.salary,
                    em.hire_date,
                    em.department_id
            from employees em
            where hire_date <= '07/12/31' 
            and hire_date >= '07/01/01'
            order by salary desc)o
        )t ,departments de
where de.department_id(+) = t.department_id
and rn >= 3
and rn <= 7
order by t.rn;