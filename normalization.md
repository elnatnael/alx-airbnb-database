##Property
property_id: Primary Key, UUID, Indexed
host_id: Foreign Key, references User(user_id)
name: VARCHAR, NOT NULL
description: TEXT, NOT NULL
location: VARCHAR, NOT NULL
pricepernight: DECIMAL, NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
updated_at: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP
##Booking
booking_id: Primary Key, UUID, Indexed
property_id: Foreign Key, references Property(property_id)
user_id: Foreign Key, references User(user_id)
start_date: DATE, NOT NULL
end_date: DATE, NOT NULL
total_price: DECIMAL, NOT NULL
status: ENUM (pending, confirmed, canceled), NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
##Payment
payment_id: Primary Key, UUID, Indexed
booking_id: Foreign Key, references Booking(booking_id)
amount: DECIMAL, NOT NULL
payment_date: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
payment_method: ENUM (credit_card, paypal, stripe), NOT NULL
##Review
review_id: Primary Key, UUID, Indexed
property_id: Foreign Key, references Property(property_id)
user_id: Foreign Key, references User(user_id)
rating: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
comment: TEXT, NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
##Message
message_id: Primary Key, UUID, Indexed
sender_id: Foreign Key, references User(user_id)
recipient_id: Foreign Key, references User(user_id)
message_body: TEXT, NOT NULL
sent_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP 

For the above ER data:
1. First normalization(1NF) is done:
      -All columns contain atomic values (no repeating groups or arrays).
      -Each column contains only one value per row.
      -There are no duplicate rows.
2. Second normalization (2NF) :
      -It is in 1NF (which is already true in this case).
      -All non-key columns are fully dependent on the primary key (no partial dependencies).
primary key(Property_id): All attributes (e.g., host_id, name, description, etc.) are fully dependent on property_id, so no partial dependency here.
3. Third normalization(3NF):
      -It is in 2NF (which is already true).
      -No transitive dependencies exist, which means that non-key columns should not depend on other non-key columns.
  Property table:
     The attributes host_id (foreign key referencing User) and other columns like name, description, and location do not have any transitive dependencies on other non-key attributes.
     No issue with transitive dependencies here.
  Booking table:
     The booking_id is the primary key, and property_id and user_id (foreign keys) do not depend on each other or any non-key column. Thus, no transitive dependency, e.t.c.
