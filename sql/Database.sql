use S1912Mobile	

go
create table Roles (
	RoleID int primary key,
	RoleName nvarchar(50),
	Create_At datetime default(getDate())
)
go
go
insert into Roles(RoleID, RoleName) 
values (1, 'Admin'), (2, 'User')

go
create table Account (
	ID int identity(1,1) primary key,
	Username nvarchar(100) not null unique,
	Email nvarchar(100) not null unique,
	Address nvarchar(100) not null,
	PhoneNumber varchar(20) not null unique,
	Password varchar(50) not null,
	RoleID int not null,
	Create_At datetime default(getDate()),
	foreign key (RoleID) references Roles(RoleID),
)
go

go
insert into Account (Username, Email, Address, PhoneNumber, Password, RoleID) 
values
('admin2', 'admin2@gmail.com', 'Hanoi', '0999999992', 'admin2pass', 1),
('admin1', 'admin1@gmail.com', 'Hanoi', '0999999991', 'admin1pass', 1)
('user1', 'user1@gmail.com', 'Saigon', '0111111111', 'user1pass', 2)
select * from Account where roleID = 2
UPDATE Account
SET isDeleted = 0
WHERE isDeleted = 1;
go
go
create table Categories(
	CateID int identity(1,1) primary key,
	CateName nvarchar(50) not null,
	Create_At datetime default(getDate())
)

ALTER TABLE Products ADD IsDeleted BIT DEFAULT 0 not null;
ALTER TABLE Categories ADD IsDeleted BIT DEFAULT 0 not null;
ALTER TABLE Account ADD IsDeleted BIT DEFAULT 0 not null;
UPDATE categories
SET isDeleted = 0
WHERE isDeleted = 1;
UPDATE products
SET isDeleted = 0
WHERE isDeleted = 1;

go
insert into Categories (CateName)
values
('iPhone'), ('Samsung'), ('Nokia'), ('Oppo')
select * from Categories where CateName = 'oppo'

go
create table Products (
	ProdID varchar(10) primary key,
	ProdName nvarchar(max) not null,
	Image nvarchar(max) not null,
	Quantity int not null,
	Price money not null,
	Describe nvarchar(max) not null,
	Create_At datetime default(getDate()),
	CateID int not null,
	foreign key (CateID) references Categories(CateID)
)

go
insert into Products (ProdID, ProdName, Image, Quantity, Price, Describe, CateID)
values
('op1', 'Oppo Reno13 F', 'img/opporeno13f.jpg', 11, 9990.0, N'Oppo Reno13 F sở hữu thiết kế hiện đại, màn hình AMOLED 6.5 inch sắc nét, chip xử lý mạnh mẽ, pin dung lượng lớn và hỗ trợ sạc nhanh.', 4),
('ip1', 'iPhone 11', 'img/ip11.jpg', 4, 8990.0, N'Smartphone với màn hình 6.1 inch, chip A13 Bionic, camera kép 12MP.', 1),
('ip2', 'iPhone 13', 'img/ip13.jpg', 7, 12990.0, N'Thiết kế sang trọng, chip A15 Bionic mạnh mẽ, camera ấn tượng.', 1),
('ip3', 'iPhone 14 Pro', 'img/ip14pro.jpg', 5, 15990.0, N'Màn hình 6.1 inch Super Retina XDR, Dynamic Island, chip A16 Bionic.', 1),
('ip4', 'iPhone 15 Pro Max', 'img/ip15pm.jpg', 10, 25990.0, N'Titanium design, chip A17 Pro, camera periscope zoom quang 5x.', 1),
('nk1', 'Nokia 1280', 'img/nk1280.jpg', 5, 490.0, N'Điện thoại phổ thông bền bỉ, pin trâu, thiết kế cổ điển.', 3),
('nk2', 'Nokia G21', 'img/nkg21.jpg', 6, 690.0, N'Màn hình 6.5 inch, pin 3 ngày, camera 50MP, hỗ trợ cập nhật lâu dài.', 3),
('ss1', 'Samsung S24 Ultra', 'img/sss24.jpg', 12, 25490.0, N'Màn hình Dynamic AMOLED 120Hz, camera 200MP, bút S-Pen.', 2),
('ss2', 'Samsung Galaxy Z Flip 5', 'img/sszflip5.jpg', 8, 20990.0, N'Thiết kế gập thời thượng, màn hình 6.7 inch AMOLED, chip Snapdragon 8 Gen 2.', 2),
('ss3', 'Samsung Galaxy S23', 'img/sss23.jpg', 9, 18990.0, N'Màn hình Dynamic AMOLED 6.1 inch, chip Snapdragon 8 Gen 2, camera 50MP.', 2),
('ss4', 'Samsung S25 Ultra', 'img/sss25.jpg', 10, 27990.0, N'Màn hình Dynamic AMOLED 120Hz, camera 200MP, chip Snapdragon 8 Gen 3, bút S-Pen cải tiến.', 2),
('ip5', 'iPhone 16', 'img/ip16.jpg', 8, 26990.0, N'Thiết kế mới, chip A18 Bionic, camera 48MP, Dynamic Island thế hệ mới.', 1),
('vv1', 'Vivo X200 Pro', 'img/vivox200pro.jpg', 7, 19990.0, N'Màn hình AMOLED 120Hz, chip Dimensity 9300, camera ZEISS 50MP.', 5),
('op2', 'Oppo Find X8 Pro', 'img/oppofindx8pro.jpg', 6, 22990.0, N'Thiết kế sang trọng, màn hình LTPO AMOLED 6.8 inch, chip Snapdragon 8 Gen 3.', 4)

