CREATE TABLE depart 
(
    depart_id INT PRIMARY KEY,
    depart_name VARCHAR(255)
);

CREATE TABLE empl 
(
    empl_id INT PRIMARY KEY,
    depart_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (depart_id) REFERENCES depart(depart_id)
);

WITH RankedSalaries AS
(
    SELECT 
        empl_id,
        depart_id,
        salary,
        ROW_NUMBER() OVER (PARTITION BY depart_id ORDER BY salary DESC) AS rn
    FROM empl
)
SELECT 
    empl_id,
    depart_id,
    salary
FROM RankedSalaries
WHERE rn <= 2;
