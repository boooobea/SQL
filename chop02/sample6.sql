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
-- WHERE <pridicates>
-----------------------------------------------
-- 1. IN Operators(**집합 연산자**)
-- WHERE column IN( value, value, ... )
-----------------------------------------------
SELECT
    employee_id,
    last_name,
    salary,
    hire_date
FROM
    employees
--WHERE
--    employee_id IN( 100, 200, 300);
-- 수학의 집합의 성질을 이용한다. 
-- (1)중복 비허용 (2)튜플/컬럼 순서를 보장하지 않는다.

WHERE
    employee_id IN(100, 100, 200, 200, 300);    --집합원소유형 : 1.숫자

SELECT
    employee_id,
    last_name,
    salary,
    hire_date
FROM
    employees
WHERE -- 논리연산자(AND, OR, NOT)=(그리고, 또는, 부정)
    employee_id = 100
    OR employee_id = 200 
    OR employee_id = 300;
    
    
SELECT 
    employee_id,
    first_name,
    last_name,
    job_id,
    salary,
    hire_date
FROM
    employees
WHERE
    last_name IN('King', 'Abel', 'Jones');  --집합원소유형: 2. 문자열
    
SELECT 
    employee_id,
    last_name,
    salary,
    hire_date
FROM 
    employees
--WHERE   --집합원소유형: 3. 날짜
--    hire_date IN ('01/01/13', '07/02/07');
--    hire_date IN ('13/JAN/01', '07/FEB/07);

WHERE
    hire_date IN(
        to_date('01/01/13', 'RR/MM/DD'),
        to_date('07/02/07', 'RR/MM/DD')
        );