select top 10 * from products where isDeleted = 0 order by create_At desc
SELECT * FROM Products WHERE isDeleted = 0;

UPDATE Products
SET Image = 'admin/img/fptu.jpg' where ProdID='rm2'

update Products set ProdName = 'iPhone 16' where ProdID = 'ip5'

delete from Products where ProdID = 'rm2'

select * from Products where ProdID = 'rm2'

select * from Products join Categories
on Products.CateID = Categories.CateID

select top 3 *
from products 
order by create_At desc

select * from products where CateID = 2
select * from Products where price between 0 and 1100
select * from products where prodname like '%sung%'

go
create table Orders (
    OrderID int identity(1,1) primary key,
    AccID int not null,
    Create_At datetime default (getdate()),
    TotalAmount money not null,
    status nvarchar(50) default 'Pending', --Pending, Processing, Completed, Canceled
    foreign key (AccID) references Account(ID)
)
ALTER TABLE Orders
ADD Email NVARCHAR(100) NOT NULL DEFAULT 'unknown@example.com',
    Address NVARCHAR(100) NOT NULL DEFAULT 'Unknown Address',
    PhoneNumber VARCHAR(20) NOT NULL DEFAULT '0000000000';
ALTER TABLE Orders DROP CONSTRAINT DF__Orders__Email__4E53A1AA;
ALTER TABLE Orders DROP CONSTRAINT DF__Orders__Address__4F47C5E3;
ALTER TABLE Orders DROP CONSTRAINT DF__Orders__PhoneNum__503BEA1C;

ALTER TABLE Orders ALTER COLUMN Address NVARCHAR(100) NOT NULL;
ALTER TABLE Orders ALTER COLUMN PhoneNumber VARCHAR(20) NOT NULL;
ALTER TABLE Orders ALTER COLUMN Email NVARCHAR(100) NOT NULL;
SELECT name, object_id, parent_object_id
FROM sys.default_constraints
WHERE parent_object_id = OBJECT_ID('Orders');

INSERT INTO Orders (AccID, Address, PhoneNumber, Email, Create_At, TotalAmount, Status) 
VALUES (455, 'Hanoi', '0111111113', 'user3@gmail.com', GETDATE(), 0, 'Pending');

SELECT * FROM Orders WHERE AccID = 455 ORDER BY OrderID DESC;


go
ALTER TABLE Orders
ADD Address NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(20) NOT NULL,
    Email NVARCHAR(50) NOT NULL;


go
insert into Orders (AccID, TotalAmount, Status) 
values 
(1, 12990.0, 'Completed'), 
(3, 25490.0, 'Processing')  
select * from orders
delete from Orders where OrderID = 7


SELECT * FROM Orders WHERE AccID = 455 ORDER BY OrderID DESC;

