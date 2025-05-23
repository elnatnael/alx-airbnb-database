CREATE TABLE User (
    user_id UUID PRIMARY KEY,                        -- Primary Key, UUID type
    first_name VARCHAR(255) NOT NULL,                -- First Name (not null)
    last_name VARCHAR(255) NOT NULL,                 -- Last Name (not null)
    email VARCHAR(255) UNIQUE NOT NULL,              -- Email (unique and not null)
    password_hash VARCHAR(255) NOT NULL,             -- Password hash (not null)
    phone_number VARCHAR(15),                        -- Phone Number (nullable)
    role ENUM('guest', 'host', 'admin') NOT NULL,    -- Role (not null)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Created At with default current timestamp
    INDEX idx_email (email)                          -- Index on email for faster lookups
);
[B[A[B
CREATE TABLE Property (
    property_id UUID PRIMARY KEY,                    -- Primary Key, UUID type
    host_id UUID NOT NULL,                            -- Foreign Key (references User)
    name VARCHAR(255) NOT NULL,                       -- Property Name (not null)
    description TEXT NOT NULL,                        -- Property Description (not null)
    location VARCHAR(255) NOT NULL,                   -- Property Location (not null)
    pricepernight DECIMAL(10, 2) NOT NULL,            -- Price per night (not null)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,   -- Created At with default current timestamp
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Updated At
    FOREIGN KEY (host_id) REFERENCES User(user_id),  -- Foreign Key to User table
    INDEX idx_property_id (property_id)              -- Index on property_id for faster lookups
);
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,                     -- Primary Key, UUID type
    property_id UUID NOT NULL,                        -- Foreign Key (references Property)
    user_id UUID NOT NULL,                            -- Foreign Key (references User)
    start_date DATE NOT NULL,                         -- Booking start date (not null)
    end_date DATE NOT NULL,                           -- Booking end date (not null)
    total_price DECIMAL(10, 2) NOT NULL,              -- Total price for the booking (not null)
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,  -- Booking status (not null)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,   -- Created At with default current timestamp
    FOREIGN KEY (property_id) REFERENCES Property(property_id), -- Foreign Key to Property table
    FOREIGN KEY (user_id) REFERENCES User(user_id),  -- Foreign Key to User table
    INDEX idx_booking_id (booking_id)                 -- Index on booking_id for faster lookups
);
);
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY,                     -- Primary Key, UUID type
    booking_id UUID NOT NULL,                         -- Foreign Key (references Booking)
    amount DECIMAL(10, 2) NOT NULL,                   -- Payment amount (not null)
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Payment date with default current timestamp
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,  -- Payment method (not null)
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id), -- Foreign Key to Booking table
    INDEX idx_payment_id (payment_id)                 -- Index on payment_id for faster lookups
);
CREATE TABLE Review (
    review_id UUID PRIMARY KEY,                      -- Primary Key, UUID type
    property_id UUID NOT NULL,                        -- Foreign Key (references Property)
    user_id UUID NOT NULL,                            -- Foreign Key (references User)
    rating INTEGER CHECK (rating >= 1 AND rating <= 5) NOT NULL,  -- Rating (not null, with check constraint)
    comment TEXT NOT NULL,                            -- Review comment (not null)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,   -- Created At with default current timestamp
    FOREIGN KEY (property_id) REFERENCES Property(property_id),  -- Foreign Key to Property table
    FOREIGN KEY (user_id) REFERENCES User(user_id),  -- Foreign Key to User table
    INDEX idx_review_id (review_id)                  -- Index on review_id for faster lookups
);
CREATE TABLE Message (
    message_id UUID PRIMARY KEY,                      -- Primary Key, UUID type
    sender_id UUID NOT NULL,                          -- Foreign Key (references User as sender)
    recipient_id UUID NOT NULL,                       -- Foreign Key (references User as recipient)
    message_body TEXT NOT NULL,                       -- Message content (not null)
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,      -- Sent At with default current timestamp
    FOREIGN KEY (sender_id) REFERENCES User(user_id), -- Foreign Key to User table (sender)
    FOREIGN KEY (recipient_id) REFERENCES User(user_id), -- Foreign Key to User table (recipient)
    INDEX idx_message_id (message_id)                 -- Index on message_id for faster lookups
);
