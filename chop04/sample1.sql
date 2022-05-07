--------------------------------------
-- 2. 그룹(처리)함수 
-- (1) SUM
-- (2) AVG
-- (3) MAX
-- (4) MIN
-- (5) COUNT
-- * 그룹(처리)함수는 1)여러 행 또는 2)테이블 전체에 대해
--   함수가 적용되어, 하나의 결과를 반환한다. 
--------------------------------------
-- 1) SUM 
-- 해당 열의 총합계를 구한다(**NULL값 제외**)
-- SUM([DISTINCT | ALL ] column )
--    DISTINCT : excluding duplicated values
--    ALL : inclouding duplicated values.(생략시 all) 
--------------------------------------
SELECT 
    sum(DISTINCT salary),
    sum(ALL salary),
    sum(salary)
FROM
    employees;

--------------------------------------
-- 2) AVG 

SELECT 
    sum(salary),
    avg(DISTINCT salary),
    avg(ALL salary),
    avg(salary)
FROM
    employees;
    
--------------------------------------
-- 3. MAX
--    MIN 

SELECT 
    max(salary),
    min(salary)
FROM
    employees;
    
-- BIOS/CMOS에서, long타입의 밀리초단위로 '정수'로 관리된다.
--(표준시:1970/01/01 00:00:00)
SELECT 
    min(hire_date),
    max(hire_date)
FROM
    employees;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD HH24:MI:SS';

--------------------------------------
-- 4. count 
-- 행의 개수를 카운트한다(컬럼명 지정하는 경우, NULL값 제외) 
-- 문법)count( { [[DISTINCT | ALL | column ] | * })
--------------------------------------
SELECT
    count(last_name),
    count(commission_pct)
FROM
    employees;
    
SELECT
    count(job_id),
    count(DISTINCT job_id)
FROM
    employees;
    
-- 해당 테이블의 전체 레코드 개수 구하기 
SELECT 
    count(*),
    count(commission_pct),
    count(employee_id)
FROM
    employees;
    
--------------------------------------
-- 3. 단순컬럼과 그룹함수 : 함께 사용 불가 
-- a. 단순컬럼 : 그룹 함수가 적용되지 않는다. 
-- b. 그룹함수 : 여러 행(그룹) 또는 테이블 전체에 대해 적용
--              하나의 값을 반환 
--------------------------------------
SELECT 
    max(salary)     --return only 1 value.
FROM
    employees;
    
--단순컬럼과 그룹함수 함께 사용불가 
--Error:00937. 00000 -  "not a single-group group function"
SELECT
    last_name,      --return 107 value.
    max(salary)     --return only 1 value.
FROM
    employees;