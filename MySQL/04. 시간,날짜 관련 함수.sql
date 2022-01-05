-- 4. 시간/날짜 관련 함수

-- (1). 시간/날짜 관련 함수
SELECT CURDATE(), CURTIME(), NOW();
-- CURDATE : 현재 날짜 반환
-- CURTIME : 현재 시간 반환
-- NOW : 현재 시간과 날짜 

SELECT
	rental_date,
	YEAR(rental_date) AS year,
    MONTHNAME(rental_date) AS month_name,
    MONTH(rental_date) AS month,
    WEEKDAY(rental_date) AS weekday,
    DAYNAME(rental_date) AS day_name,
    DAY(rental_date) AS day
FROM rental;
-- YEAR : datetime의 년도 반환
-- MONTHNAME : datetime의 월 이름 반환
-- MONTH : datetime의 월 반환
-- WEEKDAY : datetime의 요일값 반환(월요일 : 0..)
-- DAYNAME : datetime의 요일명 반환
-- DAYOFMONTH, DAY :  datetime의 날짜 반환

SELECT 
	rental_date AS before_rental_date,
    CONCAT(CONCAT_WS('/', YEAR(rental_date), MONTH(rental_date), DAY(rental_date)), ' ', UPPER(LEFT(DAYNAME(rental_date), 3))) AS rental_date
FROM rental;

SELECT HOUR(NOW()), MINUTE(NOW()), SECOND(NOW());
-- HOUR: datetiem의 시간 반환
-- MINUTE : datetiem의 분 반환
-- SECOND : datetime의 초 반환

SELECT 
	ADDDATE(NOW(), INTERVAL 1 MONTH),
    ADDDATE(NOW(), INTERVAL 3 WEEK),
    SUBDATE(NOW(), INTERVAL 1 MONTH);
-- ADDDATE: 시간 더하기
-- SUBDATE: 시간 빼기

SELECT 
	rental_date,
    return_date,
    DATEDIFF(return_date, rental_date) AS duration
FROM rental
WHERE DATEDIFF(return_date, rental_date) >= 5;
-- DATEDIFF를 통해 두 datetime의 시간차를 구할 수 있음.
-- TIMEDIFF도 있음.

SELECT 
	return_date,
    LAST_DAY(return_date) AS last_day,
    DATEDIFF(LAST_DAY(return_date), return_date) AS duration
FROM rental;
-- LAST_DAY를 통해 해당 datetime의 말일을 구할 수 있음.

SELECT
  DATE_FORMAT(NOW(), '%M %D, %Y %T'),
  DATE_FORMAT(NOW(), '%y-%m-%d %h:%i:%s %p'),
  DATE_FORMAT(NOW(), '%Y년 %m월 %d일 %p %h시 %i분 %s초');

SELECT REPLACE(
  REPLACE(
    DATE_FORMAT(NOW(), '%Y년 %m월 %d일 %p %h시 %i분 %초'),
    'AM', '오전'
  ),
  'PM', '오후'
) as '현재 시각';

SELECT STR_TO_DATE('2022-01-05 13:47', '%Y-%m-%d %T') as '현재 시각';
-- STR_TO_DATE(str, format)를 통해 string을 해당 format의 꼴로 변경해줌.

-- (2) 기타 함수
SELECT IF(1 + 1 = 3, '참이다.', '거짓이다.') AS '1 + 1 = 3'; 
-- IF(condition, true, false) : 조건이 참이면 true 반환, 거짓이면 false 반환

SELECT
CASE
	WHEN -1 > 0 THEN '-1은 양수다.'
    WHEN -1 = 0 THEN '-1은 -0이다.'
    ELSE '-1은 음수다.'
END;
-- 이렇게 조건이 많을 때는 CASE-WHEN-END문을 통해 구현한다.

SELECT
	rental_id,
    CASE
		WHEN amount < 1 THEN 'on sale'
        WHEN amount BETWEEN 1 AND 4 THEN 'full price'
        ELSE 'fancy'
	END AS price
FROM payment;

SELECT
	IFNULL('a', 'b'),
    IFNULL(NULL, 'b');
-- IFNULL(a,b) : a가 NULL일 겅우, b 출력