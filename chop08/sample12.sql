-- ---------------------------------------------
-- 5. 제약조건 추가(ALTER TABLE 문장)
-- ---------------------------------------------
-- 가. 기존 테이블에 제약조건 추가
-- 나. PK/FK/UK/CK 제약조건 추가 -> ALTER TABLE ADD
-- 다. NN 제약조건 추가 -> ALTER TABLE MODIFY 
-- 라. 기존 테이블에 추가적인 제약조건도 추가 가능
-- ---------------------------------------------
-- ALTER TABLE 테이블명
-- ADD [CONSTRANINT 제약조건명] 제약조건타입(컬럼명);
-- ---------------------------------------------
-- ------------------------------------------------------
-- (1) PRIMARY KEY 제약조건 추가
-- ------------------------------------------------------

-- 제약조건 없는 테이블 생성
CREATE TABLE dept03 (
    deptno NUMBER(2),
    dname VARCHAR2(15),
    loc VARCHAR2(15)
);

ALTER TABLE dept03
ADD CONSTRAINT dept03_deptno_pk PRIMARY KEY(deptno);

DESC dept03;

commit;

SELECT 
    table_name,
    constraint_type,
    constraint_name,
    r_constraint_name
FROM
    user_constraints
WHERE
    table_name IN ('DEPT03');


-- ------------------------------------------------------
-- (2) NOT NULL 제약조건 추가 (CK/PK/FK 제약조건 추가도 동일)
-- ------------------------------------------------------
-- Basic Syntax:

--  ALTER TABLE 테이블명
--  MODIFY ( 컬럼명 데이터타입 [CONSTRAINT 제약조건명] NOT NULL );
-- ------------------------------------------------------

DESC dept03;

-- NOT NULL 제약조건 추가
ALTER TABLE dept03
MODIFY ( dname VARCHAR2(15) CONSTRAINT dept03_dname_nn NOT NULL);

-- NOT NULL 제약조건 추가 확인
DESC dept03;

SELECT 
    table_name,
    constraint_type,
    constraint_name,
    r_constraint_name
FROM
    user_constraints
WHERE
    table_name IN ('DEPT03');