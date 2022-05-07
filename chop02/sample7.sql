
--------------------------------------
-- 1. LIKE Operators(패턴매칭연산자)
-- WHERE column LIKE <패턴>
-- <패턴>에 사용가능한 wildcard 문자들:
-- (1)%     ( x >= 0, x : 문자개수)
-- (2)_     ( x == 1, x : 문자개수)
--------------------------------------
SELECT
    employee_id,
    last_name,
    salary
FROM
    employees
WHERE
    last_name LIKE 'J%';        -- % : x >= 0 (x:문자개수) 
    
    
SELECT 
    employee_id,
    last_name,
    salary
FROM 
    employees
WHERE
    last_name LIKE '%ai%';      -- % : x >= 0 (x:문자개수) 
    

SELECT
    employee_id,
    last_name,
    salary
FROM
    employees
WHERE
    last_name LIKE '%in';       -- % : x >= 0 (x:문자개수)
    
--------------------------------------

SELECT
    employee_id,
    last_name,
    salary
FROM
    employees
WHERE
    last_name LIKE '_b%';       -- % : x >= 0, _ : x == 1 (x:문자개수) 
--------------------------------------
SELECT 
    employee_id,
    last_name,
    salary
FROM 
    employees
WHERE
    last_name LIKE '_____d';    -- _ : x == 1(x:문자개수)
    
SELECT
    employee_id,
    last_name,
    salary
FROM
    employees
WHERE
    last_name LIKE '%d';    -- % : x >= 0 (x:문자개수) 
    
--------------------------------------
SELECT
    employee_id,
    last_name,
    salary
FROM
    employees
WHERE
    last_name LIKE '%';
    -- '%_%' '_' '%%' '%';      -- % : x >= 0, _ : x==1 


SELECT
    employee_id,
    last_name,
    salary,
    job_id
FROM
    employees
WHERE
    --탈출문자(Escape Character):
    --특수한 의미를 가지는 기호의 기능을 없애는 문자를 탈출문자라고 한다. 
    job_id LIKE '%$_%' ESCAPE '$';  
    

    