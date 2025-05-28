--  A query to retrieve data of  all bookings and the respective users who made those bookings using INNER JOIN:
SELECT
    b.booking_id,
    b.property_id,
    b.user_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    u.created_at AS user_created_at
FROM
    Booking b
INNER JOIN
    User u ON b.user_id = u.user_id;
-- A query to retrieve all properties and their reviews, including properties that have no reviews:
using LEFT JOIN:

SELECT
    property.property_id,
    property.name,
    property.description,
    property.location,
    property.pricepernight,
    review.review_id,
    review.user_id,
    review.rating,
    review.comment,
    review.created_at AS review_created_at
FROM
    property
LEFT JOIN
    review ON property.property_id = review.property_id
ORDER BY
    property.name ASC, review.rating DESC;

-- A query  using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user:
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.status
FROM
    User u
FULL OUTER JOIN
    Booking b ON u.user_id = b.user_id;
--Note: FULL OUTER JOIN  doesn't work on mysql  ,so for mysql we us "UNION"  between LEFT AND RIGHT JOINS.
