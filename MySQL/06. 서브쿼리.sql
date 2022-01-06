-- 6. 서브쿼리
-- (1) 비상관 서브쿼리

SELECT
	CategoryID, CategoryName, Description,
    (
    	SELECT ProductName From Products WHERE ProductID = 1
     ) AS Chais
FROM Categories;

SELECT * FROM Products
WHERE Price < (SELECT AVG(Price) FROM Products);

SELECT title, description, release_year, rental_rate
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film);

SELECT film_id, title, description, release_year
FROM film
WHERE film_id IN (SELECT film_id FROM film_actor WHERE actor_id =  18);
-- *외부 쿼리를 참조하지 않고 단독적으로 사용되면 비상관 서브쿼리라고 함.

SELECT * FROM payment
WHERE amount > ALL(SELECT amount FROM payment WHERE customer_id = 2);

SELECT film_id, title, description, release_year
FROM film
WHERE film_id = ANY (SELECT film_id FROM film_actor WHERE actor_id =  18);
-- ALL : 서브쿼리의 모든 결과에 대해 ~하다.
-- ANY : 서브쿼리의 하나 이상의 결과에 대해 ~~하다.

-- (2). 상관 쿼리

SELECT customer_id, amount, 
	(
		SELECT CONCAT_WS(' ',first_name, last_name) FROM staff S 
        WHERE S.staff_id = P.staff_id
	) AS staff_name
FROM payment P;

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