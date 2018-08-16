-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema OnlineStore
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema OnlineStore
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `OnlineStore` DEFAULT CHARACTER SET utf8 ;
USE `OnlineStore` ;

-- -----------------------------------------------------
-- Table `OnlineStore`.`Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineStore`.`Product` ;

CREATE TABLE IF NOT EXISTS `OnlineStore`.`Product` (
  `idProduct` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `price` DOUBLE NULL,
  ` image` MEDIUMBLOB NULL,
  `description` MEDIUMTEXT NULL,
  PRIMARY KEY (`idProduct`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineStore`.`Client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineStore`.`Client` ;

CREATE TABLE IF NOT EXISTS `OnlineStore`.`Client` (
  `idClient` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Surname` VARCHAR(45) NULL,
  `InBlackList` TINYINT NULL,
  PRIMARY KEY (`idClient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineStore`.`OrderStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineStore`.`OrderStatus` ;

CREATE TABLE IF NOT EXISTS `OnlineStore`.`OrderStatus` (
  `idOrderStatus` INT NOT NULL,
  `name` VARCHAR(30) NULL,
  `isDelivered` TINYINT NULL,
  `isPaid` TINYINT NULL,
  PRIMARY KEY (`idOrderStatus`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineStore`.`Order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineStore`.`Order` ;

CREATE TABLE IF NOT EXISTS `OnlineStore`.`Order` (
  `idOrder` INT NOT NULL,
  `date` DATETIME NULL,
  `Client_idClient` INT NOT NULL,
  `OrderStatus_idOrderStatus` INT NOT NULL,
  `Cost` DOUBLE NULL,
  PRIMARY KEY (`idOrder`),
  CONSTRAINT `fk_Order_Client1`
    FOREIGN KEY (`Client_idClient`)
    REFERENCES `OnlineStore`.`Client` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_OrderStatus1`
    FOREIGN KEY (`OrderStatus_idOrderStatus`)
    REFERENCES `OnlineStore`.`OrderStatus` (`idOrderStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idOrder_UNIQUE` ON `OnlineStore`.`Order` (`idOrder` ASC) VISIBLE;

CREATE INDEX `fk_Order_Client1_idx` ON `OnlineStore`.`Order` (`Client_idClient` ASC) VISIBLE;

CREATE INDEX `fk_Order_OrderStatus1_idx` ON `OnlineStore`.`Order` (`OrderStatus_idOrderStatus` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `OnlineStore`.`OrderProductList`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineStore`.`OrderProductList` ;

CREATE TABLE IF NOT EXISTS `OnlineStore`.`OrderProductList` (
  `Order_idOrder` INT NOT NULL,
  `Product_idProduct` INT NULL,
  `RowNumber` INT NOT NULL,
  `Quantity` VARCHAR(45) NULL,
  PRIMARY KEY (`Order_idOrder`, `RowNumber`),
  CONSTRAINT `fk_OrderProductList_Order`
    FOREIGN KEY (`Order_idOrder`)
    REFERENCES `OnlineStore`.`Order` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderProductList_Product1`
    FOREIGN KEY (`Product_idProduct`)
    REFERENCES `OnlineStore`.`Product` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_OrderProductList_Order_idx` ON `OnlineStore`.`OrderProductList` (`Order_idOrder` ASC) VISIBLE;

CREATE INDEX `fk_OrderProductList_Product1_idx` ON `OnlineStore`.`OrderProductList` (`Product_idProduct` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `OnlineStore`.`Cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineStore`.`Cart` ;

CREATE TABLE IF NOT EXISTS `OnlineStore`.`Cart` (
  `Client_idClient` INT NOT NULL,
  `date` DATETIME NULL,
  PRIMARY KEY (`Client_idClient`),
  CONSTRAINT `fk_Cart_Client1`
    FOREIGN KEY (`Client_idClient`)
    REFERENCES `OnlineStore`.`Client` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Cart_Client1_idx` ON `OnlineStore`.`Cart` (`Client_idClient` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `OnlineStore`.`CartProductList`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineStore`.`CartProductList` ;

CREATE TABLE IF NOT EXISTS `OnlineStore`.`CartProductList` (
  `Cart_Client_idClient` INT NOT NULL,
  `Product_idProduct` INT NOT NULL,
  `Quantity` INT NULL,
  PRIMARY KEY (`Cart_Client_idClient`),
  CONSTRAINT `fk_CartProductList_Cart1`
    FOREIGN KEY (`Cart_Client_idClient`)
    REFERENCES `OnlineStore`.`Cart` (`Client_idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CartProductList_Product1`
    FOREIGN KEY (`Product_idProduct`)
    REFERENCES `OnlineStore`.`Product` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_CartProductList_Product1_idx` ON `OnlineStore`.`CartProductList` (`Product_idProduct` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `OnlineStore`.`ProductQuantity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineStore`.`ProductQuantity` ;

CREATE TABLE IF NOT EXISTS `OnlineStore`.`ProductQuantity` (
  `Product_idProduct` INT NOT NULL,
  `Quantity` DOUBLE NULL,
  PRIMARY KEY (`Product_idProduct`),
  CONSTRAINT `fk_ProductQuantity_Product1`
    FOREIGN KEY (`Product_idProduct`)
    REFERENCES `OnlineStore`.`Product` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineStore`.`Permisstions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineStore`.`Permisstions` ;

CREATE TABLE IF NOT EXISTS `OnlineStore`.`Permisstions` (
  `idPermisstions` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`idPermisstions`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineStore`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineStore`.`User` ;

CREATE TABLE IF NOT EXISTS `OnlineStore`.`User` (
  `idUser` INT NOT NULL,
  `login` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `Permisstions_idPermisstions` INT NOT NULL,
  `Client_idClient` INT NULL,
  PRIMARY KEY (`idUser`),
  CONSTRAINT `fk_User_Permisstions1`
    FOREIGN KEY (`Permisstions_idPermisstions`)
    REFERENCES `OnlineStore`.`Permisstions` (`idPermisstions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Client1`
    FOREIGN KEY (`Client_idClient`)
    REFERENCES `OnlineStore`.`Client` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_User_Permisstions1_idx` ON `OnlineStore`.`User` (`Permisstions_idPermisstions` ASC) VISIBLE;

CREATE INDEX `fk_User_Client1_idx` ON `OnlineStore`.`User` (`Client_idClient` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `OnlineStore`.`Product`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineStore`;
INSERT INTO `OnlineStore`.`Product` (`idProduct`, `name`, `price`, ` image`, `description`) VALUES (1, 'Робот-пылесос iRobot Roomba 616', 19999, NULL, 'Новая модель Roomba 616. Для запуска нужно всего лишь нажать кнопку \"Clean\" на роботе, и Roomba 616 самостоятельно очистит до 60 квадратных метров без подзарядки. Укомплектован контейнером AeroVac Bin. Новый контейнер не только имеет повышенную емкость, предназначенную для сбора шерсти, но также оснащен всасывающим устройством и имеет компактный отсек для сбора пыли. Таким образом, теперь нет необходимости в дополнительной чистке помещения базовым контейнером. Еще одна особенность новинки — AeroVac Bin работает в 2 раза тише, чем базовая версия. Roomba 616 — представитель 600-ой серии (6-ого поколения) роботов, которые выпускает компания iRobot, в нем использованы новейшие разработки в области робототехники, навигации в помещении, вакуумной уборки. ');
INSERT INTO `OnlineStore`.`Product` (`idProduct`, `name`, `price`, ` image`, `description`) VALUES (2, 'Ноутбук Apple MacBook Pro 13, Space Grey', 133429, NULL, 'Apple MacBook Pro стал ещё быстрее и мощнее.');
INSERT INTO `OnlineStore`.`Product` (`idProduct`, `name`, `price`, ` image`, `description`) VALUES (3, 'Игровая мышь Razer Naga Trinity, Black', 6690, NULL, 'Оцените мощные возможности тотального контроля, в какую бы игру вы ни играли. Мышь Razer Naga Trinity, призванная обеспечить преимущество в MOBA/многопользовательских онлайн-играх, позволяет вам настраивать все: от вооружений до индивидуальных конфигураций, чтобы постоянно опережать соперников. Razer Naga Trinity оснащена тремя сменными боковыми панелями, что позволяет переключаться между 2-, 7- и 12-кнопочными конфигурациями в зависимости от ваших потребностей в игре. ');
INSERT INTO `OnlineStore`.`Product` (`idProduct`, `name`, `price`, ` image`, `description`) VALUES (4, 'Canon Pixma iP2840 принтер', 1990, NULL, 'Canon PIXMA iP2840 - легкая и доступная повседневная печать. ');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineStore`.`Client`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineStore`;
INSERT INTO `OnlineStore`.`Client` (`idClient`, `Name`, `Surname`, `InBlackList`) VALUES (1, 'Себястьян', 'Негодяев', NULL);
INSERT INTO `OnlineStore`.`Client` (`idClient`, `Name`, `Surname`, `InBlackList`) VALUES (2, 'Иван', 'Алхимов', NULL);
INSERT INTO `OnlineStore`.`Client` (`idClient`, `Name`, `Surname`, `InBlackList`) VALUES (3, 'Евгений', 'Любимов', NULL);
INSERT INTO `OnlineStore`.`Client` (`idClient`, `Name`, `Surname`, `InBlackList`) VALUES (4, 'Аграфена', 'Патрикеева', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineStore`.`OrderStatus`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineStore`;
INSERT INTO `OnlineStore`.`OrderStatus` (`idOrderStatus`, `name`, `isDelivered`, `isPaid`) VALUES (1, 'Оформлен', NULL, NULL);
INSERT INTO `OnlineStore`.`OrderStatus` (`idOrderStatus`, `name`, `isDelivered`, `isPaid`) VALUES (2, 'Оплачен', NULL, 1);
INSERT INTO `OnlineStore`.`OrderStatus` (`idOrderStatus`, `name`, `isDelivered`, `isPaid`) VALUES (3, 'Доставлен', 1, 1);
INSERT INTO `OnlineStore`.`OrderStatus` (`idOrderStatus`, `name`, `isDelivered`, `isPaid`) VALUES (4, 'Аннулирован', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineStore`.`Order`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineStore`;
INSERT INTO `OnlineStore`.`Order` (`idOrder`, `date`, `Client_idClient`, `OrderStatus_idOrderStatus`, `Cost`) VALUES (1, '01.08.18', 1, 1, NULL);
INSERT INTO `OnlineStore`.`Order` (`idOrder`, `date`, `Client_idClient`, `OrderStatus_idOrderStatus`, `Cost`) VALUES (2, '05.08.18', 3, 2, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineStore`.`OrderProductList`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineStore`;
INSERT INTO `OnlineStore`.`OrderProductList` (`Order_idOrder`, `Product_idProduct`, `RowNumber`, `Quantity`) VALUES (1, 2, 1, '1');
INSERT INTO `OnlineStore`.`OrderProductList` (`Order_idOrder`, `Product_idProduct`, `RowNumber`, `Quantity`) VALUES (1, 3, 2, '1');
INSERT INTO `OnlineStore`.`OrderProductList` (`Order_idOrder`, `Product_idProduct`, `RowNumber`, `Quantity`) VALUES (2, 4, 1, '2');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineStore`.`ProductQuantity`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineStore`;
INSERT INTO `OnlineStore`.`ProductQuantity` (`Product_idProduct`, `Quantity`) VALUES (1, 3);
INSERT INTO `OnlineStore`.`ProductQuantity` (`Product_idProduct`, `Quantity`) VALUES (2, 2);
INSERT INTO `OnlineStore`.`ProductQuantity` (`Product_idProduct`, `Quantity`) VALUES (3, 10);
INSERT INTO `OnlineStore`.`ProductQuantity` (`Product_idProduct`, `Quantity`) VALUES (4, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineStore`.`Permisstions`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineStore`;
INSERT INTO `OnlineStore`.`Permisstions` (`idPermisstions`, `name`) VALUES (1, 'Administrator');
INSERT INTO `OnlineStore`.`Permisstions` (`idPermisstions`, `name`) VALUES (2, 'User');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineStore`.`User`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineStore`;
INSERT INTO `OnlineStore`.`User` (`idUser`, `login`, `password`, `Permisstions_idPermisstions`, `Client_idClient`) VALUES (1, 'Администратр', 'sa', 1, NULL);
INSERT INTO `OnlineStore`.`User` (`idUser`, `login`, `password`, `Permisstions_idPermisstions`, `Client_idClient`) VALUES (2, 'Negodyaev', '123', 2, 1);
INSERT INTO `OnlineStore`.`User` (`idUser`, `login`, `password`, `Permisstions_idPermisstions`, `Client_idClient`) VALUES (3, 'Alhimov', '123', 2, 2);
INSERT INTO `OnlineStore`.`User` (`idUser`, `login`, `password`, `Permisstions_idPermisstions`, `Client_idClient`) VALUES (4, 'Lyubimov', '123', 2, 3);
INSERT INTO `OnlineStore`.`User` (`idUser`, `login`, `password`, `Permisstions_idPermisstions`, `Client_idClient`) VALUES (5, 'Patrikeeva', '123', 2, 4);

COMMIT;

