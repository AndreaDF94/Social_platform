USE social_platform;

-- 1) Seleziono gli utenti che hanno pubblicato almeno un video.

SELECT DISTINCT u.id , u.username -- Seleziona l'id e il nome utente , evitando duplicati.
FROM users u -- Tabella degli utenti"u".
JOIN posts p ON u.id = p.user_id  -- Unisce i post scritti da ciascun utente.
JOIN media_post mp ON p.id = mp.post_id -- Unisce i media associati a ogni post.
JOIN medias m ON mp.media_id = m.id -- Ottiene i dati dei media(foto/video)
WHERE m.type = "video";

-- 2) Post che non hanno ricevuto nemmeno un like

-- Seleziona i post che non hanno ricevuto like.

SELECT p.id , p.title -- Seleziona l'id e il titolo del post
FROM posts p -- Tabella dei post"p".
LEFT JOIN likes l ON p.id= l.post_id -- Collega i like usando LEFT JOIN (inclusi quelli senza like)
WHERE l.post_id IS NULL; -- Tiene solo i post che non hanno corrispondenze nei like.

-- 3) NUmero di like per ogni post.

-- Conta i like per ogni post, anche quelli senza like.

SELECT p.id AS post_id , count(l.user_id) AS like_count -- Mostra  l'ID del post e conta i like ricevuti. 
FROM posts p -- Tabella dei post
LEFT JOIN likes l ON p.id = l.post_id -- Collega i like ed include ed include anche i post senza like. 
GROUP BY p.id; -- Raggruppa per ogni post.

-- 4) Numero di like solo per i post che ne hanno ricevuti.

-- Conta i like solo per i post che ne hanno ricevuti.

SELECT post_id, count(*) AS like_count -- Conta il numero di like per ogni post. 
FROM likes -- Tabella dei like. 
GROUP BY post_id; -- Raggruppa per post.

-- 5) Utenti ordinati per numero di media caricati

-- Mostra quanti media (foto/video) ha caricato ogni utente 

SELECT u.id , u.username , count(mp.media_id) AS total_media -- Mostra ID e nome utente e conta i media caricati tramite i post. 
FROM users u -- Tabella utenti. 
JOIN posts p ON u.id = p.user_id -- Collega i post dell'utente. 
JOIN media_post mp ON p.id = mp.post_id -- Collega i media aciascun post. 
GROUP BY u.id -- Raggruppa per utente. 
ORDER BY total_media DESC; -- Ordina dal piu attivo al meno attivo. 

-- 6) Utenti ordinati per numero di like ricevuti.

-- Mostra il numero totale di like ricevuti dai post di ogni utente.

SELECT u.id , u.username , count(l.user_id) AS total_likes -- Mostra ID e nome utente e conta i like ricevuti. 
FROM users u -- Tabella utenti. 
JOIN posts p ON u.id = p.user_id -- Collega i post all'utente. 
LEFT JOIN likes l ON p.id = l.post_id -- Collega i like ai post. 
GROUP BY u.id -- Raggruppa per utente. 
ORDER BY total_likes DESC; -- Ordina l'utente con piu like a quello che ne ha di meno.
