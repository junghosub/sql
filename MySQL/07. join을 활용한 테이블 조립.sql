-- 07. join을 활용한 테이블 조립
-- (1). 내부 조인

SELECT A.actor_id, F.film_id, F.title, F.description FROM film_actor A
JOIN film F ON F.film_id = A.film_id;
-- ambiguous 주의해야함!

SELECT 
	F.actor_id, 
    F.film_id, 
    CONCAT_WS(' ', A.first_name, A.last_name) AS actor_name
FROM actor A
JOIN film_actor F ON F.actor_id = A.actor_id
WHERE film_id = 277;

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
-- 이처럼 여러 개의 테이블을 JOIN 할 수 있음.

-- 인벤토리에 가장 많은 영화 구해보기
SELECT 
	I.film_id, 
    F.title, 
    COUNT(I.film_id) AS count FROM inventory I
JOIN film F ON F.film_id = I.film_id
GROUP BY I.film_id
ORDER BY count DESC;

-- (2). 외부 조인
SELECT 
	C1.customer_id,
    CONCAT_WS(' ', C1.first_name, C1.last_name) AS customer,
    C2.customer_id,
    CONCAT_WS(' ', C2.first_name, C2.last_name) AS next_customer
FROM customer C1
LEFT JOIN customer C2
ON C1.customer_id + 1 = C2.customer_id;

SELECT 
	C1.customer_id,
    CONCAT_WS(' ', C1.first_name, C1.last_name) AS customer,
    C2.customer_id,
    CONCAT_WS(' ', C2.first_name, C2.last_name) AS next_customer
FROM customer C1
RIGHT JOIN customer C2
ON C1.customer_id + 1 = C2.customer_id;
-- OUTER는 선택 사항이다.

-- (3). 교차 조인
-- CROSS JOIN을 활용하여 모든 조합이 볼 수 있음.