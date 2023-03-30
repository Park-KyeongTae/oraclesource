-- PL/SQL : SQL 만으로는 구현이 어렵거나 구현 불가능한 작업을 수행하기 위해 오라클에서 제공하는 프로그래밍 언어
-- 실행결과를 화면에 출력해주세요
SET SERVEROUTPUT ON;

-- 블록 : DECLEAR ~ BEGIN ~ END 
BEGIN
    dbms_output.put_line('HELLO PL/SQL');
END;
/ -- 실행

-- 변수 선언
DECLARE
    v_empno NUMBER(4) := 7788;
    v_ename VARCHAR2(10);
BEGIN
    v_ename := 'SCOTT';
    dbms_output.put_line('V_ENAME : ' || v_ename);
    dbms_output.put_line('V_EMPNO : ' || v_empno);
END;
/

-- 상수선언 
DECLARE
    v_tax CONSTANT NUMBER(4) := 7788;
BEGIN
    dbms_output.put_line('V_TAX : ' || v_tax);
END;
/

-- 변수 + DEFAULT(기본값)
DECLARE
    v_tax NUMBER(4) DEFAULT 10;
BEGIN
    dbms_output.put_line('V_TAX : ' || v_tax);
END;
/

-- 변수 + NOT NULL
DECLARE
    v_tax NUMBER(4) NOT NULL := 10;
BEGIN
    dbms_output.put_line('V_TAX : ' || v_tax);
END;
/

-- 변수 + NOT NULL + DEFAULT
DECLARE
    v_tax NUMBER(4) NOT NULL DEFAULT 10;
BEGIN
    dbms_output.put_line('V_TAX : ' || v_tax);
END;
/

-- 변수와 상수의 자료형 
-- 스칼라 : 오라클이 사용하는 타입(NUMBER, CHAR, DATE...)
-- 참조형 : 오라클 데이터 베이스에 존재하는 특정 테이블의 열의 자료형이나 하나의 행 구조를 참조하는 자료형
-- 1) 변수이름 테이블명.열이름%TYPE : 특정 테이블에 속한 열과 같은 크기의 자료형을 사용
-- 2) 변수이름 테이블명%ROWTYPE : 특정 테이블에 속한 행구조 전체 참조

DECLARE
    v_deptno dept.deptno%TYPE := 50;
BEGIN
    dbms_output.put_line('V_DEPTCO : ' || v_deptno);
END;
/

DECLARE
    -- V_DEPT_ROW 변수가 DEPT 테이블의 한 행의 구조를 참조
    v_dept_row dept%rowtype;
BEGIN
    SELECT
        deptno,
        dname,
        loc
    INTO v_dept_row -- INTO + 변수명에 대입해줘
    FROM
        dept
    WHERE
        deptno = 40;

    dbms_output.put_line('DEPTNO : ' || v_dept_row.deptno);
    dbms_output.put_line('DNAME : ' || v_dept_row.dname);
    dbms_output.put_line('LOC : ' || v_dept_row.loc);
END;
/

-- 조건문 : IF , IF ~ THEN ~ END IF,

DECLARE
    v_number NUMBER := 15;
BEGIN
    -- V_NUMBER 홀수, 짝수 구별
    -- MOD() : 나머지 구하는 오라클 함수
    IF MOD(v_number, 2) = 1 THEN
        dbms_output.put_line('V_NUMBER 는 홀수');
    END IF;
END;
/

DECLARE
    v_number NUMBER := 14;
BEGIN
    -- V_NUMBER 홀수, 짝수 구별
    -- MOD() : 나머지 구하는 오라클 함수
    IF MOD(v_number, 2) = 1 THEN
        dbms_output.put_line('V_NUMBER 는 홀수');
    ELSE
        dbms_output.put_line('V_NUMBER 는 짝수');
    END IF;
END;
/

-- 학점 출력

DECLARE
    v_number NUMBER := 87;
BEGIN
    IF v_number >= 90 THEN
        dbms_output.put_line('A 학점');
    ELSIF v_number >= 80 THEN
        dbms_output.put_line('B 학점');
    ELSIF v_number >= 70 THEN
        dbms_output.put_line('C 학점');
    ELSIF v_number >= 60 THEN
        dbms_output.put_line('D 학점');
    ELSE
        dbms_output.put_line('F 학점');
    END IF;
END;
/

DECLARE
    v_number NUMBER := 87;
