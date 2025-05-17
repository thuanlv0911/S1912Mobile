create database S1912Mobile
go

use S1912Mobile
go

create table Roles (
    RoleID int primary key,
    RoleName nvarchar(50),
    Create_At datetime default(getDate())
)
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
	IsDeleted BIT DEFAULT 0 not null,
    foreign key (RoleID) references Roles(RoleID)
)
go

insert into Account (Username, Email, Address, PhoneNumber, Password, RoleID) 
values
('admin2', 'admin2@gmail.com', 'Hanoi', '0999999992', 'admin2pass', 1),
('admin1', 'admin1@gmail.com', 'Hanoi', '0999999991', 'admin1pass', 1),
('user1', 'user1@gmail.com', 'Saigon', '0111111111', 'user1pass', 2)
go

create table Categories(
    CateID int identity(1,1) primary key,
    CateName nvarchar(50) not null,
    Create_At datetime default(getDate()),
	IsDeleted BIT DEFAULT 0 not null
)
go

insert into Categories (CateName)
values
('iPhone'), ('Samsung'), ('Nokia'), ('Oppo'), ('Vivo')
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
	IsDeleted BIT DEFAULT 0 not null,
    foreign key (CateID) references Categories(CateID)
)
go

insert into Products (ProdID, ProdName, Image, Quantity, Price, Describe, CateID)
values
('op1', 'Oppo Reno13 F', 'img/opporeno13f.jpg', 11, 9990.0, N'Oppo Reno13 F sở hữu thiết kế hiện đại với viền màn hình siêu mỏng, màn hình AMOLED 6.5 inch sắc nét, mang lại trải nghiệm hình ảnh sống động. Chip xử lý mạnh mẽ giúp xử lý tác vụ mượt mà, kết hợp viên pin dung lượng lớn 5000mAh hỗ trợ sạc nhanh 67W, đảm bảo sử dụng cả ngày dài.', 4),
('ip1', 'iPhone 11', 'img/ip11.jpg', 4, 8990.0, N'iPhone 11 sở hữu màn hình 6.1 inch Liquid Retina HD với độ sáng tốt, chip A13 Bionic mang lại hiệu năng mạnh mẽ cho các tác vụ hàng ngày. Cụm camera kép 12MP hỗ trợ chụp đêm và quay video 4K sắc nét. Máy có thời lượng pin ổn định và hỗ trợ Face ID bảo mật cao.', 1),
('ip2', 'iPhone 13', 'img/ip13.jpg', 7, 12990.0, N'iPhone 13 mang thiết kế vuông vức sang trọng với màn hình Super Retina XDR 6.1 inch, hiển thị sắc nét và chân thực. Chip A15 Bionic mạnh mẽ giúp xử lý đồ họa mượt mà, camera kép 12MP nâng cao khả năng chụp ảnh với tính năng Photographic Styles và Cinematic Mode.', 1),
('ip3', 'iPhone 14 Pro', 'img/ip14pro.jpg', 5, 15990.0, N'iPhone 14 Pro được trang bị màn hình 6.1 inch Super Retina XDR với Dynamic Island thông minh, mang đến trải nghiệm sử dụng đột phá. Chip A16 Bionic cực kỳ mạnh mẽ, camera 48MP cải tiến giúp chụp ảnh sắc nét, hỗ trợ quay video ProRAW chất lượng cao.', 1),
('ip4', 'iPhone 15 Pro Max', 'img/ip15pm.jpg', 10, 25990.0, N'iPhone 15 Pro Max sở hữu thiết kế viền titanium siêu nhẹ và bền bỉ. Trang bị màn hình ProMotion 120Hz, chip A17 Pro mạnh mẽ giúp chơi game mượt mà. Camera 48MP với ống kính periscope hỗ trợ zoom quang học 5x, mang đến trải nghiệm nhiếp ảnh chuyên nghiệp.', 1),
('nk1', 'Nokia 1280', 'img/nk1280.jpg', 5, 490.0, N'Nokia 1280 là mẫu điện thoại phổ thông huyền thoại với thiết kế bền bỉ, pin dung lượng cao giúp sử dụng nhiều ngày liền. Bàn phím T9 dễ thao tác, sóng khỏe, hỗ trợ nghe gọi ổn định, phù hợp với người lớn tuổi hoặc nhu cầu liên lạc cơ bản.', 3),
('nk2', 'Nokia G21', 'img/nkg21.jpg', 6, 690.0, N'Nokia G21 có màn hình 6.5 inch lớn, tần số quét 90Hz cho trải nghiệm vuốt chạm mượt mà. Viên pin 5000mAh cho thời gian sử dụng lên đến 3 ngày, camera 50MP AI giúp chụp ảnh chi tiết rõ nét, hệ điều hành Android One hỗ trợ cập nhật bảo mật lâu dài.', 3),
('ss1', 'Samsung S24 Ultra', 'img/sss24.jpg', 12, 25490.0, N'Samsung Galaxy S24 Ultra sở hữu màn hình Dynamic AMOLED 120Hz cực kỳ sắc nét, camera chính 200MP cho ảnh chụp chất lượng cao. Máy trang bị chip Snapdragon 8 Gen 3 mạnh mẽ, bút S-Pen hỗ trợ ghi chú tiện lợi, cùng thời lượng pin ấn tượng.', 2),
('ss2', 'Samsung Galaxy Z Flip 5', 'img/sszflip5.jpg', 8, 20990.0, N'Galaxy Z Flip 5 mang đến thiết kế gập độc đáo, màn hình chính 6.7 inch AMOLED với công nghệ hiển thị sắc nét. Chip Snapdragon 8 Gen 2 đảm bảo hiệu năng ổn định, bản lề bền bỉ hỗ trợ nhiều chế độ gập, camera AI nâng cao chất lượng chụp ảnh.', 2),
('ss3', 'Samsung Galaxy S23', 'img/sss23.jpg', 9, 18990.0, N'Samsung Galaxy S23 trang bị màn hình Dynamic AMOLED 6.1 inch sống động, chip Snapdragon 8 Gen 2 tối ưu hiệu suất. Camera 50MP hỗ trợ quay video 8K, viên pin 3900mAh bền bỉ, thiết kế nhỏ gọn nhưng vẫn mang đến trải nghiệm cao cấp.', 2),
('ss4', 'Samsung S25 Ultra', 'img/sss25.jpg', 10, 27990.0, N'Samsung S25 Ultra nâng cấp với màn hình Dynamic AMOLED 2X 120Hz siêu sắc nét, chip Snapdragon 8 Gen 3 tối ưu hiệu năng. Camera 200MP hỗ trợ zoom quang học 10x, bút S-Pen cải tiến mang lại trải nghiệm viết vẽ mượt mà.', 2),
('ip5', 'iPhone 16', 'img/ip16.jpg', 8, 26990.0, N'iPhone 16 mang đến thiết kế mới với viền mỏng hơn, màn hình Super Retina XDR sắc nét. Chip A18 Bionic vượt trội, camera 48MP hỗ trợ quay video ProRes 8K, Dynamic Island thế hệ mới nâng cao trải nghiệm tương tác.', 1),
('vv1', 'Vivo X200 Pro', 'img/vivox200pro.jpg', 7, 19990.0, N'Vivo X200 Pro trang bị màn hình AMOLED 120Hz, hiển thị màu sắc rực rỡ. Chip Dimensity 9300 cho hiệu năng mạnh mẽ, hệ thống camera ZEISS 50MP hỗ trợ chống rung quang học OIS, giúp chụp ảnh chuyên nghiệp hơn.', 5),
('op2', 'Oppo Find X8 Pro', 'img/oppofindx8pro.jpg', 6, 22990.0, N'Oppo Find X8 Pro sở hữu thiết kế cao cấp với màn hình LTPO AMOLED 6.8 inch, độ sáng cao giúp hiển thị tốt ngoài trời. Chip Snapdragon 8 Gen 3 mạnh mẽ, camera chính 50MP hỗ trợ chụp ảnh chuyên nghiệp với công nghệ Hasselblad.', 4)
go

