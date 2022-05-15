-- ------------------------------------------------------
-- 1. Index 생성
-- ------------------------------------------------------
--  가. 빠른 데이터 검색을 위해 존재하는 오라클 객체
--  나. 명시적으로 생성하지 않아도, 자동 생성되기도 함
--      (PK/UK 제약조건 생성시, Unique Index 자동생성)
--  다. PK/UK 제약조건에 따른, 자동생성 Unique Index:
--      a. 데이터 무결성을 확인하기 위해, 수시로 데이터 검색 필요
--      b. 따라서, 빠른 검색이 요구됨
--  라. 명시적인 인덱스 생성이 우리가 할 일!!!
-- 마치 작은테이블 -> 컬럼에 인덱스번호가 부여되어 인덱스만 따로 저장되기때문에 

-- ------------------------------------------------------
-- Basic syntax:
--
--  CREATE [UNIQUE] INDEX 인덱스명
--  ON 테이블(컬럼1[, 컬럼2, ...]);
--
--  (1) Unique Index
--      a. CREATE UNIQUE INDEX 문으로 생성한 인덱스
--      b. Index 내의 Key Columns에 중복값 허용하지 않음
--      c. 성능이 가장 좋은 인덱스
--      d. (*주의*) 중복값이 허용되는 테이블 컬럼에는 절대로 사용불가!!
--
--  (2) Non-unique Index
--      a. CREATE INDEX 문으로 생성한 인덱스
--      b. 중복값이 허용되는 테이블 컬럼에 대해,
--         일반적으로 생성하는 인덱스
--      c. 인덱스가 부여되면 이후에는 중복은 적용되지 않는다. 
-- ------------------------------------------------------

-- Index 없이, Table Full Scan 방식을 통한, 데이터 조회
SELECT 
    * 
FROM 
    emp 
WHERE 
    trim(ename) = 'JAMES';

-- Index생성하여, Index scan 방식을 통한 데이터 조회 
-- Index 생성시, 컬럼-rowid컬럼이 생성된다.
CREATE INDEX emp_ename_idx 
ON emp(ename);
-- index컬럼을 가공할시(ex.함수, 연산자 등) index를 사용하지 않는다. 
-- 순수한 컬럼값이 아닌 가공한 값이 들어가기 때문에 인덱스 사용안됨


-- 특정 쿼리의 실행계획(Execute plan)보기 


SELECT 
    ROWID,       --행의 논리적인 주소
    ROWNUM,      --행의 주소
    empno, 
    ename
FROM 
    emp
ORDER BY
    ename;
    
-- order by절이 마지막에 실행되기 때문에 rownum은 순서가 뒤죽박죽이 되는데 
-- sub-range DQL using ROWNUM requied to get rows per page.
-- sub-range를 사용하여 rownum을 사용한다. 



