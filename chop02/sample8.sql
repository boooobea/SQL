-----------------------------------------------
--       *** SELECT 문의 기본문법 구조 *** 
-- SELECT [DISTINCT] { *, column[AS][alias], ...}
-- FROM <테이블명>
-- WHERE <pridicates>
-----------------------------------------------
-- 1. Logical Operators(논리연산자)
-- (1) AND(그리고):두 조건을 모두 만족하는 경우 TRUE
-- (2) OR(또는):두 조건중, 한가지만 만족해도 TRUE
-- (3) NOT(부정):지정된 조건이 아닌 데이터를 검색
-----------------------------------------------
-- (1) AND
SELECT
    last_name,
    job_id,
    salary
FROM
    employees
WHERE
    job_id = 'IT_PROG'
    AND salary >= 5000;

-----------------------------------------------
SELECT
    last_name,
    job_id,
    salary
FROM
    employees
WHERE
    job_id = 'IT_PROG'
    OR salary >= 5000;