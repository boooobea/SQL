--------------------------------------------------------
-- * ANSI Join * 
-- Oracle 이외의 관계형 데이터베이스에서도 사용가능한 표준 
-- 여러테이블의 조인 조건을 WHERE절에 명시하지 않고, 
-- 다른 방법을 통해(FROM절에 기재) 기술 
-- 검색조건을 WHERE절에 기재(조인조건과 검색조건을 분리)
-- 가독성 향상 

-- a. Cross Join
--      Oracle Cartesian Product
-- b. Natural Join
--      Equi Join
-- c. USING(Common Columns) or ON <Join Condition>
--      Oracle Equal Join
-- d. Join ~ ON 
-- e. {LEFT | RIGHT | FULL}OUTER JOIN
-- F. Self Join
--------------------------------------------------------
-- a.Cross Join 
-- 카티션 프로덕트와 동일 
-- 조인에 참여한 각 테이블의 레코드의 개수를 모두 곱한 결과 반환 
-- SELECT 테이블1.컬럼, 테이블2.컬럼
-- FROM 테이블1 CROSS JOIN 테이블2 
--------------------------------------------------------

SELECT 
    count(*)
FROM
    employees;

SELECT 
    count(*)
FROM
    departments;



SELECT 
    -- count(*)
    *
FROM 
    employees CROSS JOIN departments;
--------------------------------------------------------

SELECT 
    last_name,
    department_name
FROM
    employees CROSS JOIN departments
WHERE
    last_name = 'Bell';

--------------------------------------------------------
SELECT 
        -- t1.last_name,
        -- last_name,
        -- employees.last_name         --xx

        t2.department_name,
        department_name,
        -- department_name             --xx

        t1.manager_id,              --공통컬럼 지정시 별칭 지정
        -- t2.manager_id

        -- t2.department_id
FROM
    employees t1 CROSS JOIN departments t2;

--------------------------------------------------------
-- The same as Oracle Equal(= Equi) Join 
-- with implicitly columns automatically searched.
-- ------------------------------------------------------
-- b. Natural Join (자연조인)
-- 자연조인=동등조인 + 공통컬럼의 중복제거 
-- ------------------------------------------------------
-- 가. 두 테이블의 같은 이름을 가진 컬럼에 기반하여 동작.
-- 나. 두 테이블에 반드시 하나의 공통컬럼이 있어야 함.
-- 다. (*주의*) 만일, 두 개 이상의 공통컬럼이 존재하는 경우,
--     엉뚱한 결과를 생성할 수 도 있음.
--     즉, 두 개 이상의 공통컬럼 값이 동일한 레코드만 조회.
-- 라. 테이블 별칭(Table Alias)도 사용가능.
-- 마. (*주의*) SELECT절에 컬럼 나열시, 두 테이블의 공통컬럼을
--     나열할 때, 테이블명(또는 테이블별칭)을 사용하는 경우 오류발생
--
--     ** ORA-25155: NATURAL 조인에 사용된 열은 식별자를 가질 수 없음
-- ------------------------------------------------------
-- Basic Syntax) FROM절에, NATURAL JOIN 키워드 사용
--
--  SELECT 테이블1.컬럼 , 테이블2.컬럼
--  FROM 테이블1 NATURAL JOIN 테이블2
--  [WHERE 검색조건];
-- ------------------------------------------------------

SELECT 
    last_name,
    t1.department_id,
    t2.department_id,
    t1.manager_id,
    t2.manager_id,
    department_name
FROM
    employees t1,
    departments t2
WHERE
    -- 두 테이블의 공통컬럼 department_id으로 연결
    t1.department_id = t2.department_id;    --올바른 조인조건

    -- natural join의 경우 아래와 같다. 
    -- t1.department_id=t2.department_id
    -- AND t1.manager_id = t2.manager_id;


SELECT 
    last_name, 

    -- employees.department_id,      --공통컬럼1
    --ORA-25155: column used in NATURAL join cannot have qualifier
    --중복이 제거되어 나오기 때문에 한정자(테이블명, 테이블별칭) 사용시 오류발생 
    department_id,      --공통컬럼1
    manager_id,         --공통컬럼2
    department_name
    -- *
FROM
    -- 공통컬럼department_id,manager_id --> 엉뚱한 결과 도출
    employees NATURAL JOIN departments;

