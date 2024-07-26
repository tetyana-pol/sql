SELECT 
  m.id,
  m.title,
  m.release_date,
  m.duration,
  m.description,
  json_build_object(
    'id', f.id,
    'file_name', f.file_name,
    'url', f.url,
    'mime_type', f.mime_type
  ) AS poster,
  json_build_object(
    'id', p.id,
    'first_name', p.first_name,
    'last_name', p.last_name,
    'photo', (
      SELECT json_build_object(
        'id', pf.id,
        'file_name', pf.file_name,
        'url', pf.url,
        'mime_type', pf.mime_type
      )
      FROM photos ph
      JOIN files pf ON ph.file_id = pf.id
      WHERE ph.person_id = p.id AND ph.is_main = TRUE
    )
  ) AS director,
  (
    SELECT json_agg(json_build_object(
      'id', p.id,
      'first_name', p.first_name,
      'last_name', p.last_name,
      'photo', (
        SELECT json_build_object(
          'id', pf.id,
          'file_name', pf.file_name,
          'url', pf.url,
          'mime_type', pf.mime_type
        )
        FROM photos ph
        JOIN files pf ON ph.file_id = pf.id
        WHERE ph.person_id = p.id AND ph.is_main = TRUE
      )
    ))
    FROM movies_characters mc
    JOIN characters c ON mc.character_id = c.id
    JOIN characters_people cp ON c.id = cp.character_id
    JOIN people p ON cp.people_id = p.id
    WHERE mc.movie_id = m.id
  ) AS actors,
  (
    SELECT json_agg(json_build_object(
      'id', g.id,
      'name', g.name
    ))
    FROM movies_genres mg
    JOIN genres g ON mg.genre_id = g.id
    WHERE mg.movie_id = m.id
  ) AS genres
FROM movies m
JOIN files f ON m.poster_id = f.id
JOIN people p ON m.director_id = p.id
WHERE m.id = 1;