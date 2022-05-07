CREATE TABLE myemp_hire AS
SELECT 
    empno,
    ename,
    hiredate,
    sal
FROM
    emp
WHERE
    1=2;

DROP TABLE myemp_hire;
DROP TABLE myemp_mgr;

CREATE TABLE myemp_mgr AS
SELECT
    empno,
    ename,
    mgr
FROM
    emp
WHERE
    1=2;


INSERT ALL
    INTO myemp_hire VALUES(empno, ename, hiredate, sal)
    INTO myemp_mgr VALUES(empno, ename, mgr)

    SELECT
        empno,
        ename,
        hiredate,
        sal,
        mgr
    FROM
        emp;