-----------------------------------------
-- 5. 인라인 뷰(Inline View)
-----------------------------------------
-- 가. 뷰(View) : 실제 존재하지 않는 가상의 테이블 
-- 나. FROM절에 사용된 서브쿼리를 의미
-- 다. 동작방식이 뷰(View)와 비슷하다.
-- 라. 일반적으로, FROM절에는 테이블이 와야 하지만, 서브쿼리가 
--      마치 하나의 가상의 테이블처럼 사용가능
-- 마. 장점:
--      실제로 FROM절에서 참조하는 테이블의 크기가 클 경우,
--      필요한 행과 컬럼만으로 구성된 집합(Set)을 재정의하여,
--      쿼리를 효율적으로 구성가능
-----------------------------------------
-- SELECT select_list
-- FROM ( sub-query ) alias   (**alias필수**)
-- [ WHERE 조건식 ]
-----------------------------------------

-- 각 부서별, 총 사원수 / 월급여 총계 / 월급여 평균 조회
-- Oracle Inner Join( Equi Join ) 사용방식 
SELECT 
    e.department_id,
    sum(salary) AS 총합, 
    avg(salary) AS 평균,
    count(*) AS 인원수
FROM --CROSS JOIN(Catesian Product)
    employees e,
    departments d
WHERE
    e.department_id = d.department_id   --조인조건(공통컬럼지정)
GROUP BY 
    e.department_id
ORDER BY
    1 ASC;

-- 위 조인 쿼리를, 좀 더 효율적으로 수행가능한 형식으로 변경
-- 인라인 뷰(Inline View)사용
SELECT
    e.department_id,
    d.department_name,
    총합,
    평균,
    인원수
FROM
    ( 
        SELECT
            department_id,
            sum(salary) AS 총합,
            avg(salary) AS 평균,
            count(*) AS 인원수
            -- * 대신 employee_id(PK)를 넣는다.
            -- ** 함수는 컬럼명으로 메인쿼리에서 사용할 수 없다.alias사용 
        FROM
            employees
        GROUP BY
            department_id
    ) e,
    departments d
WHERE
    e.department_id = d.department_id   --조인조건(공통컬럼지정)
ORDER BY
    1 ASC;