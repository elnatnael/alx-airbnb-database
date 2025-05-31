To monitor the performance of frequently used SQL queries and identify potential bottlenecks :

EXPLAIN ANALYZE SELECT * FROM Booking WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';
--result:

mysql> EXPLAIN SELECT * FROM Booking WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';
+----+-------------+---------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table   | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+---------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | Booking | p2023      | ALL  | NULL          | NULL | NULL    | NULL |    1 |   100.00 | Using where |
+----+-------------+---------+------------+------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

The result shows that  Identified Bottlenecks are :

  No index used → Full partition scan
type = ALL → The slowest access method
possible_keys = NULL → No index is available to help this query


---changes made :
-- Add index to the partitioned table
ALTER TABLE Booking ADD INDEX idx_start_date (start_date);
 then 
EXPLAIN SELECT * FROM Booking WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';
+----+-------------+---------+------------+-------+----------------+----------------+---------+------+------+----------+-----------------------+
| id | select_type | table   | partitions | type  | possible_keys  | key            | key_len | ref  | rows | filtered | Extra                 |
+----+-------------+---------+------------+-------+----------------+----------------+---------+------+------+----------+-----------------------+
|  1 | SIMPLE      | Booking | p2023      | range | idx_start_date | idx_start_date | 3       | NULL |    1 |   100.00 | Using index condition |
+----+-------------+---------+------------+-------+----------------+----------------+---------+------+------+----------+-----------------------+
1 row in set, 1 warning (0.01 sec)

mysql> exit

Now the result shows :

Issue	Fix
Full scan (type = ALL)	Add index on start_date
No index used (key = NULL)	Use ALTER TABLE ... ADD INDEX
Partition accessed (p2023)	✅ Good — partition pruning works.
