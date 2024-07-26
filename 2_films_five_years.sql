SELECT 
  m.id, 
  m.title, 
  COUNT(DISTINCT mc.character_id) AS actors_count
FROM 
  movies m
  JOIN movies_characters mc ON m.id = mc.movie_id
  JOIN characters c ON mc.character_id = c.id
WHERE 
  m.release_date > CURRENT_DATE - INTERVAL '5 year'
GROUP BY 
  m.id, m.title
ORDER BY 
  actors_count DESC;