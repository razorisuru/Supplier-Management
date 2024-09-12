-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 12, 2024 at 07:35 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chainsupplier`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_add` (IN `p_fname` VARCHAR(255), IN `p_lname` VARCHAR(255), IN `p_username` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_password` VARCHAR(255), IN `p_role` VARCHAR(255), IN `p_dp` VARCHAR(255), OUT `p_success` INT)   BEGIN
    DECLARE success_count INT;
    DECLARE hashed_password VARCHAR(255); -- Variable to store hashed password
    
    -- Hash the incoming password
    SET hashed_password = PASSWORD(p_password); -- Assuming you're using MySQL's PASSWORD function
    
    -- Attempt to insert the record
    INSERT INTO users (fname, lname, username, email, password, role, dp)
    VALUES (p_fname, p_lname, p_username, p_email, hashed_password, p_role, p_dp);
    
    -- Check if the insert was successful
    SELECT COUNT(*) INTO success_count FROM users WHERE username = p_username;
    
    IF success_count = 1 THEN
        SET p_success = 1; -- Success
    ELSE
        SET p_success = 0; -- Failure
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_login` (IN `p_email` VARCHAR(255), IN `p_password` VARCHAR(255), OUT `p_success` BOOLEAN, OUT `p_id` INT, OUT `p_fname` VARCHAR(255), OUT `p_lname` VARCHAR(255), OUT `p_username` VARCHAR(255), OUT `p_role` VARCHAR(255), OUT `p_dp` VARCHAR(255))   BEGIN
    DECLARE user_count INT;
    DECLARE hashed_password VARCHAR(255); -- Variable to store hashed password
    
    -- Hash the incoming password
    SET hashed_password = PASSWORD(p_password); -- Assuming you're using MySQL's PASSWORD function
    
    -- Check if user exists with provided email and hashed password
    SELECT COUNT(*) INTO user_count
    FROM users
    WHERE email = p_email AND password = hashed_password;
    
    IF user_count = 1 THEN
        -- User exists, fetch user details
        SELECT id, fname, lname, username, role, dp
        INTO p_id, p_fname, p_lname, p_username, p_role, p_dp
        FROM users
        WHERE email = p_email;
        
        SET p_success = TRUE;
    ELSE
        -- User doesn't exist or incorrect credentials
        SET p_success = FALSE;
        SET p_id = NULL;
        SET p_fname = NULL;
        SET p_lname = NULL;
        SET p_username = NULL;
        SET p_role = NULL;
        SET p_dp = NULL;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_update` (IN `p_fname` VARCHAR(255), IN `p_lname` VARCHAR(255), IN `p_username` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_password` VARCHAR(255), IN `p_dp` VARCHAR(255), IN `p_id` INT, OUT `p_success` INT)   BEGIN
    DECLARE success_count INT;
    DECLARE hashed_password VARCHAR(255); -- Variable to store hashed password
    
    -- Hash the incoming password
    SET hashed_password = PASSWORD(p_password); -- Assuming you're using MySQL's PASSWORD function
    
    -- Attempt to update the record if exists, otherwise insert
    
        UPDATE users
        SET fname = p_fname,
            lname = p_lname,
            username = p_username,
            email = p_email,
            password = hashed_password,
            dp = p_dp
        WHERE id = p_id;
    
    
    -- Check if the insert/update was successful
    SELECT COUNT(*) INTO success_count FROM users WHERE id = p_id;
    
    IF success_count = 1 THEN
        SET p_success = 1; -- Success
    ELSE
        SET p_success = 0; -- Failure
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_login` (IN `p_email` VARCHAR(255), IN `p_password` VARCHAR(255), OUT `p_success` BOOLEAN, OUT `p_id` INT, OUT `p_fname` VARCHAR(255), OUT `p_lname` VARCHAR(255), OUT `p_username` VARCHAR(255), OUT `p_role` VARCHAR(255), OUT `p_dp` VARCHAR(255))   BEGIN
    DECLARE user_count INT;
    
    -- Check if user exists with provided email and password
    SELECT COUNT(*) INTO user_count
    FROM users
    WHERE email = p_email AND password = p_password;
    
    IF user_count = 1 THEN
        -- User exists, fetch user details
        SELECT id, fname, lname, username, role, dp
        INTO p_id, p_fname, p_lname, p_username, p_role, p_dp
        FROM users
        WHERE email = p_email;
        
        SET p_success = TRUE;
    ELSE
        -- User doesn't exist or incorrect credentials
        SET p_success = FALSE;
        SET p_id = NULL;
        SET p_fname = NULL;
        SET p_lname = NULL;
        SET p_username = NULL;
        SET p_role = NULL;
        SET p_dp = NULL;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_reg` (IN `p_fname` VARCHAR(255), IN `p_lname` VARCHAR(255), IN `p_username` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_password` VARCHAR(255), OUT `p_success` INT)   BEGIN
    DECLARE success_count INT;
    DECLARE hashed_password VARCHAR(255); -- Variable to store hashed password
    
    -- Hash the incoming password
    SET hashed_password = PASSWORD(p_password); -- Assuming you're using MySQL's PASSWORD function
    
    -- Attempt to insert the record
    INSERT INTO users (fname, lname, username, email, password, role, dp)
    VALUES (p_fname, p_lname, p_username, p_email, hashed_password, "user", "user-def-128x128.jpg");
    
    -- Check if the insert was successful
    SELECT COUNT(*) INTO success_count FROM users WHERE username = p_username;
    
    IF success_count = 1 THEN
        SET p_success = 1; -- Success
    ELSE
        SET p_success = 0; -- Failure
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `CategoryID` int(11) NOT NULL,
  `CategoryName` varchar(100) DEFAULT NULL,
  `Description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`CategoryID`, `CategoryName`, `Description`) VALUES
