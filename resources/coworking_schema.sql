-- 1. Create the database if not exists
CREATE DATABASE IF NOT EXISTS coworking_space_management;

-- 2. Use the database
USE coworking_space_management;

-- 3. Create tables
CREATE TABLE `Users`(
    `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(255) NOT NULL
);
CREATE TABLE `Membership`(
    `membership_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `access_level` ENUM(
        'Hot Desk',
        'Dedicated Desk',
        'Private Office'
    ) NOT NULL,
    `total_cost` DOUBLE NOT NULL,
    `duration_days` INT NOT NULL
);
CREATE TABLE `Member_History`(
    `history_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `member_id` INT UNSIGNED NOT NULL,
    `membership_id` INT UNSIGNED NOT NULL,
    `join_date` DATE NOT NULL,
    `status` ENUM('Active', 'Inactive') NOT NULL
);
ALTER TABLE
    `Member_History` ADD INDEX `member_history_member_id_index`(`member_id`);
ALTER TABLE
    `Member_History` ADD INDEX `member_history_join_date_index`(`join_date`);
ALTER TABLE
    `Member_History` ADD INDEX `member_history_status_index`(`status`);
CREATE TABLE `Location`(
    `location_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `area` VARCHAR(100) NOT NULL,
    `city` VARCHAR(100) NOT NULL,
    `state` VARCHAR(100) NOT NULL,
    `pincode` VARCHAR(6) NOT NULL,
    `sqft` DOUBLE NOT NULL
);
CREATE TABLE `Desk_Office`(
    `item_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `item_type` ENUM(
        'Hot Desk',
        'Dedicated Desk',
        'Private Office'
    ) NOT NULL,
    `location_id` INT UNSIGNED NOT NULL,
    `status` ENUM('Available', 'Unavailable') NOT NULL,
    `sqft` INT NOT NULL
);
ALTER TABLE
    `Desk_Office` ADD INDEX `desk_office_location_id_index`(`location_id`);
CREATE TABLE `Meeting_Room`(
    `room_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `location_id` INT UNSIGNED NOT NULL,
    `capacity` INT NOT NULL,
    `cost` DOUBLE NOT NULL,
    `status` ENUM('Available', 'Unavailable') NOT NULL,
    `sqft` DOUBLE NOT NULL
);
ALTER TABLE
    `Meeting_Room` ADD INDEX `meeting_room_location_id_index`(`location_id`);
CREATE TABLE `Equipments`(
    `equipment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `location_id` INT UNSIGNED NOT NULL,
    `quantity` INT NOT NULL,
    `cost` DOUBLE NOT NULL,
    `status` ENUM('Available', 'Unavailable') NOT NULL
);
ALTER TABLE
    `Equipments` ADD INDEX `equipments_location_id_index`(`location_id`);
CREATE TABLE `Paid_Booking`(
    `booking_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `member_id` INT UNSIGNED NOT NULL,
    `resource_id` INT UNSIGNED NOT NULL,
    `resource_type` ENUM('Meeting Room', 'Equipment') NOT NULL,
    `date` DATE NOT NULL,
    `start_time` DATETIME NOT NULL,
    `end_time` DATETIME NOT NULL,
    `status` ENUM(
        'Confirmed',
        'Cancelled',
        'Completed'
    ) NOT NULL,
    `total_cost` DOUBLE NOT NULL
);
ALTER TABLE
    `Paid_Booking` ADD INDEX `paid_booking_member_id_index`(`member_id`);
ALTER TABLE
    `Paid_Booking` ADD INDEX `paid_booking_start_time_index`(`start_time`);
