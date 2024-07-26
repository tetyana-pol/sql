SELECT 
  u.id,
  u.username,
  array_agg(fm.movie_id) AS favorite_movie_ids
FROM 
  users u
  LEFT JOIN favorite_movies fm ON u.id = fm.user_id
GROUP BY 
  u.id, u.username
ORDER BY 
  u.id;