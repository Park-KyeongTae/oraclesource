-- javadb

-- USERTBL 테이블 생성
-- NO(번호-숫자(4)), USERNAME(이름-한글(4), BIRTHYEAR(년도-숫자(4)), ADDR(주소-문자(한글,숫자)), MOBILE(010-1234-1234)
-- NO PK 제약조건 지정(제약조건명 pk_userTBL)
CREATE TABLE userTBL(
NO NUMBER(4) CONSTRAINT pk_userTBL PRIMARY KEY,
USERNAME NVARCHAR2(10) NOT NULL, -- VARCHAR2(20)
BIRTHYEAR NUMBER(4) NOT NULL,
ADDR NVARCHAR2(50) NOT NULL,     -- VARCHAR2(50)
MOBILE NVARCHAR2(20)             -- VARCHAR2(20)
);

DROP TABLE USERTBL;

-- select(+서브쿼리,조인) + DML(insert, update, delete)
-- 전체조회
select * from usertbl;
-- 개별조회(특정번호,특정이름...)
-- 여러행이 나오는 상태냐? , 하나의 행이 나오는 상태냐?
select * from userTbl where no=1;
select * from userTbl where username='홍길동';

-- like : _ or % 같이 사용
select * from userTbl where username LIKE '%홍길동'; -- 홍길동으로 끝나는 
select * from userTbl where username LIKE '%길동%'; -- 앞 뒤 상관없이 길동만
select * from userTbl where username LIKE '_길동%'; -- 앞 뒤 상관없이 길동만

-- insert into 테이블명(필드명1,필드명2..)
-- value()

-- update 테이블명 
-- set 업데이트 할 필드명=값,업데이트 할 필드명=값......
-- where 조건

-- delete 테이블 명 where 조건 (from 생략가능)

-- delete from 테이블 명 where 조건








-- 시퀀스 생성
-- USER_SEQ생성(기본)
CREATE SEQUENCE USER_SEQ;


-- INSTERT 
-- NO : USER_SEQ
INSERT INTO USERTBL (NO, USERNAME, BIRTHYEAR,ADDR,MOBILE)
VALUES(USER_SEQ.NEXTVAL,'홍길동',2010,'서울시 종로구 123','010-1234-5678');

COMMIT;




-- 모든 칼럼 NOT NULL
-- SHOP

-- PAYTYPE : PAYNO(숫자(1)PK), INFO(문자(4))
CREATE TABLE PAYTYPE (
PAY_NO NUMBER(1) PRIMARY KEY ,
INFO VARCHAR2(10) NOT NULL
);

-- PAYTYPE_SEQ
CREATE SEQUENCE PAYTYPE_SEQ;

INSERT INTO PAYTYPE VALUES(paytype_seq.nextval,'CARD');
INSERT INTO PAYTYPE VALUES(paytype_seq.nextval,'CASH');

SELECT * FROM PAYTYPE;

-- SUSER : USER_ID(숫자(4)PK), NAME(문자(한글)), PAYNO(숫자(1)) :  PAYTYPE 테이블에 있는 PAY_NO 참조 해서 사용)
CREATE TABLE SUSER (
USER_ID NUMBER(4) PRIMARY KEY,
NAME VARCHAR2(20) NOT NULL,
PAY_NO NUMBER(1) NOT NULL REFERENCES PAYTYPE(PAY_NO)
);
-- PRODUCT 
-- PRODUCT_ID(숫자(8)PK), PNAME(문자(50)),PRICE(숫자(10), CONTENT(문자(50))
CREATE TABLE PRODUCT(
PRODUCT_ID NUMBER(8) PRIMARY KEY,
PNAME VARCHAR2(30) NOT NULL,
PRICE NUMBER(8)NOT NULL,
CONTENT VARCHAR2(50) NOT NULL
);

CREATE SEQUENCE PRODUCTE_SEQ;
-- SORDER
-- ORDER_ID(숫자(8)PK),USER_ID(USER 테이블의 USER_ID 참조),PRODUCT_ID(PRODUCT 테이블의 PRODUCT_ID 참조)
CREATE TABLE SORDER(
ORDER_ID NUMBER(8) PRIMARY KEY,
USER_ID NUMBER(4) NOT NULL REFERENCES SUSER(USER_ID),
PRODUCT_ID NUMBER(8) NOT NULL REFERENCES PRODUCT(PRODUCT_ID)
);

ALTER TABLE SORDER ADD ORDER_DATE DATE; -- 구매날짜
-- SORDER_SEQ 생성
CREATE SEQUENCE SORDER_SEQ;

-- user_id, name, pay_no, info 조회

SELECT
    s.user_id,
    s.name,
    s.pay_no,
    p.info
FROM
    suser   s,
    paytype p
WHERE
    s.pay_no = p.pay_no;
    
-- 주문목록 조회
select * FROM SORDER;

-- 주문목록 조회
-- USER_ID, NAME, CARD/CASH, PRODUCT_ID, PNAME, PRICE, CONTENT

-- 기준 : SORDER
-- SUSER 테이블 : NAME,
-- PAYTYPE 테이블 : CARD/CASH
-- PRODUCT 테이블 : PRODUCT_ID, PNAME, PRICE, CONTENT

-- 전체 주문목록
SELECT U.USER_ID, U.NAME, T.INFO, S.PRODUCT_ID, P.PNAME, P.PRICE, P.CONTENT, S.ORDER_DATE
FROM SORDER S, SUSER U , paytype T , PRODUCT P
WHERE U.USER_ID = U.USER_ID AND U.PAY_NO = T.PAY_NO AND S.PRODUCT_ID = P.PRODUCT_ID;

-- 홍길동 주문목록 조회
SELECT U.USER_ID, U.NAME, T.INFO, S.PRODUCT_ID, P.PNAME, P.PRICE, P.CONTENT, S.ORDER_DATE
FROM SORDER S, SUSER U , paytype T , PRODUCT P
WHERE U.USER_ID = U.USER_ID AND U.PAY_NO = T.PAY_NO AND S.PRODUCT_ID = P.PRODUCT_ID AND S.USER_ID = 1234;

