USE jewelry_store;


ALTER TABLE sizes
  ADD CONSTRAINT size_category_type_id_fk 
    FOREIGN KEY (category_type_id) REFERENCES categories_types(id)
      ON DELETE CASCADE;
     
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
      
ALTER TABLE products
  ADD CONSTRAINT product_brand_id_fk 
    FOREIGN KEY (brand_id) REFERENCES brands(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT product_category_type_id_fk 
    FOREIGN KEY (category_type_id) REFERENCES categories_types(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT product_category_id_fk 
    FOREIGN KEY (category_id) REFERENCES categories(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT product_material_id_fk 
    FOREIGN KEY (material_id) REFERENCES materials(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT product_size_id_fk 
    FOREIGN KEY (size_id) REFERENCES sizes(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT product_insert_id_fk 
    FOREIGN KEY (insert_id) REFERENCES inserts(id)
      ON DELETE CASCADE;
      
ALTER TABLE orders_product 
  ADD CONSTRAINT orders_product_order_id_fk 
    FOREIGN KEY (order_id) REFERENCES orders(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT orders_product_product_id_fk 
    FOREIGN KEY (product_id) REFERENCES products(id)
      ON DELETE CASCADE;
      
     
ALTER TABLE orders
  ADD CONSTRAINT order_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
      
ALTER TABLE images
  ADD CONSTRAINT image_user_id_fk 
    FOREIGN KEY (product_id) REFERENCES products(id)
      ON DELETE CASCADE;
      
     
ALTER TABLE discounts 
  ADD CONSTRAINT discount_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT discount_product_id_fk 
    FOREIGN KEY (product_id) REFERENCES products(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT discount_category_id_fk 
    FOREIGN KEY (category_id) REFERENCES categories(id)
      ON DELETE CASCADE;
      
ALTER TABLE descriptions 
  ADD CONSTRAINT description_product_id_fk 
    FOREIGN KEY (product_id) REFERENCES products(id)
      ON DELETE CASCADE;

CREATE UNIQUE INDEX users_username_uq ON users(username);

CREATE INDEX profiles_address_idx ON profiles(address);

CREATE INDEX product_price_uq ON products(price);

CREATE INDEX images_link_idx ON images(link_to_img);