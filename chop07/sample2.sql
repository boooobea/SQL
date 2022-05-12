------------------------------------
-- 2. UPDATE 문
------------------------------------
-- 가. 테이블에 저장된 데이터 수정
-- 나. 한 번 수행으로, 여러 개의 행들을 수정할 수 있음
-- 다. WHERE절은 **생략가능(일반적이지 않다)**
--     이 경우엔, 해당 테이블의 모든 데이터가 수정됨
------------------------------------
-- UPDATE 테이블명      --변경(수정)할 테이블명 지정
-- SET                  --변경할 한개 이상의 컬럼명 = 값 
--    컬럼명1 = 변경값1, 
--   [컬럼명2 = 변경값2 ]
--    ...
-- [WHERE 조건식];
------------------------------------

SELECT * FROM mydept;

UPDATE mydept
SET 
    dname = '영업',
    loc ='경기'
WHERE
    deptno = 40;


------------------------------------
-- 2-1. sub-query를 이용한 UPDATE 
------------------------------------
-- UPDATE 테이블명 
-- SET
--      컬럼명1 = (Sub-query 1),
--     [컬럼명2 = (Sub-query 2)],
--      ...
--     [컬럼명3 = (Sub-query 3)]
-- [WHERE 조건식];
------------------------------------

DESC mydept;

UPDATE mydept
SET
    dname = (SELECT dname FROM dept WHERE deptno=10),
    loc = (SELECT loc FROM dept WHERE deptno = 20)
WHERE
    deptno = 40;

SELECT * FROM mydept;