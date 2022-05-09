--------------------------------------
-- 4. GROUP BY clause 
--------------------------------------
--(Basic syntax)
--  SELECT
--      [단순컬럼1,]
--      [단순컬럼n,]
--
--      [표현식1,]
--      [표현식2,]
--
--      그룹함수1,
--      그룹함수2,
--      그룹함수n
-- FROM table
-- GROUP BY {단순컬럼1,...단순컬럼n|표현식1,...,표현식n}
-- HAVING 조건식 
-- ORDER BY clause;
--------------------------------------
-- *주의할 점1*
-- group by 
SELECT 
    DISTINCT department_id          --NULL포함 
FROM 
    employees
WHERE
    department_id IS NOT NULL;
    
-- 부서별 GROUP BY(AVG함수) 
SELECT 
    department_id AS 부서번호,      --그룹생성 단순컬럼
--    salary,
    avg(salary) AS 평균월급         --각 그룹마다 적용될 그룹함수
FROM
    employees
GROUP BY 
    department_id                 --NULL도 그룹으로 생성(*주의*)
ORDER BY
    부서번호 ASC;
    
-- 부서별 group by(max함수) 
SELECT 
    department_id AS 부서번호,      --그룹생성 단순컬럼
    min(salary) AS 최소월급,        --각 그룹마다 적용될 그룹함수1
    max(salary) AS 최대월급         --각 그룹마다 적용될 그룹함수2
FROM
    employees
GROUP BY 
    department_id       --OK
--    1                 --X:컬럼인덱스X
--    부서번호            --X
ORDER BY
--  1 ASC;              --사용하지말것
-- department_id ASC;   --정석
--    부서번호 ASC;
-- SELECT 절(중간 SET)을 기준으로 ORDER BY함 
--    salary ASC;    
--    min(salary);
    최소월급 DESC;

-- 다중컬럼 GROUP BY 
SELECT 
    to_char( hire_date, 'YYYY') AS 년,       --다중그룹생성 표현식1
    to_char( hire_date, 'MM') AS 월,         --다중그룹생성 표현식2
    sum(salary)                             --각 그룹마다 적용될 그룹함수
--    last_name       --xx:반환값의 개수:107논리와 목적에 적합하지 않음
FROM 
    employees
GROUP BY 
    to_char(hire_date,'YYYY'),              --다중그룹생성 표현식1
    to_char(hire_date,'MM')                 --다중그룹생성 표현식2
ORDER BY
    년 ASC;