go
CREATE TRIGGER ReduceProductQuantity
ON OrderDetail
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;


    IF EXISTS (
        SELECT 1
        FROM Products p
        INNER JOIN inserted i ON p.ProdID = i.ProdID
        WHERE p.Quantity < i.Quantity
    )
    BEGIN

        PRINT 'Error: Not enough stock!';
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    UPDATE p
    SET p.Quantity = p.Quantity - i.Quantity
    FROM Products p
    INNER JOIN inserted i ON p.ProdID = i.ProdID;
END;

CREATE TRIGGER CheckStockAfterInsert
ON OrderDetail
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM Products p
        INNER JOIN inserted i ON p.ProdID = i.ProdID
        WHERE p.Quantity < i.Quantity
    )
    BEGIN
        RAISERROR ('Not enough stock for one or more products.', 16, 1);
        DELETE FROM OrderDetail
        WHERE OrderDetailID IN (SELECT i.OrderDetailID FROM inserted i);
        RETURN;
    END;

    UPDATE p
    SET p.Quantity = p.Quantity - i.Quantity
    FROM Products p
    INNER JOIN inserted i ON p.ProdID = i.ProdID;
END;

drop trigger CheckStock

drop trigger ReduceProductQuantity

go
create trigger PreventAdminOrder
on Orders
instead of insert
as
begin
    if exists (
        select 1 from inserted i 
        join Account a on i.AccID = a.ID
        where a.RoleID = 1
    )
    begin
        print 'Admin cannot place orders!';
        rollback;
        return;
    end
    insert into orders (accid, address, phonenumber, email, create_at, totalamount, status)
    select accid, address, phonenumber, email, create_at, totalamount, status from inserted;
end;

drop trigger PreventAdminOrder;


go
create table OrderDetail (
    OrderDetailID int identity(1,1) primary key,
    OrderID int not null,
    ProdID varchar(10) not null,
    Quantity int not null check (quantity > 0), 
    UnitPrice money not null, 
    Subtotal as (Quantity * UnitPrice) persisted, 
    foreign key (OrderID) references Orders(OrderID),
    foreign key (ProdID) references Products(ProdID)
)

go
insert into OrderDetail (OrderID, ProdID, Quantity, UnitPrice)
values 
(3, 'ip2', 3, 12990.0),  
(4, 'ss1', 1, 25490.0),
(3, 'ip2', 1, 12990.0)
select * from OrderDetail

go
create table Cart (
    CartID int identity(1,1) primary key,
    AccID int not null unique,
	Amount money not null default(0),
    Create_At datetime default (getdate()),
    foreign key (AccID) references Account(ID)
)
insert into cart(AccID) values (3)
select * from cart
drop table Cart
go

CREATE TRIGGER UpdateCartAmount
ON Item
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE Cart
    SET Amount = (
        SELECT COALESCE(SUM(i.Quantity * p.Price), 0)
        FROM Item i
        JOIN Products p ON i.ProdID = p.ProdID
        WHERE i.CartID = Cart.CartID
    )
    WHERE Cart.CartID IN (
        SELECT DISTINCT CartID FROM inserted
        UNION
        SELECT DISTINCT CartID FROM deleted
    );
END;
drop trigger UpdateCartAmount


select * from Cart as c join Account as a
on c.AccID = a.ID

go
create table Item (
    ItemID int identity(1,1) primary key,
    CartID int not null,
    ProdID varchar(10) not null,
    Quantity int not null check (quantity > 0),
    Create_At datetime default (getdate()),
    foreign key (CartID) references Cart(CartID),
    foreign key (ProdID) references Products(ProdID),
    unique (CartID, ProdID)
)
insert into Item (CartID, ProdID, Quantity) 
values
(2, 'op1', 4), 
(1, 'ss1', 1), 
(2, 'ip2', 1)
select * from Item
update Item set quantity = 1 where itemID = 10


