--webdb 계정에 book 테이블 만들기
create table book(
    book_id number, 
    title varchar2(50),
    author varchar(10), --컬럼명 데이터 형식(최대 길이)
    pub_date date
);    

--book 테이블에 pubs 컬럼 추가하기
alter table book add(pubs varchar2(50));

--book 테이블의 특정 컬럼 속성 변경하기
alter table book modify(title varchar2(100));--title 최대 길이 변경
alter table book rename column title to subject;--title 컬럼명 변경

--book 테이블 컬럼 삭제하기
alter table book drop(author);

--테이블 이름 변경하기
rename book to article;
select * from book; --테이블 이름이 바뀌었으므로 오류 발생.
select * from article; --정상 출력

--테이블 삭제하기
drop table article;

--작가 (author) 테이블 만들기
create table author(
    author_id number(10),
    author_name varchar2(100) not null, --null 입력 불가
    author_desc varchar(500),
    primary key(author_id) --테이블에 단 한 개 설정 가능한 pk(작가 아이디로 설정)
);

select * from author;

--책(book) 테이블 만들기
create table book(
    book_id number(10),
    title varchar2(100) not null,
    pubs varchar2(100),
    pub_date date,
    author_id number(10),
    primary key(book_id), 
    constraint book_fk foreign key(author_id)
    references author(author_id) 
);

--작가(author) 테이블에 데이터 추가(insert)
--1)묵시적 방법: 컬럼 생성 순서대로 데이터 기입>프로그램이 알아서 순서대로 데이터 추가
insert into author
values (1, '박경리','토지 작가');

--2)명시적 방법: 데이터를 넣을 컬럼과 개수를 직접 지정
insert into author(author_id, author_name,author_desc)
values (2, '이문열','삼국지 작가');

insert into author(author_id, author_name, author_desc)
values(3,'윤흥길','기억 속의 들꽃');

--author table 정보 수정(where절 주의)
update author --update할 테이블 이름
set author_desc = '토지' --바꿀 컬럼명과 바꿀 내용
where author_desc = '토지 작가'; --바꾸고 싶은 특정 컬럼의 특정 데이터

update author 
set author_desc = '삼국지, 우리들의 일그러진 영웅',
    author_name = '이문열' --여러 항목 동시에 변경 가능
where author_desc = '삼국지 작가'; 
/*update 테이블의 set절을 사용해 수정*/

--author 테이블 정보 삭제(where절 미사용시 전체 삭제>주의)
delete from author
where author_id = 1;

--테이블 모든 정보 삭제
delete from author;

--sequence: 번호표
--seq_author_id.nextval: '겹치지 않는' 번호를 주는 것. 중간이 비더라도 신경쓰지 말 것.
create sequence seq_author_id
increment by 1
start with 1;

insert into author
values(seq_author_id.nextval,'김초엽','우리가 빛의 속도로 갈 수 없다면');

insert into author
values(seq_author_id.nextval,'박경리','토지');

insert into author
values(seq_author_id.nextval,'윤흥길','기억 속의 들꽃');

--시퀀스 삭제
drop sequence seq_author_id;
--시퀀스 조회
select * from user_sequences;
/*시퀀스 조회 시 현재 사용한 시퀀스 번호와 달리 
cache_size가 20, lsat number가 21이 나오는 이유는 번호표 개념과 비슷하다. 
미리 20번까지 번호표를 뽑아둔 것이다. 따라서 이때 프로그램을 종료할 경우 다음 시퀀스 번호는
21부터 시작하게 된다. 번호표를 쓰지 않고 버렸기 때문이다. 이런 과정을 원하지 않을 경우
시퀀스 생성 시 nocache를 넣어주면 해결된다.*/
--현재 시퀀스 조회
select seq_author_id.currval --currval: 현재 상황 확인(시퀀스가 카운트되지 않는다.)
from dual;
--다음 시퀀스 조회
select seq_author_id.nextval --nextval: 다음 시퀀스 확인(동작이므로 시퀀스가 카운트 된다.)
from dual;

select * from author;

------------------------------------------------------------------------------------
drop sequence seq_author_id; --시퀀스 삭제
drop table book; --book 테이블 삭제
drop table author; --author 테이블 삭제
/*작가 테이블과 책 테이블은 pk와 fk가 연결되어 있으므로 테이블 삭제 시에도 순서가 있다.
작가 테이블의 pk가 책 테이블의 fk로 기능하고 있으므로, 작가 테이블을 먼저 지우려고 할 경우
책 테이블의 fk가 붕 떠버리는 사태가 발생한다.(참조 데이터 실종) 
따라서 작가 테이블과 연결된 fk를 가진 책 테이블을 먼저 삭제해야 오류 발생 없이 삭제 가능하다.*/


