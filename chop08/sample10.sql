-- ------------------------------------------------------
-- 3. Flashback Drop
-- ------------------------------------------------------
-- 가. 삭제된 테이블을 복구하는 방법 (from Oracle10g)
-- 나. 테이블 삭제할 때, (DROP TABLE tablename;)
--     삭제된 테이블은 휴지통(RECYCLEBIN)이라는 특별한 객체에,
--     'BIN$' prefix가 붙은, 이름으로 저장됨.
-- 다. 삭제된 테이블을 다시 복구하고 싶을 때, Flashback Drop
--     복구기술을 이용하여, 휴지통(RECYCKEBIN) 객체에서, 삭제된
--     테이블을 복구할 수 있다.
-- ------------------------------------------------------
SHOW RECYCLEBIN;               -- RECYCLEBIN 객체정보 조회


FLASHBACK TABLE tablename TO BEFORE DROP;   -- 삭제된 테이블 복구


DROP TABLE tablename PURGE;                 -- 테이블 완전삭제(복구불가)


PURGE RECYCLEBIN;                           -- RECYCLEBIN 객체정보 삭제
-- ------------------------------------------------------

SHOW RECYCLEBIN;

SELECT * FROM tab; --수도테이블, 의사객체
-- 소유하고 있는 모든 DB객체를 조회할 수 있다.

FLASHBACK TABLE dept02 TO BEFORE DROP;

-- COMMIT;

SELECT * FROM dept02;

SELECT * FROM emp02;

SELECT * FROM USER_CONSTRAINTS
WHERE table_name IN ('dept02');

PURGE RECYCLEBIN;

-- 테이블은 복구할 수 있지만 참조관계는 복구하지 못한다. 