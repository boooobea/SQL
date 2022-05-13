----------------------------------------------
-- 4. MERGE 문
----------------------------------------------
-- 가. 스키마(구조)가 같은 두 개의 테이블을 비교하여,
-- 나. 하나의 테이블로 합침.
-- 다. INTO 절 -> 병합결과가 저장될 테이블명 지정
-- 라. USING 절 -> 병합할 대상 테이블/뷰/서브쿼리 지정
-- 마. ON 절 -> INTO절의 테이블1과 USING절의 테이블2간의 조인조건 지정
-- 바. WHERE절로 조건지정 가능
-- 사. DELETE 문도 사용가능.
-- 아. ** 앞의 INSERT/UPDATE/DELETE문과의 차이점:
--      저장 또는 수정 대상 테이블을 INTO 절에 지정.
-- 자. 응용분야:
--      대표적인 경우, 전자상거래의 물품판매회사가,
--      월별로 판매현황관리, 연말에 월별판매현황 데이터 병합
----------------------------------------------
-- MERGE INTO 테이블1 별칭 
--      USING (테이블명2 | 뷰 | 서브쿼리) 별칭
--      ON(조인조건)
--      --------------------------------------
--      (1) 조인 조건식이 일치(참이면)하면...
--      --------------------------------------
--      WHEN MATCHED THEN
--          --------------------------------------
--          -- (1-1). MERGE 테이블의 기존 데이터 변경(갱신).
--          --------------------------------------
--          UPDATE SET
--              컬럼명1 = 값1,
--              ...
--              컬럼명n = 값n
--          [WHERE 조건식]
--
--          --------------------------------------
--          -- (1-2). MERGE 테이블의 기존 데이터 삭제.
--          --------------------------------------
--          [DELETE WHERE 조건식]
--
--      --------------------------------------
--      (2) 조인 조건식이 비일치(거짓이면)하면 ...
--      --------------------------------------
--      WHEN NOT MATCHED THEN
--          --------------------------------------
--          -- (2-1). MERGE 테이블에 새로운 데이터 생성.
--          --------------------------------------
--          INSERT (컬럼목록)
--          VALUES (값목록)
--          [WHERE 조건식];
----------------------------------------------


CREATE TABLE pt_01(
    판매번호 VARCHAR2(8),
    제품번호 NUMBER,
    수량     NUMBER,
    금액     NUMBER
); --pt_01

CREATE TABLE pt_02(
    판매번호 VARCHAR2(8),
    제품번호 NUMBER,
    수량     NUMBER,
    금액     NUMBER
); --pt_02

CREATE TABLE p_total(
    판매번호 VARCHAR2(8),
    제품번호 NUMBER,
    수량     NUMBER,
    금액     NUMBER
); --p_total

BEGIN

    INSERT INTO pt_01 VALUES('20170101', 1000, 10, 500);
    INSERT INTO pt_01 VALUES('20170102', 1001, 10, 400);
    INSERT INTO pt_01 VALUES('20170103', 1002, 10, 300);

    INSERT INTO pt_02 VALUES('20170201', 1003, 5, 500);
    INSERT INTO pt_02 VALUES('20170202', 1004, 5, 400);
    INSERT INTO pt_02 VALUES('20170203', 1005, 5, 300);

    COMMIT;

END;

SELECT * FROM pt_01;
SELECT * FROM pt_02;

-- ------------------------------------------------------
-- 4-2. MERGE 문 수행 #1
-- ------------------------------------------------------
TRUNCATE TABLE p_total; --복구불가능하게 삭제함 

MERGE INTO p_total total     --MERGE결과 저장 테이블 지정

    --MERGE대상 테이블지정(Alias가능**AS키워드불가**)
    USING pt_01 p01
    ON (total.판매번호 = p01.판매번호)  --동등 조인조건

    --------------------------
    -- (1)JOIN조건에 일치하는 행(행이 일치한다면)
    --------------------------
    WHEN MATCHED THEN

        -- MERGE 대상테이블(p01)의 데이터를 이용하여,
        -- MERGE 저장테이블(total)의 데이터 변경(갱신)
        UPDATE SET
            total.제품번호 = p01.제품번호 

    --------------------------
    -- (2)JOIN조건에 일치하지 않는 행
    --------------------------
    WHEN NOT MATCHED THEN
        INSERT 
        VALUES (p01.판매번호, p01.제품번호, p01.수량, p01.금액);

SELECT * FROM p_total;
-- ------------------------------------------------------

MERGE INTO p_total total
    USING pt_02 p02
    ON (total.판매번호 = p02.판매번호)

    WHEN MATCHED THEN
        UPDATE SET
            total.제품번호 = p02.제품번호

    WHEN NOT MATCHED THEN
        INSERT
        VALUES( p02.판매번호, p02.제품번호, p02.수량, p02.금액);

SELECT * FROM p_total;

COMMIT;