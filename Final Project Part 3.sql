-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`customers` ;

CREATE TABLE IF NOT EXISTS `mydb`.`customers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`addresses` ;

CREATE TABLE IF NOT EXISTS `mydb`.`addresses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street_address` VARCHAR(45) NOT NULL,
  `zip_code` INT NOT NULL,
  `county` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `customers_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_addresses_customers1_idx` (`customers_id` ASC) VISIBLE,
  CONSTRAINT `fk_addresses_customers1`
    FOREIGN KEY (`customers_id`)
    REFERENCES `mydb`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`credit_cards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`credit_cards` ;

CREATE TABLE IF NOT EXISTS `mydb`.`credit_cards` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `card_name` VARCHAR(45) NOT NULL,
  `credit_card_number` INT NOT NULL,
  `expiration_month` INT NOT NULL,
  `expiration_year` INT NOT NULL,
  `cvv` INT NOT NULL,
  `customers_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_credit_cards_customers1_idx` (`customers_id` ASC) VISIBLE,
  CONSTRAINT `fk_credit_cards_customers1`
    FOREIGN KEY (`customers_id`)
    REFERENCES `mydb`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`invoices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`invoices` ;

CREATE TABLE IF NOT EXISTS `mydb`.`invoices` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` VARCHAR(45) NOT NULL,
  `tax` VARCHAR(45) NOT NULL,
  `total` VARCHAR(45) NOT NULL,
  `customers_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_invoices_customers_idx` (`customers_id` ASC) VISIBLE,
  CONSTRAINT `fk_invoices_customers`
    FOREIGN KEY (`customers_id`)
    REFERENCES `mydb`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`machine_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`machine_category` ;

CREATE TABLE IF NOT EXISTS `mydb`.`machine_category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`machines`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`machines` ;