create table Orders (
    OrderID int identity(1,1) primary key,
    AccID int not null,
    Create_At datetime default (getdate()),
    TotalAmount money not null,
    status nvarchar(50) default 'Pending', --Pending, Processing, Completed, Canceled
	Email nvarchar(100) not null,
    Address nvarchar(100) not null,
    PhoneNumber varchar(20) not null,
    foreign key (AccID) references Account(ID)
)
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
    insert into Orders (AccID, Create_At, TotalAmount, Status)
    select AccID, Create_At, TotalAmount, Status from inserted;
end;
go

insert into Orders (AccID, TotalAmount, Status) 
values 
(1, 12990.0, 'Completed'), 
(3, 25490.0, 'Processing')
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

create trigger ReduceProductQuantity
on OrderDetail
after insert
as
begin
    set nocount on;

    if exists (
        select 1
        from Products p
        inner join inserted i on p.ProdID = i.ProdID
        where p.Quantity < i.Quantity
    )
    begin
        print 'Error: Not enough stock!';
        rollback transaction;
        return;
    end;

    update p
    set p.Quantity = p.Quantity - i.Quantity
    from Products p
    inner join inserted i on p.ProdID = i.ProdID;
end;
go

create trigger CheckStockAfterInsert
on OrderDetail
after insert
as
begin
    set nocount on;

    if exists (
        select 1
        from Products p
        inner join inserted i on p.ProdID = i.ProdID
        where p.Quantity < i.Quantity
    )
    begin
        raiserror ('Not enough stock for one or more products.', 16, 1);
        delete from OrderDetail
        where OrderDetailID in (select i.OrderDetailID from inserted i);
        return;
    end;

    update p
    set p.Quantity = p.Quantity - i.Quantity
    from Products p
    inner join inserted i on p.ProdID = i.ProdID;
end;
go

insert into OrderDetail (OrderID, ProdID, Quantity, UnitPrice)
values 
(3, 'ip2', 3, 12990.0),  
(4, 'ss1', 1, 25490.0),
(3, 'ip2', 1, 12990.0)
go

create table Cart (
    CartID int identity(1,1) primary key,
    AccID int not null unique,
    Amount money not null default(0),
    Create_At datetime default (getdate()),
    foreign key (AccID) references Account(ID)
)
go

insert into cart(AccID) values (3)
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
go

insert into Item (CartID, ProdID, Quantity) 
values
(2, 'op1', 1), 
(1, 'ss1', 1), 
(2, 'ip2', 1)
go

create table OrderReview (
    ReviewID int identity(1,1) primary key,
    OrderID int unique NOT NULL,
    IsReceived bit default 0 not null,  -- 0: Not received, 1: Received
    Rating int check (Rating between 1 and 5),
    Comment nvarchar(500),
    Create_At datetime default (getdate()),
    foreign key (OrderID) references Orders(OrderID) 
)
go