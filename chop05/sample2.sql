-- ------------------------------------------------------
-- 1. Oracle Join
-- ------------------------------------------------------
--  가. Oracle에서만 사용되는 조인
--  나. 특징: 여러 테이블을 연결하는 조인조건을 WHERE절에 명시
-- ------------------------------------------------------
--  a. Catesian Product (카테시안 프로덕트)
--  b. Equal(= Equi) Join (동등 조인)
--  c. Non-equal(= Non-equi) Join (비동등 조인)
--  d. Self Join (셀프 조인)
--  e. Outer Join (외부 조인)
-- ------------------------------------------------------
-- A. Catesian Product (카티션 프로덕트)
-- ------------------------------------------------------
-- 두 개 이상의 테이블을 공통컬럼없이 연결하는 조인으로,
-- 모든 조인에서 가장 먼저 발생하는 조인이자 기본이 됨.
--  가. 유효한 데이터로 사용되지 못함.
--  나. 조인조건이 생략된 경우에 발생.
--
-- * 조인결과: 테이블1 x ... x 테이블n 개의 레코드 생성
-- ------------------------------------------------------
-- Basic Syntax)
--  SELECT 테이블1.컬럼 , 테이블2.컬럼
--  FROM 테이블1, 테이블2
-- ------------------------------------------------------
SELECT 
    last_name,
    department_name
FROM
    employees,
    departments;
    
--------------------------------------
-- b. Equal(=Equi) Join(동등 조인) 
--------------------------------------
-- 가. 가장 많이 사용하는 조인 
-- 나. 두 테이블에서, 공통으로 존재하는 컬럼의 값이 일치하는 행들을 
--      연결하여 데이터를 반환.
-- (조인조언:병합가능해야 함,Union Compatible)
--      일치하지 않는 데이터는 제외된다. 
-- 다. 대부분, 기본키(PK)를 가진 테이블(Parent, Master)과 
--      참조키(FK)를 가진 테이블(child, slave)을 조인할 때 사용(***) 
--------------------------------------
-- SELECT 테이블1.컬럼, 테이블2.컬럼
-- FROM 테이블1, 테이블2 
-- WHERE 테이블1.공통컬럼 = 테이블2.공통컬럼;
--------------------------------------
SELECT 
    last_name, 
    
    employees.department_id,                -- FK
    departments.department_id,              -- PK
    
    department_name
FROM                    -- FROM절은, 두개의 테이블이 지정됨(CP연산수행)
    employees,
    departments
WHERE
    employees.department_id = departments.department_id;

--------------------------------------
-- 공통칼럼 사용시, 모호성 제거 
--------------------------------------
SELECT 
    last_name,
    department_name,
    departments.department_id   --소속연산자:column ambiguously defined
-- 공통컬럼 사용시 소속사용자를 사용하여 밝혀야 에러가 나지 않는다. 
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id;
    
--------------------------------------
-- 테이블에 별칭 사용 
--------------------------------------
-- 가. SELECT절에서 컬럼별칭을 사용했듯이 FROM절에서도 테이블별칭 사용가능 
-- 나. 테이블명이 길거나, 식별이 힘든 경우에 유용하다.
-- 다.(*주의*)테이블 별칭을 지정한 경우에는, 반드시 이 별칭을 사용하여 컬럼을 참조해야 한다. 
--      만일, 테이블 별칭을 사용하지 않고, 테이블명으로 컬럼을 참조하면 
--      테이블명을 별칭으로 인식하기 때문에 오류 발생.
--------------------------------------
-- SELECT alias1.컬럼, alias2.컬럼
-- FROM 테이블1 alias1, 테이블2 alias2
-- WHERE alias1.공통컬럼 = alias2.공통컬럼;
-- 테이블 별칭은 AS 키워드 사용하지 않는다.(***)
--------------------------------------

-- 테이블 별칭(alias)사용

SELECT 
    emp.last_name,              --성
    dept.department_name,       --부서명
    employees.department_id     --부서번호
FROM
    employees emp,          --emp:테이블별칭
    departments dept        --dept:테이블별칭
WHERE
    emp.department_id = dept.department_id;

-- 테이블 별칭(alias)사용시 주의할 점 
-- ORA-00904: "EMPLOYEES"."DEPARTMENT_ID": 부적합한 식별자

SELECT 
    emp.last_name,
    department_name,
    emp.department_id
FROM
    employees emp,          --emp
    departments dept        --dept
WHERE
    empoyees.department_id = dept.department_id;    --조인조건(**)
