-- ------------------------------------------------------
-- 6. 제약조건 삭제 (ALTER TABLE DROP 문)
-- ------------------------------------------------------
--  가. 제약조건명 이용
--      USER_CONSTRAINTS, USER_CON_COLUMNS 조회하여,
--      제약조건명 조회
--  나. CASCADE 옵션
--      모든 종속적인 제약조건을 같이 삭제
--  다. 기본적으로, 제약조건명을 이용하여, 제약조건 삭제
--  라. 기본키(PK)와 UNIQUE(UK) 제약조건명 없이, 
--      키워드만 사용하여 삭제가능
--      NN/CK/FK 제약조건 삭제 -> CONSTRAINT 제약조건명 지정하여 삭제
-- ------------------------------------------------------
-- Basic Syntax:

--  ALTER TABLE 테이블명
--  DROP PRIMARY KEY | UNIQUE(컬럼) | CONSTRAINT 제약조건명 [CASCADE];
-- ------------------------------------------------------

-- 데이터사전: PK 제약조건 확인
SELECT 
    table_name,
    constraint_type,
    constraint_name,
    r_constraint_name
FROM
    user_constraints
WHERE
    table_name IN ('DEPT03');

DESC dept03;

----------------------------------------------------------
--(1) PK 제약조건 삭제 
-- 1st --

ALTER TABLE dept03
DROP PRIMARY KEY;

-- 2st --
ALTER TABLE dept03
DROP CONSTRAINT dept03_empno_pk;



----------------------------------------------------------
-- (2) NN 제약조건 삭제 
----------------------------------------------------------
ALTER TABLE dept03
DROP CONSTRAINT dept03_dname_nn;

DESC dept03;

SELECT *
FROM USER_CONSTRAINTS
WHERE table_name = ('DEPT03');



----------------------------------------------------------
-- (3) CASCADE 옵션 적용
----------------------------------------------------------
DROP TABLE dept05;
CREATE TABLE dept05 (
    deptno NUMBER(2) CONSTRAINT dept05_deptno_pk PRIMARY KEY,
    dname VARCHAR2(15),
    loc VARCHAR2(15)
);

INSERT INTO dept05 (deptno, dname, loc)
VALUES (10,'인사','서울');

DESC dept05;


CREATE TABLE emp05 (
    empno   NUMBER(4)       CONSTRAINT emp05_empno_pk PRIMARY KEY,
    ename   VARCHAR2(15),
    deptno  NUMBER(2)       CONSTRAINT emp05_deptno_fk REFERENCES dept05(deptno)
);


INSERT INTO emp05 (empno, ename, deptno)
VALUES (1000, 'John', 10);

DESC emp05;

COMMIT;


ALTER TABLE dept05
DROP PRIMARY KEY;
--ORA-02273: this unique/primary key is referenced by some foreign keys
-- 참조키에 의한 기본 키 삭제 불가
-- 자식테이블에서 부모테이블을 참조하고 있는 경우, 부모테이블의 
-- 기본키(PK)를 삭제하면, 에러가 발생


ALTER TABLE dept05
DROP PRIMARY KEY CASCADE;
-- 연쇄삭제되어서 자식테이블도 삭제됨 
