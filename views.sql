USE jewelry_store;

CREATE VIEW product_with_discount AS 
	SELECT catt.name AS category,
			b.name AS brand,
			p.price,
			format(p.price - p.price * d.discount, 2) AS price_with_discount
		FROM products p
		JOIN categories_types catt
		ON p.category_type_id = catt.id 
		JOIN brands b
		ON p.brand_id = b.id 
		JOIN discounts d
		ON p.id = d.product_id;
	

CREATE VIEW buy_address AS	
	SELECT concat(u.first_name, ' ', u.last_name) AS user,
				u.phone, p.address
			FROM users u
			JOIN orders o
			ON u.id = o.user_id
			JOIN profiles p
			ON u.id = p.user_id
			GROUP BY user;