--------------------------------------
-- 검색조건 추가 
--------------------------------------
-- 가. Oracle 조인에서는 WHERE절에 AND/OR연산자를 사용하여 
--      조인조건에 검색조건을 추가할 수 있다. 
-- 나. WHERE의 어떤 조건이 조인조건이 되고,
--      어떤조건이 검색조건인지, 쉽게 파악이 안되어 가독성이 떨어짐 
-- 다. (***)따라서, 조인조건을 우선 명시하고 나중에 검색조건을 명시하는 방법으로 
--      가독성을 향상 시켜야 한다.
-- 라. 결과:조인조건의 결과 중에서, 검색조건으로 필터링 된 결과를 반환 
--------------------------------------

SELECT 
    emp.last_name, 
    salary,
    department_name
FROM
    employees emp,
    departments dept
WHERE
    emp.department_id = dept.department_id  --조인조건
    AND last_name='Whalen';                 --검색조건
    

SELECT 
    --d.department_name AS 부서명,
    department_name AS 부서명, 
    -- count(e.employee_id) AS 인원수,
    count(employee_id) AS 인원수 
FROM
    employees e,
    departments d 
WHERE
    e.department_id = d.department_id          --조인조건
    AND to_char( hire_date, 'YYYY') <= 2005    --검색조건
GROUP BY 
    -- d.department_name;
    department_name;            --옵티마이저가 식별가능할시 별칭식별 안넣어도 됨.
    
-- 테이블별칭으로 간단하게->조인조건확인-> 그룹by들어가야하는지 확인 

-- ------------------------------------------------------
-- C. Non-equal(= Non-equi) Join (비동등 조인) / 세타조인
-- ------------------------------------------------------
-- 가. WHERE절에 조인조건을 지정할 때, 동등연산자(=) 이외의,
--     비교 연산자(>,<,>=,<=,!=)를 사용하는 조인
-- (***) 범위, 비교가 필요할때 사용하는 조인 
-- ------------------------------------------------------
DROP TABLE job_grades PURGE;    --테이블삭제 

CREATE TABLE  job_grades (
    grade_level VARCHAR2(3) -- 월급여등급
        CONSTRAINT job_gra_level_pk PRIMARY KEY,
    lowest_sal NUMBER,      -- 최소 월급여
    highest_sal NUMBER      -- 최대 월급여
);
DESC job_grades;

INSERT INTO job_grades VALUES('A', 1000, 2999);
INSERT INTO job_grades VALUES('B', 3000, 5999);
INSERT INTO job_grades VALUES('C', 6000, 9999);
INSERT INTO job_grades VALUES('D', 10000, 14999);
INSERT INTO job_grades VALUES('E', 15000, 24999);
INSERT INTO job_grades VALUES('F', 25000, 40000);

COMMIT;

SELECT * FROM job_grades;

-- 2개의 테이블 조인
SELECT 
    last_name,
    salary,
    grade_level
FROM
    employees e,
    job_grades g
WHERE
    -- e.salary BETWEEN 1000 AND 3000;
    e.salary BETWEEN g.lowest_sal AND g.highest_sal     -- 데이터의 일관성 확보
    AND last_name = 'Bell';     

-- 범위BETWEEN ...job_grades테이블 확인 후 범위를 지정 

    
-- 3개의 테이블 조인 
SELECT 
    last_name,
    salary,
    department_name,
    grade_level
FROM 
    employees e,
    departments d,
    job_grades g
WHERE                                       --조건N => n-1 ... 3개테이블 조인시 조건2개발생 
    e.department_id = d.department_id       --동등조인
    AND e.salary BETWEEN g.lowest_sal AND g.highest_sal;    --비동등조인(세타조인)

------------------------------------------------------
-- d. Self Join(셀프조인)
------------------------------------------------------
-- 하나의 테이블만 사용하여, 자기자신을 조인할 수 있다.
-- 가. FROM절에 같은 테이블을 사용해야 함.
-- 나. 따라서, 반드시 테이블 별칭을 사용해야 함.
-- 다. 테이블 하나를, 두 개 이상으로 self 조인가능 
-- 라. 하나의 테이블을, 마치 여러 테이블을 사용하는 것처럼, 
--      테이블 별칭을 사용하여 조인하는 방법
------------------------------------------------------

-- 1. 사원이름과 담당관리자 사원번호를 필요로 하는 경우 
SELECT 
    last_name,
    employee_id,       --자신의사번
    manager_id         --자신의 관리자 사번
FROM
    employees
WHERE
    -- employee_id= 101;
    employee_id=100;


-- 2. 사원이름과 담당관리자 이름을 필요로 하는 경우, 불가능 
-- 사원테이블과 사원테이블과 동일한 구조의 담당관리자 테이블이 있다면 
-- : 두 테이블 조인을 통해, 원하는 데이터의 조회가능 
--   실제 존재하지 않는 관리자 테이블 생성은, 테이블 별칭(alias)을 이용하여,
--   가상의 관리자 테이블을 생성한다(***)

