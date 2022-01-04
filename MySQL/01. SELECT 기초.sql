-- 1. 테이블의 모든 내용(*) 보기
SELECT * FROM film;

-- 2. 원하는 column(열)만 보기
SELECT title, release_year, length
FROM film;

-- 테이블 column이 아닌 값도 선택할 수 있음.
SELECT title, release_year, 'actors', 1
FROM film;
-- 해당 값을 확인해보면 모든 행에 actors, 1이 나옴.

-- 3. 원하는 조건의 row(행)만 걸러서 보기
SELECT title, release_year
FROM film
WHERE release_year > 2002;
-- WHERE 구문을 통해 if문과 같이 조건을 붙여 원하는 데이터만 볼 수 있음.

-- 4. 원하는 순서대로 데이터 가져오기
SELECT title, release_year, rating
FROM film
ORDER BY title;

SELECT title, release_year, rating
FROM film
ORDER BY title DESC;

-- 5. 원하는 만큼만 데이터 가져오기
SELECT title, release_year
FROM film
LIMIT 10;

SELECT title, release_year
FROM film
LIMIT 20, 10;
-- LIMIT{가져올 개수} 또는 LIMIT {건너뛸 개수, 가져올 개수} 형태로 사용 가능

-- 6. 원하는 예명(alias)으로 가져오기
SELECT 
	film_id AS no,
    title,
    release_year,
    rental_duration AS duration
FROM film;
-- AS문을 통해 컬럼명 변경이 가능하다.

-- 응용
SELECT
	film_id AS No,
    title,
    release_year,
    rental_duration AS duration,
    length
FROM film
WHERE
	length < 60 AND duration < 8;
