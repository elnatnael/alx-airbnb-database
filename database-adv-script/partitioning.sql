CREATE TABLE Booking (
    id BIGINT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status TEXT,
    PRIMARY KEY (id, start_date)
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION pmax  VALUES LESS THAN MAXVALUE
);

--analyze how MySQL optimizes the partitioned query:
EXPLAIN 
SELECT * FROM Booking
WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';

-- Measure Execution Time:
SET PROFILING = 1;

-- Query on partitioned table
SELECT * FROM Booking
WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';

SHOW PROFILES;