CREATE TABLE `Unpaid_Booking`(
    `booking_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `member_id` INT UNSIGNED NOT NULL,
    `resource_id` INT UNSIGNED NOT NULL,
    `resource_type` ENUM(
        'Hot Desk',
        'Dedicated Desk',
        'Private Office'
    ) NOT NULL,
    `date` DATE NOT NULL,
    `start_time` DATETIME NOT NULL,
    `end_time` DATETIME NOT NULL,
    `status` ENUM(
        'Confirmed',
        'Cancelled',
        'Completed'
    ) NOT NULL
);
ALTER TABLE
    `Unpaid_Booking` ADD INDEX `unpaid_booking_member_id_index`(`member_id`);
ALTER TABLE
    `Unpaid_Booking` ADD INDEX `unpaid_booking_start_time_index`(`start_time`);
CREATE TABLE `Access_Log`(
    `log_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `member_id` INT UNSIGNED NOT NULL,
    `location_id` INT UNSIGNED NOT NULL,
    `access_method` ENUM('card', 'fingerprint') NOT NULL,
    `entry_time` DATETIME NOT NULL,
    `exit_time` DATETIME NOT NULL,
    `resource_id` INT UNSIGNED NOT NULL,
    `resource_type` ENUM(
        'Desk_Office',
        'Meeting_Room',
        'Equipments'
    ) NOT NULL
);
ALTER TABLE
    `Access_Log` ADD INDEX `access_log_member_id_index`(`member_id`);
ALTER TABLE
    `Access_Log` ADD INDEX `access_log_location_id_index`(`location_id`);
ALTER TABLE
    `Access_Log` ADD INDEX `access_log_entry_time_index`(`entry_time`);
ALTER TABLE
    `Access_Log` ADD INDEX `access_log_resource_id_index`(`resource_id`);
CREATE TABLE `Service`(
    `service_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `service_type` ENUM('printing', 'mail', 'refreshments') NOT NULL,
    `cost_per_unit` DOUBLE NOT NULL
);
CREATE TABLE `Service_Usage`(
    `usage_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `member_id` INT UNSIGNED NOT NULL,
    `service_id` INT UNSIGNED NOT NULL,
    `location_id` INT UNSIGNED NOT NULL,
    `date` DATE NOT NULL,
    `quantity` INT NOT NULL,
    `total_cost` DOUBLE NOT NULL
);
CREATE TABLE `Events`(
    `event_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `location_id` INT UNSIGNED NOT NULL,
    `event_name` VARCHAR(255) NOT NULL,
    `start_time` DATETIME NOT NULL,
    `end_time` DATETIME NOT NULL,
    `description` TEXT NOT NULL
);
CREATE TABLE `Event_Participation`(
    `participation_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `event_id` INT UNSIGNED NOT NULL,
    `attendee_id` INT UNSIGNED NOT NULL,
    `status` ENUM('Confirmed', 'Attended', 'Cancelled') NOT NULL
);
ALTER TABLE
    `Event_Participation` ADD INDEX `event_participation_event_id_index`(`event_id`);
ALTER TABLE
    `Event_Participation` ADD INDEX `event_participation_attendee_id_index`(`attendee_id`);
