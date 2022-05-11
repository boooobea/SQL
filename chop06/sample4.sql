-----------------------------------------
-- 4. 다중컬럼 sub-query
-----------------------------------------
-- 가. 서브쿼리에서, 여러 컬럼을 조회하여 반환
-- 나. 메인쿼리의 조건절에서는, 서브쿼리의 여러 컬럼의 값과 일대일
--      매칭되어 조건판단을 수행해야 함.
-- 다. 메인쿼리의 조건판단방식에 따른 구분:
--  (1) Pairwise 방식
--      컬럼을 쌍으로 묶어서, 동시에 비교
--  (2) Un-pairwise 방식
--      컬럼별로 나누어 비교, 나중에 AND 연산으로 처리
-----------------------------------------

SELECT 
    last_name,
    department_id,
    salary
FROM
    employees
WHERE
    --메인쿼리:복수행 서브쿼리가 사용 되었으므로, 복수값과 연산가능한 연산자 사용(IN)
    --컬럼을 쌍으로 동시에 비교(**Pairwise 방식**)
    --동시에 만족하는 경우에만 참(true)으로 판단 

    --<<부서별로 가장 많은 월급여를 받는 사원정보 조회>>
    ( department_id, salary) IN (
        SELECT 
            department_id,
            max(salary)
        FROM
            employees
        GROUP BY
            department_id --NULL그룹도 포함
    )
ORDER BY
    2 ASC;

----"부서별 최소급여"보다 적은 급여를 받는 직원을 출력하라 

SELECT 
    last_name,
    department_id,
    salary
FROM
    employees
WHERE
    (department_id, salary) IN (
        SELECT
            department_id,
            min(salary)
        FROM
            employees
        GROUP BY
            department_id
    )
ORDER BY
    department_id ASC;