SELECT 
    acc.ID AS AccountID, acc.Username, acc.Email, acc.PhoneNumber, r.RoleName, 
    c.CartID, c.Amount AS CartAmount, c.Create_At AS CartCreatedAt, 
    i.ItemID, p.ProdID, p.ProdName, cat.CateName, i.Quantity AS CartQuantity, p.Price AS ProductPrice, (i.Quantity * p.Price) AS TotalCartItemPrice, 
    o.OrderID, o.TotalAmount AS OrderTotal, o.Status AS OrderStatus, o.Create_At AS OrderCreatedAt,
    od.OrderDetailID, od.Quantity AS OrderQuantity, od.UnitPrice, od.Subtotal AS OrderSubtotal
FROM Account acc
LEFT JOIN Roles r ON acc.RoleID = r.RoleID
LEFT JOIN Cart c ON acc.ID = c.AccID
LEFT JOIN Item i ON c.CartID = i.CartID
LEFT JOIN Products p ON i.ProdID = p.ProdID
LEFT JOIN Categories cat ON p.CateID = cat.CateID
LEFT JOIN Orders o ON acc.ID = o.AccID
LEFT JOIN OrderDetail od ON o.OrderID = od.OrderID AND od.ProdID = p.ProdID
ORDER BY acc.ID, o.OrderID, i.ItemID;

select i.itemID, i.cartID, i.prodID, i.quantity, p.price, p.image, p.prodName from Item i join Products p on i.prodID = p.prodID join Cart c on i.cartID = c.cartID where c.accID = 3

sELECT *  FROM Orders WHERE AccID = 3 ORDER BY OrderID DESC

SELECT * FROM Orders as o join Account as a on o.AccID = a.ID
WHERE AccID = 3 ORDER BY o.Create_At DESC

DELETE FROM OrderDetail WHERE OrderID IN (SELECT OrderID FROM Orders WHERE AccID = 3);
DELETE FROM OrderReview WHERE OrderID IN (SELECT OrderID FROM Orders WHERE AccID = 3);
DELETE FROM Orders WHERE AccID = 3;


create table OrderReview (
    ReviewID int identity(1,1) primary key,
    OrderID int unique NOT NULL,
    IsReceived bit default 0,  -- 0: Not received, 1: Received
    Rating int check (Rating between 1 and 5),
    Comment nvarchar(500),
    Create_At datetime default (getdate()),
    foreign key (OrderID) references Orders(OrderID) 
)




-- Test
select o.*, r.IsReceived from Orders o LEFT JOIN OrderReview r on o.OrderID = r.OrderID

SELECT p.ProdName, od.Quantity, od.Subtotal FROM OrderDetail od JOIN Products p ON od.ProdID = p.ProdID WHERE od.OrderID = 29
select * from Orders where OrderID = 25
select od.OrderDetailID, od.OrderID, od.ProdID, p.ProdName, od.Quantity, od.UnitPrice, od.Subtotal from OrderDetail od join Products p on od.ProdID = p.ProdID where od.OrderID = 29

-- Phân trang
DECLARE @CateID INT = 0; 
DECLARE @Page INT = 1;    
DECLARE @PageSize INT = 10; 

SELECT * FROM Products
WHERE (@CateID = 0 OR CateID = @CateID)
ORDER BY ProdID
OFFSET (@Page - 1) * @PageSize ROWS FETCH NEXT @PageSize ROWS ONLY;

SELECT COUNT(*) AS TotalProducts FROM Products
WHERE (@CateID = 0 OR CateID = @CateID);


-- Sản phẩm bán chạy
SELECT TOP 5 p.ProdID, p.ProdName, p.Image, p.Price, SUM(od.Quantity) AS TotalSold
FROM OrderDetail od
JOIN Products p ON od.ProdID = p.ProdID
GROUP BY p.ProdID, p.ProdName, p.Image, p.Price
ORDER BY TotalSold DESC;

SELECT SUM(od.Quantity) AS TotalSold FROM OrderDetail od WHERE od.ProdID = 'op2'

SELECT p.prodname, p.quantity, SUM(od.quantity) AS total_sold
FROM OrderDetail od
JOIN products p ON od.ProdID = p.ProdID 
GROUP BY p.prodname, p.quantity;

select p.prodid, p.prodname, p.quantity, sum(od.quantity) as totalSold from OrderDetail od join products p on od.ProdID = p.ProdID group by p.prodid, p.prodname, p.quantity

