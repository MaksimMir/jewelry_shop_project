USE jewelry_store;
	
-- 1 Выборка из корзин покупателей
SELECT concat(u.first_name, ' ', u.last_name) AS user,
		concat(catt.name, ', ', b.name) AS product,
				m.name AS material, 
				i.name AS insert_material,
				p.price * op.total AS price
	FROM users u
	JOIN orders o
	ON u.id = o.user_id
	JOIN orders_product op
	ON o.id = op.order_id
	JOIN products p
	ON p.id = op.product_id 
	JOIN brands b
	ON p.brand_id = b.id 
	JOIN categories_types catt
	ON p.category_type_id = catt.id 
	JOIN materials m
	ON p.material_id = m.id 
	JOIN inserts i
	ON p.insert_id = i.id;

-- 2 Общая сумма товаров в корзине
SELECT sum(p.price * op.total) AS total_sum
	FROM orders_product op 
	JOIN products p
	ON op.product_id = p.id;

-- 3 Персональные скидки покупателям. Процент и время действия
SELECT concat(u.first_name, ' ', u.last_name) AS user,
		d.discount, d.started_at, d.finished_at 
	FROM users u
	JOIN discounts d
	ON u.id = d.user_id;

-- 4 Сравнение цен со скидкой и без. Процент скидки
SELECT concat(catt.name, ' ',
				b.name) AS product,
				p.price,
		format(p.price - p.price * d.discount, 2) AS discount_price,
		concat(format(d.discount * 100, 0), '%') AS discount
	FROM products p
	JOIN categories_types catt
	ON p.category_type_id = catt.id 
	JOIN brands b
	ON p.brand_id = b.id 
	JOIN discounts d
	ON p.id = d.product_id;
	
-- 5 То же что и 1 только с учетом скидки (Можно группировать по скидкам на товары и категории)
SELECT DISTINCT concat(u.first_name, ' ', u.last_name) AS user,
				p.id,
				p.category_id,
				p.price,
				op.total,
				format(d.discount * 100, 0) AS '%%',
				format((p.price * op.total) - (p.price * d.discount), 2) AS discount
	FROM users u
	JOIN orders o
	ON u.id = o.user_id
	JOIN orders_product op
	ON o.id = op.order_id
	JOIN products p
	ON p.id = op.product_id
	LEFT JOIN discounts d 
	ON u.id = d.user_id OR p.id = d.product_id OR p.category_id = d.category_id
	GROUP BY u.id;

-- 6 Список пользователей у кого блжайший день рождения
SELECT u.username, u.email, p.birthday
	FROM users u
	JOIN profiles p
	ON u.id = p.user_id
	AND p.birthday IN (SELECT birthday FROM profiles WHERE day(birthday) BETWEEN
	day(now()) AND day(now() + INTERVAL 10 day)
	AND 
	MONTH(birthday) = MONTH(now()));

-- 7 Средняя цена и количество товаров по категориям
SELECT ct.name, format(avg(p.price), 2) AS avg_price, count(p.id) AS total
	FROM products p
	JOIN categories_types ct  
	ON p.category_id = ct.id
	WHERE p.total > 0
	GROUP BY ct.name;

-- 8 Средняя цена в категории, минимальная и максимальная цена(оконные функции)
SELECT DISTINCT ct.name, 
	avg(p.price) OVER cat_n AS avg_price, 
	count(p.id) OVER cat_n AS total,
	min(p.price) OVER cat_n AS min_price,
	max(p.price) OVER cat_n AS max_price
	FROM products p
	JOIN categories_types ct  
	ON p.category_id = ct.id
	WHERE p.total > 0
	WINDOW cat_n AS (PARTITION BY ct.name);


