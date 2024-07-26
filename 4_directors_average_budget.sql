SELECT 
  p.id AS director_id,
  CONCAT(p.first_name, ' ', p.last_name) AS director_name,
  AVG(m.budget) AS average_budget
FROM 
  people p
  JOIN movies m ON p.id = m.director_id
GROUP BY 
  p.id, p.first_name, p.last_name
ORDER BY 
  p.id;