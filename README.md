# DB와 SQL

## Contents
* [DB와 SQL에 대해 간략히 살펴보기](#1-db)
* [기초 SQL 문법](#2-sql-문법)
  * [SELECT문 기초](#select문-기초)
  * [연산자](#연산자)
  * [숫자/문자열 함수](#숫자-문자열-함수)
  * [시간/날짜 함수](#시간-날짜-관련-함수)
  * [그룹 함수](#그룹-함수)
  * [서브 쿼리](#서브-쿼리)
  * [JOIN을 활용한 테이블 조립](#join)
  * [테이블 생성 및 데이터 입력](#테이블-생성-및-데이터-입력)
  * [데이터 변경 및 삭제](#데이터-변경-및-삭제)
* [데이터 모델링의 이해](#3-데이터-모델링의-이해)
  * [데이터 모델링이란?](#데이터-모델링이란)
  * [ERD](#erd)
- [Level Schema](#4-level-schema)


# 1. DB
## DB?
DB란 database의 약자로 ``여러 사람이 공유하고 사용하기 위해 조직적으로 통합하여 데이터의 중복을 없애고 구조화한 데이터의 집합체``를 말합니다. 다양한 종류(계층형, 네트워크형)의 DB가 존재하지만 Excel과 같은 관계형 DB가 대표적입니다.

> tip 테이블 Table의 구조

데이터는 관계형 데이터베이스의 기본 단위인 테이블의 형태로 저장됩니다. 업무, 공부를 하시면서 Excel 프로그램을 많이 접해보셨을거라 생각합니다. Excel을 보시면 세로 방향으로 이루어진 속성들을 ``열 column``이라고 합니다. 반대로 가로 방향으로 이루어진 속성들을 ``행 row``라고 합니다. 이렇게 2차원 형태의 구조를 가진 데이터의 저장장소이고, DB의 가장 기본적인 개념을 ``테이블 Table``이라고 합니다.

## DBMS?
'database management system'의 약자로 DB를 관리하기 위한 소프트웨어 프로그램을 DBMS라고 합니다. 대표적으로 orcle, microsoft의 access, mysql 등이 있습니다.

## SQL?
- SQL은 관계형 DB에서 `데이터 정의 definition`/`조작 manipulation`/`제어 control`를 위해 사용하는 언어입니다. 쉽게 말해 DB와 의사소통을 하기 위해 사용하는 언어입니다.
- SQL은 ANSI/ISO 표준을 준수하므로 DBMS가 변경되어도 그대로 사용할 수 있습니다.

|표준|설명|
|---|---|
|ANSI/ISO SQL 표준|INNER JOIN, NATURAL JOIN, USING 조건, ON 조건절 사용|
|ANSI/ISO SQL3 표준|DBMS에 따라 차이를 표준화하여 제정 = case by case|

### SQL의 종류
|명령어 종류|명령어|설명|
|---|---|---|
|데이터 조작어 DML|SELECT|DB에 들어있는 데이터를 조회하거나 검색하기 위한 명령어|
||INSERT, UPDATE, DELETE|DB의 테이블의 데이터에 변형을 가하는 명령어들이다. 데이터를 새로 집어넣거나 삭제 및 변경하는 명령어|
|데이터 정의어 DDL|CREATE, ALTER, DROP, RENAME|데이터 구조를 정의하는데 사용되는 명령어로 테이블을 생성하거나 변경, 삭제 또는 이름을 바꾸는 등의 명령어|
|데이터 제어어 DCL|GRANT, REVOKE|DB에 접근하고 객체들을 사용하도록 권한을 주고 회수하는 명령어|
|트랜잭션 제어어 TCL|COMMIT, ROLL BACK|논리적인 작업의 단위를 묶어 DML에 의해 조작된 결과를 트랜잭션별로 제어하는 명령어|

# 2. SQL 문법
<img src = https://user-images.githubusercontent.com/72376781/158291794-8e9c478c-3560-48d1-8032-67e67985c044.png width = 800>

이번 단락에서는 MySQL을 통해 기초적인 SQL 문법들을 알아볼 것입니다. 데이터셋은 [sakila](https://downloads.mysql.com/docs/sakila-en.pdf)를 사용했습니다. 자세한 테이블 설명 및 다운로드 방법을 하고 싶으시다면 링크를 클릭해주세요.

## SELECT문 기초
### 1. 테이블의 모든 내용(*) 보기
``` SQL
SELECT * FROM film;
```

### 2. 원하는 column(열)만 보기
``` SQL
SELECT title, release_year, length
FROM film;
```

``` SQL
SELECT title, release_year, 'actors', 1
FROM film;
```
테이블의 column이 아닌 값도 선택할 수 있습니다. 위의 코드의 값을 확인해보면 모든 행에 actors, 1이 나옵니다.

### 3. 원하는 조건의 row(행)만 걸러서 보기
``` SQL
SELECT title, release_year
FROM film
WHERE release_year > 2002;
```
`WHERE` 구문을 통해 c나 python의 if문과 같이 조건을 붙여 원하는 데이터만 볼 수 있습니다.

### 4. 원하는 순서대로 데이터 가져오기
``` SQL
SELECT title, release_year, rating
FROM film
ORDER BY title;
```

### 5. 원하는 만큼만 데이터 가져오기
``` SQL
SELECT title, release_year
FROM film
LIMIT 10;
```
``` SQL
SELECT title, release_year
FROM film
LIMIT 20, 10;
```
위의 소드코드와 같이 `LIMIT{가져올 개수}` 또는 `LIMIT {건너뛸 개수, 가져올 개수}` 형태로 사용 가능합니다.

### 6. 원하는 예명(alias)으로 가져오기
``` SQL
SELECT
    film_id AS no,
    title,
    release_year,
    rental_duration AS duration
FROM film;
```
`AS문`을 통해 손쉽게 컬럼명 변경이 가능합니다.

``` SQL
SELECT
    film_id AS No,
    title,
    release_year,
    rental_duration AS duration,
    length
FROM film
WHERE length < 60 AND duration < 8;
```

## 연산자
|구분|연산자|의미|
|---|:---:|---|
|비교 연산자|=|같다.|
||>|보다 크다.|
||>=|보다 크거나 같다.|
||<|보다 작다.|
||<=|보다 작거나 같다.|
|SQL 연산자|BETWEEN a AND b|a와 b 사이(a, b 값 포함)|
||IN (list)|list에 있는 값 중 어느 하나라도 일치하면 된다.|
||LIKE '비교 문자열'|비교 문자열과 형태가 일치하면 된다.|
||IS NULL|NULL 값인 경우|
|논리 연산자|AND|앞, 뒤의 조건을 동시 만족|
||OR|앞, 뒤의 조건 중 하나라도 만족|
||NOT|뒤에 오는 조건에 반대되는 결과를 반환|
|부정 비교 연산자|!=|같지 않다.|
||<>|같지 않다.(ISO 표준)|
|부정 SQL 연산자|NOT BETWEEN a AND b|a와 b 사이에 있지 않다.|
||NOT IN (list)|list 값에 포함되지 않는다.|
||IS NOT NULL|NULL이 아니면 참 반환|

### 1. 사칙연산
``` SQL
SELECT 1+2;
SELECT 5-2.5 AS Difference;
SELECT 'ABC'+3;
SELECT '1'+'002'+3;
```
문자열은 0으로 인식하지만 숫자로 구성된 문자열은 숫자로 자동 인식합니다. 숫자로 구성된 문자열은 숫자로 자동 인식된다는 점을 다음과 같은 소스코드로 응용할 수 있습니다.

``` SQL
SELECT
    payment_id,
    rental_id,
    amount,
    amount * 0.75 AS sale_amount
FROM payment;
```
숫자로 구성된 문자열에 할인율인 0.75를 곱하여 할인된 가격을 구할 수 있습니다.

### 2. 참거짓 연산자
``` SQL
SELECT TRUE IS TRUE;
SELECT TRUE IS NOT FALSE;
SELECT (TRUE IS TRUE) IS NOT TRUE;
```
기본적으로 MySQL에서도 TRUE, FALSE는 각각 1과 0을 저장하고 있습니다. AND, OR과 비슷한 ``IS``, ``IS NOT`` 연산자를 통해 살펴봅시다. ``IS``는 양쪽이 같을 때 True를 반환합니다. 반면 ``IS NOT``의 경우 양쪽이 다를 때 TRUE를 반환합니다.

``` SQL
SELECT
    payment_id, 
    rental_id, 
    amount > 10 AS overdue
FROM payment;
```
``` SQL
SELECT 
    payment_id,
    rental_id,
    NOT amount > 10 AS non_overdue
FROM payment;
``` 
amount가 10 초과이거나 또는 10을 넘지 않는 데이터를 살펴보도록 하겠습니다. 해당 소스코드를 출력하면 overdue, non_overdue 컬럼에는 0과 1로 구성된 값들이 나옵니다.

### 3. BETEWEEN 연산자
``` SQL
SELECT customer_id, rental_id, amount
FROM payment
WHERE amount BETWEEN 4 AND 7;
```
amount가 4$와 7$ 사이에 있는 데이터만 추출해보았습니다.

### 4. IN 연산자
``` SQL
SELECT 1+2 IN (2,3,4);
SELECT 'hello' IN (1, TRUE, 'hello');
``` 

``` SQL
SELECT address, district, city_id
FROM address
WHERE district IN ('Texas', 'Alberta');
```
`IN` 연산자를 활용해 Texas, Alberta에 속한 주소만 추출해보았습니다.

### 5. LIKE 연산자
``` SQL
SELECT
    address, 
    district LIKE 'a%' AS A_blahblah,
    city_id
FROM address;
```
`LIKE문`은 와일드카드를 사용해서 데이터를 조회할 수 있습니다.
|와일드 카드|설명|
|:---:|---|
|%|어떤 문자를 포함한 모든 것을 조회한다. 예를 들어 '%es%'는 문자 중간에 'es'가 포함된 모든 문자를 조회한다. 다만 정상적인 Index Range Scan이 불가능하다.|
|_ |한 개인 단일 문자를 의미한다. 예를 들어 'alex_'은 'alex'으로 시작하고 그 뒤에 한 글자만 더 붙는 것을 조회한다. (alexa...)|
|* |모든 것을 의미한다.|

## 숫자, 문자열 함수
### 1. 숫자 관련 함수
``` SQL
SELECT
    ROUND(0.5),
    CEIL(0.4),
    FLOOR(0.6);
```
``ROUND``는 반올림 처리를 해주는 함수입니다. ``CEIL``은 올림, ``FLOOR``는 내림 처리를 해주는 함수입니다. `CEIL`과 `FLOOR`가 헷갈리시다면 `CEIL`은 천장을 의미하니까 올림! `FLOOR`는 바닥을 의미하니까 내림!으로 기억하시면 됩니다.

``` SQL
SELECT 
    ABS(1),
    ABS(-1),
    ABS(3-10);
```
`ABS()`는 절댓값 처리를 해주는 함수입니다.

``` SQL
SELECT
    GREATEST(1,2,3),
    LEAST(1,2,3,4,5);
```
`greatest()`는 가장 큰 값, `least()`는 가장 작은 값을 반환해주는 함수입니다.

``` SQL
SELECT
    TRUNCATE(1234.5678, 1), -- 1234.5
    TRUNCATE(1234.5678, 2), -- 12345.56
    TRUNCATE(1234.5678, 3), -- 1234.567
    TRUNCATE(1234.5678, -1), -- 1230
    TRUNCATE(1234.5678, -2); -- 1200
```
소수점 이하 자리를 제거해주는 `truncate` 함수입니다. `POW`(제곱), `SQRT`(제곱근)을 구하는 숫자 함수들이 있습니다.

### 2. 문자열 함수
``` SQL
SELECT UPPER('abcDEF'), LOWER('abcDEF');
SELECT UCASE('abcDEF'), LCASE('abcDEF');
```
`UPPER`, `UCASE`는 해당 문자열을 대문자로 바꿔주며 반대로 `LOWER`, `LCASE`는 소문자로 바꿔줍니다.

```SQL
SELECT CONCAT('HELLO', ' ', 'THIS IS ', 2022);
SELECT CONCAT_WS('-', 2022, 10, 30, 'AM');
```
문자열을 합쳐주는 `CONCAT` 함수입니다. 파이썬에서 문자열 병합(+)을 사용할 때와 같습니다. `CONCAT_WS(s,...)`는 s를 이어붙이게 됩니다.

``` SQL
SELECT
    SUBSTR('abcdefg', 3), -- cdefg
    SUBSTR('abcdefg', 3,2), -- cd
    SUBSTR('abcdefg', -4), -- defg
    SUBSTR('abcdefg', -4, 2); -- de
```
문자열을 추출해주는 `SUBSTR` 함수입니다. `SUBSTR(원본 문자열, 시작할 위치, 가져올 길이값)`을 통해 문자를 추출합니다.

``` SQL
SELECT 
    rental_date,
    LEFT(rental_date, 4) AS year, --맨 왼쪽에서부터 4글자
    SUBSTR(rental_date, 6, 2) AS month,
    SUBSTR(rental_date, 9, 2) AS day
FROM rental;
```
맨 왼쪽부터 시작하는 `LEFT`와 맨 오른쪽부터 시작하는 `RIGHT` 함수도 있습니다.

``` SQL
SELECT
  CONCAT('|', ' HELLO ', '|'), --|  HELLO  |
  CONCAT('|', LTRIM(' HELLO '), '|'), -- |HELLO  |
  CONCAT('|', RTRIM(' HELLO '), '|'), -- |  HELLO|
  CONCAT('|', TRIM(' HELLO '), '|'); -- |HELLO|
```
- `LTRIM`: 왼쪽 공백 제거
- `RTRIM`: 오른쪽 공백 제거
- `TRIM`: 공백 제거

``` SQL
SELECT customer_id, first_name, last_name, email
FROM customer
WHERE last_name = TRIM(' JOHNSON ');
```
고객이 혹시 공백을 포함하여 입력했을 경우를 방지하기 위해 `TRIM`을 사용할 수 있습니다.

``` SQL
SELECT 
	LPAD('abc', 5, '_'), -- '__abc'
	RPAD('abc', 5, '_'); -- 'abc__'
```
- `LPAD(string, n, p)`: string의 길이가 n글자가 될 때까지 p를 이어붙인다.
- `RPAD(string, n, p)`: string의 길이가 n글자가 될 때까지 p를 이어붙인다.

``` SQL
SELECT CONVERT('01', DECIMAL) = CONVERT('1', DECIMAL);
```
`CONVERT(a, type)`은 a의 타입을 type으로 변경해주는 함수입니다.

## 시간, 날짜 관련 함수
### 1. 시간/날짜 관련 함수
``` SQL
SELECT CURDATE(), CURTIME(), NOW();
```
- `CURDATE`: 현재 날짜 반환
- `CURTIME`: 현재 시간 반환
- `NOW`: 현재 시간과 날짜 

``` SQL
SELECT
    rental_date,
    YEAR(rental_date) AS year,
    MONTHNAME(rental_date) AS month_name,
    MONTH(rental_date) AS month,
    WEEKDAY(rental_date) AS weekday,
    DAYNAME(rental_date) AS day_name,
    DAY(rental_date) AS day
FROM rental;
```
- `YEAR`: datetime의 년도 반환
- `MONTHNAME`: datetime의 월 이름 반환
- `MONTH`: datetime의 월 반환
- `WEEKDAY`: datetime의 요일값 반환(월요일 : 0..)
- `DAYNAME`: datetime의 요일명 반환
- `DAYOFMONTH, DAY`:  datetime의 날짜 반환

``` SQL
SELECT HOUR(NOW()), MINUTE(NOW()), SECOND(NOW());
```
- `HOUR`: datetiem의 시간 반환
- `MINUTE`: datetiem의 분 반환
- `SECOND`: datetime의 초 반환

``` SQL
SELECT 
ADDDATE(NOW(), INTERVAL 1 MONTH),
    ADDDATE(NOW(), INTERVAL 3 WEEK),
    SUBDATE(NOW(), INTERVAL 1 MONTH);
```
- `ADDDATE`: 시간 더하기
- `SUBDATE`: 시간 빼기

``` SQL
SELECT
    rental_date,
    return_date,
    DATEDIFF(return_date, rental_date) AS duration
FROM rental
WHERE DATEDIFF(return_date, rental_date) >= 5;
```
- `DATEDIFF`를 통해 두 datetime의 시간차를 구할 수 있습니다.
- `TIMEDIFF`도 있습니다.
``` SQL
SELECT STR_TO_DATE('2022-01-05 13:47', '%Y-%m-%d %T') as '현재 시각';
```
- `STR_TO_DATE(str, format)`를 통해 string을 해당 format의 꼴로 변경해줄 수 있습니다.

### 2. 기타 함수
``` SQL
SELECT IF(1 + 1 = 3, '참이다.', '거짓이다.') AS '1 + 1 = 3'; 
```
- `IF(condition, true, false)`: 조건이 참이면 true 반환, 거짓이면 false 반환

``` SQL
SELECT
CASE
    WHEN -1 > 0 THEN '-1은 양수다.'
    WHEN -1 = 0 THEN '-1은 -0이다.'
    ELSE '-1은 음수다.'
END;
```
이렇게 조건이 많을 때는 `CASE-WHEN-END`문을 통해 구현합니다.

``` SQL
SELECT rental_id,
    CASE
	WHEN amount < 1 THEN 'on sale'
        WHEN amount BETWEEN 1 AND 4 THEN 'full price'
        ELSE 'fancy'
	END AS price
FROM payment;
```
`CASE-WHEN-END`문을 응용한다면 위의 소스코드와 같이 사용할 수 있습니다.
``` SQL
SELECT
    IFNULL('a', 'b'),
    IFNULL(NULL, 'b');
```
- `IFNULL(a,b)`: a가 NULL일 경우, b를 출력합니다.

## 그룹 함수
테이블의 전체 행을 하나 이상의 컬럼(열)을 기준으로 컬럼값에 따라 그룹화하여 그룹별로 결과를 출력하는 함수를 `그룹 함수`라고 합니다.
``` SQL
SELECT
    customer_id,
    COUNT(rental_date) AS total
FROM rental
GROUP BY customer_id
ORDER BY total DESC;
```
일자별 반환 갯수를 내림차순으로 정렬하기 위 소스코드와 같이 `COUNT` 그룹 함수를 응용할 수 있습니다.

``` SQL
SELECT
    customer_id,
    MAX(amount) AS max_amount,
    MIN(amount) AS min_amount,
    TRUNCATE(MAX(amount)+MIN(amount)/2, 2) AS med_amount,
    TRUNCATE(AVG(amount), 2) AS avg_amount
FROM payment
GROUP BY customer_id;
```
`MAX`, `MIN`, `AVG` 등을 통해 고객별 가격(최대, 최소, 중앙, 평균) 출력할 수도 있습니다.

``` SQL
SELECT
    COUNT(*) AS count, DATE(return_date) AS return_date
FROM rental
GROUP BY DATE(return_date)
WITH ROLLUP;
```
`WITH ROLLUP`을 사용하면 전체의 집계값을 함께 추출해줍니다.

``` SQL
SELECT
	COUNT(*) AS count, DATE(return_date) AS return_date
FROM rental
GROUP BY DATE(return_date)
HAVING count >= 200;
```
그룹 함수를 사용할 때 조건문을 추가하고 싶다면 `HAVING`을 사용하면 됩니다. 그런데 WHERE과 HAVING은 어떤 차이가 있을까요?

``` SQL
SELECT
	COUNT(*) AS count, DATE(return_date) AS return_date
FROM rental
WHERE rental_date > '2005-05-31'
GROUP BY DATE(return_date)
HAVING count >= 200;
```
`WHERE`는 그룹하기 전의 데이터, `HAVING`은 그룹 후 집계에 사용합니다. 따라서 2005년 5월 31일 이후의 데이터를 먼저 선별한 후, count가 200 이상인 데이터만 추출됩니다.

``` SQL
SELECT DISTINCT customer_id
FROM rental;
```
`DISTINCT`는 중복된 값을 제거합니다. GROUP BY와 달리 기본적인 정렬을 지원하지 않습니다. 그렇기 때문에 더 빠릅니다.

## 서브 쿼리
서브 쿼리는 하나의 SQL문에 또 다른 SQL문이 포함된 것을 말합니다. 이때 안에 있는 쿼리는 inner query, 밖에 있는 쿼리를 outer query라고 합니다. 서브 쿼리는 크게 `상관 쿼리`와 `비상관 쿼리`로 나눠집니다. 그 자체만으로도 독립적인 실행이 가능한 inner query라면 `비상관 서브쿼리`라고 부릅니다. 반대로 outer query와 상관 관계가 있다면 `상관 쿼리`라고 합니다.

### 1. 비상관 서브 쿼리
``` SQL
SELECT
    CategoryID, CategoryName, Description,
    (SELECT ProductName From Products WHERE ProductID = 1) AS Chais
FROM Categories;
```
위 소스코드는 SELECT문에 포함된 inner query입니다. 제품명이 Chais인지 확인하는 inner query를 통해 비상관 서브 쿼리를 구현했습니다.

``` SQL
SELECT * FROM Products
WHERE Price < (SELECT AVG(Price) FROM Products);
```

``` SQL
SELECT title, description, release_year, rental_rate
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film);
```

평군 가격 미만이거나 초과한 데이터들만 추출하는 SQL문들입니다. 이처럼 그룹 함수를 함께 사용하는 것도 서브 쿼리입니다.

### 2. 상관 쿼리
``` SQL
SELECT customer_id, amount, 
	(SELECT CONCAT_WS(' ',first_name, last_name) FROM staff S 
        WHERE S.staff_id = P.staff_id
	) AS staff_name
FROM payment P;
```

``` SQL
SELECT store_id, address_id,
	(
	    SELECT COUNT(*) FROM address a 
	    WHERE a.address_id = c.customer_id
	) AS count,
    (
    	SELECT district FROM address a
        WHERE a.address_id = c.address_id
	)
FROM customer c;
```

## JOIN
JOIN은 2개의 테이블에서 각각의 공통 Key 값을 통해 테이블을 조합하는 방법입니다.

<img src = https://user-images.githubusercontent.com/72376781/158281168-b1ea2a2d-1c89-4033-b823-9e28d1d496d3.png width = 700>


### 1. 내부 조인 INNER JOIN
`내부 조인 INNER JOIN`은 두 테이블을 조인할 때, 두 테이블에 모두 지정한 열의 데이터가 있어야 합니다.

``` SQL
SELECT A.actor_id, F.film_id, F.title, F.description FROM film_actor A
JOIN film F ON F.film_id = A.film_id;
```
또한 `내부 조인 INNER JOIN`을 할 땐 ambiguous를 주의해야합니다. film_actor와 film이란 테이블 모두 film_id란 공통 컬럼을 갖고 있습니다. 따라서 film_actor의 film_id, film의 film_id와 같이 지정해주지 않는다면 에러가 발생합니다.

``` SQL
SELECT
    FA.actor_id, 
    CONCAT_WS(' ', A.first_name, A.last_name) AS actor_name,
    FA.film_id,
    F.title,
    F.special_features
FROM actor A
JOIN film_actor FA 
ON FA.actor_id = A.actor_id
JOIN film F 
ON F.film_id = FA.film_id
WHERE F.special_features LIKE ('%Behind%');
```
이와 같이 여러 개의 테이블을 JOIN 할 수도 있습니다.

``` SQL
SELECT
    I.film_id, 
    F.title, 
    COUNT(I.film_id) AS count FROM inventory I
JOIN film F ON F.film_id = I.film_id
GROUP BY I.film_id
ORDER BY count DESC;
```
JOIN문과 GROUP BY문을 통해 인벤토리에 가장 많이 담긴 영화를 찾아볼 수도 있습니다.

### 2. 외부 조인 OUTER JOIN
외부 조인 OUTER JOIN은 두 테이블을 조인할 때, 1개의 테이블에만 데이터가 있어도 결과가 나옵니다.

``` SQL
SELECT
    C1.customer_id,
    CONCAT_WS(' ', C1.first_name, C1.last_name) AS customer,
    C2.customer_id,
    CONCAT_WS(' ', C2.first_name, C2.last_name) AS next_customer
FROM customer C1
LEFT JOIN customer C2
ON C1.customer_id + 1 = C2.customer_id;
```

``` SQL
SELECT
    C1.customer_id,
    CONCAT_WS(' ', C1.first_name, C1.last_name) AS customer,
    C2.customer_id,
    CONCAT_WS(' ', C2.first_name, C2.last_name) AS next_customer
FROM customer C1
RIGHT JOIN customer C2
ON C1.customer_id + 1 = C2.customer_id;
```

이와 같이 데이터를 출력할 한 테이블을 정할 수도 있고, FULL OUTER JOIN을 통해 왼쪽과 오른쪽 테이블의 값을 모두 출력할 수도 있습니다.

## 테이블 생성 및 데이터 입력

### 1. 테이블 생성 및 제약 넣기

``` SQL
CREATE TABLE people(
	person_id INT AUTO_INCREMENT PRIMARY KEY,
	person_name VARCHAR(10) NOT NULL,
    nickname VARCHAR(10) UNIQUE NOT NULL,
    age TINYINT UNSIGNED,
    is_married TINYINT DEFAULT 0
    );
 ```
`CREATE TABLE`을 통해 테이블을 생성할 수 있습니다. 다만 테이블을 생성할 땐 제약 조건을 넣어줘야합니다. 테이블에 잘못된 데이터 입력을 사전 방지하기 위해 데이터의 자료형, primary key, NULL 조건과 같은 제약 조건을 사전 설정합니다. 제약 조건은 다음의 예시와 같습니다.

- AUTO_INCREMENT: 새 행 생성시마다 자동으로 1씩 증가
- PRIMARY KEY: 중복 입력 불가, NULL 불가
- UNIQUE: 중복 입력 불가
- NOT NULL: NULL 입력 불가
- UNSIGNED: 양수만 가능
- DEFAULT: 값 입력이 없을 시 기본값

### 2. 데이터 입력하기

``` SQL
INSERT INTO friend
	(person_id, person_name, age, birthday)
	VALUES (1, '정호섭', 27, '1996-12-15');
```

friend란 테이블에 person_id, person_name, age, birthday의 컬럼에 각각의 데이터를 `INSERT INTO`문을 통해 입력할 수 있습니다.

``` SQL
INSERT INTO friend
	VALUES (2, '전우치', 18, '1003-05-12');
```
만약 위 소스코드처럼 테이블의 모든 컬럼에 값을 넣을 땐 컬럼명은 생략 가능합니다.

``` SQL
INSERT INTO friend
	(person_id, person_name, birthday)
	VALUES (3, '임꺽정', '1996-11-04');
```
컬럼의 제약 조건이 NOT NULL이 아닐 시엔 일부 컬럼에만 값을 넣을 수도 있습니다. 하지만 컬럼에 맞는 자료형을 입력해야만 합니다.

``` SQL
INSERT INTO friend
	(person_id, person_name, age, birthday)
	VALUES
	(4, '존 스미스', 30, '1991-03-02'),
        (5, '몽키 D 루피', 15, '2006-12-07'),
        (6, '황비홍', 24, '1997-10-30');
```
이와 같이 여러 개의 데이터를 한 번에 입력할 수도 있습니다.

## 데이터 변경 및 삭제

### 1. UPDATE
``` SQL
UPDATE menus
SET menu_name = '삼선짜장'
WHERE menu_id = 12;
```

``` SQL
UPDATE menus
SET price = price + 1000
WHERE fk_business_id = 8;
```
`UPDATE`절을 통해 주어진 조건의 행의 데이터를 변경할 수 있습니다.

``` SQL
UPDATE menus
SET
    menu_name = '응급실 떡볶이',
    kilocalories = 492.78,
    price = 5000
WHERE
    fk_business_id = 4
    AND menu_name = '국물떡볶이';
```
여러 개의 컬럼 또한 변경할 수 있습니다.

### 2. DELETE
``` SQL
DELETE FROM businesses
WHERE status = 'CLS'; --조건
```
`DELETE`는 `WHERE`절을 데이터를 하나하나 삭제하는 방식입니다. 만약 `WHERE`절을 사용하지 않는다면 전체 데이터가 사라지게 됩니다. 하지만 내부적으로는 데이터 하나하나가 삭제되는 방식이므로 처리 속도는 느립니다. 데이터가 모두 삭제되더라도 데이터가 담겨져 있던 용량은 삭제되지 않습니다. 또한 COMMIT 전이라면 `ROLL BACK`을 통해 복구 할 수 있습니다.

### 3. TRUNCATE
``` SQL
TRUNCATE businesses;
```
`TRUNCATE`는 전체 데이터를 삭제하는 방식입니다. 테이블은 삭제되지 않고 데이터만 삭제되며 데이터가 차지했던 용량도 줄어듭니다. 따라서 `TRUNCATE`를 하게 되면 테이블을 처음 생성했을 때와 같게 됩니다. 또한 자동 COMMIT 되는 명령어이기 때문에 ROLL BACK은 불가합니다. 이외에도 테이블, 데이터 전체를 삭제하고 공간도 초기화하는 `DROP`이 있습니다.

# 3. 데이터 모델링의 이해

## 데이터 모델링이란?
``데이터 모델링``이란 <b> 복잡한 데이터를 개체, 관계, 속성을 중심으로 단순화 시켜 DB로 옮기는 과정입니다.</b>

### 데이터 모델링의 특징
|특징|설명|
|---|---|
|추상화| 현실 세계를 간략히 표현한다.|
|단순화| 누구나 쉽게 이해하도록 표현한다.|
|명확화| 명확하게 한 가지 의미로 표현한다.|

### 모델링의 3가지 관점
|관점|특징|장점|단점|
|---|---|---|---|
|데이터|업무가 어떤 데이터와 관련이 있으며 무슨 관계인지에 대해 모델링|업무가 변경되어도 모델링 결과에는 큰 영향을 주지 않음|프로세스 모델링보단 다소 어려움|
|프로세스|업무에서 실제 하는 일은 무엇인지 또는 어떻게 해야하는지 모델링하는 방법|업무 분석이 잘되면 비교적 쉽고 편리함|해당 업무가 변경 및 삭제되면 모델링 결과에 영향이 있을 수 있음|
|상관|업무를 처리하는 방법에 따라 어떤 영향을 받는지에 대해 모델링|두 관점을 섞어서 하는 방법으로 검증을 위해 CRUD Matrix 방법을 사용함|

### 모델링의 3단계
추상화 수준에 따라 개념-논리-물리 3단계로 정의합니다.
- ``개념적 모델링``: 현실 세계의 데이터를 <b>추상화</b> 과정을 통해 개념 세계의 데이터로 표현하는 과정이며 <b>엔터티와 속성을 도출하고 개념적 ERD를 작성</b>하는 단계입니다.
- ``논리적 모델링``: DB의 논리적 파트로 변환시키는 과정입니다. <b>key, 관계, 속성 등을 모두 정의 및 표현</b>하는 단계입니다.
- ``물리적 모델링``: 데이터가 저장될 수 있도록 논리적 -> 물리적 구조로 변환시키는 과정입니다. 성능, 보안, 가용성 등을 고려하여 DB를 실제로 구축하는 단계로 테이블, 인덱스, 함수 등을 생성하는 단계입니다.

## ERD
테이블간 상관 관계를 그림으로 도식화한 것을 'ERD'라고 합니다. ERD의 구성 요소는 `` 엔터티 Entity``, ``관계 Relationship``, ``속성 Attribute ``로 3가지입니다.

<img src = "https://user-images.githubusercontent.com/72376781/158088632-2ab0596e-c0d1-42ca-95db-e8451d9f70bc.jpg" width = 500>

토트넘 team과 손흥민 player의 관계를 한 번 봅시다. 토트넘 team과 손흥민 player은 모두 엔터티 entity 에 해당되고 '소속'이라는 관계 relationship로 맺어져있습니다. 해당 테이블들을 다른 테이블들과도 어떤 의미의 연관성을 지닐 수 있습니다. 이처럼 ERD로 도식화한다면 관계의 의미를 직관적으로 볼 수 있다는 장점이 있습니다.

#### ERD의 작성 절차
1. 엔터티를 도출하고 그린다.
2. 엔터티를 배치한다.
3. 엔터티간 관계 설정한다.
4. 관계 서술한다.
5. 관계 참여도를 표현한다.
6. 관계 필수 여부를 표현한다.

그렇다면 엔터티는 무엇이고 속성, 관계는 무엇일까요?

### 1. 엔터티 entity
`엔터티 entity`란 <b>업무에 필요하게 정보들을 저장 및 관리하기 위한 집합적인 것(thing)</b>을 말합니다. 예를 들어 학교에서 업무를 위해 학생이라는 엔터티를 정의한다고 합시다. 학생이란 엔터티에는 이름, 학번, 전공, 학점 등 다양한 속성 attribute들을 갖게 됩니다.

엔터티는 다음과 같은 특징들을 갖습니다.
- 업무에서 필요로 하는 정보이다.
- 유일한 식별자에 의해 식별이 가능하다. 예를 들어 한 반에 동명이인이 존재하면 이름만으론 유일하게 식별할 수 없습니다. 따라서 학급 번호와 같이 유일한 식별자를 통해 식별 할 수 있도록 해야합니다.
- 두 개 이상의 인스턴스의 집합이다.
- 반드시 속성을 가진다.
- 다른 엔터티와 관계가 존재한다.

### 2. 속성 attribute
`속성 attribute`란 <b>업무에서 필요로 하는 인스턴스로 관리하고자 하는 의미상 더 이상 분리되지 않는 최소의 데이터 단위</b>를 말합니다. 읽다보면 엔터티-속성-인스턴스가 헷갈리실 수 있습니다. 학생이란 엔터티를 다시 생각해봅시다. 학생 엔터티에는 이름, 학번, 전공, 학점 등의 속성이 존재합니다. 다시 말해 엔터티는 속성들의 집합입니다.

|이름|학번|전공|학점|
|---|---|---|---|
|정호섭|201511995|사회학|3.88|

이와 같이 <b>각 속성에 맞는 속성값들로 이루어져 만들어진 객체</b>를 `인스턴스 instance`라고 합니다. 그렇기 때문에 `속성 attribute`이 최소의 데이터 단위가 되는 것입니다.

속성은 다음과 같은 특징을 갖습니다.
- 엔터티와 마찬가지로 반드시 해당 업무에서 필요하고 관리하고자 하는 정보이어야 한다.
- 하나의 속성에는 하나의 속성값만 가진다. 하나의 속성에 여러 개의 값이 있는 다중값일 경우 별도의 엔터티를 이용하여 분리한다.
- 정규화 이론을 근거로 <b>주식별자에 함수적으로 종속된다. 즉 기본키가 변경되면 속성 값도 변경된다.</b>

### 3. 관계 relationship
`관계 relationship`는 <b>엔터티 간의 관련성을 의미</b>합니다. 이러한 관계는 어떤 목적으로 연결되었는가에 따라 `존재에 의한 관계`와 `행위에 의한 관계`로 구분됩니다.

<img src = https://user-images.githubusercontent.com/72376781/158291136-21d066b3-958d-4d68-a9c9-4a8a5d9a9a56.jpg width = 700>

위 그림과 같이 `존재에 의한 관계`는 엔터티 간의 상태를 의미합니다. '소속된다'는 것은 어떤 행위가 아닌 손흥민 선수가 토트넘이라는 팀에 소속되었기 때문에 존재에 의해 생성되는 관계입니다. 반면 주문과 같은 `행위에 의한 관계`는 '주문'이라는 행위를 통해 생성된 관계입니다.

## 4. Level Schema
사용자, 설계자, 개발자가 DB를 보는 관점에 따라 DB를 기술하고, 관계를 정리한 [ANSI 표준](https://velog.io/@gillog/ANSI-SQL%EC%9D%B4%EB%9E%80)으로 <b>DB의 독립성을 확보할 수 있는 방법</b>입니다.

> #### tip 데이터 독립성은 무엇이고, 왜 확보하나요?
데이터 독립성이란 <b>특정 스키마를 변경해도 상위 수준의 스키마 정의에 영향을 주지 않는 성질</b>입니다. 데이터 독립성을 확보하면 다음과 같은 효과를 얻을 수 있습니다.
- 데이터 복잡도 증가
- 데이터 중복 제거
- 사용자 요구사항 변경에 따른 대응력 향상
- 관리 및 유지보수 비용 절감
이러한 이유로 데이터 독립성을 확보합니다.

level schema는 다음 그림과 같이 이루어져 있습니다.

![level schema](https://user-images.githubusercontent.com/72376781/158091190-d0162e65-febe-4713-9e96-30e860348177.jpg)

1. 외부 스키마 external level
- 사용자 개개인, DB 이용자의 관점으로 구성된 개인적 DB 스키마
- 응용 프로그램에 접근하는 DB 정의
- 하나의 외부 스키마는 여럿이서 공유가 가능

2. 개념 스키마 conceptual level
- 설계자, 사용자 관점을 통합한 기관, 조직 전체 관점의 DB 구조
- 개념 단계 하나의 개념적 스키마로 구성되어 있으며 전체 DB내 규칙과 구조를 표현함

3. 내부 스키마 internal level
- 개발자와 저장장치 관점의 물리적 저장 구조
- 데이터 저장구조, 레코드 구조, 필드 정의, 인덱스 등을 의미
