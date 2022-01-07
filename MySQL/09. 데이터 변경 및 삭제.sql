-- 09. 데이터 변경, 삭제하기

-- (1). DELETE
-- 주어진 조건의 행 삭제
DELETE FROM businesses
WHERE status = 'CLS';

-- WHERE문을 통해 조건 설정을 하지 않으면 행 전체가 삭제됨..
DELETE FROM businesses;

INSERT INTO businesses (fk_section_id, business_name, status, can_takeout)
VALUES 
	(3, '화룡각', 'OPN', 1),
    (2, '미미 분식', 'OPN', 1),
    (5, '얄코렐라', 'RMD', 1);
-- DELETE로 business 테이블의 데이터를 삭제한 후, 다시 데이터를 입력해줬는데 pk인 business_id가 초기화되지 않았다. 이땐 TRUNCATE문으로 테이블을 초기화한다.
TRUNCATE businesses;

INSERT INTO businesses (fk_section_id, business_name, status, can_takeout)
VALUES 
	(3, '화룡각', 'OPN', 1),
    (2, '미미 분식', 'OPN', 1),
    (5, '얄코렐라', 'RMD', 1);
    
-- (2). UPDATE
-- 주어진 조건의 행 수정하기
UPDATE menus
SET menu_name = '삼선짜장'
WHERE menu_id = 12;

-- 여러 컬럼 수정하기
UPDATE menus
SET
	menu_name = '응급실 떡볶이',
	kilocalories = 492.78,
    price = 5000
WHERE
	fk_business_id = 4
    AND menu_name = '국물떡볶이';
    
UPDATE menus
SET price = price + 1000
WHERE fk_business_id = 8;

UPDATE menus
SET menu_name = CONCAT('전통 ', menu_name)
WHERE fk_business_id IN
(
	SELECT business_id
    FROM sections S
    LEFT JOIN businesses B
		ON S.section_id = B.fk_section_id
	WHERE section_name = '한식'
);