----------------------------------- 
-- 1. 단일(행) (반환)함수 
-- 단일(행) (반환)함수의 구분 :
-- (1) 문자 (처리)함수 : 문자와 관련된 특별한 조작을 위한 함수 
-- (2) 숫자 (처리)함수 
-- (3) 날짜 (처리)함수
-- (4) 변환 (처리)함수 : 숫자/문자/날자 데이터 간의 형변환 함수
--      a. TO_CHAR       - 숫자 데이터를 문자 데이터로 변환
--                         날짜 데이터를 문자 데이터로 변환
--      b. TO_NUMBER     - 문자->숫자
--      c. TO_DATE       - 문자->날짜 
-- (5) 일반 (처리)함수 
-- 단일(행) (반환)함수는, 테이블의 행 단위로 처리된다.
-----------------------------------
-- 1. 자동형변환(묵시적) - Promotion 
-- <NUMBER> <-> <CHARACTER> <-> <DATE>
-- 2. 강제형변환(명시적) - Casting
-- NUMBER - X -> DATE
-- DATE   - X -> NUMBER
-----------------------------------
-- 0. 자동형변환(Promotion) 예 
-- 문자 -> 숫자
-----------------------------------
DESC; 

SELECT
    last_name,
    salary
FROM
    employees
WHERE
    -- 자동형변환(Promotion)에 의해 비교연산 가능
    salary = '17000';

-----------------------------------
-- 1. to_char
-- 날짜 -> 문자 
--  TO_CHAR( hire_date, 'YYYY' )
-- 숫자 -> 문자
--  TO)CAHR( 123456, '999,999' )
-----------------------------------
-- 1. 날짜 -> 문자 
SELECT 
    --YYYY:4자리년도, MM:2자리 월, DD:2자리 일
    -- AM:오전/오후, DY:요일, HH(12시간제), HH24(24시간제)
    -- MI:2자리 분, SS:2자리 초 
    to_char(current_date, 'YYYY/MM/DD,(PM) DY HH24:MI:SS')
FROM
    dual;

SELECT 
    last_name,
    hire_date,
    salary
FROM
    employees
WHERE
    to_char(hire_date, 'MM') = '09';
    
SELECT
    to_char(sysdate, 'YYYY"년"MM"월"DD"일"') 날짜
--    to_char(sysdate, 'YYYY . MM . DD') 날짜
FROM
    dual;
    
-----------------------------------
-- 2. 숫자->문자 
-- to_char( 123456, '999,999' )
-----------------------------------
SELECT 
    to_char(1234,'99999')   AS "99999",
    to_char(1234,'099999')  AS "099999",
    to_char(1234,'$99999')  AS "$99999",
    to_char(1234,'99999.99')AS "99999.99",
    to_char(1234,'99,999')  AS "99.999",
    to_char(1234,'B9999.99')AS "B9999.99",
    to_char(1234,'B99999')  AS "B99999",
    to_char(1234,'L99999')  AS "L99999",
    to_char(1234) 
FROM
    dual;
-- 2. 화폐
SELECT
    last_name,
    salary,
    to_char(salary, '$999,999')달러 
FROM
    employees;

-----------------------------------
-- to_number
-- 문자->숫자
-----------------------------------
SELECT 
    to_number('123') + 100,     --casting**
    '456' + 100,                --promotion
    to_char(123)||'456',        --casting**
    123||'456'                  --promotion
FROM 
    dual;

-----------------------------------
-- 4. to_date
-- '날짜형태' 문자 -> 날짜 데이터로 변환 
-----------------------------------

ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD HH24:MI:SS';

-- 2. 응용
SELECT
    to_date('20170802181030','YYYYMMDDHH24MISS')
FROM
    dual;
    
SELECT
    sysdate,
    sysdate - to_date('20170101', 'YYYYMMDD'),
    current_date - to_date('20170101', 'YYYYMMDD')
FROM
    dual;