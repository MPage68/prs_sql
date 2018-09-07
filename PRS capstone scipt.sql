DROP DATABASE IF EXISTS prs;
CREATE DATABASE prs;
USE prs;


CREATE TABLE User (
    UserName VARCHAR(20) NOT NULL UNIQUE,
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Password VARCHAR(10) NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    PhoneNumber VARCHAR(12) NOT NULL,
    Email VARCHAR(75) NOT NULL UNIQUE,
    IsReviewer TINYINT(1) NOT NULL,
    IsAdmin TINYINT(1) NOT NULL,
    IsActive TINYINT(1),
    DateCreated DATETIME,
    DateUpdated DATETIME,
    UpdatedByUser INT,
    CONSTRAINT Uname UNIQUE (UserName)
);

CREATE TABLE Vendor (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Code VARCHAR(10) NOT NULL UNIQUE,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(255) NOT NULL,
    State VARCHAR(2) NOT NULL,
    Zip VARCHAR(5) NOT NULL,
    PhoneNumber VARCHAR(12) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    IsPreApproved TINYINT(1) NOT NULL,
    IsActive TINYINT(1),
    DateCreated DATETIME,
    DateUpdated DATETIME,
    UpdatedByUser INT,
    CONSTRAINT Vcode UNIQUE (Code)
);

CREATE TABLE product (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    VendorID INT NOT NULL,
    PartNumber VARCHAR(50) NOT NULL,
    Name VARCHAR(150) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Unit VARCHAR(255),
    PhotoPath VARCHAR(255),
    IsActive TINYINT(1),
    DateCreated DATETIME,
    DateUpdated DATETIME,
    UpdatedByUser INT,
    FOREIGN KEY (VendorID)
        REFERENCES Product (ID),
    CONSTRAINT Vendor_Part UNIQUE (VendorId , PartNumber)
);

CREATE TABLE purchaseRequest (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    Description VARCHAR(100) NOT NULL,
    Justification VARCHAR(255) NOT NULL,
    DateNeeded DATE NOT NULL,
    DeliveryMode VARCHAR(25) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    SubmittedDate DATETIME,
    IsActive TINYINT(1) NOT NULL,
    ReasonForRejection VARCHAR(100) NOT NULL,
    DateCreated DATETIME,
    DateUpdated DATETIME,
    UpdatedByUser INT,
    FOREIGN KEY (USERID)
        REFERENCES User (ID)
);

CREATE TABLE PurchaseRequestLineitem (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    PurchaseRequestID INT NOT NULL UNIQUE,
    ProductID INT NOT NULL UNIQUE,
    Quantity INT NOT NULL,
    IsActive TINYINT(1) DEFAULT 1 NOT NULL,
    DateCreated DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    DateUpdated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    UpdatedByUser INTEGER DEFAULT 1 NOT NULL,
    FOREIGN KEY (PRODUCTID)
        REFERENCES PRODUCT (ID),
    FOREIGN KEY (PURCHASEREQUESTID)
        REFERENCES PURCHASEREQUEST (ID),
    CONSTRAINT req_pdt UNIQUE (purchaserequestid , productid)
);

INSERT INTO User(ID, UserName, Password, FirstName, LastName, PhoneNumber, Email, IsReviewer, IsAdmin) values

(1,'SYSTEM','xxxxx','System','System','XXX-XXX-XXXX','system@test.com',1,1),

(2,'sblessing','login','Sean','Blessing','513-600-7096','sean@blessingtechnology.com',1,1);

INSERT INTO vendor(ID, Code, Name, Address, City, State, Zip, PhoneNumber, Email, isPreApproved) values

(1,'BB-1001','Best Buy','100 Best Buy Street','Louisville','KY','40207','502-111-9099','geeksquad@bestbuy.com',1),

(2,'AP-1001','Apple Inc','1 Infinite Loop','Cupertino','CA','95014','800-123-4567','genius@apple.com',1),

(3,'AM-1001','Amazon','410 Terry Ave. North','Seattle','WA','98109','206-266-1000','amazon@amazon.com',0),

(4,'ST-1001','Staples','9550 Mason Montgomery Rd','Mason','OH','45040','513-754-0235','support@orders.staples.com',0),

(5,'MC-1001','Micro Center','11755 Mosteller Rd','Sharonville','OH','45241','513-782-8500','support@microcenter.com',0);

INSERT INTO product(`ID`,`VendorID`,`PartNumber`,`Name`,`Price`,`Unit`,`PhotoPath`) values

(1,1,'ME280LL','iPad Mini 2',296.99,NULL,NULL),

(3,3,'105810','Hammermill Paper, Premium Multi-Purpose Paper Poly Wrap',8.99,'1 Ream / 500 Sheets',NULL),

(4,4,'122374','HammerMill® Copy Plus Copy Paper, 8 1/2\" x 11\", Case',29.99,'1 Case, 10 Reams, 500 Sheets per ream',NULL),

(5,4,'784551','Logitech M325 Wireless Optical Mouse, Ambidextrous, Black ',14.99,NULL,NULL),

(6,4,'382955','Staples Mouse Pad, Black',2.99,NULL,NULL),

(7,4,'2122178','AOC 24-Inch Class LED Monitor',99.99,NULL,NULL),

(8,4,'2460649','Laptop HP Notebook 15-AY163NR',529.99,NULL,NULL),

(9,4,'2256788','Laptop Dell i3552-3240BLK 15.6\"',239.99,NULL,NULL),

(10,4,'IM12M9520','Laptop Acer Acer™ Aspire One Cloudbook 14\"',224.99,NULL,NULL),

(11,4,'940600','Canon imageCLASS Copier (D530)',99.99,NULL,NULL),

(12,5,'228148','Acer Aspire ATC-780A-UR12 Desktop Computer',399.99,'','/images/AcerAspireDesktop.jpg'),

(13,5,'279364','Lenovo IdeaCentre All-In-One Desktop',349.99,'','/images/LenovoIdeaCenter.jpg');

-- INSERT INTO purchaseRequest VALUES
-- ();

-- INSERT INTO purchaseRequestLineitem VALUES
-- ();

-- INSERT INTO x VALUES
-- ();
CREATE USER prs_user@localhost IDENTIFIED BY 'sesame';
GRANT SELECT, INSERT, DELETE, UPDATE ON prs.* TO prs_user@localhost;
-- create a user and grant privileges to that user
-- GRANT SELECT, INSERT, DELETE, UPDATE
-- ON mma.*
-- TO mma_user@localhost
-- IDENTIFIED BY 'sesame';