SELECT 
    manager_id,     --관리자 사번
    last_name       --나의 이름
FROM
    employees e
ORDER BY 
    last_name ASC;


SELECT 
    e.employee_id AS 직원사번,
    e.last_name AS 사원명,
    e.manager_id AS 관리자사번1,
    m.employee_id AS 관리자사번2,
    m.last_name AS 관리자명
FROM
    employees e,
    employees m
WHERE
    e.manager_id = m.employee_id;


-- self 조인을 위한 가상 테이블 생성(**)
SELECT 
    -- 사원 테이블의 컬럼들
    e.employee_id AS 사원번호, 
    e.last_name AS 사원명,
    e.manager_id AS 관리자번호, 

    -- 관리자 테이블의 컬럼등
    m.employee_id AS 사원번호,
    m.last_name AS 관리자명 
FROM
    employees e,        -- 사원정보 : 자식
    employees m         -- 관리자 정보(가상) : 부모
WHERE
    e.manager_id = m.employee_id;

------------------------------------------------------
-- E. Outer Join(외부조인)(*****)
------------------------------------------------------
-- Join 조건에 부합하지 않아도, 결과값에 누락된 데이터를 포함시키
-- 는 방법:
--  가. Inner Join (Equal, Non-Equal, Self Join):
--      조인결과는 반드시, 조인조건을 만족하는 데이터만 포함하는 조인
--  나. (+) 연산자를 사용한다.
--  다. (+) 연산자는, 조인대상 테이블들 중에서, 한번만 사용가능
--  라. (+) 연산자는, 일치하는 데이터가 없는 쪽에 지정
--  마. (+) 연산자의 지정:
--      내부적으로, 한 개 이상의 NULL 가진 행이 생성되고,
--      이렇게 생성된 NULL 행들과 데이터를 가진 테이블들의 행들
--      이 조인하게 되어, 조건이 부합하지 않아도, 결과값에 포함됨
-- 원래 테이블이 가지고 있던 행들 중 탈락한 행들을 살리는 것
--------------------------------------------------------
-- Basic Syntax)
--
--  SELECT 테이블1.컬럼 , 테이블2.컬럼
--  FROM 테이블1 , 테이블2
--  WHERE 테이블1.공통컬럼 = 테이블2.공통컬럼 (+);
--------------------------------------------------------
    
SELECT 
    e.employee_id AS 사원번호,
    e.manager_id AS 관리자번호,
    e.last_name AS 사원명,
    m.last_name AS 관리자명 
FROM
    employees e,        -- 사원 정보
    employees m         -- 관리자 정보(가상)
WHERE
    --FK            --PK
    e.manager_id = m.employee_id;       --동등조인 


SELECT 
    e.last_name AS 사원명, 
    m.last_name AS 관리자명 
FROM 
    employees e,
    employees m
WHERE
    -- e.manager_id = m.employee_id(+);        --(+) : Left외부조인 연산자(Oracle Only)
     e.manager_id (+) = m.employee_id;       --(+) : Right외부조인 연산자(Oracle Only)
    -- e.manager_id (+) = m.employee_id(+);       --(+) : Full외부조인 지원안함 
    --  AND m.last_name = 'lorentz';        --check 조건

--------------------------------------------------------
-- 각 사원의 '관리자의 관리자'가 누구인지를 찾아내기 위해
-- 셀프조인을 2번 하는 것이다. 

SELECT 
    e.last_name AS 사원명,
    m.last_name AS 관리자명,
    n.last_name AS "관리자의 관리자명"
    -- *
FROM
    employees e,        --사원
    employees m,        --관리자
    employees n         --관리자의 관리자
WHERE --Equi Join with 3 table
    e.manager_id = m.employee_id
    AND m.manager_id = n.employee_id;
    -- AND e.last_name = 'Whalen';

--------------------------------------------------------
SELECT 
    e.last_name AS 사원명,
    m.last_name AS 관리자명,
    n.last_name AS "관리자의 관리자명"
FROM
    employees e,
    employees m,
    employees n
WHERE
    -- 사원중에서 관리자가 없는 사원까지 포함
    e.manager_id = m.employee_id(+)
    -- 관리자 중에서, 관리자가 없는 관리자까지 포함
    AND m.manager_id = n.employee_id(+);

--------------------------------------------------------

SELECT 
    --사원테이블의 컬럼
    e.employee_id,
    e.last_name,
    e.department_id,

    --부서테이블의 컬럼
    d.department_id,
    d.department_name
FROM
    employees e,
    departments d 
WHERE
    -- e.department_id = d.department_id;  --eqit join
    -- e.department_id = d.department_id(+); --Left outer join
    e.department_id(+) = d.department_id; --Left outer join