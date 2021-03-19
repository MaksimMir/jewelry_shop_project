USE jewelry_store;

DROP FUNCTION IF EXISTS insert_user_in_discount;

DELIMITER //

CREATE FUNCTION insert_user_in_discount ()
RETURNS TEXT NO SQL
BEGIN
	IF NOT EXISTS (SELECT user_id FROM discounts WHERE user_id IN 
		(SELECT user_id FROM profiles WHERE 
		DAY(birthday) = DAY(now())
		AND 
		MONTH(birthday) = MONTH(now()))
		)
	THEN 
	INSERT INTO discounts VALUES (DEFAULT, 
		(SELECT user_id FROM profiles WHERE 
		DAY(birthday) = DAY(now()) 
		AND 
		MONTH(birthday) = MONTH(now())),
		null, 
		null, 
		0.3, 
		now(),
		now() + INTERVAL 20 DAY, 
		DEFAULT, 
		DEFAULT);
	RETURN 'Дарим скидку 30% на день рождения';
	END IF;
END//

DELIMITER ;
SELECT insert_user_in_discount ();


DROP TRIGGER IF EXISTS username_validate_on_insert;
DROP TRIGGER IF EXISTS username_validate_on_update;
DROP TRIGGER IF EXISTS validate_brand_on_insert;
DROP TRIGGER IF EXISTS validate_brand_on_update;
DROP TRIGGER IF EXISTS validate_order_on_insert;
DELIMITER //

CREATE TRIGGER usernme_validate_on_insert BEFORE INSERT ON users
FOR EACH ROW 
BEGIN
  IF NEW.username IN(SELECT username FROM users) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Такое имя уже существует';
  END IF;
END//

CREATE TRIGGER usernme_validate_on_update BEFORE UPDATE ON users
FOR EACH ROW 
BEGIN
  IF NEW.username IN(SELECT username FROM users) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Такое имя уже существует';
  END IF;
END//

CREATE TRIGGER validate_brand_on_insert BEFORE INSERT ON brands
FOR EACH ROW 
BEGIN
  IF NEW.name IN(SELECT name FROM brands) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Бренд уже существует в базе данных';
  END IF;
END//

CREATE TRIGGER validate_brand_on_update BEFORE UPDATE ON brands
FOR EACH ROW 
BEGIN
  IF NEW.name IN(SELECT name FROM brands) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Бренд уже существует в базе данных';
  END IF;
END//

CREATE TRIGGER validate_order_on_insert BEFORE INSERT ON orders_product
FOR EACH ROW 
BEGIN
  IF NEW.product_id IN(SELECT id FROM products WHERE total = 0) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Товар отсутствует';
  END IF;
END//

DELIMITER ;



	