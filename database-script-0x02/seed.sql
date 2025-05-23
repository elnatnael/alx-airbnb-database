-- Inserting sample users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
  (UUID(), 'John', 'Doe', 'john.doe@example.com', 'hashedpassword123', '555-1234', 'guest', CURRENT_TIMESTAMP),
  (UUID(), 'Alice', 'Smith', 'alice.smith@example.com', 'hashedpassword456', '555-5678', 'host', CURRENT_TIMESTAMP),
  (UUID(), 'Bob', 'Johnson', 'bob.johnson@example.com', 'hashedpassword789', '555-9876', 'guest', CURRENT_TIMESTAMP),
  (UUID(), 'Eve', 'Williams', 'eve.williams@example.com', 'hashedpassword101', '555-1122', 'admin', CURRENT_TIMESTAMP);

-- Inserting sample properties
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
  (UUID(), 'user_id_of_Alice', 'Downtown Apartment', 'A modern apartment in the heart of the city.', 'New York', 120.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (UUID(), 'user_id_of_Alice', 'Beachfront House', 'Beautiful house with ocean view.', 'Miami', 2RENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (UUID(), 'user_id_of_Bob', 'Mountain Cabin', 'Cozy cabin in the mountains, perfect for a weekend getaway.', 'Aspen', 180.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (UUID(), 'user_id_of_Bob', 'Lakeview Cottage', 'A quiet cottage by the lake, ideal for relaxation.', 'Lake Tahoe', 150.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Inserting sample bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
  (UUID(), 'property_id_of_downtown_apartment', 'user_id_of_John', '2025-06-01', '2025-06-07', 720.00, 'confirmed', CURRENT_TIMESTAMP),
  (UUID(), 'property_id_of_beachfront_house', 'user_id_of_Bob', '2025-07-10', '2025-07-15', 1250.00, 'pending', CURRENT_TIMESTAMP),
  (UUID(), 'property_id_of_mountain_cabin', 'user_id_of_John', '2025-05-20', '2025-05-23', 540.00, 'confirmed', CURRENT_TIMESTAMP),
  (UUID(), 'property_id_of_lakeview_cottage', 'user_id_of_Bob', '2025-06-10', '2025-06-15', 750.00, 'canceled', CURRENT_TIMESTAMP);

-- Inserting sample payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
  (UUID(), 'booking_id_of_john_booking_1', 720.00, CURRENT_TIMESTAMP, 'credit_card'),
  (UUID(), 'booking_id_of_bob_booking_1', 1250.00, CURRENT_TIMESTAMP, 'paypal'),
  (UUID(), 'booking_id_of_john_booking_2', 540.00, CURRENT_TIMESTAMP, 'stripe'),
  (UUID(), 'booking_id_of_bob_booking_2', 750.00, CURRENT_TIMESTAMP, 'credit_card');

-- Inserting sample reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
  (UUID(), 'property_id_of_downtown_apartment', 'user_id_of_Bob', 5, 'Amazing place! Great location and clean.', CURRENT_TIMESTAMP),
  (UUID(), 'property_id_of_beachfront_house', 'user_id_of_John', 4, 'Nice house but the beach was a bit crowded.', CURRENT_TIMESTAMP),
  (UUID(), 'property_id_of_mountain_cabid_of_John', 5, 'The perfect getaway! Very cozy.', CURRENT_TIMESTAMP),
  (UUID(), 'property_id_of_lakeview_cottage', 'user_id_of_Bob', 3, 'The cottage was nice, but it could use some updates.', CURRENT_TIMESTAMP);

-- Inserting sample messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
  (UUID(), 'user_id_of_Alice', 'user_id_of_John', 'Your booking for the Downtown Apartment has been confirmed!', CURRENT_TIMESTAMP),
  (UUID(), 'user_id_of_Bob', 'user_id_of_John', 'Do you have any questions about the Mountain Cabin?', CURRENT_TIMESTAMP),
  (UUID(), 'user_id_of_Alice', 'user_id_of_Bob', 'Can you provide more details about the Beachfront House?', CURRENT_TIMESTAMP),
  (UUID(), 'user_id_of_John', 'user_id_of_Bob', 'The Lakeview Cottage looks great. Can you confirm the booking?', CURRENT_TIMESTAMP);