(1, 'Electronics', 'Products related to electronics'),
(2, 'Clothing', 'Apparel and fashion accessories'),
(3, 'Home Appliances', 'Household appliances'),
(4, 'Books', 'Books and literature'),
(5, 'Furniture', 'Home and office furniture'),
(6, 'Toys', 'Children\'s toys and games'),
(7, 'Automotive', 'Vehicle parts and accessories'),
(8, 'Sports', 'Sports equipment and accessories'),
(9, 'Beauty', 'Cosmetics and beauty products'),
(10, 'Food & Beverage', 'Food and beverages');

-- --------------------------------------------------------

--
-- Table structure for table `contracts`
--

CREATE TABLE `contracts` (
  `ContractID` int(11) NOT NULL,
  `SupplierID` int(11) DEFAULT NULL,
  `ContractType` varchar(100) DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `Terms` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contracts`
--

INSERT INTO `contracts` (`ContractID`, `SupplierID`, `ContractType`, `StartDate`, `EndDate`, `Terms`) VALUES
(1, 1, 'Service Contract', '2023-01-01', '2024-12-31', 'Terms and conditions apply'),
(2, 2, 'Product Supply Contract', '2023-02-15', '2024-12-31', 'Supplier to provide products as per order'),
(3, 3, 'Maintenance Agreement', '2023-03-10', '2024-12-31', 'Supplier responsible for equipment maintenance'),
(4, 4, 'Consulting Agreement', '2023-04-20', '2024-12-31', 'Supplier to provide consulting services as needed'),
(5, 5, 'Exclusive Distribution Agreement', '2023-05-01', '2024-12-31', 'Supplier granted exclusive distribution rights'),
(6, 6, 'Lease Agreement', '2023-06-05', '2024-12-31', 'Supplier leases equipment to the customer'),
(7, 7, 'Construction Contract', '2023-07-15', '2024-12-31', 'Supplier to carry out construction work as per agreement'),
(8, 8, 'Software License Agreement', '2023-08-20', '2024-12-31', 'Supplier grants license for software usage'),
(9, 9, 'Advertising Contract', '2023-09-10', '2024-12-31', 'Supplier to provide advertising services as per contract'),
(10, 10, 'Supply Chain Agreement', '2023-10-05', '2024-12-31', 'Supplier to manage supply chain operations');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `CustomerID` int(11) NOT NULL,
  `FirstName` varchar(100) DEFAULT NULL,
  `LastName` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `PostalCode` varchar(20) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`CustomerID`, `FirstName`, `LastName`, `Email`, `Phone`, `Address`, `City`, `State`, `PostalCode`, `Country`) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '+1234567890', '123 Main Street', 'Anytown', 'StateA', '12345', 'CountryX'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '+1987654321', '456 Elm Street', 'Othertown', 'StateB', '54321', 'CountryY'),
(3, 'Michael', 'Johnson', 'michael.johnson@example.com', '+1122334455', '789 Oak Street', 'Anycity', 'StateC', '67890', 'CountryZ'),
(4, 'Emily', 'Brown', 'emily.brown@example.com', '+14455443322', '987 Pine Street', 'Anothercity', 'StateD', '98765', 'CountryW'),
(5, 'William', 'Martinez', 'william.martinez@example.com', '+19988776655', '654 Birch Street', 'Somewhere', 'StateE', '34567', 'CountryV'),
(6, 'Sophia', 'Lopez', 'sophia.lopez@example.com', '+15556667788', '321 Cedar Street', 'Nowhere', 'StateF', '23456', 'CountryU'),
(7, 'Alexander', 'Garcia', 'alexander.garcia@example.com', '+14445556666', '135 Walnut Street', 'Elsewhere', 'StateG', '87654', 'CountryT'),
(8, 'Emma', 'Wang', 'emma.wang@example.com', '+12223334444', '246 Maple Street', 'Anywhere', 'StateH', '45678', 'CountryS'),
(9, 'Daniel', 'Lee', 'daniel.lee@example.com', '+17778889999', '753 Oakwood Street', 'NoPlace', 'StateI', '89012', 'CountryR'),
(10, 'Olivia', 'Kim', 'olivia.kim@example.com', '+18889990000', '987 Willow Street', 'Everywhere', 'StateJ', '56789', 'CountryQ');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `OrderID` int(11) NOT NULL,
  `SupplierID` int(11) DEFAULT NULL,
  `ProductID` int(11) NOT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `OrderDate` date DEFAULT NULL,
  `TotalAmount` decimal(10,2) DEFAULT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`OrderID`, `SupplierID`, `ProductID`, `CustomerID`, `OrderDate`, `TotalAmount`, `status`) VALUES
(1, 1, 1, 1, '2023-01-05', 250.00, 'Shipped'),
(2, 2, 2, 2, '2023-02-10', 500.00, 'Pending'),
(3, 3, 3, 3, '2023-03-15', 750.00, 'Delivered'),
(4, 4, 4, 4, '2023-04-20', 1000.00, 'Processing'),
(5, 5, 5, 5, '2023-05-25', 1250.00, 'Shipped'),
(6, 6, 6, 6, '2023-06-30', 1500.00, 'Shipped'),
(7, 7, 7, 7, '2023-07-05', 1750.00, 'Pending'),
(8, 8, 8, 8, '2023-08-10', 2000.00, 'Processing'),
(9, 9, 9, 9, '2023-09-15', 2250.00, 'Delivered'),
(10, 10, 10, 10, '2023-10-20', 2500.00, 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `ProductID` int(11) NOT NULL,
  `SupplierID` int(11) DEFAULT NULL,
  `ProductName` varchar(100) NOT NULL,
  `Description` text DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`ProductID`, `SupplierID`, `ProductName`, `Description`, `Price`, `Quantity`) VALUES
(1, 1, 'Laptop', 'High-performance laptop', 999.00, 50),
(2, 2, 'T-shirt', 'Cotton T-shirt', 20.00, 100),
(3, 3, 'Refrigerator', 'Large capacity refrigerator', 800.00, 30),
(4, 4, 'Consulting Service', 'Professional consulting service', 150.00, 30),
(5, 5, 'Smartphone', 'Latest smartphone model', 700.00, 80),
(6, 6, 'Toy Car', 'Remote-controlled toy car', 30.00, 200),
(7, 7, 'Car Battery', 'Automotive battery', 100.00, 50),
(8, 8, 'Football', 'Standard football', 25.00, 50),
(9, 9, 'Lipstick', 'Matte finish lipstick', 15.00, 150),
(10, 10, 'Chocolate', 'Assorted chocolate box', 10.00, 200),
(13, 5, 'Iphone 15 pro max', 'iSheep', 1299.99, 4),
(14, 16, 'Iphone 15 pro max', '23', 1299.99, 5);

--
-- Triggers `products`
--
DELIMITER $$
CREATE TRIGGER `products_audit_trigger_delete` AFTER DELETE ON `products` FOR EACH ROW BEGIN
    INSERT INTO products_audit (ProductID,username, Action, Old_ProductName, Old_Description, Old_Price, Old_Quantity)
    VALUES (OLD.ProductID,user(), 'DELETE', OLD.ProductName, OLD.Description, OLD.Price, OLD.Quantity);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `products_audit_trigger_insert` AFTER INSERT ON `products` FOR EACH ROW BEGIN
    INSERT INTO products_audit (ProductID,username, Action, Old_ProductName, Old_Description, Old_Price, Old_Quantity)
    VALUES (NEW.ProductID,user(), 'INSERT', NULL, NULL, NULL, NULL);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `products_audit_trigger_update` AFTER UPDATE ON `products` FOR EACH ROW BEGIN
    INSERT INTO products_audit (ProductID,username, Action, Old_ProductName, Old_Description, Old_Price, Old_Quantity)
    VALUES (NEW.ProductID,user(), 'UPDATE', OLD.ProductName, OLD.Description, OLD.Price, OLD.Quantity);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `products_audit`
--

CREATE TABLE `products_audit` (
  `Prodcuts_Audit_ID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `Action` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `Old_ProductName` varchar(100) DEFAULT NULL,
  `Old_Description` text DEFAULT NULL,
  `Old_Price` decimal(10,2) DEFAULT NULL,
  `Old_Quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products_audit`
--

INSERT INTO `products_audit` (`Prodcuts_Audit_ID`, `ProductID`, `username`, `Action`, `Timestamp`, `Old_ProductName`, `Old_Description`, `Old_Price`, `Old_Quantity`) VALUES
(3, 13, 'root@localhost', 'UPDATE', '2024-04-22 16:22:40', 'Iphone 15 pro max', 'iSheep', 1299.99, 5),
(4, 12, 'root@localhost', 'DELETE', '2024-04-22 16:23:24', 'Apple', 'test 2', 56.99, 25),
(5, 14, 'root@localhost', 'INSERT', '2024-04-24 06:40:56', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `ReviewID` int(11) NOT NULL,
  `SupplierID` int(11) DEFAULT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `Rating` int(11) DEFAULT NULL,
  `ReviewText` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`ReviewID`, `SupplierID`, `CustomerID`, `Rating`, `ReviewText`) VALUES
(1, 1, 1, 4, 'Great product quality and fast delivery'),
(2, 2, 2, 5, 'Excellent service, highly recommended'),
(3, 3, 3, 3, 'Average experience, could be improved'),
(4, 4, 4, 2, 'Disappointed with the product quality'),
(5, 5, 5, 4, 'Satisfied with the purchase, would buy again'),
(6, 6, 6, 5, 'Fantastic product, kids love it'),
(7, 7, 7, 3, 'Good service but delivery took longer than expected'),
(8, 8, 8, 4, 'Impressed with the software functionality'),
(9, 9, 9, 1, 'Poor quality advertising materials'),
(10, 10, 10, 4, 'Smooth supply chain process, no issues');

-- --------------------------------------------------------

--
-- Table structure for table `suppliercategories`
--

CREATE TABLE `suppliercategories` (
  `SupplierID` int(11) NOT NULL,
  `CategoryID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliercategories`
--

INSERT INTO `suppliercategories` (`SupplierID`, `CategoryID`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `SupplierID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `ContactPerson` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `PostalCode` varchar(20) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`SupplierID`, `Name`, `ContactPerson`, `Email`, `Phone`, `Address`, `City`, `State`, `PostalCode`, `Country`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 'Tech World', 'John Bhem', 'info@techworld.com', '+1234567890', '123 Tech Street', 'Gampola', 'TechState', '10583', 'TechCountry', '2022-12-31 18:30:00', '2024-04-24 15:58:32'),
(2, 'FashionHub', 'Emma Smith', 'info@fashionhub.com', '+1987654321', '456 Fashion Street', 'FashionCity', 'FashionState', '12345', 'FashionCountry', '2023-01-31 18:30:00', '2023-01-31 18:30:00'),
(3, 'Appliance Mart', 'Michael Brown', 'info@appliancemart.com', '+1122334455', '789 Appliance Street', 'ApplianceCity', 'ApplianceState', '67890', 'ApplianceCountry', '2023-02-28 18:30:00', '2023-02-28 18:30:00'),
(4, 'Consulting Solutions', 'Sarah Miller', 'info@consultingsolutions.com', '+14455443322', '987 Consulting Street', 'ConsultingCity', 'ConsultingState', '98765', 'ConsultingCountry', '2023-03-31 18:30:00', '2023-03-31 18:30:00'),
(5, 'Mobile Planet', 'James Davis', 'info@mobileplanet.com', '+19988776655', '654 Mobile Street', 'MobileCity', 'MobileState', '34567', 'MobileCountry', '2023-04-30 18:30:00', '2023-04-30 18:30:00'),
(6, 'Toys Galore', 'Jessica Wilson', 'info@toysgalore.com', '+15556667788', '321 Toy Street', 'ToyCity', 'ToyState', '23456', 'ToyCountry', '2023-05-31 18:30:00', '2023-05-31 18:30:00'),
(7, 'Auto Parts Inc.', 'Kevin Anderson', 'info@autopartsinc.com', '+14445556666', '135 Auto Street', 'AutoCity', 'AutoState', '87654', 'AutoCountry', '2023-06-30 18:30:00', '2023-06-30 18:30:00'),
(8, 'Tech Solutions', 'Rachel Martinez', 'info@techsolutions.com', '+12223334444', '246 Tech Street', 'TechCity', 'TechState', '45678', 'TechCountry', '2023-07-31 18:30:00', '2023-07-31 18:30:00'),
(9, 'Marketing Pro', 'Chris Lee', 'info@marketingpro.com', '+17778889999', '753 Marketing Street', 'MarketingCity', 'MarketingState', '89012', 'MarketingCountry', '2023-08-31 18:30:00', '2023-08-31 18:30:00'),
(10, 'Logistics Solutions', 'Samantha Kim', 'info@logisticssolutions.com', '+18889990000', '987 Logistics Street', 'LogisticsCity', 'LogisticsState', '56789', 'LogisticsCountry', '2023-09-30 18:30:00', '2023-09-30 18:30:00'),
(16, 'Apple.inc', 'Steve Jobs', 'apple@steve.inc', '0766668527', '05, Mahawaththagama, Kundasale.', 'Kundasale.', 'United', '20500', 'USA', '2024-04-20 14:45:33', '2024-04-20 14:45:33');

--
-- Triggers `suppliers`
--
DELIMITER $$
CREATE TRIGGER `suppliers_audit_trigger_delete` AFTER DELETE ON `suppliers` FOR EACH ROW BEGIN
    INSERT INTO suppliers_audit (SupplierID, username, Action, Old_Name, Old_ContactPerson, Old_Email, Old_Phone, Old_Address, Old_City, Old_State, Old_PostalCode, Old_Country)
    VALUES (OLD.SupplierID, user(), 'DELETE', OLD.Name, OLD.ContactPerson, OLD.Email, OLD.Phone, OLD.Address, OLD.City, OLD.State, OLD.PostalCode, OLD.Country);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `suppliers_audit_trigger_insert` AFTER INSERT ON `suppliers` FOR EACH ROW BEGIN
    INSERT INTO suppliers_audit (SupplierID, username, Action, Old_Name, Old_ContactPerson, Old_Email, Old_Phone, Old_Address, Old_City, Old_State, Old_PostalCode, Old_Country)
    VALUES (NEW.SupplierID, user(), 'INSERT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `suppliers_audit_trigger_update` AFTER UPDATE ON `suppliers` FOR EACH ROW BEGIN
    INSERT INTO suppliers_audit (SupplierID, username, Action, Old_Name, Old_ContactPerson, Old_Email, Old_Phone, Old_Address, Old_City, Old_State, Old_PostalCode, Old_Country)
    VALUES (NEW.SupplierID, user(), 'UPDATE', OLD.Name, OLD.ContactPerson, OLD.Email, OLD.Phone, OLD.Address, OLD.City, OLD.State, OLD.PostalCode, OLD.Country);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers_audit`
--

CREATE TABLE `suppliers_audit` (
  `Suppliers_Audit_ID` int(11) NOT NULL,
  `SupplierID` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `Action` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `Old_Name` varchar(100) DEFAULT NULL,
  `Old_ContactPerson` varchar(100) DEFAULT NULL,
  `Old_Email` varchar(100) DEFAULT NULL,
  `Old_Phone` varchar(20) DEFAULT NULL,
  `Old_Address` varchar(255) DEFAULT NULL,
  `Old_City` varchar(50) DEFAULT NULL,
  `Old_State` varchar(50) DEFAULT NULL,
  `Old_PostalCode` varchar(20) DEFAULT NULL,
  `Old_Country` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers_audit`
--

INSERT INTO `suppliers_audit` (`Suppliers_Audit_ID`, `SupplierID`, `username`, `Action`, `Timestamp`, `Old_Name`, `Old_ContactPerson`, `Old_Email`, `Old_Phone`, `Old_Address`, `Old_City`, `Old_State`, `Old_PostalCode`, `Old_Country`) VALUES
(1, 1, 'root@localhost', 'UPDATE', '2024-04-22 16:51:46', 'Tech World', 'John Ado', 'info@techworld.com', '+1234567890', '123 Tech Street', 'Gampola', 'TechState', '10583', 'TechCountry'),
(2, 17, 'root@localhost', 'INSERT', '2024-04-22 16:53:52', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 17, 'root@localhost', 'DELETE', '2024-04-22 16:54:16', 'Papol.inc', 'Papol Jobs', 'papol@gmail.com', '675080900', 'papol 09, papol watta.', 'papol', 'papol', '12345', 'Russia'),
(4, 1, 'root@localhost', 'UPDATE', '2024-04-24 15:58:32', 'Tech World', 'John Bada', 'info@techworld.com', '+1234567890', '123 Tech Street', 'Gampola', 'TechState', '10583', 'TechCountry');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fname` varchar(255) NOT NULL,
  `lname` varchar(255) NOT NULL,
  `username` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` varchar(255) NOT NULL,
  `dp` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fname`, `lname`, `username`, `email`, `password`, `role`, `dp`) VALUES
(1, 'Isuru', 'Bandara', 'isuru', 'isurubandara318@gmail.com', '*D9D1875DE2365F73F832EA8ECA6E4EF82D2849E9', 'admin', 'user1-128x128.jpg'),
(2, 'Idunil', 'Bandara', 'idu', 'idunil@gmail.com', '*23AE809DDACAF96AF0FD78ED04B6A265E05AA257', 'admin', 'user4-128x128.jpg'),
(3, 'Flash', 'Tharanga', 'flash', 'flash@gmail.com', '*D94CEFBDE1918061ED12A447ECBC6BB87D1378B0', 'admin', 'user7-128x128.jpg'),
(4, 'Amindu', 'Sangeeth', 'ami', 'ami@gmail.com', '*23AE809DDACAF96AF0FD78ED04B6A265E05AA257', 'employee', 'user4-128x128.jpg'),
(16, 'dd', 'dd', 'dd', 'isurubandara318@gmail.coggg', '*2F3B76898A59E6BB293D056656D934848B96A444', 'user', 'user-def-128x128.jpg'),
(17, 'dd', 'dd', 'dd', 'isurubandara318@gmail.coggg', '*44019FB6C583EFACD2FB2F1A1960B97F86E36A74', 'user', 'user-def-128x128.jpg'),
(18, 'dd', 'dd', 'ddddd', 'isurubandara318@gmd', '*78070D954FAB99FA683FD2DD54E50350C449B388', 'user', 'user-def-128x128.jpg'),
(19, 'John', 'Bada', 'john', 'john@gg.com', '*4EB723494B91D34CCD2B9901D94F9A3404360033', 'employee', 'user-def-128x128.jpg'),
(20, 'Isuru', 'Bandara', 'razor', 'isurubandara@gmail.com', '*D9D1875DE2365F73F832EA8ECA6E4EF82D2849E9', 'user', 'user-def-128x128.jpg');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `users_audit_trigger_delete` AFTER DELETE ON `users` FOR EACH ROW BEGIN
    INSERT INTO users_audit (UserID, username, Action, Old_fname, Old_lname, Old_username, Old_email,  Old_role, Old_dp)
    VALUES (OLD.id, user(), 'DELETE', OLD.fname, OLD.lname, OLD.username, OLD.email, OLD.role, OLD.dp);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `users_audit_trigger_insert` AFTER INSERT ON `users` FOR EACH ROW BEGIN
    INSERT INTO users_audit (UserID, username, Action, Old_fname, Old_lname, Old_username, Old_email,  Old_role, Old_dp)
    VALUES (NEW.id, user(), 'INSERT', NULL, NULL, NULL, NULL,  NULL, NULL);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `users_audit_trigger_update` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
    INSERT INTO users_audit (UserID, username, Action, Old_fname, Old_lname, Old_username, Old_email,  Old_role, Old_dp)
    VALUES (NEW.id, user(), 'UPDATE', OLD.fname, OLD.lname, OLD.username, OLD.email, OLD.role, OLD.dp);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users_audit`
--

CREATE TABLE `users_audit` (
  `Users_Audit_ID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `Action` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `Old_fname` varchar(255) DEFAULT NULL,
  `Old_lname` varchar(255) DEFAULT NULL,
  `Old_username` varchar(20) DEFAULT NULL,
  `Old_email` varchar(50) DEFAULT NULL,
  `Old_role` varchar(255) DEFAULT NULL,
  `Old_dp` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_audit`
--

INSERT INTO `users_audit` (`Users_Audit_ID`, `UserID`, `username`, `Action`, `Timestamp`, `Old_fname`, `Old_lname`, `Old_username`, `Old_email`, `Old_role`, `Old_dp`) VALUES
(1, 2, 'root@localhost', 'UPDATE', '2024-04-22 19:58:43', 'Idunil', 'Bandara', 'idu', 'idunil@gmail.com', 'employee', 'user4-128x128.jpg'),
(6, 15, 'root@localhost', 'UPDATE', '2024-04-22 20:12:09', 'John', 'Bad0', 'john', 'john@gg.com', 'admin', 'user-def-128x128.jpg'),
(7, 15, 'root@localhost', 'UPDATE', '2024-04-22 20:12:42', 'John', 'Bado', 'john', 'john@gg.com', 'admin', 'user7-128x128.jpg'),
(8, 6, 'root@localhost', 'UPDATE', '2024-04-24 07:15:52', 'Isuri', 'Samaranayake', 'isuri', 'isuri@gmail.com', 'employee', 'user2-160x160.jpg'),
(9, 15, 'root@localhost', 'DELETE', '2024-04-24 16:15:53', 'John', 'Bado', 'john', 'john@gg.com', 'admin', 'user6-128x128.jpg'),
(10, 6, 'root@localhost', 'DELETE', '2024-04-24 16:15:58', 'Isuri', 'Samaranayake', 'isuri', 'isuri@gmail.com', 'admin', 'user2-160x160.jpg'),
(11, 16, 'root@localhost', 'INSERT', '2024-04-24 16:16:16', NULL, NULL, NULL, NULL, NULL, NULL),
(12, 17, 'root@localhost', 'INSERT', '2024-04-24 16:17:22', NULL, NULL, NULL, NULL, NULL, NULL),
(13, 18, 'root@localhost', 'INSERT', '2024-04-24 16:18:45', NULL, NULL, NULL, NULL, NULL, NULL),
(14, 1, 'root@localhost', 'UPDATE', '2024-04-24 16:20:17', 'Isuru', 'Bandara', 'isuru', 'isurubandara318@gmail.com', 'admin', 'user1-128x128.jpg'),
(15, 1, 'root@localhost', 'UPDATE', '2024-04-24 16:20:22', 'Isuru', 'Bandara', 'isuru', 'isurubandara318@gmail.com', 'admin', 'user1-128x128.jpg'),
(16, 1, 'root@localhost', 'UPDATE', '2024-04-24 16:20:32', 'Isuru', 'Bandara', 'isuru', 'isurubandara318@gmail.com', 'admin', 'user1-128x128.jpg'),
(17, 1, 'root@localhost', 'UPDATE', '2024-04-24 16:21:51', 'Isuru', 'Bandara', 'isuru', 'isurubandara318@gmail.com', 'admin', 'user1-128x128.jpg'),
(18, 1, 'root@localhost', 'UPDATE', '2024-04-24 16:21:56', 'Isuru', 'Bandara', 'isuru', 'isurubandara318@gmail.com', 'admin', 'user1-128x128.jpg'),
(19, 19, 'root@localhost', 'INSERT', '2024-04-24 16:22:30', NULL, NULL, NULL, NULL, NULL, NULL),
(20, 1, 'root@localhost', 'UPDATE', '2024-04-24 16:23:31', 'Isuru', 'Bandara', 'isuru', 'isurubandara318@gmail.com', 'admin', 'user1-128x128.jpg'),
(21, 1, 'root@localhost', 'UPDATE', '2024-04-24 16:23:47', 'Isuru', 'Bandara', 'isuru', 'isurubandara318@gmail.com', 'admin', 'user1-128x128.jpg'),
(22, 3, 'root@localhost', 'UPDATE', '2024-04-24 16:25:29', 'Flash', 'Tharanga', 'flash', 'flash@gmail.com', 'employee', 'user2-160x160.jpg'),
(23, 20, 'root@localhost', 'INSERT', '2024-09-12 17:09:26', NULL, NULL, NULL, NULL, NULL, NULL),
(24, 1, 'root@localhost', 'UPDATE', '2024-09-12 17:11:26', 'Isuru', 'Bandara', 'isuru', 'isurubandara318@gmail.com', 'admin', 'user1-128x128.jpg'),
(25, 3, 'root@localhost', 'UPDATE', '2024-09-12 17:12:25', 'Flash', 'Tharanga', 'flash', 'flash@gmail.com', 'employee', 'user7-128x128.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`CategoryID`);

--
-- Indexes for table `contracts`
--
ALTER TABLE `contracts`
  ADD PRIMARY KEY (`ContractID`),
  ADD KEY `SupplierID` (`SupplierID`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`CustomerID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `SupplierID` (`SupplierID`),
  ADD KEY `CustomerID` (`CustomerID`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`ProductID`),
  ADD KEY `SupplierID` (`SupplierID`);

--
-- Indexes for table `products_audit`
--
ALTER TABLE `products_audit`
  ADD PRIMARY KEY (`Prodcuts_Audit_ID`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`ReviewID`),
  ADD KEY `SupplierID` (`SupplierID`),
  ADD KEY `CustomerID` (`CustomerID`);

--
-- Indexes for table `suppliercategories`
--
ALTER TABLE `suppliercategories`
  ADD PRIMARY KEY (`SupplierID`,`CategoryID`),
  ADD KEY `CategoryID` (`CategoryID`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`SupplierID`);

--
-- Indexes for table `suppliers_audit`
--
ALTER TABLE `suppliers_audit`
  ADD PRIMARY KEY (`Suppliers_Audit_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users_audit`
--
ALTER TABLE `users_audit`
  ADD PRIMARY KEY (`Users_Audit_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `CategoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `contracts`
--
ALTER TABLE `contracts`
  MODIFY `ContractID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `CustomerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `ProductID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `products_audit`
--
ALTER TABLE `products_audit`
  MODIFY `Prodcuts_Audit_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `ReviewID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `SupplierID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `suppliers_audit`
--
ALTER TABLE `suppliers_audit`
  MODIFY `Suppliers_Audit_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `users_audit`
--
ALTER TABLE `users_audit`
  MODIFY `Users_Audit_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contracts`
--
ALTER TABLE `contracts`
  ADD CONSTRAINT `contracts_ibfk_1` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`),
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`);

--
-- Constraints for table `suppliercategories`
--
ALTER TABLE `suppliercategories`
  ADD CONSTRAINT `suppliercategories_ibfk_1` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`),
  ADD CONSTRAINT `suppliercategories_ibfk_2` FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`CategoryID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
