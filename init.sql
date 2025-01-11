CREATE DATABASE IF NOT EXISTS test_db;
USE test_db;

CREATE TABLE IF NOT EXISTS test_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    column_name VARCHAR(255) NOT NULL
);

INSERT INTO test_table (column_name) VALUES ('First row'), ('Second row');

-- cоздание пользователя и выдача ему прав на созданную бд
CREATE USER IF NOT EXISTS 'db_user'@'localhost' IDENTIFIED BY 'db_password';
GRANT ALL PRIVILEGES ON test_db.* TO 'db_user'@'localhost';
FLUSH PRIVILEGES; -- применение внесенных изменений
