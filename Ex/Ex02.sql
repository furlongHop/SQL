/*단일행 함수*/

--문자 함수 - INITCAP(컬럼명)
select  email,
        initcap(email) "email2", --첫글자만 대문자로 출력
        department_id
from employees
where department_id = 100;

select  first_name, --불러온 원래 데이터
        lower(first_name) l_first_name, --원래의 데이터를 가공한 데이터(모두 소문자로 출력)
        upper(first_name) u_first_name--원래의 데이터를 가공한 데이터(모두 대문자로 출력)
from employees
where department_id = 100;

--문자 함수 --SUBSTR(컬럼명, 시작위치, 글자수)
select  first_name,
        substr(first_name,1,3), --이름 데이터의 첫번째 글자부터 세 글자 출력
        substr(first_name,-3,2) --이름 데이터의 마지막 글자 기준으로 세 번째 글자부터 두 글자 출력
from employees
where department_id = 100;

--문자함수 --LPAD(컬럼명, 자리수, '채울 문자')/ RPAD(컬럼명, 자리수,'채울 문자')
select  first_name,
        lpad(first_name,10,'*'), --자리의 총 개수를 10개로 두고, 완쪽 공백을 전부 *로 채운다.
        rpad(first_name,10,'*') --자리의 총 개수를 10개로 두고, 오른쪽 공백을 전부 *로 채운다.
from employees;

--문자함수 --REPLACE(컬럼명,문자1,문자2)
select  first_name,
        replace(first_name,'a','*'),--이름 데이터에 포함된 글자 a를 전부 *로 변환
        replace(first_name, substr(first_name,2,3),'***')
        --이름 데이터의 두 번째 글자부터 세 글자를 별 세 개로 변환
from employees
where department_id = 100;


--숫자함수 - ROUND(숫자, 출력을 원하는 소수점 밑 자리수)>반올림 함수
select  round(123.346,2) "r2", --소수점 밑 두 번째 자리 반올림
        round(123.656,0) "r0", --소수점 밑 첫 번째 자리 반올림
        round(123.456,-1) "r-1" --정수 일의 자리 반올림
from dual; --dual:가상의 테이블

--숫자함수 - TRUNC(숫자, 출력을 원하는 자리수)>끝부분 버리는 함수(내림)
SELECT  trunc(123.456, 2) "r2", --소수점 두 번째 자리까지만 출력
        trunc(123.956, 0) "r0", --정수 부분만 출력
        trunc(129.456, -1) "r-1" --정수 부분 일의 자리 내림
FROM dual;

--날짜 함수 -SYSDATE()
select sysdate -- 현재 시간 출력(주로 저장용)
from dual; --dual: 가상의 테이블

select  sysdate,
        hire_date,
        MONTHS_BETWEEN(SYSDATE,hire_date),--고용된 날짜부터 지금까지의 개월 수(일한 경력)
        trunc(MONTHS_BETWEEN(SYSDATE,hire_date),0),--개월 수 정수 부분만 출력(소수점 전부 버림)
        round(MONTHS_BETWEEN(SYSDATE,hire_date),0) --정수 부분만 출력(소수점 밑 첫째자리 반올림)
from employees
where department_id = 100;


--TO_CHAR (숫자, '출력 모양:포맷') 숫자형>문자형 변환
select  first_name,
        salary,
        salary*12,
        to_char(salary*12, '9999999'), --9: 숫자가 아니라 자리를 표현하는 기호
        to_char(salary*12, '$9999999'), --최대 7자리 출력(데이터에 비해 자리 수가 부족할 경우 #으로 출력됨)
        to_char(salary*12, '999999.9999'), --소수점 밑 4자리까지 출력(없으면 0으로 표기됨)
        to_char(salary*12, '999,999,999'), --3자리마다 , 넣어주기
        to_char(salary*12, '0099999') --빈 자리는 0으로 채워라
from employees
where department_id = 100;

--변환함수>TO_CHAR (날짜, '출력 형식') 날짜>문자형 변환
select  sysdate,
        to_char(sysdate,'YYYY'), --y:연도를 위한 자리 기호(두 자리 혹은 네 자리)
        to_char(sysdate,'MM'), --m:달을 위한 자리 기호(자리수 맞춰줘야 오류가 없다.)
        to_char(sysdate,'dd') --d:일을 위한 자리 기호 
from dual;

--날짜 표현 방식은 다양하다. 실제 저장된 값의 형태는 따로 있기 때문이다.
2021-12-16
2021/12/16
2021.12.16
--문자로 저장할 경우 저장된 값의 형태는 숫자일 때와 다르다.
1900/01/01 00:00:00     0
"1900/01/01 00:00:01"   1231231232311

select  sysdate,
        to_char(sysdate,'DD'), --오늘 날짜의 일을 두 자리로 출력
        hire_date,
        to_char(hire_date,'MM') --고용일의 달을 두 자리 출력
from employees;

select  sysdate,
        to_char(sysdate,'YYYY-MM_DD HH24:MI:SS'), --????년 ??월 ??일 ??시(24시 기준):??분:??초
         to_char(sysdate,'YYYY"년"MM"월"DD"일" HH24"시"MI"분"SS"초"')
from dual;

--일반함수>NVL(컬럼명, null일 때 값))/NVL2(컬럼명, null 아닐 때 값, null일 때 값)
select  first_name,
        commission_pct,
        nvl(commission_pct,0), --해당 컬럼 데이터가 null일 경우 0으로 변환 후 출력
        nvl2(commission_pct,100,0) --null이 아니면 100으로 출력, null이면 0으로 출력
from employees;

