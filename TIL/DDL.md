# DDL (Data Definition Language)

  
관계형 데이터베이스 구조(테이블, 스키마)를 정의하기위한 명령어로서, 구체적으로 CREATE(생성), ALTER(수정), DROP(삭제)을 의미한다.

---

# CREATE TABLE

데이터베이스에서 새 테이블을 만든다.

### 문법

```
    CREATE TABLE 테이블_이름 (  
    필드이름 데이터형식 제약조건,  
    필드이름 데이터형식 제약조건1 제약조건2  
);
```

-   id 컬럼은 우리가 직접 기본 키 역할의 컬럼을 정의하지 않으면 자동으로 rowid라는 컬럼으로 만들어진다

### Data Types(데이터 형식) 종류

1.  NULL
2.  INTEGER: 정수
3.  REAL: 실수
4.  TEXT: 문자
5.  BLOB(Binary Large Object): 데이터 덩어리. 대체로 멀티미디어 파일

-   Boolean 값은 정수 0(false) 1(true)로 저장됨
-   날짜 및 시간을 저장하기 위한 타입이 없음

SQLite는 다른 SQL 데이터베이스 엔진과 다르게, **'동적 타입 시스템'** 을 사용: 유연하게 변화한다  
선언된 데이터 타입이 중요한 것이 아니라, 데이터에 맞춰서 타입이 변화됨. 지정한 데이터 타입보다 데이터의 타입이 중요  
(테이블 생성 시 정수 데이터 형식으로 지정했으나, 문자열 데이터가 저장됨 -> TEXT 타입으로 지정됨)

-   값에 둘러싸는 따옴표와 소수점 또는 지수가 없으면 INTEGER
-   값이 작은 따옴표나 큰 따옴표로 묶이면 TEXT
-   값에 따옴표나 소수점, 지수가 없으면 REAL
-   값이 따옴표 없이 NULL이면 NULL
-   데이터 타입을 지정하게 되면 SQLite는 입력된 데이터의 타입을 지정된 데이터 타입으로 변환

### Type Affinity(타입 선호도)

5가지 데이터 타입이 아닌 다른 데이터 타입을 선언한다면, 에러가 나지 않는다. 내부적으로 각 타입의  
지정된 선호도에 따라 5가지 선호도로 인식된다.  
\=> 다른 데이터베이스 엔진간의 호환성을 최대화하기 위해서이다.

### Constraints(제약 조건)

입력하는 자료에 대해 제약을 정함. 제약에 맞지 않으면 입력이 거부된다. 사용자가 원하는 조건의 데이터만 유지하기 위한 즉, 데이터의 무결성을 유지하기 위한 보편적인 방법으로 테이블의 특정 컬럼에 설정하는 제약

### Constrains 종류

1.  NOT NULL: 컬럼이 NULL 값을 허용하지 않도록 지정
2.  UNIQUE: 컬럼의 모든 값이 서로 구별되거나 고유한 값이 되도록 지정
3.  PRIMARY KEY: 테이블에서 행의 고유성을 식별하는 데 사용되는 컬럼 / 암시적으로 NOT NULL 제약조건 포함되어있음 / INTEGER 타입에만 사용가능
4.  AUTOINCREMENT: 사용되지 않은 값이나 이전에 삭제된 행의 값을 재사용하는 것을 방지 / Django에서 테이블 생성 시 id컬럼에 기본적으로 사용하는 제약조건
5.  그외 기타 Constraints

### rowid(암시적 자동 증가 컬럼)

테이블을 생성할 때마다 rowid라는 암시적 자동 증가 컬럼이 자동으로 생성됨  
테이블의 행을 고유하게 식별하는 64비트 부호 있는 정수 값  
테이블에 새 행을 삽입할 때마다 정수 값을 자동으로 할당  
값은 1에서 시작

---

# ALTER TABLE

기존 테이블의 구조를 수정(변경)한다.  
구체적으로 아래의 ALTER TABLE 문이 있다.

1.  Rename a table
2.  Rename a column
3.  Add a new Column to a table
4.  Delete a column

### 1\. Rename a table (테이블명 변경)

```
ALTER TABLE 테이블_이름 RENAME TO 새_테이블_이름;
```

### 2\. Rename a column (컬럼명 변경)

```
ALTER TABLE 테이블_이름 RENAME COLUMN 컬럼_이름 TO 새_컬럼_이름;
```

### 3\. Add a new column to a table (새 컬럼 추가)

```
ALTER TABLE 테이블_이름 ADD COLUMN 컬럼정의;
```

-   주의: 만약 테이블에 기존 데이터가 있을 경우 에러 발생. 이전에 이미 저장된 데이터들은 새롭게 추가되는 컬럼에 값이 없기 때문에 NULL이 작성되기 때문이다.
-   해결: **DEFAULT** 제약 조건을 사용하여 해결할 수 있다. 아래와 같이 하면 address 컬럼이 추가되면서 기존에 있던 데이터들의 address 컬럼 값은 'no address'가 된다.
-   `ALTER TABLE table_name ADD COLUMN address TEXT NOT NULL DEFAULT 'no address';`

### 4\. Delete a column (컬럼 삭제)

```
ALTER TABLE 테이블_이름 DROP COLUMN 컬럼_이름;
```

-   주의: 삭제하지 못하는 경우가 있다.
    -   컬럼이 다른 부분에서 참조되는 경우
        -   FOREIGN KEY(외래 키) 제약조건에서 사용되는 경우
    -   PRIMARY KEY인 경우
    -   UNIQUE 제약 조건이 있는 경우

---

# DROP TALBE

: 데이터베이스에서 테이블을 제거한다.

`DROP TABLE 테이블_이름;`

-   주의: 존재하지 않는 테이블을 제거하면 SQLite에서 오류가 발생

### DROP TABLE 특징

-   한 번에 하나의 테이블만 삭제할 수 있음
-   여러 테이블을 제거하려면 여러 DROP TABLE 문을 실행해야 함
-   DROP TABLE 문은 실행 취소하거나 복구할 수 없음
    -   따라서 각별히 주의하여 수행해야 한다.