BEGIN
    CASE trunc(v_number / 10)
        WHEN 10 THEN
            dbms_output.put_line('A 학점');
        WHEN 9 THEN
            dbms_output.put_line('A 학점');
        WHEN 8 THEN
            dbms_output.put_line('B 학점');
        WHEN 7 THEN
            dbms_output.put_line('C 학점');
        WHEN 6 THEN
            dbms_output.put_line('D 학점');
        ELSE
            dbms_output.put_line('F 학점');
    END CASE;
END;
/

DECLARE
    v_number NUMBER := 87;
BEGIN
    CASE
        WHEN v_number >= 90 THEN
            dbms_output.put_line('A 학점');
        WHEN v_number >= 80 THEN
            dbms_output.put_line('B 학점');
        WHEN v_number >= 70 THEN
            dbms_output.put_line('C 학점');
        WHEN v_number >= 60 THEN
            dbms_output.put_line('D 학점');
        ELSE
            dbms_output.put_line('F 학점');
    END CASE;
END;
/

-- 반복문
-- LOOP ~ END LOOP, WHILE LOOP, FOR LOOP, CUSOR FOR LOOP

DECLARE
    v_num NUMBER := 0;
BEGIN
    LOOP
        dbms_output.put_line('V_NUM : ' || v_num);
        v_num := v_num + 1;
        EXIT WHEN v_num > 4;
    END LOOP;
END;
/

DECLARE
    v_num NUMBER := 0;
BEGIN
    WHILE v_num < 4 LOOP
        dbms_output.put_line('V_NUM : ' || v_num);
        v_num := v_num + 1;
    END LOOP;
END;
/
--FOR I IN 시작값..종료값 LOOP
-- 반복수행작업;
-- END LOOP

BEGIN
    FOR i IN 0..4 LOOP
        dbms_output.put_line('I : ' || i);
    END LOOP;
END;
/

-- REVERSE
BEGIN
    FOR i IN REVERSE 0..4 LOOP
        dbms_output.put_line('I : ' || i);
    END LOOP;
END;
/

--CONTINUE
BEGIN
    FOR i IN 0..4 LOOP
        CONTINUE WHEN MOD(i, 2) = 1;
        dbms_output.put_line('I : ' || i);
    END LOOP;
END;
/

-- 1~10 까지 홀수만 입력 CONTINUE 이용
BEGIN
    FOR i IN 1..10 LOOP
        CONTINUE WHEN MOD(i, 2) = 0;
        dbms_output.put_line('I : ' || i);
    END LOOP;
END;
/
-- 1~10 까지 홀수만 입력 IF 이용
BEGIN
    FOR i IN 1..10 LOOP
        IF i MOD 2 = 1 THEN
            dbms_output.put_line('I : ' || i);
        END IF;
    END LOOP;
END;
/


-- 커서 : SELECT 문 또는 데이터 조작어 같은 SQL 문을 실행했을 때
--       해당 SQL 문을 처리하는 정보를 저장한 메모리 공간(포인터)

-- 명시적 커서
--1) 커서 선언 2) 커서 열기 3) 커서에서 얻어온 데이터 사용 4) 커서 닫기

-- 결과가 단일행 일 때
DECLARE
    -- V_DEPT_ROW 변수가 DEPT 테이블의 한 행의 구조를 참조
    v_dept_row dept%rowtype;
    
    -- 커서 선언
    CURSOR c1 IS
    SELECT
        deptno,
        dname,
        loc
    FROM
        dept
    WHERE
        deptno = 40;

BEGIN

    -- 커서 열기
    OPEN c1;
    -- 커서에서 얻어온 데이터 사용
    FETCH c1 INTO v_dept_row;
    dbms_output.put_line('DEPTNO : ' || v_dept_row.deptno);
    dbms_output.put_line('DNAME : ' || v_dept_row.dname);
    dbms_output.put_line('LOC : ' || v_dept_row.loc);
    
    -- 커서 닫기
    CLOSE c1;
END;
/


-- 결과가 여러행 일 때
DECLARE
    -- V_DEPT_ROW 변수가 DEPT 테이블의 한 행의 구조를 참조
    v_dept_row dept%rowtype;
    
    -- 커서 선언
    CURSOR c1 IS
    SELECT
        deptno,
        dname,
        loc
    FROM
        dept;

