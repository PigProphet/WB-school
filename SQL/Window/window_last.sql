SELECT first_name, last_name, salary, industry,
       LAST_VALUE(CONCAT(first_name, ' ', last_name)) OVER (
           PARTITION BY industry
           ORDER BY salary ASC
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS name_lowest_sal
FROM Salary
ORDER BY industry, salary ASC;