-- Create Users Table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(255) UNIQUE NOT NULL,
    address TEXT,
    role VARCHAR(50) NOT NULL,
    password VARCHAR(255),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    region VARCHAR(100),
    quantity_order DECIMAL(10, 2) DEFAULT 0,
    rating INTEGER DEFAULT 0,
    CONSTRAINT valid_role CHECK (role IN ('client', 'executor'))
);

-- Create Categories Table
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Create SubCategories Table
CREATE TABLE sub_categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category_id INTEGER NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

-- Create Services Table
CREATE TABLE services (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    category_id INTEGER NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

-- Create ServiceSubCategories Table (Junction table for many-to-many relationship)
CREATE TABLE service_sub_categories (
    id SERIAL PRIMARY KEY,
    service_id INTEGER NOT NULL,
    sub_category_id INTEGER NOT NULL,
    FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE CASCADE,
    FOREIGN KEY (sub_category_id) REFERENCES sub_categories(id) ON DELETE CASCADE,
    UNIQUE (service_id, sub_category_id)
);

-- Create Orders Table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    service_id INTEGER NOT NULL,
    client_id INTEGER NOT NULL,
    executor_id INTEGER NOT NULL,
    date_order TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_execution TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (executor_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT valid_status CHECK (status IN ('pending', 'completed', 'cancelled'))
);

-- Create Payments Table
CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    client_id INTEGER NOT NULL,
    executor_id INTEGER NOT NULL,
    date_order TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_execution TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (executor_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT valid_payment_status CHECK (status IN ('pending', 'completed', 'cancelled'))
);

-- Create SMS Codes Table
CREATE TABLE sms_codes (
    id SERIAL PRIMARY KEY,
    phone VARCHAR(255) NOT NULL,
    code VARCHAR(6) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Insert Initial Data
INSERT INTO categories (name) VALUES ('Cleaning'), ('Plumbing'), ('Electrical');
INSERT INTO sub_categories (name, category_id) VALUES
    ('House Cleaning', 1),
    ('Office Cleaning', 1),
    ('Pipe Repair', 2);
INSERT INTO users (name, email, phone, address, role, password, region, quantity_order, rating, created_at)
VALUES
    ('John Doe', 'john@example.com', '+1234567890', '123 Main St', 'client', 'hashed_password', 'NY', 0, 0, CURRENT_TIMESTAMP),
    ('Jane Smith', 'jane@example.com', '+1234567891', '456 Oak St', 'executor', 'hashed_password', 'CA', 0, 0, CURRENT_TIMESTAMP);
INSERT INTO services (name, description, category_id, price)
VALUES
    ('Cleaning Service', 'General cleaning', 1, 50.00),
    ('Plumbing Service', 'Fixing pipes', 2, 75.00);
INSERT INTO service_sub_categories (service_id, sub_category_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 3);
