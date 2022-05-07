-- ***************************************
-- SELECT 문의 기본구조와 각 절의 실행순서 
--   -Clauses-              - 실행순서 -
-- SELECT clause                (5)
-- FROM clause                  (1)     ** 테이블조회
-- WHERE clause                 (2)     ** 1차 필터링, 조건식(조건문)
-- GROUP BY clause              (3)     ** 그룹핑
-- HAVING clause                (4)     ** 2차 필터링 
-- ORDER BY clause              (6)     ** 정렬
-- ***************************************

-----------------------------------------------
--       *** SELECT 문의 기본문법 구조 *** 
-- SELECT [DISTINCT] { *, column[AS][alias], ...}
-- FROM <테이블명>
-----------------------------------------------
-- 1. To remove duplicated data(중복제거)
-- SELECT DISTINCT column1[, column2, ..., columN]
-- FROM table;
-----------------------------------------------
SELECT
    job_id
FROM
    employees;
    
SELECT
    DISTINCT job_id --SELECT절에 나열한 컬럼들에 대해서 중복판단
FROM
    employees;
    

SELECT
    DISTINCT last_name, first_name
-- SELECT DISTINCT *
FROM 
    employees;