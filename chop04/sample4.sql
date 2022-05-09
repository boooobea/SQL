------------------------------------------
-- 5. HAVING 조건식
-- GROUP BY절에 의해 생성된 결과(그룹들)중에서, 지정된 조건에 일치하는 데이터를 추출할때 사용
-- (1) 가장 먼저, FROM절이 실행되어 테이블이 선택 
-- (2) WHERE절에 지정된 검색조건과 일치하는 행들이 추출 
-- (3) 이렇게 추출된 행들은, GROUP BY에 의해 그룹핑 된다. 
-- (4) HAVING절의 조건과 일치하는 그룹들이 추가로 추출된다. 
--  HAVING절까지 실행되면, 테이블의 전체 행들이 
--( WHERE:1차 필터링, HAVING: 2차필터링 ) 
-------------------------------------------

-- 각 부서별, 월급여 총계 구하기 
SELECT                      --4
    department_id, 
    sum(salary)
FROM                        --1
    employees
GROUP BY                    --2
    department_id
HAVING                      --3
--    sum(salary) >= 90000    --***필터링 조건 
--    department_id > 50;    
    avg(salary) > 10000    
ORDER BY                    --5
    department_id ASC;
    
-- 각 부서별, 직원수 구하기 
SELECT 
    department_id AS 부서번호,
--    count(department_id)       --사원의속성 : coun()는 null을 제거하고 체크한다.
    count(employee_id) AS 사원수   -- pk로 수량체크하는것이 적합 
--    count(*)                   -- * : all colums->하나의 객체
FROM 
    employees
GROUP BY 
    department_id      --null그룹도 생성됨 
HAVING
--    count(salary) >=6 
--    salary >= 3000                    --xx
--    department_id IN ( 10, 20 )       --ok
--    department_id>10                  --ok
    department_id IS NULL   
ORDER BY    
    1 ASC;
    
-- 각 부서별, 월급여 총계 구하기 
SELECT 
    department_id, 
    sum(salary)
FROM 
    employees
WHERE
    salary >= 3000          --1st.filtering(for records)
GROUP BY 
    department_id
HAVING 
    sum(salary) >= 90000    --2st.filtering(for gruop)
ORDER BY 
    department_id ASC;