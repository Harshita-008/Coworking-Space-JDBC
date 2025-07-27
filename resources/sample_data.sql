-- SELECT * FROM Location;

INSERT INTO Users (user_id, name, email, phone) VALUES
(1, 'Amit', 'amit@mail', '9876543210'),
(2, 'Priya', 'priya@mail', '8765432109'),
(3, 'Raj', 'raj@mail', '7654321098'),
(4, 'Radhesh', 'radhesh@mail', '7839960462'),
(5, 'Varun', 'varun@mail', '7783526793'),
(6, 'Himani', 'himani@mail', '9822789010'),
(7, 'Mahak', 'mahak@mail', '8892563904'),
(8, 'Darsh', 'darsh@mail', '9456398205'),
(9, 'Krisha', 'krisha@mail', '7834253647'),
(10, 'Suchi', 'suchi@mail', '9284935278');


INSERT INTO Membership (membership_id, access_level, total_cost, duration_days) VALUES
(1, 'Private Office', 6500, 30),
(2, 'Dedicated Desk', 4500, 30),
(3, 'Hot Desk', 4000, 30);
    
INSERT INTO `Location` (`area`, `city`, `state`, `pincode`, `sqft`) VALUES
('Koramangala', 'Bengaluru', 'Karnataka', '560034', 2500.50),
('Hinjewadi', 'Pune', 'Maharashtra', '411057', 3200.75),
('Connaught Place', 'Delhi', 'Delhi', '110001', 4100.25),
('Salt Lake', 'Kolkata', 'West Bengal', '700091', 2800.00),
('Banjara Hills', 'Hyderabad', 'Telangana', '500034', 3600.60),
('Andheri East', 'Mumbai', 'Maharashtra', '400069', 3900.00),
('Navrangpura', 'Ahmedabad', 'Gujarat', '380009', 3100.80),
('Velachery', 'Chennai', 'Tamil Nadu', '600042', 3300.10),
('Civil Lines', 'Jaipur', 'Rajasthan', '302006', 2750.00),
('Vijay Nagar', 'Indore', 'Madhya Pradesh', '452010', 2950.25);

INSERT INTO Service (service_id, service_type, cost_per_unit) VALUES
(1, 'printing', 10),
(2, 'mail', 7),
(3, 'refreshments', 50);
    
INSERT INTO `Events` (`location_id`, `event_name`, `start_time`, `end_time`, `description`) VALUES
(5, 'Startup Networking Night', '2025-07-20 18:00:00', '2025-07-20 21:00:00', 'An evening of networking for startup founders, investors, and tech enthusiasts.'),
(2, 'Freelancer Meetup', '2025-07-22 16:00:00', '2025-07-22 19:00:00', 'A casual meetup for freelancers to connect, collaborate, and share tips.'),
(4, 'Tech Talk: AI in Everyday Life', '2025-07-25 14:00:00', '2025-07-25 16:00:00', 'A guest speaker session exploring how AI is transforming our daily routines.'),
(7, 'Design Thinking Workshop', '2025-07-28 10:00:00', '2025-07-28 13:00:00', 'Hands-on workshop introducing the principles and application of design thinking.'),
(3, 'Women in Tech Panel', '2025-07-30 11:00:00', '2025-07-30 13:30:00', 'A panel discussion featuring inspiring women leaders in the technology industry.');

INSERT INTO `Event_Participation` (`event_id`, `attendee_id`, `status`) VALUES
(1, 1, 'Attended'),
(1, 2, 'Cancelled'),
(2, 3, 'Attended'),
(3, 7, 'Confirmed'),
(3, 8, 'Attended'),
(4, 10, 'Confirmed'),
(5, 1, 'Confirmed'),
(2, 10, 'Attended');


INSERT INTO `Member_History` (`member_id`, `membership_id`, `join_date`, `status`) VALUES
(3, 2, '2020-03-10', 'Inactive'),
(5, 1, '2020-03-15', 'Inactive'),
(1, 3, '2020-04-01', 'Inactive'),
(6, 2, '2020-04-25', 'Inactive'),
(1, 2, '2020-05-05', 'Inactive'),
(4, 3, '2020-05-15', 'Inactive'),
(7, 3, '2020-06-01', 'Inactive'),
(9, 3, '2020-06-20', 'Inactive'),
(3, 2, '2020-06-25', 'Active'),
(1, 1, '2020-07-01', 'Active'),
(4, 2, '2020-07-01', 'Active'),
(7, 2, '2020-07-10', 'Active'),
(5, 3, '2020-07-10', 'Active'),
(6, 3, '2020-07-15', 'Active'),
(9, 1, '2020-07-20', 'Active');

