-- =========================================
-- DATABASE: FAST FOOD CHAIN (SQL SERVER)
-- =========================================

IF DB_ID('FastFoodChain') IS NOT NULL
    DROP DATABASE FastFoodChain;
GO

CREATE DATABASE FastFoodChain;
GO

USE FastFoodChain;
GO

-- =========================================
-- TABLE: Store
-- =========================================
CREATE TABLE Store (
    store_id INT IDENTITY(1,1) PRIMARY KEY,
    store_name NVARCHAR(100) NOT NULL,
    address NVARCHAR(255) NOT NULL,
    phone NVARCHAR(20)
);
GO

-- =========================================
-- TABLE: Employee
-- =========================================
CREATE TABLE Employee (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(100) NOT NULL,
    position NVARCHAR(50),
    salary DECIMAL(10,2),
    store_id INT,
    CONSTRAINT FK_Employee_Store
        FOREIGN KEY (store_id)
        REFERENCES Store(store_id)
        ON DELETE CASCADE
);
GO

-- =========================================
-- TABLE: Food
-- =========================================
CREATE TABLE Food (
    food_id INT IDENTITY(1,1) PRIMARY KEY,
    food_name NVARCHAR(100) NOT NULL,
    category NVARCHAR(50),
    price DECIMAL(10,2) NOT NULL
);
GO

-- =========================================
-- TABLE: Orders
-- =========================================
CREATE TABLE Orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    order_date DATETIME DEFAULT GETDATE(),
    total_amount DECIMAL(10,2),
    store_id INT,
    CONSTRAINT FK_Orders_Store
        FOREIGN KEY (store_id)
        REFERENCES Store(store_id)
        ON DELETE CASCADE
);
GO

-- =========================================
-- TABLE: OrderDetail
-- =========================================
CREATE TABLE OrderDetail (
    order_id INT NOT NULL,
    food_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_OrderDetail PRIMARY KEY (order_id, food_id),
    CONSTRAINT FK_OrderDetail_Orders
        FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
        ON DELETE CASCADE,
    CONSTRAINT FK_OrderDetail_Food
        FOREIGN KEY (food_id)
        REFERENCES Food(food_id)
);
GO

-- =========================================
-- SAMPLE DATA
-- =========================================
INSERT INTO Store (store_name, address, phone) VALUES
(N'FastFood Center 1', N'Quận 1, TP.HCM', N'0909000001'),
(N'FastFood Center 2', N'Quận 3, TP.HCM', N'0909000002');

INSERT INTO Employee (full_name, position, salary, store_id) VALUES
(N'Nguyễn Văn A', N'Quản lý', 12000000, 1),
(N'Trần Thị B', N'Thu ngân', 7000000, 1),
(N'Lê Văn C', N'Phục vụ', 6500000, 2);

INSERT INTO Food (food_name, category, price) VALUES
(N'Burger bò', N'Burger', 45000),
(N'Gà rán', N'Gà', 35000),
(N'Khoai tây chiên', N'Ăn kèm', 25000),
(N'Coca Cola', N'Nước uống', 15000);

INSERT INTO Orders (store_id, total_amount) VALUES
(1, 95000),
(2, 60000);

INSERT INTO OrderDetail (order_id, food_id, quantity, price) VALUES
(1, 1, 1, 45000),
(1, 3, 2, 25000),
(2, 2, 1, 35000),
(2, 4, 1, 15000);
GO
