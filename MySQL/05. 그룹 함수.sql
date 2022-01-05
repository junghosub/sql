-- 5. 조건에 따라 그룹으로 묶기

-- 문제 : 일자별 반환 갯수
SELECT
	COUNT(*) AS count, DATE(return_date) AS return_date
FROM rental
GROUP BY DATE(return_date);

-- 문제: 일자별 반환 갯수를 내림차순으로 정렬하기
SELECT
	customer_id,
    COUNT(rental_date) AS total
FROM rental
GROUP BY customer_id
ORDER BY total DESC;
-- group by와 집계 함수를 같이 사용하여 다양하게 응용 할 수 있음.

-- 문제: 고객별 가격(최대, 최소, 중앙, 평군) 출력하기
SELECT
	customer_id,
    MAX(amount) AS max_amount,
    MIN(amount) AS min_amount,
    TRUNCATE(MAX(amount)+MIN(amount)/2, 2) AS med_amount,
    TRUNCATE(AVG(amount), 2) AS avg_amount
FROM payment
GROUP BY customer_id;

SELECT
	COUNT(*) AS count, DATE(return_date) AS return_date
FROM rental
GROUP BY DATE(return_date)
WITH ROLLUP;
-- WITH ROLLUP을 사용하면 전체의 집계값을 함께 추출해줌.


SELECT
	COUNT(*) AS count, DATE(return_date) AS return_date
FROM rental
GROUP BY DATE(return_date)
HAVING count >= 200;
-- HAVING을 통해 조건문을 추가할 수 있다.
-- 그렇다면 WHERE가 무슨 차이점이 있는걸까?

SELECT
	COUNT(*) AS count, DATE(return_date) AS return_date
FROM rental
WHERE rental_date > '2005-05-31'
GROUP BY DATE(return_date)
HAVING count >= 200;
-- WHERE는 그룹하기 전의 데이터, HAVING은 그룹 후 집계에 사용합니다.

SELECT DISTINCT customer_id
FROM rental;
-- DISTINCT는 중복된 값을 제거합니다. GROUP BY와 달리 기본적인 정렬을 지원하지 않습니다. 그렇기 때문에 더 빠릅니다.