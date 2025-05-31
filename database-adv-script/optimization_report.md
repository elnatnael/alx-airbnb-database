Refactor the query to reduce execution time, such as reducing unnecessary joins or using indexing:

mysql> EXPLAIN SELECT 
    ->     b.booking_id,
    ->     b.start_date,
    ->     b.end_date,
    ->     b.total_price,
    ->     b.status AS booking_status,
    ->     b.created_at AS booking_created_at,
    ->     u.first_name,
    ->     u.last_name,
    ->     u.email,
    ->     p.name AS property_name,
    ->     p.location,
    ->     p.pricepernight
    -> FROM Booking b
    -> JOIN User u ON b.user_id = u.user_id
    -> JOIN Property p ON b.property_id = p.property_id
    -> WHERE b.status = 'confirmed'
    -> ORDER BY b.created_at DESC;
+----+-------------+-------+------------+--------+----------------------------------------------------------------+--------------------+---------+----------------------+------+----------+---------------------------------------+
| id | select_type | table | partitions | type   | possible_keys                                                  | key                | key_len | ref                  | rows | filtered | Extra                            ---------+-------+------------+--------+----------------------------------------------------------------+--------------------+---------+----------------------+------+----------+---------------------------------------+
|  1 | SIMPLE      | b     | NULL       | ref    | idx_booking_user_id,idx_booking_property_id,idx_booking_status | idx_booking_status | 1       | const                |    2 |   100.00 | Using index condition; Using filesort |
|  1 | SIMPLE      | u     | NULL       | eq_ref | PRIMARY                                                        | PRIMARY            | 144     | airbnb.b.user_id     |    1 |   100.00 | NULL                                  |
|  1 | SIMPLE      | p     | NULL       | eq_ref | PRIMARY,idx_property_id                                        | PRIMARY            | 144     | airbnb.b.property_id |    1 |   100.00 | NULL                                  |
+----+-------------+-------+------------+--------+----------------------------------------------------------------+--------------------+---------+----------------------+------+----------+---------------------------------------+
3 rows in set, 1 warning (0.00 sec)
