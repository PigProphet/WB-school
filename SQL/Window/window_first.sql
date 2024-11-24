SELECT first_name, last_name, salary, industry,
       FIRST_VALUE(CONCAT(first_name, ' ', last_name)) OVER (
           PARTITION BY industry
           ORDER BY salary DESC
       ) AS name_highest_sal
FROM Salary
ORDER BY industry, salary DESC;