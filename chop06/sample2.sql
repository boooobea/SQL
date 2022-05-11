-------------------------------------------
-- 2.단일행 Sub-quary
-------------------------------------------
-- 가. 하나의 행을 반환 
-- 나. 반드시 단일 행 서브쿼리를 사용해야 하는 경우 :
--      - 기본키(Primary Key)를 이용하는 경우 
--      - 그룹함수(max,min,sum 등)를 이용하는 경우 



-------------------------------------------
--(1)평균 월급여보다 많은 월급을 받는 사원조회 
-------------------------------------------
-- 평균 급여를 먼저 구하기 위해, 단일 행 서브쿼리 및 그룹함수 agv사용
-- 따라서, 메인쿼리에서 사용가능한 연산자는 하나의 값과 비교하는 비교연산자 

SELECT 
    last_name, 
    salary,
    ( SELECT avg(salary) FROM employees) AS 평균급여
FROM
    employees 
WHERE
    --메인쿼리 : 단일 행 서브쿼리가 사용되었으므로, 단일값과 비교가능한, 비교연산자 사용
    salary >= (
        -- 단일 행 비상관 서브쿼리:모든 사원의 평균 월급여 반환
        -- 메인쿼리로 결과값 전달 
        SELECT 
            avg(salary)
        FROM
            employees 
    );
---
SELECT 
    last_name, 
    salary,
    ( SELECT avg(salary) FROM employees) AS 평균급여
FROM
    employees t1
WHERE
    salary >= (
        SELECT 
            avg(salary)
        FROM
            employees t2
        WHERE
            t1.last_name = t2.last_name
    );

-----
-- 각 사원 중에, 'Whalen'의 급여보다 더 많이 받는 사원의 이름과 급여를 출력하라 
-- 소속부서명도 출력
SELECT 
    last_name,
    salary,
    
    (SELECT department_name 
    FROM departments t2
    WHERE t2.department_id = t1.department_id ) AS 소속부서
FROM
    employees t1
WHERE
    salary > (
        SELECT 
            salary
        FROM
            employees
        WHERE
            last_name = 'Whalen'
    );
-----
-- 각 사원의 관리자명을 추출해보자(셀프조인을 서브쿼리로 해결)

SELECT 
    --사번, 관리자사번
    employee_id,
    manager_id, 
    -- 관리자의 이름도 추출 
    (  
        SELECT last_name
        FROM employees t2
        WHERE t1.manager_id = t2.employee_id
    ) AS 관리자명
FROM
    employees t1;
    
-----
-- IT부서의 프로그래머의 이름, 급여, 평균급여를 출력 
SELECT 
    --이름,급여
    last_name,
    salary,
    (   --비상관 부속질의(Sub_query)
        SELECT avg(salary)
        FROM employees
        WHERE Job_id = 'IT_PROG'
    ) AS 평균급여 -- shape(1,1)
FROM
    employees 
WHERE
    Job_id = 'IT_PROG';

----- 우리회사의 전체부서를 대상으로, 
--    각 부서별, 부서번호와 소속 인원수를 출력하라 
SELECT 
    department_id AS 부서번호,
    --부서명도 출력
    (
      SELECT department_name
      FROM departments t1
      WHERE t1.department_id = t2.department_id
     ) AS 부서명,
    
    count(employee_id) AS 사원수
FROM
    employees t2
GROUP BY
    department_id;

----- FROM절에 sub-query를 사용해보자 
-- 우리회사 전직원중에, 급여가 10000달러 이상인 직원의 이름과 급여를 출력하라 
-- 컬럼수가 아주 많은 테이블로부터, 출력하고자 하는 컬럼의 수가 적을 때 
-- 메모리 자원의 효율성이 떨어진다(DB는 테이블을 메모리에 올려놓고 작업하기 때문에)

SELECT 
    last_name,
    salary
FROM
    -- employees
    -- FROM 절에 나온 서브쿼리가 만들어낸 결과셋(테이블)을 '인라인뷰'라고 한다.
    -- 필요한 데이터만 추출하여 작업시간을 줄이고 효율성이 좋다.
    (
        SELECT last_name, salary
        FROM employees
        WHERE salary > 10000
    ) t;
-- WHERE
--     salary > 10000;

-----
-- 우리 회사 전 직원중에,급여가 5000 달러 이상을 받는, 부서번호의 
-- 목록을 출력하라
-- 부서번호 목록을 구했다면, 각 부서별 사원수를 출력하라

SELECT 
    department_id,
    department_name
FROM
    departments 
WHERE
    department_id IN (
        SELECT department_id
        FROM employees 
        WHERE 
            salary > 5000 
            AND department_id IS NOT NULL
    );

SELECT
    -- DISTINCT 
    department_id
FROM
    employees 
WHERE 
    salary > 5000 
    AND department_id IS NOT NULL;

--
SELECT
    department_id AS 부서번호,
    count(*) AS 사원수
FROM
    employees 
WHERE 
    salary > 5000 
    AND department_id IS NOT NULL
GROUP BY --(중복제거)
    department_id;