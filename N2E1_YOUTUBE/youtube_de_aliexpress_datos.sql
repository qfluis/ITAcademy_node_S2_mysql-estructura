USE `youtube_aliexpress_bd`;
-- DATOS USUARIOS
INSERT INTO `usuarios` (`email`, `password`, `username`, `fecha_nacimiento`, `genero`, `pais`, `cp`) 
VALUES  ('hola@hola.com', '1233444º', 'hola', '2000-02-01', '1', 'Spain', '08999'),
        ('wuuuu@eeeee.com', '3ureujeruie', 'udwu', '1995-06-25', '2', 'Canada', '89977'),
        ('eejeje@eeeee.com', 'uwudjski', 'kiwi', '2020-01-25', '1', 'EEUU', '84753');

-- DATOS CANALES
INSERT INTO `canales` (`nombre`, `descripcion`, `fecha_creacion`, `usuarios_idusuario`) 
VALUES ('ElCanalBleBle', 'Epiquísimo canal de gameplays', '2020-01-15', '1');

-- DATOS VIDEOS
INSERT INTO `videos` (`titulo`, `descripcion`, `tamano`, `nombre_archivo`, `duracion`, `thumbnail_url`, `fecha_hora_publicacion`, `reproducciones`, `likes`, `dislikes`, `estado`, `usuarios_idusuario`, `canales_idcanal`) 
VALUES  ('Epico gameplay buscaminas', 'wua wua wua menudo gameplay de 2 horas', '1354584', 'epic_buscaminas_gameplayer.mp4', '1250', 'urldelaimagen', '2021-03-22', '2', '1', '0', '1', '1', '1'),
        ('Epico gameplay solitario', 'wua wua wua menudo gameplay de 3 horas', '1854584', 'epic_solitario_gameplayer.mp4', '1450', 'urldelaimagen2', '2021-03-25', '4', '2', '1', '1', '1', '1');
-- DATOS SUBSCRIPTOR
INSERT INTO `subscripciones_canal` (`canales_idcanal`, `usuarios_idusuario`) 
VALUES  ('1', '1'),
        ('1', '2'),
        ('1', '3');

-- DATOS COMENTARIOS
INSERT INTO `comentarios` (`texto`, `fecha_hora`, `usuarios_idusuario`, `videos_idvideo`) 
VALUES  ('Wua LOL XD', '2022-02-25', '2', '1'),
        ('POLE', '2022-02-20', '3', '2');

-- DATOS ETIQUETAS
INSERT INTO `etiquetas` (`nombre`) 
VALUES  ('LOL'),
        ('XD'),
        ('GAMEPLAYER');

-- DATOS ETIQUETAS_VIDEO
INSERT INTO `youtube_aliexpress_bd`.`etiquetas_video` (`etiquetas_idetiqueta`, `videos_idvideo`) 
VALUES  ('1', '1'),
        ('2', '1'),
        ('3', '1');

-- DATOS PLAYLISTS
INSERT INTO `playlists` (`nombre`, `fecha_creacion`, `estado`) 
VALUES  ('Tremenda Playlist', '2022-03-25', '1'),
        ('Leyendiosa playlist', '2021-02-25', '1');

-- DATOS ITEMS_PLAYLIST
INSERT INTO `youtube_aliexpress_bd`.`items_playlist` (`playlists_idplaylist`, `videos_idvideo`) 
VALUES  ('1', '1'),
        ('1', '2'),
        ('2', '2');

-- DATOS LIKES_DISLIKES
INSERT INTO `youtube_aliexpress_bd`.`likes_dislikes` (`tipo`, `fecha_like_dislike`, `usuarios_idusuario`, `videos_idvideo`) 
VALUES  ('1', '2022-03-30', '2', '1'),
        ('1', '2022-03-30', '3', '1'),
        ('2', '2022-03-30', '3', '2');

-- DATOS LIKES_DISLIKES_COMENTARIOS
INSERT INTO `youtube_aliexpress_bd`.`likes_dislikes_comentarios` (`tipo`, `fecha`, `comentarios_idcomentario`, `usuarios_idusuario`) VALUES ('1', '2022-03-31', '1', '2');
INSERT INTO `youtube_aliexpress_bd`.`likes_dislikes_comentarios` (`tipo`, `fecha`, `comentarios_idcomentario`, `usuarios_idusuario`) VALUES ('1', '2022-03-15', '2', '3');
