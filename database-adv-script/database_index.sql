uii-- User Table Indexes
CREATE UNIQUE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role);

-- Booking Table Indexes
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_start_date ON Booking(start_date);
CREATE INDEX idx_booking_status ON Booking(status);

-- Property Table Indexes
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_pricepernight ON Property(pricepernight);

-- Checks for Measure the query performance
   -- before adding indexes:
       -- Booking queries
ANALYZE SELECT * FROM Booking WHERE user_id = 'some-user-id' ORDER BY start_date;
EXPLAIN SELECT * FROM Booking WHERE property_id = 'some-property-id' AND status = 'confirmed';

-- Property queries
EXPLAIN SELECT * FROM Property WHERE location = 'New York' ORDER BY pricepernight;
EXPLAIN SELECT * FROM Property WHERE host_id = 'some-host-id';

-- User queries
EXPLAIN SELECT * FROM User WHERE email = 'user@example.com';
EXPLAIN SELECT * FROM User WHERE role = 'guest' ORDER BY created_at;

  -- After adding indexes:

-- User Table
ANAL:YZE SELECT * FROM User WHERE email = 'user@example.com';
ANALYZE SELECT * FROM User WHERE role = 'guest' ORDER BY created_at;

-- Booking Table
ANALYZE SELECT * FROM Booking WHERE user_id = 'some-user-id' ORDER BY created_at;
ANALYZE SELECT * FROM Booking WHERE property_id = 'some-property-id' AND status = 'confirmed';
EXPLAIN SELECT * FROM Booking WHERE start_date >= '2025-01-01' AND end_date <= '2025-01-10';

-- Property Table
ANALYZE SELECT * FROM Property WHERE location = 'New York' ORDER BY pricepernight;
EXPLAIN SELECT * FROM Property WHERE host_id = 'some-host-id' ORDER BY created_at;

