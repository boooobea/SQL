-----------------------------------
-- 1. 단일(행) (반환)함수  
-- 단일(행) (반환)함수의 구분 :
-- (1)문자 (처리)함수 : 문자와 관련된 특별한 조작을 위한 함수 
--      a.INITCAP   -첫글자만 대문자로 변경
--      b.UPPER     -모든 글자를 대문자로 변경 
--      c.LOWER     -모든 글자를 소문자로 변경
--      d.CONCAT    -두 문자열 연결
--      e.LENGTH    -문자열의 길이 반환
--      f.INSTR     -문자열에서, 특정 문자열의 위치(인덱스)반환
--      g.SUBSTR    -문자열에서, 부분문자열(Substring)반환
--      h.REPLACE   -문자열 치환(replace)
--      i.LPAD      -문자열 오른쪽 정렬 후, 왼쪽의 빈 공간에 지정문자 채우기(padding)
--      j.RPAD      -문자열 왼쪽 정렬 후, 오른쪽의 빈 공간에 지정문자 채우기(padding)
--      k.LTRIM     -문자열의 왼쪽에서, 지정문자 까지 삭제(trim)
--      l.RTRIM     -문자열의 오른쪽에서, 지정문자 까지 삭제(trim)
--      m.TRIM      -문자열의 왼쪽/오른쪽/양쪽에서, 지정문자 삭제(trim)
--                   (단, 문자열의 중간은 처리못함)
-- (2) 숫자 (처리)함수 
-- (3) 날짜 (처리)함수
-- (4) 변환 (처리)함수
-- (5) 일반 (처리)함수 
-- 단일(행) (반환)함수는, 테이블의 행 단위로 처리된다.
-----------------------------------
-- (1) INITCAP
--      첫 글자만 대문자로 변경
-----------------------------------
SELECT
    'ORACLE SQL',
    initcap('ORACLE SQL')     --공백으로 띄워져 있어서 각 글자의 첫글자 반영 
FROM
    dual;
    
SELECT
    email,
    initcap(email)
FROM
    employees;
    
-----------------------------------
-- (2) UPPER
-- 모든 글자를 대문자로 변경 
-----------------------------------
SELECT
    'Oracle Sql',
    upper('Oracle Sql')
FROM
    dual;
    
SELECT
    last_name,
    upper(last_name)
FROM
    employees;
    
SELECT 
    last_name,
    salary
FROM
    employees
--WHERE
--    upper(last_name) = 'KING';      --Decommendation : 칼럼가공시 인덱스 사용 못함.
WHERE
    last_name = initcap('KING');    --Recommendation 
    
-----------------------------------
-- (3) LOWER
-- 모든 글자를 소문자로 변경 
-----------------------------------
SELECT 
    'Oracle Sql',
    lower('Oracle Sql')
FROM
    dual;
    
SELECT
    last_name,
    lower(last_name)
FROM
    employees;
    
-----------------------------------
-- (4) CONCAT 
-- 두 문자열 연결(Concatenation) 
-----------------------------------
--SELECT 
--    -- || (Concatenation operator)== concat function
--    'Oracle' || 'Sql',
--    concat('Oracle', 'Sql')
SELECT
    -- || (Concatenation operator)== concat function
    'Oracle'||'Sql'||'third',
    concat( concat('Oracle','Sql'),'third')
FROM
    dual;
    

SELECT
    -- || (Concatenation operator)== concat function
    last_name || salary,
    concat (last_name, salary)
FROM
    employees;
    
SELECT 
    -- || (Concatenation operator)== concat function
    last_name || hire_date,
    concat(last_name, hire_date)
FROM
    employees;
    
-----------------------------------
-- (5) LENGTH
--  문자열의 길이 반환
-- A. LENGTH return Characters
-- B. LENGTHB return Bytes
-----------------------------------
SELECT 
    'Oralce',
    length('Oracle')
FROM
    dual;

SELECT
    last_name,
    lengthb(last_name)
FROM
    employees;
    
-- '한글'문자열을 유니코드(Unicode)로 표현하면, '\D55D\AE00'
SELECT
    '한글',
    length('한글')  AS length,
    lengthb('한글') AS lengthb
FROM
    dual;
    
SELECT 
    unistr('\D55C\AE00'),
    length( unistr('\D55C\AE00') ) AS length,
    lengthb( unistr('\D55C\AE00') ) AS lengthb
FROM 
    dual;
    
-----------------------------------
-- 6. instr
-- 문자열에서, 특정 문자열의 (시작)위치 (시작인덱스) 반환 
-----------------------------------

SELECT 
    instr('MILLER', 'L', 1, 2),     -- 1:offset, 2:occurence
    instr('MILLER', 'X', 1, 2)      -- 1:offset, 2:occurence