-------------------------------------------------------------
-- ANSI JOIN 수행시,
-- FROM절과 SELECT절에 테이블 별칭(Table alias)를 사용하는 경우 
-- SELECT절에 테이블별칭이 적용된, 두 테이블의 컬럼 나열시 
-- 테이블명.컬럼 형식으로 나열하면 오류발생(테이블별칭이 적용되었으면, 테이블별칭 사용가능(옵션))

SELECT 
-- 테이블명.으로 컬럼의 소속을 밝혀주는 것은 허용되지 않음(natural join)
    last_name,                      --테이블별칭 없어도가능
    t1.last_name,                   --테이블별칭 가능
    -- employees.last_name,         --xx

    department_name,                --테이블별칭 없어도가능
    t2.department_name,             --테이블별칭가능
    -- departements.department_name --xx

    --자연조인은, 중복된 컬럼을 제거하고 한번만 나오게 해주기 때문에 
    --그 결과로 모든 컬럼이 고유하다. 그러므로 소속을 밝힐 이유가 없다.
    manager_id                 --ok
    -- t1.manager_id               --xx
FROM 
    -- 공통컬럼1,2->엉뚱한 결과 도출 
    employees t1 NATURAL JOIN departments t2;
------------------------------------------------------

SELECT 
    last_name,
    department_name,
    department_id
FROM
    employees t1 NATURAL JOIN departments t2    --조인조건
WHERE
    department_id = 90;                         --검색조건


------------------------------------------------------
-- C. USING(column) , ON<Join Condition>
-- ------------------------------------------------------
-- The same as Oracle Equal Join
-- with explicitly columns manually determined.
-- ------------------------------------------------------
-- 가. Natural Join 에서 발생했엇던, 두 개 이상의 공통컬럼에 의해
--    발생가능한 엉뚱한 결과를 예방하기 위해, 명시적으로 조인할 컬럼
--    을 지정하는 방식의 조인
-- 나. Natural Join 과 마찬가지로, 두 테이블의 공통컬럼을 SELECT
--    절에 나열시, 테이블 별칭(Table Alis)이나 테이블명을 앞에
--    붙이는 경우, 오류발생
-- 다. USING(Common Columns):
--    반드시 공통컬럼 값이 일치하는 동등조인(Equal Join) 형식으로
--    실행된다.
-- 라. ON <Join condition>:
--    Non-equal Join 이나, 임의의 조건으로 Join 할 경우에 사용 
-- ------------------------------------------------------
-- USING(Common Columns):
-- FROM절에, [INNER] JOIN / USING 키워드 사용
--
-- SELECT 테이블1.컬럼 , 테이블2.컬럼
-- FROM 테이블1 [INNER] JOIN 테이블2 USING(공통컬럼)
-- [WHERE 검색조건];
-- ------------------------------------------------------
--  ON <Join condition>:
--  FROM절에, [INNER] JOIN / ON 키워드 사용
--
--  SELECT 테이블1.컬럼 , 테이블2.컬럼
--  FROM 테이블1 [INNER] JOIN 테이블2 ON 조인조건
--  [WHERE 검색조건];
-- ------------------------------------------------------

-- ------------------------------------------------------
-- 1. USING(Common Column1, Common Column1, ..)
-- ------------------------------------------------------
-- a. 반드시 공통컬럼값이 일치하는 동등조인(Equal Join) 형식으로 실행
-- b. column part of USING clause cannot have qualifier
-- ------------------------------------------------------
SELECT 
    -- USING절에 기재한 공통컬럼의 중복은 제거된다.NATURAL JOIN 기반

    -- t1.last_name ,
    -- last_name,
    -- -- employees.last_name  --테이블별칭이 설정되어 있으면 별칭을 사용하자.

    -- t2.department_name,
    -- department_name,

    department_id           --OK:공통컬럼
    ---- 두 테이블의 공통컬럼은 식별자를 가질 수 없다. 
    ---- departments.department_id,
    ---- t2.department_id
    
FROM
    employees t1 INNER JOIN departments t2
    --employees t1 JOIN departments T2      --INNER 생략가능
    USING(department_id);

------------------------------------------------------

SELECT 
    last_name,
    department_name,

    --두 테이블의 공통컬럼은 식별자를 가질 수 없음.
    department_id,          --공통컬럼1
    manager_id              --공통컬럼2
FROM
    employees t1 INNER JOIN departments t2  --INNER 생략가능
    USING(department_id, manager_id)
WHERE
    department_id = 90;     -- 검색조건


-- ------------------------------------------------------
-- 2. ON <Join Condition>
-- ------------------------------------------------------
-- Non-equal Join 이나, 임의의 조건으로 Join 할 경우에 사용 
-- ------------------------------------------------------

