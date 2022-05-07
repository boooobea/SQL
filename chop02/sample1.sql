-- ***************************************
-- SELECT 문의 기본구조와 각 절의 실행순서 
--   -Clauses-              - 실행순서 -
-- SELECT clause                (5)
-- FROM clause                  (1)     ** 테이블조회
-- WHERE clause                 (2)     ** 1차 필터링, 조건식(조건문)
-- GROUP BY clause              (3)     ** 그룹핑
-- HAVING clause                (4)     ** 2차 필터링 
-- ORDER BY clause              (6)
-- ***************************************

-----------------------------------------------
--       *** SELECT 문의 기본문법 구조 *** 
-- SELECT [DISTINCT] { *, column[AS][alias], ...}
-- []선택 , {}필수선택- *:all(모든컬럼), [AS][별칭]:별칭생성 
-- FROM <테이블명>
-----------------------------------------------
-- 1. To project all columns of the table 
-----------------------------------------------
-- SELECT * 
-- FROM table;

SELECT *                     -- * : 와일드카드 문자(wildcard)
FROM employees;

SELECT * 
FROM departments;

-----------------------------------------------
-- 2. To project only the specified columns of the table
-- SELECT column1[ , column2, ..., columnN]
-- FROM table;
-----------------------------------------------
SELECT
    employee_id,
    last_name,
    hire_date,
    salary
FROM
    employees;

-----------------------------------------------
-- 3. 산술연산자의 활용( +, - , * , / )
-- SELECT column1 + column2 FROM table;
-- SELECT column1 - column2 FROM table;
-- SELECT column1 * column2 FROM table;
-- SELECT column1 / column2 FROM table;
-----------------------------------------------
SELECT 
    salary,
    salary + 100
FROM
    employees;
    
SELECT
    salary,
    salary - 100
FROM
    employees;
    
SELECT
    salary,
    salary * 100
FROM
    employees;
    
SELECT
    salary,
    salary / 100
FROM
    employees;

SELECT
    last_name,
    salary,
    salary * 12
FROM
    employees;


DESCRIBE employees;     --테이블 스키마를 보여줌(***)
DESCRIBE dual;
------------------------------------------
-- 4. About SYS.DUAL table
-- SYS account owns this DUAL table.
-- If you don't need a table, the DUAL table needed.
------------------------------------------
SELECT
    245 * 567 
FROM
    dual;       -- 더미 테이블, MySQL/Mariadb/Postgresql에서는 생략가능 
    
SELECT * 
FROM dual;

DESC sys.dual;
DESC dual;

SELECT
    *
FROM
    sys.dual;