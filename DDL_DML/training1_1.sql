DROP TABLE zoo;

CREATE TABLE zoo (
  name TEXT NOT NULL,
  eat TEXT NOT NULL,
  weight INT NOT NULL,
  height INT,
  age INT
);

INSERT INTO zoo VALUES 
('gorilla', 'omnivore', 215, 180, 5),
('tiger', 'carnivore', 220, 115, 3),
('elephant', 'herbivore', 3800, 280, 10),
('dog', 'omnivore', 8, 20, 1),
('panda', 'herbivore', 80, 90, 2),
('pig', 'omnivore', 70, 45, 5);


--트랜잭션이 실행되는 구문이다.
--트랜잭션이란 무결성을 유지하기 위해 특정 작업이 모두 수행되거나, 모두 수행되지 않게 하기위한 기술이다.

BEGIN; --BEGIN은 트랜잭션을 시작한다.
  DELETE FROM zoo
  WHERE weight < 100; -- ROLLBACK으로 인해 취소된다.
ROLLBACK;--ROLLBACK은 트랙잭션 시작 이후 수행된 모든 연산을 취소함
BEGIN;
  DELETE FROM zoo
  WHERE eat = 'omnivore';
COMMIT;-- COMMIT은 트랙잭션 시작 이후 수행된 모든 연산을 DB에 반영한다.
-- 그러므로 eat이 'omnivore'인 동물만 다 삭제된다.
SELECT COUNT(*)
FROM zoo; -- 결과: 3마리 남게 됨
