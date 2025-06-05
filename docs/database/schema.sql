-- docs\database\schema.sql

CREATE TABLE `Address`(
    `address_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `street` VARCHAR(255) NOT NULL,
    `postal_code` VARCHAR(255) NOT NULL,
    `city` VARCHAR(255) NOT NULL,
    `country` VARCHAR(255) NOT NULL,
    `user_id` BIGINT NOT NULL
);
CREATE TABLE `Seller`(
    `seller_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `address_id` BIGINT NOT NULL,
    `store_name` VARCHAR(255) NOT NULL,
    `contact_phone` VARCHAR(255) NOT NULL,
    `address_seller` VARCHAR(255) NOT NULL,
    `email_seller` VARCHAR(255) NOT NULL,
    `information_seller` VARCHAR(255) NOT NULL
);
CREATE TABLE `Shipment`(
    `shipment_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `shipment_date` DATETIME NOT NULL,
    `shipment_type` ENUM('') NOT NULL,
    `status` ENUM('') NOT NULL,
    `order_id` BIGINT NOT NULL
);
CREATE TABLE `Review`(
    `review_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT NOT NULL,
    `product_id` BIGINT NOT NULL,
    `rating` ENUM('') NOT NULL,
    `comment` VARCHAR(255) NOT NULL,
    `publication_date` DATETIME NOT NULL
);
CREATE TABLE `User`(
    `user_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `password` TEXT NOT NULL,
    `role` ENUM('') NOT NULL,
    `address_id` BIGINT NOT NULL,
    `seller_id` BIGINT NULL
);
CREATE TABLE `Order`(
    `order_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `date_order` DATETIME NOT NULL,
    `status` ENUM('') NOT NULL,
    `total_amount` DECIMAL(8, 2) NOT NULL,
    `user_id` BIGINT NOT NULL,
    `shipping_address_id` BIGINT NOT NULL
);
CREATE TABLE `Payment`(
    `payment_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `amount` DOUBLE NOT NULL,
    `payment_method` ENUM('') NOT NULL,
    `status` ENUM('') NOT NULL,
    `payment_date` DATETIME NOT NULL,
    `order_id` BIGINT NOT NULL,
    `user_id` BIGINT NOT NULL
);
CREATE TABLE `ShoppingCart`(
    `shopping_cart_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `created_at` DATETIME NOT NULL,
    `user_id` BIGINT NOT NULL,
    `user_session_id` BIGINT NOT NULL
);
CREATE TABLE `OrderItem`(
    `order_item_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_id` BIGINT NOT NULL,
    `order_id` BIGINT NOT NULL,
    `quantity` DOUBLE NOT NULL,
    `price_unit` DECIMAL(8, 2) NOT NULL
);
CREATE TABLE `CartItem`(
    `cart_item_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `shopping_cart_id` BIGINT NOT NULL,
    `product_id` BIGINT NOT NULL
);
CREATE TABLE `Product`(
    `product_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `seller_id` BIGINT NOT NULL,
    `product_name` VARCHAR(255) NOT NULL,
    `product_description` TEXT NOT NULL,
    `product_price` DOUBLE NOT NULL,
    `product_stock` BIGINT NOT NULL,
    `created_at` DATETIME NOT NULL
);
CREATE TABLE `Category`(
    `category_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `category_name` VARCHAR(255) NOT NULL,
    `product_description` TEXT NOT NULL
);
CREATE TABLE `Product_Category`(
    `product_category_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_id` BIGINT NOT NULL,
    `category_id` BIGINT NOT NULL
);
CREATE TABLE `UserSession`(
    `user_session_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT NOT NULL,
    `refresh_token` BIGINT NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT NOW(),
    `expires_at` DATETIME NOT NULL
);
CREATE TABLE `Like`(
    `like_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT NOT NULL,
    `product_id` BIGINT NOT NULL
);
ALTER TABLE
    `CartItem` ADD CONSTRAINT `cartitem_shopping_cart_id_foreign` FOREIGN KEY(`shopping_cart_id`) REFERENCES `ShoppingCart`(`shopping_cart_id`);
ALTER TABLE
    `UserSession` ADD CONSTRAINT `usersession_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `User`(`user_id`);
ALTER TABLE
    `Product_Category` ADD CONSTRAINT `product_category_category_id_foreign` FOREIGN KEY(`category_id`) REFERENCES `Category`(`category_id`);
ALTER TABLE
    `OrderItem` ADD CONSTRAINT `orderitem_order_id_foreign` FOREIGN KEY(`order_id`) REFERENCES `Order`(`order_id`);
ALTER TABLE
    `Shipment` ADD CONSTRAINT `shipment_order_id_foreign` FOREIGN KEY(`order_id`) REFERENCES `Order`(`order_id`);
ALTER TABLE
    `Review` ADD CONSTRAINT `review_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `User`(`user_id`);
ALTER TABLE
    `Review` ADD CONSTRAINT `review_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `Product`(`product_id`);
ALTER TABLE
    `ShoppingCart` ADD CONSTRAINT `shoppingcart_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `User`(`user_id`);
ALTER TABLE `ShoppingCart` ADD CONSTRAINT `shoppingcart_user_session_id_foreign` FOREIGN KEY(`user_session_id`) REFERENCES `UserSession`(`user_session_id`);
ALTER TABLE
    `Like` ADD CONSTRAINT `like_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `Product`(`product_id`);
ALTER TABLE
    `OrderItem` ADD CONSTRAINT `orderitem_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `Product`(`product_id`);
ALTER TABLE
    `Order` ADD CONSTRAINT `order_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `User`(`user_id`);
ALTER TABLE
    `Order` ADD CONSTRAINT `order_shipping_address_id_foreign` FOREIGN KEY(`shipping_address_id`) REFERENCES `Address`(`address_id`);
ALTER TABLE
    `Payment` ADD CONSTRAINT `payment_order_id_foreign` FOREIGN KEY(`order_id`) REFERENCES `Order`(`order_id`);
ALTER TABLE
    `Payment` ADD CONSTRAINT `payment_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `User`(`user_id`);
ALTER TABLE
    `Like` ADD CONSTRAINT `like_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `User`(`user_id`);
ALTER TABLE
    `User` ADD CONSTRAINT `user_seller_id_foreign` FOREIGN KEY(`seller_id`) REFERENCES `Seller`(`seller_id`);
ALTER TABLE
    `CartItem` ADD CONSTRAINT `cartitem_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `Product`(`product_id`);
ALTER TABLE
    `Product_Category` ADD CONSTRAINT `product_category_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `Product`(`product_id`);
ALTER TABLE
    `Address` ADD CONSTRAINT `address_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `User`(`user_id`);
ALTER TABLE
    `Seller` ADD CONSTRAINT `seller_address_id_foreign` FOREIGN KEY(`address_id`) REFERENCES `Address`(`address_id`);
ALTER TABLE
    `Product` ADD CONSTRAINT `product_seller_id_foreign` FOREIGN KEY(`seller_id`) REFERENCES `Seller`(`seller_id`);