CREATE TABLE `Member_Bill`(
    `bill_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `member_id` INT UNSIGNED NOT NULL,
    `location_id` INT UNSIGNED NOT NULL,
    `product_id` INT UNSIGNED NOT NULL,
    `product_type` ENUM(
        'Membership',
        'Paid_Booking',
        'Service_Usage'
    ) NOT NULL,
    `bill_date` DATE NOT NULL,
    `amount` DOUBLE NOT NULL
);
ALTER TABLE
    `Member_Bill` ADD INDEX `member_bill_member_id_index`(`member_id`);
ALTER TABLE
    `Member_Bill` ADD INDEX `member_bill_location_id_index`(`location_id`);
ALTER TABLE
    `Member_Bill` ADD INDEX `member_bill_bill_date_index`(`bill_date`);
ALTER TABLE
    `Member_Bill` ADD CONSTRAINT `member_bill_location_id_foreign` FOREIGN KEY(`location_id`) REFERENCES `Location`(`location_id`);
ALTER TABLE
    `Access_Log` ADD CONSTRAINT `access_log_member_id_foreign` FOREIGN KEY(`member_id`) REFERENCES `Users`(`user_id`);
ALTER TABLE
    `Equipments` ADD CONSTRAINT `equipments_location_id_foreign` FOREIGN KEY(`location_id`) REFERENCES `Location`(`location_id`);
ALTER TABLE
    `Member_History` ADD CONSTRAINT `member_history_membership_id_foreign` FOREIGN KEY(`membership_id`) REFERENCES `Membership`(`membership_id`);
ALTER TABLE
    `Paid_Booking` ADD CONSTRAINT `paid_booking_member_id_foreign` FOREIGN KEY(`member_id`) REFERENCES `Users`(`user_id`);
ALTER TABLE
    `Paid_Booking` ADD CONSTRAINT `paid_booking_resource_id_equipment_foreign` FOREIGN KEY(`resource_id`) REFERENCES `Equipments`(`equipment_id`);
ALTER TABLE
    `Service_Usage` ADD CONSTRAINT `service_usage_service_id_foreign` FOREIGN KEY(`service_id`) REFERENCES `Service`(`service_id`);
ALTER TABLE
    `Service_Usage` ADD CONSTRAINT `service_usage_member_id_foreign` FOREIGN KEY(`member_id`) REFERENCES `Users`(`user_id`);
ALTER TABLE
    `Member_Bill` ADD CONSTRAINT `member_bill_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `Paid_Booking`(`booking_id`);
ALTER TABLE
    `Event_Participation` ADD CONSTRAINT `event_participation_attendee_id_foreign` FOREIGN KEY(`attendee_id`) REFERENCES `Users`(`user_id`);
ALTER TABLE
    `Unpaid_Booking` ADD CONSTRAINT `unpaid_booking_resource_id_foreign` FOREIGN KEY(`resource_id`) REFERENCES `Desk_Office`(`item_id`);
ALTER TABLE
    `Member_Bill` ADD CONSTRAINT `member_bill_product_id_membership_foreign` FOREIGN KEY(`product_id`) REFERENCES `Membership`(`membership_id`);
ALTER TABLE
    `Member_Bill` ADD CONSTRAINT `member_bill_product_id_service_foreign` FOREIGN KEY(`product_id`) REFERENCES `Service_Usage`(`usage_id`);
ALTER TABLE
    `Meeting_Room` ADD CONSTRAINT `meeting_room_location_id_foreign` FOREIGN KEY(`location_id`) REFERENCES `Location`(`location_id`);
ALTER TABLE
    `Desk_Office` ADD CONSTRAINT `desk_office_location_id_foreign` FOREIGN KEY(`location_id`) REFERENCES `Location`(`location_id`);
ALTER TABLE
    `Access_Log` ADD CONSTRAINT `access_log_location_id_foreign` FOREIGN KEY(`location_id`) REFERENCES `Location`(`location_id`);
ALTER TABLE
    `Service_Usage` ADD CONSTRAINT `service_usage_location_id_foreign` FOREIGN KEY(`location_id`) REFERENCES `Location`(`location_id`);
ALTER TABLE
    `Unpaid_Booking` ADD CONSTRAINT `unpaid_booking_member_id_foreign` FOREIGN KEY(`member_id`) REFERENCES `Users`(`user_id`);
ALTER TABLE
    `Event_Participation` ADD CONSTRAINT `event_participation_event_id_foreign` FOREIGN KEY(`event_id`) REFERENCES `Events`(`event_id`);
ALTER TABLE
    `Member_Bill` ADD CONSTRAINT `member_bill_member_id_foreign` FOREIGN KEY(`member_id`) REFERENCES `Users`(`user_id`);
ALTER TABLE
    `Paid_Booking` ADD CONSTRAINT `paid_booking_resource_id_meeting_foreign` FOREIGN KEY(`resource_id`) REFERENCES `Meeting_Room`(`room_id`);
ALTER TABLE
    `Events` ADD CONSTRAINT `events_location_id_foreign` FOREIGN KEY(`location_id`) REFERENCES `Location`(`location_id`);
ALTER TABLE
    `Member_History` ADD CONSTRAINT `member_history_member_id_foreign` FOREIGN KEY(`member_id`) REFERENCES `Users`(`user_id`);