INSERT INTO `Desk_Office` (`item_id`, `item_type`, `location_id`, `status`, `sqft`) VALUES
(1, 'Hot Desk', 1, 'Available', 100),
(2, 'Dedicated Desk', 1, 'Available', 150),
(3, 'Private Office', 2, 'Unavailable', 300),
(4, 'Dedicated Desk', 3, 'Available', 200),
(5, 'Hot Desk', 4, 'Available', 120);

INSERT INTO `Meeting_Room` (`room_id`, `location_id`, `capacity`, `cost`, `status`, `sqft`) VALUES
(1, 1, 6, 1000.0, 'Available', 250.0),
(2, 2, 10, 1500.0, 'Available', 350.0),
(3, 3, 8, 1200.0, 'Unavailable', 300.0);

INSERT INTO `Equipments` (`equipment_id`, `location_id`, `quantity`, `cost`, `status`) VALUES
(1, 1, 5, 150.0, 'Available'),
(2, 2, 2, 300.0, 'Available'),
(3, 3, 1, 500.0, 'Unavailable');

INSERT INTO `Unpaid_Booking` (`member_id`, `resource_id`, `resource_type`, `date`, `start_time`, `end_time`, `status`) VALUES
(1, 1, 'Hot Desk', '2020-07-05', '2020-07-05 09:00:00', '2020-07-05 17:00:00', 'Completed'),
(3, 2, 'Dedicated Desk', '2020-07-20', '2020-07-20 10:00:00', '2020-07-20 16:00:00', 'Completed'),
(4, 4, 'Dedicated Desk', '2020-07-25', '2020-07-25 09:00:00', '2020-07-25 18:00:00', 'Confirmed'),
(5, 5, 'Hot Desk', '2020-07-27', '2020-07-27 09:00:00', '2020-07-27 13:00:00', 'Confirmed'),
(6, 2, 'Dedicated Desk', '2020-07-28', '2020-07-28 12:00:00', '2020-07-28 15:00:00', 'Confirmed'),
(7, 1, 'Hot Desk', '2020-07-15', '2020-07-15 08:00:00', '2020-07-15 11:00:00', 'Completed'),
(9, 3, 'Private Office', '2020-07-25', '2020-07-25 11:00:00', '2020-07-25 18:00:00', 'Confirmed');

INSERT INTO `Paid_Booking` (`member_id`, `resource_id`, `resource_type`, `date`, `start_time`, `end_time`, `status`, `total_cost`) VALUES
(1, 1, 'Meeting Room', '2020-07-10', '2020-07-10 10:00:00', '2020-07-10 13:00:00', 'Completed', 1000.0),
(3, 2, 'Meeting Room', '2020-07-25', '2020-07-25 14:00:00', '2020-07-25 17:00:00', 'Confirmed', 1500.0),
(4, 1, 'Equipment', '2020-07-22', '2020-07-22 09:00:00', '2020-07-22 10:00:00', 'Completed', 150.0),
(5, 2, 'Equipment', '2020-07-26', '2020-07-26 11:00:00', '2020-07-26 12:30:00', 'Confirmed', 300.0),
(6, 3, 'Meeting Room', '2020-07-30', '2020-07-30 09:30:00', '2020-07-30 11:30:00', 'Confirmed', 1200.0),
(7, 1, 'Equipment', '2020-07-25', '2020-07-25 10:00:00', '2020-07-25 11:00:00', 'Confirmed', 150.0),
(9, 2, 'Meeting Room', '2020-07-24', '2020-07-24 15:00:00', '2020-07-24 18:00:00', 'Completed', 1500.0);

