----- Identified high-usage columns in your User, Booking, and Property tables:
| Table    | High-Usage Columns                                                  |
| -------- | ------------------------------------------------------------------- |
| User     | `user_id` (PK), `email` (unique), `role`                            |
| Booking  | `booking_id` (PK), `user_id`, `property_id`, `start_date`, `status` |
| Property | `property_id` (PK), `host_id`, `location`, `pricepernight`          |

-----sample performance before indexing:
 EXPLAIN SELECT * FROM Property WHERE host_id = '77776596-3ba1-11f0-815b-e8aeac54a028';
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-----------------------+
| id | select_type | table    | partitions | type | possible_keys | key     | key_len | ref   | rows | filtered | Extra                 |
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-----------------------+
|  1 | SIMPLE      | Property | NULL       | ref  | host_id       | host_id | 144     | const |    2 |   100.00 | Using index condition |
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-----------------------+
1 row in set, 1 warning (0.00 sec)
mysql> EXPLAIN SELECT * FROM User WHERE role = 'guest' ORDER BY created_at;
+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------------------+
| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra                       |
+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------------------+
|  1 | SIMPLE      | User  | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    4 |    33.33 | Using where; Using filesort |
+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------------------+
----performance after indexing:
mysql> EXPLAIN SELECT * FROM Property WHERE host_id = '77776596-3ba1-11f0-815b-e8aeac54a028';
+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------+------+----------+-----------------------+
| id | select_type | table    | partitions | type | possible_keys        | key                  | key_len | ref   | rows | filtered | Extra                 |
+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------+------+----------+-----------------------+
|  1 | SIMPLE      | Property | NULL       | ref  | idx_property_host_id | idx_property_host_id | 144     | const |    2 |   100.00 | Using index condition |
+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------+------+----------+-----------------------+
1 row in set, 1 warning (0.00 sec)

mysql> EXPLAIN SELECT * FROM User WHERE role = 'guest' ORDER BY created_at;
+----+-------------+-------+------------+------+---------------+---------------+---------+-------+------+----------+---------------------------------------+
| id | select_type | table | partitions | type | possible_keys | key           | key_len | ref   | rows | filtered | Extra                                 |
+----+-------------+-------+------------+------+---------------+---------------+---------+-------+------+----------+---------------------------------------+
|  1 | SIMPLE      | User  | NULL       | ref  | idx_user_role | idx_user_role | 1       | const |    2 |   100.00 | Using index condition; Using filesort |
+----+-------------+-------+------------+------+---------------+---------------+---------+-------+------+----------+---------------------------------------+
1 row in set, 1 warning (0.00 sec)