FROM 
    dual;

-----------------------------------
-- 7. substr
-- 문자열에서 부분문자열 반환 
-- (주의) 인덱스 번호는 1부터 시작 
-----------------------------------
SELECT
--    substr('123456-1234567', 1, 6)
--    substr('123456-1234567',8)
    substr('123456-1234567', 1, 7)||'*******' AS "주민등록번호"
FROM
    dual;

-- In the Oracle SQL*Developer    
SELECT 
    hire_date AS 입사일,
    substr(hire_date, 1, 2) AS 입사년도,
    substr(hire_date, 8, 1) AS 입사년도2,
    substr(hire_date, 8) AS 입사년도3
FROM 
    employees;
    
-- In the vscode 
SELECT 
   hire_date,
   to_char(hire_date) AS 입사일, 
   to_char(hire_date, 'RR/MM/DD') AS 입사일2,
   to_char(hire_date, 'YYYY/MM/DD HH24:MM:SS') AS 입사일3,
   substr( to_char(hire_date), 8, 2 ) AS 입사년도 
FROM
   employees;
    
-- SYSDATE 함수와 CURRENT_DATE 함수를 알자
-- SYSDATE 함수: 세계표준시(UTC)기준으로 현재 날짜와 시간정보 생성 
-- CURRENT_DATE 함수:현재 로컬 시간대(Timezone)에 맞는 현재 날짜/시간 생성 
SELECT
    to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') AS now,
    to_char(current_date, 'YYYY/MM/DD HH24:MI:SS') AS now2 --이것을사용하자
FROM
    dual;
    

SELECT 
   '900303-1234567',
   substr('900303-1234567',8)   --length지정안할시 offset~끝까지
FROM
    dual;
    
-- 그런데, offset index를 음수를 사용할 수 있다면? 
SELECT
    '900303-1234567',
    substr('900303-1234567',-7) --끝에서부터 7자리, length끝자리 -1
FROM
    dual;

-----------------------------------
-- 8. RELPACE : 대체하다, 바꾸다 
-- 문자열 치환
-----------------------------------
SELECT 
    replace('JACK and JUE', 'J', 'BL' )
FROM
    dual;
    
-----------------------------------
-- 9. LPAD
-- 문자열 오른쪽 정렬 후, 
-- 왼쪽의 빈 공간에 지정문자 채우기(padding)
-----------------------------------
SELECT 
    lpad('MILLER', 10, '*')
FROM
    dual;
    
    
-----------------------------------
-- 10. RPAD
-- 문자열 왼쪽으로 정렬 후,
-- 오른쪽의 빈 공간에 지정문자 채우기(padding)
-----------------------------------
SELECT
    rpad('MILLER',10,'*')
FROM
    dual;

--1
SELECT
    substr('900303-1234567', 1, 8)||'******' AS 주민번호 
FROM
    dual;
--2
SELECT 
    rpad(
        substr('900303-1234567', 1, 8), 14, '*'
    ) AS 주민번호 
FROM
    dual;
    
-----------------------------------
-- 11. LTIRM
-- 문자열의 왼쪽에서, 지정문자 삭제(trim)
-----------------------------------
SELECT
    ltrim('MMMIMLLER', 'M')
FROM
    dual;

SELECT 
    ltrim(' MILLER '), --삭제할 문자를 정하지 않으면 default로 공백을 삭제 
    length( ltrim(' MILLER ') )
FROM 
    dual;

-----------------------------------
-- 12. RTRIM
-- 문자열의 오른쪽에서, 지정문자 삭제(trim)
-----------------------------------
SELECT 
    rtrim('MILLRER', 'R')
FROM 
    dual;
    
SELECT
    rtrim(' MILLER '),
    length( rtrim(' MILLER ') )
FROM 
    dual;
    
-----------------------------------
-- 13. TRIM
-- 문자열의 왼쪽/오른쪽/양쪽에서, 지정문자 삭제(trim)
-- 단, 문자열의 중간은 처리못한다.
-- 문법)
--     TRIM( LEADING 'str' FROM 컬럼명|표현식)
--     TRIM( TRAILING 'str' FROM 컬럼명|표현식)
--     TRIM( BOTH 'str' FROM 컬럼명|표현식)
--     TRIM( 'str' FROM 컬럼명|표현식)      - BOTH(default)
-----------------------------------
SELECT
    trim( '0' FROM '0001234567000' )    --default:BOTH(양쪽에서 제거)
FROM 
    dual;

SELECT 
    trim( LEADING '0' FROM '0001234567000') --왼쪽에서 제거
FROM 
    dual;
    
SELECT
    trim( TRAILING '0' FROM '0001234567000' ) --오른쪽에서 제거
FROM 
    dual;