CREATE TABLE IF NOT EXISTS `mydb`.`machines` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `brand` VARCHAR(45) NOT NULL,
  `year` INT NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  `size` INT NOT NULL,
  `price` INT NOT NULL,
  `machine_category_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_machines_machine_category1_idx` (`machine_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_machines_machine_category1`
    FOREIGN KEY (`machine_category_id`)
    REFERENCES `mydb`.`machine_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`parts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`parts` ;

CREATE TABLE IF NOT EXISTS `mydb`.`parts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`gear`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`gear` ;

CREATE TABLE IF NOT EXISTS `mydb`.`gear` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `brand` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `size` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`services` ;

CREATE TABLE IF NOT EXISTS `mydb`.`services` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`machines_has_parts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`machines_has_parts` ;

CREATE TABLE IF NOT EXISTS `mydb`.`machines_has_parts` (
  `machines_id` INT NOT NULL,
  `parts_id` INT NOT NULL,
  PRIMARY KEY (`machines_id`, `parts_id`),
  INDEX `fk_machines_has_parts_parts1_idx` (`parts_id` ASC) VISIBLE,
  INDEX `fk_machines_has_parts_machines1_idx` (`machines_id` ASC) VISIBLE,
  CONSTRAINT `fk_machines_has_parts_machines1`
    FOREIGN KEY (`machines_id`)
    REFERENCES `mydb`.`machines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_machines_has_parts_parts1`
    FOREIGN KEY (`parts_id`)
    REFERENCES `mydb`.`parts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`invoice_line_items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`invoice_line_items` ;

CREATE TABLE IF NOT EXISTS `mydb`.`invoice_line_items` (
  `invoices_id` INT NOT NULL,
  `gear_id` INT NULL,
  `services_id` INT NULL,
  `machines_id` INT NULL,
  PRIMARY KEY (`invoices_id`),
  INDEX `fk_invoice_line_items_gear1_idx` (`gear_id` ASC) VISIBLE,
  INDEX `fk_invoice_line_items_services1_idx` (`services_id` ASC) VISIBLE,
  INDEX `fk_invoice_line_items_machines1_idx` (`machines_id` ASC) VISIBLE,
  CONSTRAINT `fk_invoice_line_items_invoices1`
    FOREIGN KEY (`invoices_id`)
    REFERENCES `mydb`.`invoices` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoice_line_items_gear1`
    FOREIGN KEY (`gear_id`)
    REFERENCES `mydb`.`gear` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoice_line_items_services1`
    FOREIGN KEY (`services_id`)
    REFERENCES `mydb`.`services` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoice_line_items_machines1`
    FOREIGN KEY (`machines_id`)
    REFERENCES `mydb`.`machines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Customers
USE mydb;
INSERT INTO customers VALUES
(DEFAULT, 'John', 'Smith', 'johnsmith1@gmail.com');
SET @johnsmith = last_insert_id();

INSERT INTO customers VALUES
(DEFAULT, 'James', 'Miller', 'jamesmiller2@gmail.com');
SET @jamesmiller = last_insert_id();

INSERT INTO customers VALUES
(DEFAULT, 'Robert', 'Jones', 'robertjones3@gmail.com');
SET @robertjones = last_insert_id();

INSERT INTO customers VALUES
(DEFAULT, 'Suzie', 'Moore', 'suziemoore4@gmail.com');
SET @suziemoore = last_insert_id();

INSERT INTO customers VALUES
(DEFAULT, 'Rebecca', 'Roberts', 'rebeccaroberts5@gmail.com');
SET @rebeccaroberts = last_insert_id();

INSERT INTO customers VALUES
(DEFAULT, 'Tiffany', 'Thompson', 'tiffanythompson6@gmail.com');
SET @tiffanythompson = last_insert_id();

-- Addresses 
INSERT INTO addresses VALUES
(DEFAULT, '1223 Crimson Dr', '83401', 'Bonneville', 'Idaho Falls', 'ID', 'United States', @johnsmith);
SET @johnadd = last_insert_id();

INSERT INTO addresses VALUES
(DEFAULT, '193 Robison Dr', '83406', 'Bonneville', 'Ammon', 'ID', 'United States', @jamesmiller);
SET @jamesadd = last_insert_id();

INSERT INTO addresses VALUES
(DEFAULT, '5376 Scoresby Ave', '83401', 'Bonneville', 'Iona', 'ID', 'United States', @robertjones);
SET @robertadd = last_insert_id();

INSERT INTO addresses VALUES
(DEFAULT, '4086 E 200 N', '83442', 'Jefferson', 'Rigby', 'ID', 'United States', @suziemoore);
SET @suzieadd = last_insert_id();

INSERT INTO addresses VALUES
(DEFAULT, '66 N 4161 E', '83442', 'Jefferson', 'Rigby', 'ID', 'United States', @rebeccaroberts);
SET @rebeccaadd = last_insert_id();

INSERT INTO addresses VALUES
(DEFAULT, '4315 Dixie St', '83401', 'Bonneville', 'Idaho Falls', 'ID', 'United States', @tiffanythompson);
SET @tiffanyadd = last_insert_id();

-- Credit Cards
INSERT INTO credit_cards VALUES
(DEFAULT, 'John Smith', '941272151', '04', '24', '343', @johnsmith);
SET @johncc = last_insert_id();

INSERT INTO credit_cards VALUES
(DEFAULT, 'James Miller', '861283775', '06', '24', '967', @jamesmiller);
SET @jamescc = last_insert_id();

INSERT INTO credit_cards VALUES
(DEFAULT, 'Robert Jones', '677373998', '03', '23', '778', @robertjones);
SET @robertcc = last_insert_id();

INSERT INTO credit_cards VALUES
(DEFAULT, 'Suzie Moore', '545512314', '07', '23', '848', @robertjones);
SET @suziecc = last_insert_id();

INSERT INTO credit_cards VALUES
(DEFAULT, 'Rebecca Roberts', '071037584', '01', '25', '525', @rebeccaroberts);
SET @rebeccacc = last_insert_id();

INSERT INTO credit_cards VALUES
(DEFAULT, 'Tiffany Thompson', '316129788', '08', '23', '990', @tiffanythompson);
SET @tiffanycc = last_insert_id();

-- Machines
INSERT INTO machine_category VALUES
(DEFAULT, 'Snowmobiles');
SET @snowmobile = last_insert_id();

INSERT INTO machine_category VALUES
(DEFAULT, 'Dirtbikes');
SET @dirtbike = last_insert_id();

INSERT INTO machine_category VALUES
(DEFAULT, 'ATVs');
SET @atv = last_insert_id();

INSERT INTO machine_category VALUES
(DEFAULT, 'UTVs');
SET @utv = last_insert_id();

INSERT INTO machine_category VALUES
(DEFAULT, 'Timbersleds');
SET @timbersled = last_insert_id();


-- Machines
INSERT INTO machines VALUES
(DEFAULT, 'Polaris', '2022', 'Axys-Pro-RMK', '850', '14999', @snowmobile);
SET @polaris = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Skidoo', '2022', 'Summit', '850', '13999', @snowmobile);
SET @skidoo = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Artic Cat', '2022', 'Alpha', '850', '12999', @snowmobile);
SET @articcat = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Yamaha', '2022', 'Sidewinder', '800', '13500', @snowmobile);
SET @yamaha = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Honda', '2022', 'CRF-R', '450', '9999', @dirtbike);
SET @honda = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Yamaha', '2022', 'YZ-F', '450', '8999', @dirtbike);
SET @yamahadirt = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Kawasaki', '2022', 'KX', '450', '7550', @dirtbike);
SET @kawasaki = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'KTM', '2022', 'SX-F', '450', '8500', @dirtbike);
SET @ktm = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Husqvarna', '2022', 'FC', '450', '9500', @dirtbike);
SET @husqvarna = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Gasgas', '2022', 'MC', '450', '8550', @dirtbike);
SET @gasgas = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Suzuki', '2022', 'RM-Z', '450', '6799', @dirtbike);
SET @suzuki = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Honda', '2022', 'Fourtrax-Foreman', '518', '8799', @atv);
SET @hondaatv = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Polaris', '2022', 'Sportsman', '450', '6799', @atv);
SET @polarisatv = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Suzuki', '2022', 'Kingquad', '400', '6650', @atv);
SET @suzukiatv = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Kawasaki', '2022', 'Brute-Force', '750', '8799', @atv);
SET @kawasakiatv = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Honda', '2022', 'Fourtrax-Foreman', '518', '8799', @atv);
SET @hondaatv = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Yamaha', '2022', 'Kodiak', '450', '6799', @atv);
SET @yamahaatv = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Can-Am', '2022', 'Outlander', '570', '6499', @atv);
SET @canamatv = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Can-Am', '2022', 'Commander', '1000', '13499', @utv);
SET @canamutv = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Polaris', '2022', 'Razor', '1000', '14499', @utv);
SET @polarisutv = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Honda', '2022', 'Talon', '900', '12499', @utv);
SET @hondautv = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Kawasaki', '2022', 'Teryx', '1000', '13499', @utv);
SET @kawasakiutv = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Polaris-Timbersled', '2022', 'ARO-3', '129', '7999', @timbersled);
SET @aro3timbersled = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Polaris-Timbersled', '2022', 'ARO-129', '129', '5499', @timbersled);
SET @aro129timbersled = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Polaris-Timbersled', '2022', 'RIOT-3', '129', '6999', @timbersled);
SET @riot3timbersled = last_insert_id();

INSERT INTO machines VALUES
(DEFAULT, 'Polaris-Timbersled', '2022', 'RIOT', '129', '5999', @timbersled);
SET @riottimbersled = last_insert_id();

-- Parts
INSERT INTO parts VALUES
(DEFAULT, 'Low Profile Windsheild', '89.99');
SET @snowpart = last_insert_id();

INSERT INTO parts VALUES
(DEFAULT, 'Polaris Large Tunnel Bag', '279.99');
SET @polarisepart = last_insert_id();

INSERT INTO parts VALUES
(DEFAULT, 'Renthal Handlebar Pad', '24.99');
SET @hondapart = last_insert_id();

INSERT INTO parts VALUES
(DEFAULT, 'Dunlop Paddle Sand Tire', '99.99');
SET @sandpart = last_insert_id();

INSERT INTO parts VALUES
(DEFAULT, 'Honda Plastics Kit', '149.99');
SET @hondapart2 = last_insert_id();

INSERT INTO parts VALUES
(DEFAULT, 'Renthal Hand Grips', '14.99');
SET @dirtbikepart = last_insert_id();

INSERT INTO parts VALUES
(DEFAULT, 'Led Headlight Bulb', '49.99');
SET @snowmobilepart = last_insert_id();

INSERT INTO parts VALUES
(DEFAULT, 'Full Windsheild', '199.99');
SET @utvpart = last_insert_id();

INSERT INTO parts VALUES
(DEFAULT, 'GGB Mountain Can', '164.99');
SET @snowcanpart = last_insert_id();

INSERT INTO parts VALUES
(DEFAULT, 'Hand Warmer Kit', '89.99');
SET @atvpart = last_insert_id();

-- Machine_Has_Parts
INSERT INTO machines_has_parts VALUES
(@polaris, @polarisepart);

INSERT INTO machines_has_parts VALUES
(@polaris, @snowpart);

INSERT INTO machines_has_parts VALUES
(@skidoo, @atvpart);

INSERT INTO machines_has_parts VALUES
(@articcat, @atvpart);

INSERT INTO machines_has_parts VALUES
(@polarisatv, @atvpart);

INSERT INTO machines_has_parts VALUES
(@hondaatv, @atvpart);

INSERT INTO machines_has_parts VALUES
(@yamahaatv, @atvpart);

INSERT INTO machines_has_parts VALUES
(@honda, @hondapart);

INSERT INTO machines_has_parts VALUES
(@ktm, @hondapart);

INSERT INTO machines_has_parts VALUES
(@suzuki, @hondapart);

-- Gear
INSERT INTO gear VALUES
(DEFAULT, 'Fox Racing', 'Jersey', 'L', '54.99');
SET @foxjersey = last_insert_id();

INSERT INTO gear VALUES
(DEFAULT, 'Fox Racing', 'Pants', '34', '149.99');
SET @foxpant = last_insert_id();

INSERT INTO gear VALUES
(DEFAULT, 'Fox Racing', 'Boots', '10', '129.99');
SET @foxboots = last_insert_id();

INSERT INTO gear VALUES
(DEFAULT, 'Fox Racing', 'Gloves', 'M', '49.99');
SET @foxgloves = last_insert_id();

INSERT INTO gear VALUES
(DEFAULT, 'Fox Racing', 'Helmet', 'L', '139.99');
SET @foxhelmet = last_insert_id();

INSERT INTO gear VALUES
(DEFAULT, 'Fox Racing', 'Goggles', '10', '64.99');
SET @foxgoggles = last_insert_id();

INSERT INTO gear VALUES
(DEFAULT, 'Fox Racing', 'Chest Protector', 'M', '74.99');
SET @foxchest = last_insert_id();

INSERT INTO gear VALUES
(DEFAULT, 'Klim', 'Storm Jacket', 'L', '399.99');
SET @klimstorm = last_insert_id();

INSERT INTO gear VALUES
(DEFAULT, 'Klim', 'Storm Bibs', 'L', '299.99');
SET @klimstormbib = last_insert_id();

INSERT INTO gear VALUES
(DEFAULT, 'Klim', 'GTX Boots', '10', '299.99');
SET @klimboots = last_insert_id();

INSERT INTO gear VALUES
(DEFAULT, 'Klim', 'Edge Goggles', 'X', '189.99');
SET @klimgoggles = last_insert_id();

INSERT INTO gear VALUES
(DEFAULT, 'Klim', 'Powercross Gloves', 'M', '164.99');
SET @klimgloves = last_insert_id();

-- Services
INSERT INTO services VALUES
(DEFAULT, 'Pre Season', '164.99');
SET @preseason = last_insert_id();

INSERT INTO services VALUES
(DEFAULT, 'Winterize', '134.99');
SET @winterize = last_insert_id();

INSERT INTO services VALUES
(DEFAULT, 'Oil Change', '124.99');
SET @oilchange = last_insert_id();

-- Invoices
INSERT INTO invoices VALUES
(DEFAULT, '12-02-2021', '23.99', '423.98', @johnsmith);
SET @johninvoice = last_insert_id();

INSERT INTO invoices VALUES
(DEFAULT, '12-02-2021', '8.99', '158.98', @jamesmiller);
SET @jamesinvoice = last_insert_id();

INSERT INTO invoices VALUES
(DEFAULT, '12-02-2021', '599.94', '10598.94', @robertjones);
SET @robertinvoice = last_insert_id();

INSERT INTO invoices VALUES
(DEFAULT, '12-02-2021', '899.94', '15898.94', @suziemoore);
SET @suzieinvoice = last_insert_id();

INSERT INTO invoices VALUES
(DEFAULT, '12-02-2021', '9.89', '174.89', @rebeccaroberts);
SET @rebeccainvoice = last_insert_id();

INSERT INTO invoices VALUES
(DEFAULT, '12-02-2021', '527.94', '9326.94', @tiffanythompson);
SET @tiffanyinvoice = last_insert_id();

-- Invoice Line Items
INSERT INTO invoice_line_items VALUES
(@johninvoice, @klimstorm, NULL, NULL);

INSERT INTO invoice_line_items VALUES
(@jamesinvoice, @foxboots, NULL, NULL);

INSERT INTO invoice_line_items VALUES
(@robertinvoice, NULL, NULL, @honda);

INSERT INTO invoice_line_items VALUES
(@suzieinvoice, NULL, NULL, @polaris);

INSERT INTO invoice_line_items VALUES
(@rebeccainvoice, NULL, @preseason, NULL);

INSERT INTO invoice_line_items VALUES
(@tiffanyinvoice, NULL, NULL, @hondaatv);













