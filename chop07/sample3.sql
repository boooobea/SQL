----------------------------------------------
-- 3. DELETE 문
----------------------------------------------
-- 가. 테이블에 저장된 데이터 삭제 
-- 나. 한번에 여러 행들을 삭제가능 
-- 다. WHERE절은 **생략가능(주의)**
--      생략하면, 지정 테이블의 모든 데이터(행)가 삭제된다.
----------------------------------------------
-- DELETE FROM 테이블명 --데이터를 삭제할 테이블
-- [WHERE 조건식];      --조건이 참인 행들만 삭제

-- DELETE 테이블명;     --지정된 테이블의 모든 행들을 삭제
----------------------------------------------
BEGIN       -- to start a transaction

    DELETE FROM mydept
    WHERE deptno = 30;

    -- TCL:Transaction Control Language
    ROLLBACK;
    -- COMMIT;

END;

DESC mydept;
SELECT * FROM mydept;

----------------------------------------------
-- 3-1. Sub-query를 이용한 DELETE 문
----------------------------------------------
--  가. DELETE 문의 WHERE 절에서, 서브쿼리 사용.
--  나. 서브쿼리의 실행 결과값으로, 테이블의 데이터 삭제가능.
--  다. 이 방법을 사용하면, 기존 테이블에 저장된 데이터를 사용하여,
--      현재 테이블의 특정 데이터 삭제가능.
--  라. 서브쿼리의 실행결과 값의 개수와 타입이, 메인쿼리의 WHERE절
--      에 지정된 조건식의 컬럼의 개수와 타입이 반드시 동일해야 함.
----------------------------------------------
-- DELETE FROM 테이블명 
-- [WHERE <Sub-quert>];
----------------------------------------------
BEGIN 

    DELETE FROM mydept
    -- WHERE loc = (
    --     SELECT loc
    --     FROM dept
    --     WHERE deptno=20
    -- );
    
    WHERE (loc, dname) = (      --다중컬럼 조건식(Pairwise방식)
        SELECT loc, dname
        FROM dept
        WHERE deptno = 20
    );

    ROLLBACK;
END;

SELECT * FROM mydept;