BEGIN

    -- 커서 열기
    OPEN c1;
    LOOP
    -- 커서에서 얻어온 데이터 사용
        FETCH c1 INTO v_dept_row;
    
    -- 루프 탈출 : 커서이름%NOTFOUND => 수행된 FETCH 문을 통해 추출된 행이 있으면 FALSE, 없으면 TRUE 반환
        EXIT WHEN c1%notfound;
        dbms_output.put_line('DEPTNO : ' || v_dept_row.deptno);
        dbms_output.put_line('DNAME : ' || v_dept_row.dname);
        dbms_output.put_line('LOC : ' || v_dept_row.loc);
    END LOOP;
    -- 커서 닫기
    CLOSE c1;
END;
/



-- FOR LOOP + 커서 : OEPN , FETCH, CLOSE 자동
DECLARE 
    -- 커서 선언
    CURSOR c1 IS
    SELECT
        deptno,
        dname,
        loc
    FROM
        dept;

BEGIN
    FOR c1_rec IN c1 LOOP
        dbms_output.put_line(' DEPTNO : '
                             || c1_rec.deptno
                             || ' DNAME : '
                             || c1_rec.dname
                             || ' LOC : '
                             || c1_rec.loc);
    END LOOP;
END;
/


-- 커서 + 파라미터
DECLARE
    -- V_DEPT_ROW 변수가 DEPT 테이블의 한 행의 구조를 참조
    v_dept_row dept%rowtype;
    
    -- 커서 선언
    CURSOR c1 (
        p_deptno dept.deptno%TYPE
    ) IS
    SELECT
        deptno,
        dname,
        loc
    FROM
        dept
    WHERE
        deptno = p_deptno;

BEGIN

    -- 커서 열기
    OPEN c1(10);
    LOOP
    -- 커서에서 얻어온 데이터 사용
        FETCH c1 INTO v_dept_row;
    
    -- 루프 탈출 : 커서이름%NOTFOUND => 수행된 FETCH 문을 통해 추출된 행이 있으면 FALSE, 없으면 TRUE 반환
        EXIT WHEN c1%notfound;
        dbms_output.put_line('10번 부서 DEPTNO : '
                             || v_dept_row.deptno
                             || ' DNAME : '
                             || v_dept_row.dname
                             || ' LOC : '
                             || v_dept_row.loc);

    END LOOP;
    -- 커서 닫기
    CLOSE c1;
    
    
    -- 20번 부서
    OPEN c1(20);
    LOOP
    -- 커서에서 얻어온 데이터 사용
        FETCH c1 INTO v_dept_row;
    
    -- 루프 탈출 : 커서이름%NOTFOUND => 수행된 FETCH 문을 통해 추출된 행이 있으면 FALSE, 없으면 TRUE 반환
        EXIT WHEN c1%notfound;
        dbms_output.put_line('10번 부서 DEPTNO : '
                             || v_dept_row.deptno
                             || ' DNAME : '
                             || v_dept_row.dname
                             || ' LOC : '
                             || v_dept_row.loc);

    END LOOP;
    -- 커서 닫기
    CLOSE c1;
END;
/


-- 커서 + 파라미터 입력받기

DECLARE
    -- 사용자가 입력한 부서 번호를 저장하는 변수
    v_deptno dept.deptno%TYPE;

    -- 커서 선언
    CURSOR c1 (
        p_deptno dept.deptno%TYPE
    ) IS
    SELECT
        deptno,
        dname,
        loc
    FROM
        dept
    WHERE
        deptno = p_deptno;

BEGIN
    
    -- 사용자 입력 : &변수 

    v_deptno := &input_deptno;
    FOR c1_rec IN c1(v_deptno) LOOP
        dbms_output.put_line(' DEPTNO : '
                             || c1_rec.deptno
                             || ' DNAME : '
                             || c1_rec.dname
                             || ' LOC : '
                             || c1_rec.loc);
    END LOOP;

END;
/



-- 묵시적 커서 : 별다른 선언 없이 SQL 문 사용
--             여러 행의 결과를 가지는 커서는 명시적 커서로만 사용 함

-- SQL%NOTFOUND : 묵시적 커서 안에 추출된 행이 있으면 FALSE, 없으면 TRUE 반환
--                DML 명령어로 영향을 받는 행이 없을 경우에도 TRUE

-- SQL%FOUND : 묵시적 커서 안에 추출된 행이 있으면 FALSE, 없으면 TRUE 반환
--             영향을 받는 행이 없을 경우에도 TRUE

-- SQL%ROWCOUNT : 묵시적 커서에 현재까지 추출한 행 수 또는 DML 명령어로 영향받는 행 수 반환

-- SQL%ISOPEN : 묵시적 커서는 자동으로 SQL 문을 실행한 후 CLOSE 되므로 이 속성은 항상 FALSE 반환

