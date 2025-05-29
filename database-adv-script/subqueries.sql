
----Practice Subqueries:
SELECT 
    p.property_id,
    p.name,
    p.description,
    p.location,
    p.pricepernight,
    avg_ratings.avg_rating
FROM 
    property p
JOIN (
    SELECT 
        property_id,
        AVG(rating) AS avg_rating
    FROM 
        review
    GROUP BY 
        property_id
    HAVING 
        AVG(rating) > 4.0
) AS avg_ratings ON p.property_id = avg_ratings.property_id;

-- subquery to find users who have made more than 3 bookings.

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM 
    user u
WHERE 
    (
        SELECT COUNT(*)
        FROM booking b
        WHERE b.user_id = u.user_id
    ) > 3;

