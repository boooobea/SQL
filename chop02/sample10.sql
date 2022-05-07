-----------------------------------------------
-- 연산자 우선순위
-- (1)괄호() 
-- (2)비교 연산자
-- (3)NOT 연산자 
-- (4)AND 연산자
-- (5)OR 연산자 
-- *우선순위 : 괄호() > 비교 > NOT > AND > OR
-----------------------------------------------
-- 1. AND연산자가 우선실행 : 예상치 못한 결과 
SELECT
    last_name,
    job_id,
    salary,
    commission_pct
FROM
    employees
WHERE
    job_id = 'AC_MGR' OR job_id='MK_REP'
    AND commission_pct IS NULL
    AND salary >= 4000 
    AND salary <= 9000;
    
-- 2. 연산자 우선순위 조정(소괄호 이용):올바른 결과 
SELECT
    last_name,
    job_id,
    salary,
    commission_pct
FROM
    employees
WHERE
    (job_id = 'AC_MGR' OR job_id='MK_REP')     --우선순위로()써준다.
    AND commission_pct IS NULL
    AND ( salary BETWEEN 4000 AND 9000);       --BETWEEN AND연산자를 구분하기위해 
--    AND salary >= 4000 
--    AND salary <= 9000;
   