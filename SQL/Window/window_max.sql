SELECT s1.first_name, s1.last_name, s1.salary, s1.industry,
       (SELECT CONCAT(s2.first_name, ' ', s2.last_name)
        FROM Salary s2
        WHERE s2.industry = s1.industry
        AND s2.salary = (SELECT MAX(salary) FROM Salary s3 WHERE s3.industry = s1.industry)
        LIMIT 1) AS name_highest_sal
FROM Salary s1
ORDER BY s1.industry, s1.salary DESC;