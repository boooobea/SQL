--Cartesian Product 집합연산에 대해서 알아보자 
--두 테이블(==집합)A, B가 있을 때 C/P=|A| x |B|

SELECT 
    count(*)
FROM
    departments;

SELECT
    count(*)
FROM
    regions;          

SELECT 
    *
FROM 
    regions,              --4
    departments;          --27

--------------------------------------
-- The relationship beteen
-- parent(=master) table and child(=slave) table
-- child(=slave) table to refer to others
--------------------------------------
DESC employees;     --릴레이션의 스키마를 보여줌

SELECT 
    last_name, 
    department_id
FROM
    employees
ORDER BY 
    department_id ASC;

-- Parent(=Master) table to be referrend.
DESC departments;

SELECT 
    department_id,
    department_name
FROM
    departments
ORDER BY 
    department_id ASC;

--1.특정 직원의 부서번호 찾아내기 
SELECT 
    last_name, 
    department_id               --FK
FROM
    employees
WHERE 
    last_name = 'Whalen';

--2. 찾아낸 부서번호를 이용한 부서명 조회
SELECT 
    department_name
FROM
    departments
WHERE
    department_id = 10;

--------------------------------------
-- JOIN: 필요한 데이터가, 여러 테이블에 분산되어 있을 경우에,
-- 여러 테이블의 공통된 컬럼을 연결시켜, 원하는 데이터를 검색하는 방법을 
-- '조인'이라 한다. 
-- 조인은 검색하고자 하는 컬럼이 두개 이상의 테이블에 분산되어 있는 
-- 경우에 사용된다. 
--------------------------------------

