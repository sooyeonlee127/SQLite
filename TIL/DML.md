# DML (Data Manipulation Language)

데이터를 조작(추가, 조회, 변경, 삭제)하기 위한 명령어로서, 구체적으로 INSERT, SELECT, UPDATE, DELETE가 있다.

# SELECT

특정 테이블에서 데이터를 조회하기 위해 사용한다.

### 문법

`SELECT 컬럼_이름1, 컬럼_이름2 FROM 테이블_이름;`  
1\. SELECT 절에서 컬럼 또는 쉼표로 구분된 컬럼 목록을 지정  
2\. FROM 절(clause)에서 데이터를 가져올 테이블을 지정

##### \* 사용

모든 컬럼에 대한 shorthand(약칭)인 \*(asterisk)를 사용할 수 있음

```
SELECT * FROM 테이블_이름;
```

### 종류

1.  ORDER BY
2.  DISTINCT
3.  WHERE
4.  LIMIT
5.  LIKE
6.  GROUP BY

---

### 1\. 정렬(ORDER BY)

```
SELECT 컬럼_이름1, 컬럼_이름2 FROM 테이블_이름 ORDER BY 컬럼_이름1 ASC, 컬럼_이름2 DESC;
```

SELECT 문에 추가하여 결과를 정렬한다. ORDER BY 절의 위치는 FROM 절 뒤이다.  
하나 이상의 컬럼을 기준으로 결과를 오름차순, 내림차순으로 정렬할 수 있음 ('ASC': 오름차순(기본값)/ 'DESC': 내림차순)  
우선순위가 높은 정렬 기준은 위치상 뒤에 있어야 한다.

### 2\. 중복 제거(DISTINCT)

: 조회 결과에서 중복된 행을 제거

```
SELECT DISTINCT 컬럼_이름 FROM 테이블_이름;
```

##### 주의

-   SQLite는 NULL 값을 중복으로 간주
-   NULL 값이 있는 컬럼에 DISTINCT 절을 사용하면 SQLite는 NULL 값의 한 행을 유지

### 3\. 조건 (Where)

: 조회 시 특정 검색 조건을 지정한다.

```
SELECT 컬럼_이름 FROM 테이블_이름
WHERE 검색_조건;
```

WHERE 절은 SELECT 문에서 선택적으로 사용할 수 있는 절이다.  
(SELECT 문 외에도 UPDATE 및 DELETE 문에서 WHERE 절을 사용할 수 있음)

##### 예시

```
WHERE column_1 = 10

WHERE column_2 LIKE 'Ko%'

WHERE column_3 IN (1, 2)

WHERE column_4 BETWEEN 10 AND 20
```

##### SQLite comparison operators (비교 연산자)

-   \=
-   <> or !=
-   <
-   \>
-   <=
-   \>=

##### SQLite logical operators (논리 연산자)

-   ALL, AND, ANY, BETWEEN, IN, LIKE, NOT, OR 등

### 5\. 패턴 일치 조회(LIKE operator)

: 패턴 일치를 기반으로 데이터를 조회한다.

-   기본적으로 대소문자를 구분하지 않음
    1.  % (percent): 0개 이상의 문자가 올 수 있음을 의미
    2.  \_(underscore): 단일(1개) 문자가 있음을 의미

##### 'wildscards' character

-   파일을 지정할 때, 구체적인 이름 대신에 여러파일을 동시에 지정할 목적으로 사용하는 특수 기호. 주로 특정한 패턴이 있는 문자열 혹은 파일을 찾거나, 긴 이름을 생략할 때 쓰임
    -   \*, ?등

##### IN operator

: 값이 값 목록 결과에 있는 값과 일치하는지 확인한다.

-   표현식이 값 목록의 값과 일치하는지 여부에 따라 true 또는 false를 반환한다. IN 연산자의 결과를 부정하려면 NOT IN 연산자를 사용하면 된다.

```
SELECT name, age FROM NCT
WHERE unit IN ('NCT127', 'NCTDREAM');
```

##### BETWEEN operator

값이 값 범위에 있는지 테스트하여 값이 지정된 범위에 있으면 true를 반환한다. BETWEEN 연산자의 결과를 부정하려면 NOT BETWEEN 연산자를 사용하면 된다.

```
-- DML.sql

SELECT name, age FROM NCT
WHERE age BETWEEN 20 AND 30;
```

### 4\. 행의 개수 제한(LIMIT clause)

쿼리에서 반환되는 행 수를 제한한다.

```
SELECT column_list FROM table_name LIMIT 반환되는_행_수;
```

