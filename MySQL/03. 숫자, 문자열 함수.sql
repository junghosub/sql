-- 3. 숫자, 문자열 함수

-- (1) 숫자 관련 함수
SELECT
	ROUND(0.5),
    CEIL(0.4),
    FLOOR(0.6);
-- ROUND : 반올림, CEIL : 올림, FLOOR : 내림

SELECT 
	ABS(1),
    ABS(-1),
    ABS(3-10);
-- ABS()는 절댓값

SELECT
	GREATEST(1,2,3),
    LEAST(1,2,3,4,5);
-- greatest()는 가장 큰 값, least() 가장 작은 값

SELECT
	MAX(amount) AS maxium,
    MIN(amount) AS mininum,
    COUNT(amount) AS count,
    SUM(amount) AS sum,
    AVG(amount) AS average
FROM payment
WHERE amount BETWEEN 5 AND 15;
-- MAX, MIN 함수는 column을 기준으로 하고, GREATEST, LEAST는 ()을 기준으로 한다.
-- 위 함수들을 '그룹 함수'라고 한다.

SELECT POW(2,3), POWER(2,3), SQRT(16);
-- POW, POWER는 제곱 함수이고, SQRT는 제곱근을 구하는 함수이다.

SELECT
	TRUNCATE(1234.5678, 1), -- 1234.5
    TRUNCATE(1234.5678, 2), -- 12345.56
    TRUNCATE(1234.5678, 3), -- 1234.567
    TRUNCATE(1234.5678, -1), -- 1230
    TRUNCATE(1234.5678, -2); -- 1200
    
SELECT customer_id, rental_id, amount
FROM payment
WHERE TRUNCATE(amount, 0) = 4;

-- (2) 문자열 관련 함수
SELECT UPPER('abcDEF'), LOWER('abcDEF');
SELECT UCASE('abcDEF'), LCASE('abcDEF');
-- 둘이 동일함.

SELECT CONCAT('HELLO', ' ', 'THIS IS ', 2022);
-- 파이썬에서 문자열 병합(+)을 사용할 때와 같음.
SELECT CONCAT_WS('-', 2022, 10, 30, 'AM');
-- CONCAT_WS(s,...)는 s를 이어붙임.

SELECT 
	CONCAT('customerID: ', customer_id) AS cutomer_id,
    CONCAT('staffID: ', staff_id) AS staff_id
FROM payment;

SELECT
	CONCAT_WS(' ', first_name, last_name) AS full_name
FROM actor;

SELECT
	SUBSTR('abcdefg', 3), -- cdefg
    SUBSTR('abcdefg', 3,2), -- cd
    SUBSTR('abcdefg', -4), -- defg
    SUBSTR('abcdefg', -4, 2); -- de
    
SELECT
	LEFT('abcdefg', 3),
    RIGHT('abcdefg', 3);
    
SELECT 
	rental_date,
    LEFT(rental_date, 4) AS year,
    SUBSTR(rental_date, 6, 2) AS month,
    SUBSTR(rental_date, 9, 2) AS day
FROM rental;

SELECT LENGTH('abcde'), CHAR_LENGTH('abcde'), CHARACTER_LENGTH('abcde');
SELECT LENGTH('안녕'), CHAR_LENGTH('안녕'), CHARACTER_LENGTH('안녕');
-- LENGTH는 문자열의 바이트 길이를 나타내고, 문자열의 길이를 보려면 CHAR_LENGTH를 사용해야함
-- 영어는 한 문자에 1 byte, 한글은 한 문자에 3 byte

SELECT
  CONCAT('|', ' HELLO ', '|'),
  CONCAT('|', LTRIM(' HELLO '), '|'),
  CONCAT('|', RTRIM(' HELLO '), '|'),
  CONCAT('|', TRIM(' HELLO '), '|');
-- LTRIM : 왼쪽 공백 제거
-- RTRIM : 오른쪽 공백 제거
-- TRIM : 공백 제거

SELECT customer_id, first_name, last_name, email
FROM customer
WHERE last_name = TRIM(' JOHNSON ');
-- 혹시나 공백을 포함하여 입력했을 경우를 방지

SELECT 
	LPAD('abc', 5, '_'), -- '__abc'
	RPAD('abc', 5, '_'); -- 'abc__'
-- LPAD(string, n, p) : string의 길이가 n글자가 될 때까지 p를 이어붙인다.
-- RPAD(string, n, p) : string의 길이가 n글자가 될 때까지 p를 이어붙인다.

SELECT REPLACE('나는 코딩을 좋아한다.', '코딩', '음악');

SELECT 
	title, 
	release_year, 
	REPLACE(special_features, ',', '/')
FROM film;
-- REPLACE(s, a, b) : 문자열 s 중 a -> b로 변경

SELECT
  INSTR('ABCDE', 'ABC'),
  INSTR('ABCDE', 'BCDE'),
  INSTR('ABCDE', 'C'),
  INSTR('ABCDE', 'DE'),
  INSTR('ABCDE', 'F');
-- INSTR(string, s) : string 중 s의 첫 위치를 반환, 없으면 0

SELECT CONVERT('01', DECIMAL) = CONVERT('1', DECIMAL);
-- CONVERT(a, type) : a의 타입을 type으로 변경