INSERT INTO `Access_Log` (`log_id`, `member_id`, `location_id`, `access_method`, `entry_time`, `exit_time`, `resource_id`, `resource_type`) VALUES
(1, 1, 1, 'card', '2020-07-05 09:00:00', '2020-07-05 17:00:00', 1, 'Desk_Office'),
(2, 3, 1, 'fingerprint', '2020-07-20 10:00:00', '2020-07-20 16:00:00', 2, 'Desk_Office'),
(3, 4, 3, 'card', '2020-07-25 09:00:00', '2020-07-25 18:00:00', 4, 'Desk_Office'),
(4, 5, 4, 'fingerprint', '2020-07-27 09:00:00', '2020-07-27 13:00:00', 5, 'Desk_Office'),
(5, 6, 1, 'card', '2020-07-28 12:00:00', '2020-07-28 15:00:00', 2, 'Desk_Office'),
(6, 7, 1, 'fingerprint', '2020-07-15 08:00:00', '2020-07-15 11:00:00', 1, 'Desk_Office'),
(7, 9, 2, 'card', '2020-07-25 11:00:00', '2020-07-25 18:00:00', 3, 'Desk_Office'),
(8, 1, 1, 'card', '2020-07-10 10:00:00', '2020-07-10 13:00:00', 1, 'Meeting_Room'),
(9, 3, 2, 'fingerprint', '2020-07-25 14:00:00', '2020-07-25 17:00:00', 2, 'Meeting_Room'),
(10, 4, 1, 'card', '2020-07-22 09:00:00', '2020-07-22 10:00:00', 1, 'Equipments'),
(11, 5, 2, 'fingerprint', '2020-07-26 11:00:00', '2020-07-26 12:30:00', 2, 'Equipments'),
(12, 6, 3, 'card', '2020-07-30 09:30:00', '2020-07-30 11:30:00', 3, 'Meeting_Room'),
(13, 7, 1, 'fingerprint', '2020-07-25 10:00:00', '2020-07-25 11:00:00', 1, 'Equipments'),
(14, 9, 2, 'card', '2020-07-24 15:00:00', '2020-07-24 18:00:00', 2, 'Meeting_Room');

INSERT INTO `Service_Usage` (`member_id`, `service_id`, `location_id`, `date`, `quantity`, `total_cost`) VALUES
(1, 1, 1, '2020-07-15', 15, 150),
(3, 2, 2, '2020-07-20', 5, 35),
(4, 3, 3, '2020-07-25', 2, 100),
(5, 1, 1, '2020-07-23', 10, 100),
(6, 2, 2, '2020-07-25', 3, 21),
(7, 3, 3, '2020-07-26', 1, 50),
(9, 1, 2, '2020-07-27', 8, 80),
(1, 3, 1, '2020-07-24', 4, 200),
(3, 1, 2, '2020-07-25', 12, 120),
(5, 2, 1, '2020-07-28', 6, 42);

INSERT INTO `Member_Bill` (`member_id`, `location_id`, `product_id`, `product_type`, `bill_date`, `amount`) VALUES
(5, 2, 1, 'Membership', '2020-03-01', 6500),
(3, 2, 2, 'Membership', '2020-03-10', 4500),
(1, 1, 3, 'Membership', '2020-04-01', 4000),
(1, 1, 2, 'Membership', '2020-05-05', 4500),
(4, 3, 3, 'Membership', '2020-05-15', 4000),
(6, 2, 2, 'Membership', '2020-06-01', 4500),
(7, 3, 3, 'Membership', '2020-06-01', 4000),
(9, 2, 3, 'Membership', '2020-06-20', 4000),
(3, 2, 2, 'Membership', '2020-06-25', 4500),
(1, 2, 1, 'Membership', '2020-07-01', 6500),
(4, 3, 2, 'Membership', '2020-07-01', 4500),
(7, 1, 2, 'Membership', '2020-07-10', 4500),
(5, 1, 3, 'Membership', '2020-07-10', 4000),
(1, 1, 1, 'Paid_Booking', '2020-07-10', 1000),
(6, 1, 3, 'Membership', '2020-07-15', 4000),
(1, 1, 1, 'Service_Usage', '2020-07-15', 150),
(7, 1, 1, 'Paid_Booking', '2020-07-15', 150),
(3, 2, 2, 'Service_Usage', '2020-07-20', 35),
(9, 2, 1, 'Membership', '2020-07-20', 6500),
(4, 1, 1, 'Paid_Booking', '2020-07-22', 150),
(5, 1, 1, 'Service_Usage', '2020-07-23', 100),
(9, 2, 2, 'Paid_Booking', '2020-07-24', 1500),
(1, 1, 3, 'Service_Usage', '2020-07-24', 200),
(4, 3, 3, 'Service_Usage', '2020-07-25', 100),
(6, 2, 2, 'Service_Usage', '2020-07-25', 21),
(3, 2, 2, 'Paid_Booking', '2020-07-25', 1500),
(3, 2, 1, 'Service_Usage', '2020-07-25', 120),
(5, 2, 2, 'Paid_Booking', '2020-07-26', 300),
(7, 3, 3, 'Service_Usage', '2020-07-26', 50),
(9, 2, 1, 'Service_Usage', '2020-07-27', 80),
(5, 1, 2, 'Service_Usage', '2020-07-28', 42),
(6, 3, 3, 'Paid_Booking', '2020-07-30', 1200);
