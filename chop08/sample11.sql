-- ------------------------------------------------------
-- 4. 테이블 변경
-- ------------------------------------------------------
-- 가. 생성된 테이블의 구조를 변경
--     a. 컬럼의 추가/삭제
--     b. 컬럼의 타입/길이 변경
--     c. 컬럼의 제약조건 추가/삭제
-- 나. ALTER TABLE 문장 사용
-- 다. 테이블의 구조변경은 기존 저장된 데이터에 영향을 주게 됨

-- **** ALTER 수정, 삭제시 바로 적용되고 BIN에 들어가지 않는다.복구불가 **** 
-- ------------------------------------------------------
DROP TABLE emp04;

CREATE TABLE emp04 AS 
SELECT * FROM emp;

DESC emp04;
DESC emp;
SELECT * FROM emp04;

----------------------------------------------------------
--(1)컬럼 추가 (ALTER TABLE ADD 문장)
----------------------------------------------------------
-- a. 기존 테이블에 새로운 컬럼 추가 
-- b. 추가된 컬럼은, 테이블의 마지막에 추가 
-- c. 데이터는 자동으로 null값으로 저장된다. 
-- d. default 옵션도 설정 가능(하지만 대부분 null값으로 준다.)
----------------------------------------------------------
-- ALTER TABLE 테이블명
-- ADD (컬럼명1 데이터타입 [, ..., 컬럼명n 데이터타입]);
----------------------------------------------------------

ALTER TABLE emp04 
ADD (
    email VARCHAR2(10),
    address VARCHAR2(20)
);



-- --------------------------------------------------------
-- (1) 컬럼 변경 (ALTER TABLE MODIFY 문장)
-- --------------------------------------------------------
-- a. 기존 테이블에 기존 컬럼 변경
-- b. 컬럼의 타입/크기/DEFALUT값 변경가능 
--    숫자/문자 컬럼의 전체길이의 증가/축소, 타입변경도 가능 
-- c. DEFAULT 값 변경의 경우, 이후 입력되는 행에 대해서만 적용
-- --------------------------------------------------------
-- ALTER TABLE 테이블명
-- MODIFY (컬럼명1 데이터타입 [, ..., 컬럼명N 데이터타입]);
-- --------------------------------------------------------

DESC emp04;

ALTER TABLE emp04 
MODIFY ( email VARCHAR2(40) );

ALTER TABLE emp04
MODIFY ( ename VARCHAR2(20) );

ALTER TABLE emp04
MODIFY ( ename VARCHAR2(5) );
--ORA-01441: cannot decrease column length because some value is too big

ALTER TABLE emp04           --컬럼타입변경
MODIFY (sal VARCHAR2(10));
--ORA-01439: column to be modified must be empty to change datatype


-- ---------------------------------------------------------
-- (2) 컬럼 삭제 (ALTER TABLE DROP 문장)
-- ---------------------------------------------------------
-- a. 기존 테이블에 기존 컬럼 삭제 
-- b. 컬럼은 값의 존재여부와 상관없이, 무조건 삭제 됨
-- c. 동시에 여러 컬럼삭제가 가능 
-- d. 최소한 1개의 컬럼은 반드시 존재해야 한다. 
-- ---------------------------------------------------------
-- ALTER TABLE 테이블명 
-- DROP (컬럼명1, [컬럼명N]);

ALTER TABLE emp04
DROP (email);

DESC emp04;