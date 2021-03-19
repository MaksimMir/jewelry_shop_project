USE jewelry_store;
SHOW tables;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  username varchar(100) NOT NULL,
  first_name varchar(100) NOT NULL,
  last_name varchar(100) NOT NULL,
  email varchar(100) NOT NULL UNIQUE,
  phone varchar(100) NOT NULL UNIQUE,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  update_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  user_id int unsigned NOT NULL PRIMARY KEY,
  gender enum('m','w') NOT NULL,
  city varchar(100) NOT NULL,
  address varchar(255) DEFAULT NULL,
  birthday date DEFAULT NULL,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  update_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS brands;
CREATE TABLE brands (
  id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name varchar(128) NOT NULL
);

DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
  id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name varchar(128) NOT NULL,
  alias_name varchar(128) DEFAULT NULL
);

DROP TABLE IF EXISTS categories_types;
CREATE TABLE categories_types (
  id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name varchar(128) NOT NULL,
  alias_name varchar(128) DEFAULT NULL
);

DROP TABLE IF EXISTS materials;
CREATE TABLE materials (
  id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name varchar(128) NOT NULL,
  alias_name varchar(128) DEFAULT NULL
) COMMENT = 'Материал изделия';

DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (
  id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  category_type_id int UNSIGNED NOT NULL,
  value decimal(5,1) NOT NULL
) COMMENT = 'Размер изделия';

DROP TABLE IF EXISTS inserts;
CREATE TABLE inserts (
  id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name varchar(128) DEFAULT 'Без вставки',
  alias_name varchar(128) DEFAULT NULL
) COMMENT = 'Вставка(материал) для изделия';

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  brand_id int unsigned NOT NULL,
  category_type_id int unsigned NOT NULL,
  category_id int unsigned NOT NULL,
  material_id int unsigned NOT NULL,
  size_id int unsigned NOT NULL,
  insert_id int UNSIGNED NOT NULL,
  price decimal(10,2) NOT NULL,
  total int UNSIGNED DEFAULT NULL,
  alias_name varchar(128) DEFAULT NULL, 
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  update_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS images;
CREATE TABLE images (
  product_id int unsigned NOT NULL PRIMARY KEY,
  link_to_img varchar(256) DEFAULT NULL,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  update_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Изображение изделия';

DROP TABLE IF EXISTS descriptions;
CREATE TABLE descriptions (
  product_id int unsigned NOT NULL PRIMARY KEY,
  article text DEFAULT NULL,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  update_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Описание изделия';

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id int unsigned NOT NULL,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  update_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS orders_product;
CREATE TABLE orders_product (
  id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  order_id int unsigned NOT NULL,
  product_id int unsigned NOT NULL,
  total int UNSIGNED DEFAULT 1,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  update_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id int unsigned NOT NULL,
  product_id int unsigned NOT NULL,
  category_id int unsigned NOT NULL,
  discount float UNSIGNED COMMENT 'Значение скидки от 0.0 до 1.0',
  started_at datetime,
  finished_at datetime,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  update_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


SELECT * FROM products;

