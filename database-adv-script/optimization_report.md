Result of the an initial query that retrieves all bookings along with the user details, property details, and payment details:

mysql> SELECT 
    ->     b.booking_id,
    ->     b.start_date,
    ->     b.end_date,
    ->     b.total_price,
    ->     b.status AS booking_status,
    ->     b.created_at AS booking_created_at,
    ->     
    ->     u.first_name,
    ->     u.last_name,
    ->     u.email,
    ->     
    ->     p.name AS property_name,
    ->     p.location,
    ->     p.pricepernight
    -> 
    -> FROM Booking b
    -> JOIN User u ON b.user_id = u.user_id
    -> JOIN Property p ON b.property_id = p.property_id
    -> WHERE b.status = 'confirmed'
    ->   AND b.start_date >= '2025-06-01'
    -> ORDER BY b.created_at DESC;
+--------------------------------------+------------+------------+-------------+----------------+---------------------+------------+-----------+----------------------+--------------------+----------+---------------+
| booking_id                           | start_date | end_date   | total_price | booking_status | booking_created_at  | first_name | last_name | email                | property_name      | location | pricepernight |
+--------------------------------------+------------+------------+-------------+----------------+---------------------+------------+-----------+----------------------+--------------------+----------+---------------+
| b4731cb8-3ba3-11f0-815b-e8aeac54a028 | 2025-06-01 | 2025-06-07 |      720.00 | confirmed      | 2025-05-28 12:11:14 | John       | Doe       | john.doe@example.com | Downtown Apartment | New York |        120.00 |
+--------------------------------------+------------+------------+-------------+----------------+---------------------+------------+-----------+----------------------+--------------------+----------+---------------+
1 row in set (0.00 sec)

--result forAnalyze the query’s performance using EXPLAIN and identify any inefficiencies:

mysql> EXPLAIN SELECT 
    ->     b.booking_id,
    ->     b.start_date,
    ->     b.end_date,
    ->     b.total_price,
    ->     b.status AS booking_status,
    ->     b.created_at AS booking_created_at,
    ->     
    ->     u.first_name,
    ->     u.last_name,
    ->     u.email,
    ->     
    ->     p.name AS property_name,
    ->     p.location,
    ->     p.pricepernight
    -> 
    -> FROM Booking b
    -> JOIN User u ON b.user_id = u.user_id
    -> JOIN Property p ON b.property_id = p.property_id
    -> WHERE b.status = 'confirmed'
    ->   AND b.start_date >= '2025-06-01'
    -> ORDER BY b.created_at DESC;
+----+-------------+-------+------------+--------+---------------------------------------------------------------------------------------+--------------------+---------+----------------------+------+----------+----------------------------------------------------+
| id | select_type | table | partitions | type   | possible_keys                                                                         | key                | key_len | ref                  | rows | filtered | Extra                                              |
+----+-------------+-------+------------+--------+---------------------------------------------------------------------------------------+--------------------+---------+----------------------+------+----------+----------------------------------------------------+
|  1 | SIMPLE      | b     | NULL       | ref    | idx_booking_user_id,idx_booking_property_id,idx_booking_start_date,idx_booking_status | idx_booking_status | 1       | const                |    2 |   100.00 | Using index condition; Using where; Using filesort |
|  1 | SIMPLE      | u     | NULL       | eq_ref | PRIMARY                                                                               | PRIMARY            | 144     | airbnb.b.user_id     |    1 |   100.00 | NULL                                               |
|  1 | SIMPLE      | p     | NULL       | eq_ref | PRIMARY,idx_property_id                                                               | PRIMARY            | 144     | airbnb.b.property_id |    1 |   100.00 | NULL                                               |
+----+-------------+-------+------------+--------+---------------------------------------------------------------------------------------+--------------------+---------+----------------------+------+----------+----------------------------------------------------+
3 rows in set, 1 warning (0.00 sec)

