-- 1. 사칙연산
SELECT 1+2;
SELECT 5-2.5 AS Difference;
SELECT 'ABC'+3;
-- 문자열은 0으로 인식한다.
SELECT '1'+'002'+3;
-- 하지만 숫자로 구성된 문자열은 숫자로 자동 인식한다.

SELECT 
	payment_id, 
	rental_id, 
    amount,
    amount * 0.75 AS sale_amount
FROM payment;
-- 이런 식으로 응용 가능

-- 2. 참거짓 연산자
-- 기본적으로 MySQL에서도 TRUE, FALSE는 각각 1과 0을 저장하고 있음.
SELECT TRUE IS TRUE;
SELECT TRUE IS NOT FALSE;
SELECT (TRUE IS TRUE) IS NOT TRUE;
-- IS : 양쪽이 모두 True이거나 False
-- IS NOT : 한쪽은 True, 한쪽은 False
-- and, or은 생략

SELECT 
	payment_id, 
    rental_id, 
    amount > 10 AS overdue
FROM payment;

SELECT 
	payment_id,
    rental_id,
    NOT amount > 10 AS non_overdue
FROM payment;
-- 0과 1로 구성된 값이 나옴

SELECT 5 BETWEEN 1 AND 10;
SELECT 'banana' NOT BETWEEN 'apple' AND 'camera';

SELECT customer_id, rental_id, amount
FROM payment
WHERE amount BETWEEN 4 AND 7;
-- amount가 4$와 7$ 사이에 있는 데이터만 추출

SELECT 1+2 IN (2,3,4);
SELECT 'hello' IN (1, TRUE, 'hello');

SELECT address, district, city_id
FROM address
WHERE district IN ('Texas', 'Alberta');
-- IN 연산자를 활용해 Texas, Alberta에 속한 주소만 추출

SELECT
  'HELLO' LIKE 'hel%',
  'HELLO' LIKE 'H%',
  'HELLO' LIKE 'H%O',
  'HELLO' LIKE '%O',
  'HELLO' LIKE '%HELLO%',
  'HELLO' LIKE '%H',
  'HELLO' LIKE 'L%';
-- 0 ~ n개의 문자를 가진 패턴

SELECT 
	address, 
	district LIKE 'a%' AS A_blahblah,
    city_id
FROM address;

SELECT
  'HELLO' LIKE 'HEL__',
  'HELLO' LIKE 'h___O',
  'HELLO' LIKE 'HE_LO',
  'HELLO' LIKE '_____',
  'HELLO' LIKE '_HELLO',
  'HELLO' LIKE 'HEL_',
  'HELLO' LIKE 'H_O';
  -- '_'의 개수의 문자를 가진 패턴