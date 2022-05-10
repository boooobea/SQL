-----------------------------------
-- 1. 단일(행) (반환)함수  
-- 단일(행) (반환)함수의 구분 :
-- (1) 문자 (처리)함수 : 문자와 관련된 특별한 조작을 위한 함수 
-- (2) 숫자 (처리)함수 
-- (3) 날짜 (처리)함수
--      a.SYSDATE           - DB서버에 설정된 날짜를 반환
--        CURRENT_DATE
--      b.MONTH_BETWEEN     - 두 날짜 사이의 월수를 계산하여 반환
--      c.ADD_MONTHS        - 특정 개우러수를 더한 날짜를 계산하여 반환
--                          - 음수값을 지정하면 뺀 날짜를 반환
--      d.NEXT_DAY          - 명시된 날짜로부터, 다음 요일에 대한 날짜 반환
--      e.LAST_DAY          - 지정된 월의 마지막 날짜 반환
--                          - 윤년 및 평년 모두 자동으로 계산
--      f.ROUND             - 날짜를 가장 가까운 년도 또는 월로 반올림하여 반환
--      g.TRUNC             - 날짜를 가장 가까운 년도 또는 월로 절삭하여 반환
--
--      *Oracle은 날짜 정보를 내부적으로 7바이트 숫자로 관리->산술연산가능 
-- (4) 변환 (처리)함수
-- (5) 일반 (처리)함수 
-- 단일(행) (반환)함수는, 테이블의 행 단위로 처리된다.
-----------------------------------
-- 0. 현 Oracle 서버의 날짜표기형식(DATE_FORMAT)설정 확인 
-- Oracle NLS:National Language Support 
-- 오라클의 년도표기 방식
-----------------------------------
DESC nls_session_parameters;

SELECT 
    * 
FROM 
    nls_session_parameters;     --NLS_DATE_FORMAT항목

SELECT 
    sysdate
FROM
    dual;

-----------------------------------
-- *To change Oracle dafault 
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-RR';
-- session format 변경가능

SELECT
    sysdate 
FROM
    dual;
    
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD HH24:MI:SS';
SELECT
    sysdate,
    current_date
FROM
    dual;
-----------------------------------
-- 1. SYSDATE 
-- DB서버에 설정된 날짜를 반환 
-----------------------------------
SELECT 
    sysdate 
FROM
    dual;
    
-- *날짜연산 
-- (1) 날짜 + 숫자 : 날짜에 일수를 더하여 반환
-- (2) 날짜 - 숫자 : 날짜에 일수를 빼고 반환
-- (3) 날짜 - 날짜 : 두 날짜의 차이(일수) 반환
-- (4) 날짜 + 숫자/24 : 날짜에 시간을 더한다.
SELECT 
    sysdate AS 오늘, 
    sysdate + 1  AS 내일,     --현재날짜 + 하루
    sysdate - 1  AS 어제,      --현재날짜 - 하루
    sysdate + 29210 AS "잉잉"
FROM
    dual;
    
SELECT 
    last_name,
    hire_date,
    sysdate - hire_date AS 근속일수,            --현재날자-채용일자=기간(일수)
    (sysdate - hire_date) / 365,    --근속기간(일수) / 365 = 근속년수(소수점포함)
    trunc( (sysdate - hire_date) /365 ) AS 근속년수
FROM
    employees
ORDER BY 
    근속일수 DESC;
    
-----------------------------------
-- 2. MONTH_BETWEEN
-- 두 날짜 사이의 개월수를 계산하여 반환 
-----------------------------------
SELECT
    last_name,
    hire_date,
    months_between(sysdate, hire_date) AS "근속월수(소수점포함)",
    trunc(months_between(sysdate, hire_date)) AS "근속월수",
    trunc(months_between(sysdate, hire_date)/ 12) AS "근속년수"
FROM
    employees
ORDER BY
    3 DESC;
-----------------------------------
-- 3. ADD_MONTHS
-- 특정 개월수를 더한 날짜를 계산하여 반환
-- 음수값을 지정하면 뺀 날짜를 반환 
-----------------------------------
SELECT 
    sysdate AS 오늘,
    add_months(sysdate, 1) AS "1개월후 오늘",    --현재날짜+1개월
    add_months(sysdate, -1) AS "1개월전 오늘"    --현재날짜-1개월
FROM
    dual;
-----------------------------------
-- 4. NEXT_DAY
-- 명시된 날짜로부터, 다음 요일에 대한 날짜 반환
-- 일요일(1), 월요일(2), ~ 토요일(7)
-- next_day(date1, {'string'| n})
-----------------------------------
SELECT 
    last_name,
    hire_date,
     -- 최초로 돌아오는 금요일에 해당하는 날짜 출력
--    next_day(hire_date,'FRI'),
    --ORA-01846:에러 
    next_day(hire_date, '금'),
    -- 최초로 돌아오는 금요일에 해당하는 날짜 출력 
    next_day(current_date, 6)
FROM
    employees
ORDER BY
    3 DESC;

-----------------------------------
-- 5. last_day
-- 지정된 월의 마지막 날짜 반환 
-- 윤년 및 평년 모두 자동으로 계산 
-- last_day(date1)
-----------------------------------
SELECT
    last_name,
    hire_date,
    
    --채용일자가 속한 그 날의 마지막 날짜 반환 
    last_day(hire_date)
FROM 
    employees
ORDER BY 
    hire_date DESC;
    
SELECT 
    last_name, 
    hire_date AS 채용일자, 
    -- 입사일 기준, 5개월 후의 돌아오는 일요일의 날짜 반환
    next_day(add_months(hire_date, 5), '일')
    -- VSCODE 
--    next_dat(add_months(hire_date, 5), 'SUN')
FROM
    employees
ORDER BY 
    채용일자 DESC;
-----------------------------------
-- 6. round 
-- 날짜를 가장 가까운 년도 또는 월로 반올림하여 반환 
-- round(date1, 'YEAR'): 지정된 날짜의 년도를 반올림(toYYYY/01/01)
-- round(date1, 'MONTH') : 지정된 날짜의 월을 반올림(to YYYY/MM/01)
-----------------------------------
SELECT
    last_name, 
    hire_date,
    -- 채용날짜의'연도'를 반올림(to YYYY/01/01)
    round(hire_date,'YEAR'),
    -- 채용날짜의 '월'을 반올림(to YYYY/MM/01)
    round(hire_date,'MONTH')
FROM
    employees;

-----------------------------------
-- 7. trunc
-- trunc(date1, 'YEAR') 
-- trunc(date1, 'MONTH')
-----------------------------------
SELECT 
    last_name, 
    hire_date,
    -- 채용날짜의 년도를 가장 가까운 년도로 절삭
    trunc(hire_date, 'YEAR'),
    -- 채용날짜의 년도를 가장 가까운 월로 절삭
    trunc(hire_date, 'MONTH')
FROM
    employees;