-- 08. 테이블 생성 및 데이터 입력

INSERT INTO friend
	(person_id, person_name, age, birthday)
	VALUES (1, '정호섭', 27, '1996-12-15');

-- 모든 컬럼에 값을 넣을 땐, 컬럼명 생략 가능    
INSERT INTO friend
	VALUES (2, '전우치', 18, '1003-05-12');
    
-- 일부 컬럼에만 값 넣기 가능 (NOT NULL 아닐 시)
INSERT INTO friend
	(person_id, person_name, birthday)
	VALUES (3, '임꺽정', '1996-11-04');
-- 다만 컬럼에 맞는 자료형을 입력해야함.

-- 여러 행도 한 번에 입력 가능하다.
INSERT INTO friend
	(person_id, person_name, age, birthday)
	VALUES
		(4, '존 스미스', 30, '1991-03-02'),
        (5, '몽키 D 루피', 15, '2006-12-07'),
        (6, '황비홍', 24, '1997-10-30');
        
-- 테이블 생성시 제약 넣기
CREATE TABLE people(
	person_id INT AUTO_INCREMENT PRIMARY KEY,
	person_name VARCHAR(10) NOT NULL,
    nickname VARCHAR(10) UNIQUE NOT NULL,
    age TINYINT UNSIGNED,
    is_married TINYINT DEFAULT 0
    );
    
-- AUTO_INCREMENT : 새 행 생성시마다 자동으로 1씩 증가
-- PRIMARY KEY : 중복 입력 불가, NULL 불가
-- UNIQUE : 중복 입력 불가
-- NOT NULL : NULL 입력 불가
-- UNSIGNED : 양수만 가능
-- DEFAULT : 값 입력이 없을 시 기본값

INSERT INTO people
	(person_name, nickname, age)
    VALUES ('김철수', '아이언워터', 10);