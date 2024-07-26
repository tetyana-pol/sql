SELECT 
  m.id,
  m.title,
  m.release_date,
  m.duration,
  m.description,
  (
    SELECT json_agg(f)
    FROM files f
    WHERE f.id = m.poster_id
  ) AS poster,
  (
    SELECT json_agg(p)
    FROM people p
    WHERE p.id = m.director_id
  ) AS director
FROM 
  movies m
WHERE 
  m.country_id = 1
  AND m.release_date >= '2022-01-01'
  AND m.duration > 135
  AND EXISTS (
    SELECT 1
    FROM movies_genres mg
    WHERE mg.movie_id = m.id
    AND mg.genre_id IN (
      SELECT id
      FROM genres
      WHERE name IN ('Action', 'Drama')
    )
  );