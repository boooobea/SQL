-- ***************************************
-- SELECT 문의 기본구조와 각 절의 실행순서 
--   -Clauses-              - 실행순서 -
-- SELECT clause                (5)
-- FROM clause                  (1)     ** 테이블조회
-- [WHERE clause]               (2)     ** 1차 필터링, 조건식(조건문)
-- [GROUP BY clause]            (3)     ** 그룹핑
-- [HAVING clause]              (4)     ** 2차 필터링 
-- [ORDER BY clause]            (6)     ** 정렬
-- ***************************************
-----------------------------------------------
--       *** SELECT 문의 기본문법 구조 *** 
-- SELECT [DISTINCT] { *, column[AS][alias], ...}
-- FROM <테이블명>
-- [WHERE <pridicates>]
-- [ORDER BY{ column|표현식 } [ASC|DESC] ]
-----------------------------------------------
-- ORDER BY clause 
-- 문법
--1. 숫자 데이터 정렬 
-----------------------------------------------
SELECT
    employee_id,
    last_name, 
    job_id,
    salary
FROM
    employees
--ORDER BY
--    salary;         --defalut:ASC(오름차순정렬) 
--ORDER BY
--    salary ASC;     --오름차순 정렬(ascending)
ORDER BY
    salary DESC;    --내림차순 정렬(descending)

-- ORDER BY절에 별칭(alias)사용 
SELECT
    employee_id,
    last_name,
    job_id,
    salary + 100 AS 월급
FROM
    employees
--ORDER BY
--    월급 DESC;        -- 컬럼별칭으로 정렬
ORDER BY
    salary + 100 DESC;  --표현식으로 정렬 
    
-- ORDER BY 절에 컬럼인덱스 사용
--(주의)Oracle은 인덱스가 1부터 시작한다.
SELECT
    employee_id,        --1
    first_name,         --2
    last_name,          --3
    job_id,             --4
    salary AS 월급       --5
FROM
    employees
--다른 대안이 없는 경우에만 사용(부작용이 있음)
--(SELECT절의 구성컬럼목록에 변경이 없다라는 조건하에) 
ORDER BY
    4 DESC;     --컬럼인덱스로 정렬
    
--------------------------------------------
-- 2. 문자 데이터 정렬 
--------------------------------------------
SELECT
    employee_id,
    last_name AS 이름,
    job_id,
    salary
FROM
    employees
--ORDER BY
--    last_name ASC;      --컬럼명으로 정렬 
ORDER BY
    이름 ASC;         --컬럼별칭으로 정렬 
--ORDER BY
--    2 ASC;           --컬럼인덱스로 정렬
    
SELECT * FROM dual;    --dual:SYS계정 소유 테이블, Dummy table
-------------------------------------------
-- 3. 날짜 데이터 정렬 
-------------------------------------------
SELECT
    employee_id,
    last_name,
    salary,
    hire_date AS 입사일
FROM
    employees
--ORDER BY
--    hire_date DESC;         --컬럼명으로 정렬 
ORDER BY
    입사일 DESC;           --컬럼별칭으로 정렬
--ORDER BY 
--    4 DESC;             --컬럼인덱스로 정렬

-------------------------------------------
-- 4. 다중컬럼 정렬 
-- 문법)
-- SELECT [DISTINCT] { *, column[AS][alias], ...}
-- FROM <테이블명>
-- [WHERE <pridicates>]
-- ORDER BY
-- { column1|표현식1 } [ASC|DESC],
-- { column1|표현식2 } [ASC|DESC];
-------------------------------------------
SELECT
    employee_id,
    last_name,
    salary,
    hire_date
FROM 
    employees
ORDER BY
    salary DESC,        -- 컬럼명1 내림자순
    hire_date ASC;      -- 컬럼명2 오름차순
    
-------------------------------------------
-- 5. NULL 값 정렬 
-- (주의) Oracle에서 가장 큰 값은 NULL값이다. 
-- (값이 없기 때문에, 값의 크기를 비교 불가)
-- 따라서, 내림차순 정렬시 가장 큰 값이 NULL이 된다. 
-------------------------------------------
SELECT 
    employee_id,
    last_name, 
    commission_pct
FROM
    employees
--ORDER BY
--    commission_pct DESC;        --컬럼명 내림차순
ORDER BY
    commission_pct ASC;         --컬럼명 오름차순 

-- (주의)관계형 데이터베이스의 테이블은, 수학의 집합과 동일 
-- 즉, 수학의 집합의 성질을 그대로 물려받음 
--      (1) 레코드의 순서를 보장하지 않음(무작위로 저장)
--      (2) 중복을 허용하지 않음
--          (단, 관계형 테이블은 중복행을 포함할 수는 있으나
--           기본키(PK)가 지정되어 있다면, 당연히 중복은 없다.)