-- Elimina BD si existe
DROP SCHEMA IF EXISTS `youtube_aliexpress_BD` ;
-- Crear BD
CREATE SCHEMA `youtube_aliexpress_BD` DEFAULT CHARACTER SET utf8mb4 ;
USE `youtube_aliexpress_BD` ;

CREATE TABLE `usuarios` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(60) NULL,
  `password` VARCHAR(45) NULL,
  `username` VARCHAR(45) NULL,
  `fecha_nacimiento` DATETIME NULL,
  `genero` ENUM('hombre', 'mujer', 'no indicado') NULL,
  `pais` VARCHAR(45) NULL,
  `cp` VARCHAR(12) NULL,
  PRIMARY KEY (`idusuario`)
);

CREATE TABLE `canales` (
  `idcanal` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(90) NULL,
  `fecha_creacion` DATETIME NULL,
  `usuarios_idusuario` INT NOT NULL,
  PRIMARY KEY (`idcanal`),
  CONSTRAINT `fk_canales_usuarios1`
    FOREIGN KEY (`usuarios_idusuario`)
    REFERENCES `usuarios` (`idusuario`)
);

CREATE TABLE `videos` (
  `idvideo` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(60) NULL,
  `descripcion` VARCHAR(120) NULL,
  `tamano` INT NULL,
  `nombre_archivo` VARCHAR(90) NULL,
  `duracion` TIME NULL,
  `thumbnail_url` VARCHAR(90) NULL,
  `fecha_hora_publicacion` TIMESTAMP NULL,
  `reproducciones` INT NULL,
  `likes` INT NULL,
  `dislikes` INT NULL,
  `estado` ENUM('publico', 'oculto', 'privado') NULL,
  `usuarios_idusuario` INT NOT NULL,
  `canales_idcanal` INT NOT NULL,
  PRIMARY KEY (`idvideo`),
  CONSTRAINT `fk_videos_usuarios`
    FOREIGN KEY (`usuarios_idusuario`)
    REFERENCES `usuarios` (`idusuario`),
  CONSTRAINT `fk_videos_canales1`
    FOREIGN KEY (`canales_idcanal`)
    REFERENCES `canales` (`idcanal`)
);

CREATE TABLE `etiquetas` (
  `idetiqueta` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idetiqueta`)
);

CREATE TABLE `etiquetas_video` (
  `idetiqueta_video` INT NOT NULL AUTO_INCREMENT,
  `etiquetas_idetiqueta` INT NOT NULL,
  `videos_idvideo` INT NOT NULL,
  PRIMARY KEY (`idetiqueta_video`),
  CONSTRAINT `fk_etiquetas_video_etiquetas1`
    FOREIGN KEY (`etiquetas_idetiqueta`)
    REFERENCES `etiquetas` (`idetiqueta`),
  CONSTRAINT `fk_etiquetas_video_videos1`
    FOREIGN KEY (`videos_idvideo`)
    REFERENCES `videos` (`idvideo`)
);

CREATE TABLE `subscripciones_canal` (
  `subscripcion_canal` INT NOT NULL AUTO_INCREMENT,
  `canales_idcanal` INT NOT NULL,
  `usuarios_idusuario` INT NOT NULL,
  PRIMARY KEY (`subscripcion_canal`),
  CONSTRAINT `fk_subscripciones_canal_canales1`
    FOREIGN KEY (`canales_idcanal`)
    REFERENCES `canales` (`idcanal`),
  CONSTRAINT `fk_subscripciones_canal_usuarios1`
    FOREIGN KEY (`usuarios_idusuario`)
    REFERENCES `usuarios` (`idusuario`)
);

CREATE TABLE `likes_dislikes` (
  `idlike_dislike` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('like', 'dislike') NULL,
  `fecha_like_dislike` TIMESTAMP NULL,
  `usuarios_idusuario` INT NOT NULL,
  `videos_idvideo` INT NOT NULL,
  PRIMARY KEY (`idlike_dislike`),
  CONSTRAINT `fk_likes_dislikes_usuarios1`
    FOREIGN KEY (`usuarios_idusuario`)
    REFERENCES `usuarios` (`idusuario`),
  CONSTRAINT `fk_likes_dislikes_videos1`
    FOREIGN KEY (`videos_idvideo`)
    REFERENCES `videos` (`idvideo`)
);

CREATE TABLE `playlists` (
  `idplaylist` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `fecha_creacion` TIMESTAMP NULL,
  `estado` ENUM('publica', 'privada') NULL,
  PRIMARY KEY (`idplaylist`)
);

CREATE TABLE `comentarios` (
  `idcomentario` INT NOT NULL AUTO_INCREMENT,
  `texto` VARCHAR(120) NULL,
  `fecha_hora` TIMESTAMP NULL,
  `usuarios_idusuario` INT NOT NULL,
  `videos_idvideo` INT NOT NULL,
  PRIMARY KEY (`idcomentario`),
  CONSTRAINT `fk_comentarios_usuarios1`
    FOREIGN KEY (`usuarios_idusuario`)
    REFERENCES `usuarios` (`idusuario`),
  CONSTRAINT `fk_comentarios_videos1`
    FOREIGN KEY (`videos_idvideo`)
    REFERENCES `videos` (`idvideo`)
);

CREATE TABLE `likes_dislikes_comentarios` (
  `idlike_dislike_comentario` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('like', 'dislike') NULL,
  `fecha` DATETIME NULL,
  `comentarios_idcomentario` INT NOT NULL,
  `usuarios_idusuario` INT NOT NULL,
  PRIMARY KEY (`idlike_dislike_comentario`),
  CONSTRAINT `fk_likes_dislikes_comentarios_comentarios1`
    FOREIGN KEY (`comentarios_idcomentario`)
    REFERENCES `comentarios` (`idcomentario`),
  CONSTRAINT `fk_likes_dislikes_comentarios_usuarios1`
    FOREIGN KEY (`usuarios_idusuario`)
    REFERENCES `usuarios` (`idusuario`)
);

CREATE TABLE `items_playlist` (
  `iditem_playlist` INT NOT NULL AUTO_INCREMENT,
  `playlists_idplaylist` INT NOT NULL,
  `videos_idvideo` INT NOT NULL,
  PRIMARY KEY (`iditem_playlist`),
  CONSTRAINT `fk_items_playlist_playlists1`
    FOREIGN KEY (`playlists_idplaylist`)
    REFERENCES `playlists` (`idplaylist`),
  CONSTRAINT `fk_items_playlist_videos1`
    FOREIGN KEY (`videos_idvideo`)
    REFERENCES `videos` (`idvideo`)
);