BEGIN
    UPDATE dept_temp
    SET
        dname = 'DATABASE'
    WHERE
        deptno = 50;

    dbms_output.put_line('갱신 된 행의 수 : ' || SQL%rowcount);
    
    IF ( SQL%found ) THEN
        dbms_output.put_line('갱신 대상 행 존재 여부 :  TRUE');
    ELSE
        dbms_output.put_line('갱신 대상 행 존재 여부 :  FALSE');
    END IF;

    IF ( SQL%isopen ) THEN
        dbms_output.put_line('커서의 OPEN 여부  :  TRUE');
    ELSE
        dbms_output.put_line('커서의 OPEN 여부  :  FALSE');
    END IF;

END;
/



-- 예외 처리 )v_wrong NUMBER은 숫자이고 dname은 문자
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT
        dname
    INTO v_wrong
    FROM
        dept
    WHERE
        deptno = 10;
        dbms_output.put_line('예외 발생 시 다음 문장은 실행되지 않음');
EXCEPTION
    WHEN TOO_MANY_ROW THEN
        dbms_output.put_line('예외 처리 : 요구 보다 행 추출 오류 발생');
    WHEN value_error THEN
        dbms_output.put_line('예외 처리 : 수치 또는 값 오류발생');
    WHEN OTHERS THEN
        dbms_output.put_line('예외 처리 : 사전 정의 외 오류 발생');
END;
/


DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT
        dname
    INTO v_wrong
    FROM
        dept
    WHERE
        deptno = 10;
        dbms_output.put_line('예외 발생 시 다음 문장은 실행되지 않음');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('예외 처리 : 사전 정의 외 오류 발생');
        dbms_output.put_line('SQLCODE : || TO_CHAR(SQLCODE)');
        dbms_output.put_line('SQLERRM : || SQLERRM');
END;
/


-- 명시적 커서를 사용하여 EMP 테이블 전체 데이터를 조회한 후 데이터 출력
-- FOR LOOP

DECLARE 
    -- 커서 선언
    CURSOR c1 IS
    SELECT
       *
    FROM
        EMP;
BEGIN

    FOR c1_rec IN c1 LOOP
        dbms_output.put_line(' EMPNO : '
                             || c1_rec.EMPNO
                             || ' ENAME : '
                             || c1_rec.Ename
                             || ' JOB : '
                             || c1_rec.JOB
                             || ' MGR : '
                             || c1_rec.MGR
                             || ' HIREDATE : '
                             || c1_rec.HIREDATE
                             || ' SAL : '
                             || c1_rec.SAL
                             || ' COMM : '
                             || c1_rec.COMM
                             || ' DEPTNO : '
                             || c1_rec.DEPTNO);
    END LOOP;
END;
/

-- (저장) 프로시저 : 특정 처리 작업을 수행하는 데 사용(다른 응용 프로그램에서 호출 가능)

--CREATE [OR REPLACE] PROCEDURE 프로시저명
--IS | AS
--BEGIN
-- 실행부
--EXCEPTION
-- 예외부
--END

-- 작성 후 컴파일
CREATE OR REPLACE PROCEDURE PRO_NOPARAM
IS 
    v_empno NUMBER(4) := 7788;
    v_ename VARCHAR2(10);
BEGIN
    v_ename := 'SCOTT';
    dbms_output.put_line('V_ENAME : ' || v_ename);
    dbms_output.put_line('V_EMPNO : ' || v_empno);
END;
/

-- 프로시저 실행
EXECUTE PRO_NOPARAM;


-- 프로시저 블록 안에서 실행
BEGIN
    pro_noparam;
END;
/


-- 프로시저 삭제
DROP PROCEDURE  pro_noparam;




-- 파라미터 프로시저
-- IN(DEFAILT) : 프로시저 호출 시 값을 입력받음
-- OUT : 프로시저 호출할 때 값 반환
-- IN OUT : 호출할 때 값을 입력 받은 후 실행 결과 값 반환

-- IN 은 생략가능
CREATE OR REPLACE PROCEDURE PRO_PARAM(PARAM1 IN NUMBER, PARAM2 NUMBER, PARAM3 NUMBER := 3, PARAM4 NUMBER DEFAULT 4)
IS 
  
BEGIN
 
    dbms_output.put_line('PARAM1 : ' || PARAM1);
    dbms_output.put_line('PARAM2 : ' || PARAM2);
    dbms_output.put_line('PARAM3 : ' || PARAM3);
    dbms_output.put_line('PARAM4 : ' || PARAM4);
END;
/