##### OFFSET keyword

LIMIT 절을 사용하면 첫 번째 데이터부터 지정한 수 만큼의 데이터를 받아올 수 있지만, OFFSET과 함께 사용하면 특정 지정된 위치에서부터 데이터를 조회할 수 있다.

-   11번째부터 20번째 데이터의 rowid와 이름 조회하기
    
    ```
    SELECT rowid, first_name FROM users 
    LIMIT 10 OFFSET 10;
    ```
    

---

### 6\. GROUP BY clause

특정 그룹으로 묶인 결과를 생성한다. 선택된 컬럼 값을 기준으로 데이터(행)들의 공통 값을 묶어서 결과로 나타낸다

```
SELECT column_1, aggregate_function(column_2)
FROM table_name
GROUP BY column_1, column_2;
```

-   각 그룹에 대해 MIN, MAX, SUM, COUNT, 또는 AVG와 같은 집계 함수(aggregate function)를 적용하여 각 그룹에 대한 추가적인 정보를 제공할 수 있다.

##### 집계 함수 (Aggregate function)

-   각 집함의 최대값, 최소값, 평균, 합계 및 개수를 계산
-   값 집합에 대한 계산을 수행하고 단일 값을 반환
    -   여러 행으로부터 하나의 결과 값을 반환하는 함수
-   SELECT 문의 GROUP BY 절과 함께 종종 사용됨
-   제공되는 함수 목록
    -   AVG(), COUNT(), MAX(), MIN(), SUM()
-   AVG(), MAX(), MIN(), SUM()는 숫자를 기준으로 계산이 되어져야 하기 때문에 반드시 컬럼의 데이터 타입이 숫자 (INTEGER)일 떄만 사용 가능
-   나이가 30살 이상인 사람들의 평균 나이 조회하기

```
-- DML.sql

SELECT AVG(age) FROM users WHERE age >= 30;
```

---

# INSERT

: 새 행을 테이블에 삽입한다.

```
INSERT INTO 테이블_이름 (컬럼_이름1, 컬럼_이름2, ...)
VALUES (value1, value2, ...);
```

##### 문법

1.  먼저 INSERT INTO 키워드 뒤에 데이터를 삽입할 테이블의 이름을 지정
2.  테이블 이름 뒤에 쉼표로 구분된 컬럼 목록을 추가
    -   컬럼 목록은 선택 사항이지만 컬럼 목록을 포함하는 것이 권장된다.
3.  VALUES 키워드 뒤에 쉼표로 구분된 값 목록을 추가
    -   만약 컬럼 목록을 생략하는 경우 값 목록의 모든 컬럼에 대한 값을 지정해야 한다.
    -   값 목록의 값 개수는 컬럼 목록의 컬럼 개수와 같아야 한다.

---

# UPDATE

: 테이블에 있는 기존 행의 데이터를 업데이트한다.

```
UPDATE 테이블_이름
SET 컬럼_이름1 = 새_값1,
    컬럼_이름2 = 새_값2
WHERE
    검색_조건;
```

##### 문법

1.  UPDATE 절 이후에 업데이트 할 테이블을 지정
2.  SET 절에서 테이블의 각 컬럼에 대해 새 값을 설정
3.  WHERE 절의 조건을 사용하여 업데이트할 행을 지정
    -   WHERE 절은 선택 사항이며, 생략하면 UPDATE 문은 테이블의 모든 행에 있는 데이터를 업데이트 함
4.  선택적으로 ORDER BY 및 LIMIT 절을 사용하여 업데이트할 행 수를 지정 할 수도 있음

```
UPDATE classmates
SET name = ' 김철수한무두루미 ',
    address = ' 제주도 '
WHERE rowid = 2;
```

---

# DELETE

: 테이블에서 행을 제거한다. 테이블의 한 행, 여러 행 및 모든 행을 삭제할 수 있다.

```
DELETE FROM 테이블_이름
WHERE 검색_조건;
```

##### 문법

1.  DELETE FROM 키워드 뒤에 행을 제거하려는 테이블의 이름을 지정
2.  WHERE 절에 검색 조건을 추가하여 제거할 행을 식별
    -   WHERE 절은 선택 사항이며, 생략하면 DELETE 문은 테이블의 모든 행을 삭제
3.  선택적으로 ORDER BY 및 LIMIT 절을 사용하여 삭제할 행 수를 지정 할 수도 있음

-   5번 데이터 삭제하기
-   `DELETE FROM classmates WHERE rowid = 5;`
-   테이블의 모든 데이터 삭제하기
-   `DELETE FROM classmates;`