SELECT 
    -- t1.last_name,
    last_name,

    t2.department_name
    --department_name,

    -- t1.department_id        -- ok:공통조건
    -- t2.department_id        -- ok:공통조건
    -- departments.department_id   --xx:공통조건
    --ORA-00904: "DEPARTMENTS"."DEPARTMENT_ID": invalid identifier

FROM
    employees t1 INNER JOIN departments t2
    ON t1.department_id = t2.department_id;
    -- 명시적으로 조인조건 지정 

------------------------------------------------------    

-- WHERE절을 이용한 검색조건 추가 
SELECT 
    last_name,
    department_name,
    t1.department_id
FROM
    employees t1 INNER JOIN departments t2
    -- employees t1 JOIN departments t2     --INNER키워드 생략가능
    ON t1.department_id = t2.department_id  --조인조건
WHERE                            
    t1.department_id = 90;                  -- 검색조건


------------------------------------------------------ 

-- ON절에 검색조건 추가 
SELECT 
    last_name, 
    department_name,
    t1.department_id
FROM
    employees t1 INNER JOIN departments t2
    ON t1.department_id = t2.department_id  -- 조인조건
    AND t1.department_id = 90;              -- 검색조건(ON절에 검색추가(가독성저하))

------------------------------------------------------ 

-- ON절을 이용한, Self Join
SELECT 
    e.last_name AS 사원명, 
    m.last_name AS 관리자명 
FROM
    employees e INNER JOIN employees m
    ON e.manager_id = m.employee_id;

------------------------------------------------------ 

SELECT 
    e.last_name AS 사원명,
    d.department_name AS 부서명,
    g.grade_level AS 등급
FROM 
    employees e INNER JOIN departments d
    ON e.department_id = d.department_id

    JOIN job_grades g
    ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;

------------------------------------------------------
-- ANSI Join 에서도, 2개 이상의 테이블 조인 가능.
-- Eqaul(= Equi) 조인조건은 ON절 대신에, USING절 사용가능
-- 3개의 테이블 조인

SELECT 
    e.last_name AS 사원명, 
    d.department_name AS 부서명, 
    g.grade_level AS 등급 

FROM
    employees e JOIN departments d
    USING(department_id)                                    --Equal(=Equi)조인조건

    JOIN job_grades g
    ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;     --non-equal 조인조건


-- ------------------------------------------------------
-- E. { LEFT | RIGHT | FULL } OUTER JOIN
-- ------------------------------------------------------
-- The same as Oracle Outer Join.
--
-- 가. Oracle Outer Join에서는, (+) 연산자 사용
--     반드시, 한 쪽 테이블에서만 사용가능
-- 나. ANSI Outer Join에서는, LEFT / RIGHT / FULL 키워드 사용
--     어느 한 쪽 테이블 또는 양 쪽 테이블에서 모두 사용가능
-- 다. LEFT OUTER JOIN :
--      LEFT로 지정된 테이블1의 데이터를, 테이블2의 조인조건의
--      일치여부와 상관없이 모두 출력
-- 라. RIGHT OUTER JOIN :
--      RIGHT로 지정된 테이블2의 데이터를, 테이블1의 조인조건의
--      일치여부와 상관없이 모두 출력
-- 마. FULL OUTER JOIN :
--      LEFT OUTER JOIN + RIGHT OUTER JOIN
--      양쪽 테이블의 데이터를, 조인조건 일치여부와 상관없이 모두 출력 
-- 바. Oracle Outer Join 보다 향상
-- 사. 조인조건 명시할 때, ON절 또는 USING절 사용가능
-- ------------------------------------------------------
-- Basic Syntax)
--
--  SELECT 테이블1.컬럼 , 테이블2.컬럼
--  FROM 테이블1 { LEFT|RIGHT|FULL } OUTER JOIN 테이블2
--  ON 조인조건 | USING(컬럼)
--  [WHERE 검색조건];
-- ------------------------------------------------------

SELECT 
    e.last_name AS 사원명, 
    m.last_name AS 관리자명 

FROM 
    -- 일치하는 데이터가 없는 테이블의 별칭이 e를 가진 LEFT
    -- 이기 때문에, LEFT OUTER JOIN 지정하고, ON 절을 사용하여 조인조건 지정.

    -- employees e LEFT JOIN employees m        --OUTER생략가능

    -- employees e LEFT OUTER JOIN employees m
    -- employees e RIGHT OUTER JOIN employees m
    employees e FULL OUTER JOIN employees m

    ON e.manager_id = m.employee_id;