-- 'PRO_PARMA' 식별자가 정의되어야 합니다 변수명 이름확인 오류
EXECUTE PRO_PARAM(1,2,8,9);

EXECUTE PRO_PARAM(1,2);




CREATE OR REPLACE PROCEDURE PRO_PARAM_OUT(IN_EMPNO IN EMP.EMPNO%TYPE, OUT_ENAME OUT EMP.ENAME%TYPE, OUT_SAL OUT EMP.SAL%TYPE)
IS 

BEGIN
    SELECT ENAME,SAL INTO OUT_ENAME, OUT_SAL
    FROM EMP
    WHERE EMPNO =IN_EMPNO;
END;
/




DECLARE
    V_ENAME EMP.ENAME%TYPE;
    V_SAL EMP.SAL%TYPE;
BEGIN
    PRO_PARAM_OUT(7839,V_ENAME,V_SAL); -- 위 V_ENAME에 OUT_ENAME 값이 들어감, V_SAL에 OUT_SAL 값이 들어감
    dbms_output.put_line('V_ENAME : ' || V_ENAME); -- V_ENAME 출력해줘
    dbms_output.put_line('V_SAL : ' || V_SAL); -- V_SAL 출력해줘
END;
/


-- 주석오류 MS키보드인지 확인!

-- 트리거 : 데이터베이스 안의 특정 상황이나 동작, 즉 이벤트가 발생할 경우 자동으로 실행되는 기능 정의
-- 회원테이블에서 회원이 삭제가 되면 해당 회원을 다른 테이블로 이동

-- CREATE [OR REPLACE] TRIGGER 트리거 이름
-- BEFORE | AFTER => 트리거 동작 시점
-- INSERT | UPDATE | DELETE ON 테이블 명
-- FOR EACH ROW WHEN 조건식
-- ENABLE | DISABLE

-- DECLARE
--   선언부
-- BEGIN
--   실행부
-- EXCEPTION
--   예외부
-- END;

CREATE TABLE EMP_TRG AS SELECT * FROM EMP;

-- EMP_TRG 테이블에 DML 명령어 사용 시 주말일 경우는 DML 명령 실행 취소

CREATE OR REPLACE TRIGGER TRG_EMP_NODML_WEEKEND
BEFORE
INSERT OR UPDATE OR DELETE ON EMP_TRG
BEGIN
    IF TO_CHAR(SYSDATE, 'DY') IN ('토','일') THEN
        IF INSERTING THEN
            RAISE_APPLICATION_ERROR(-20000, '주말 사원정보 추가 불가');
            ELSIF UPDATING THEN
            RAISE_APPLICATION_ERROR(-20001, '주말 사원정보 수정 불가');
            ELSIF DELETING THEN
            RAISE_APPLICATION_ERROR(-20002, '주말 사원정보 삭제 불가');
            ELSE 
            RAISE_APPLICATION_ERROR(-20003, '주말 사원정보 변경 불가');
        END IF;
    END IF;
END;
/

UPDATE EMP_TRG SET SAL = 8000 WHERE EMPNO = 7369;
COMMIT;

SELECT * FROM EMP_TRG_LOG;


-- LOG 기록 트리거 

-- 로그 기록 테이블 만들기
CREATE TABLE EMP_TRG_LOG(
TABLENAME VARCHAR2(10),
DML_TYPE VARCHAR2(10),
EMPNO NUMBER(4),
USER_NAME VARCHAR2(30),
CHANGE_DATE DATE);


-- LOG 기록 트리거 문
CREATE OR REPLACE TRIGGER TRG_EMP_LOG
AFTER -- 이후에 기록하기 위해 AFTER
INSERT OR UPDATE OR DELETE ON EMP_TRG

FOR EACH ROW 

BEGIN
    
        IF INSERTING THEN
            INSERT INTO EMP_TRG_LOG
            VALUES ('EMP_TRG','INSERT', : NEW.EMPNO, SYS_CONTEXT('USERENV', 'SESSION_USER'), SYSDATE); -- NEW
        ELSIF UPDATING THEN
            INSERT INTO EMP_TRG_LOG
            VALUES ('EMP_TRG','UPDATE', : OLD.EMPNO, SYS_CONTEXT('USERENV', 'SESSION_USER'), SYSDATE);
            ELSIF DELETING THEN
            INSERT INTO EMP_TRG_LOG
            VALUES ('EMP_TRG','DELETE', : OLD.EMPNO, SYS_CONTEXT('USERENV', 'SESSION_USER'), SYSDATE);
    END IF;
END;
/