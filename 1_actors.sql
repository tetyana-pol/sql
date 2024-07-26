SELECT 
  c.person_id,
  p.first_name,
  p.last_name,
  COALESCE(SUM(m.budget), 0) AS total_movies_budget
FROM 
characters c
  RIGHT JOIN people p ON p.id = c.person_id
  LEFT JOIN movies_characters mc ON c.id = mc.character_id
  LEFT JOIN movies m ON mc.movie_id = m.id
GROUP BY 
  c.person_id,
  p.first_name,
  p.last_name
