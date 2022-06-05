-- Elimina BD si existe
DROP SCHEMA IF EXISTS `spotify_like` ;
-- Crear BD
CREATE SCHEMA `spotify_like` DEFAULT CHARACTER SET utf8mb4 ;
USE `spotify_like` ;

CREATE TABLE `usuarios` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('free', 'premium') NULL,
  `email` VARCHAR(60) NULL,
  `password` VARCHAR(45) NULL,
  `nombre_usuario` VARCHAR(45) NULL,
  `fecha_nacimiento` DATETIME NULL,
  `genero` ENUM('hombre', 'mujer', 'no indicado') NULL,
  `pais` VARCHAR(45) NULL,
  `cp` VARCHAR(10) NULL,
  PRIMARY KEY (`idusuario`));

CREATE TABLE  `suscripciones` (
  `idsuscripcion` INT NOT NULL AUTO_INCREMENT,
  `fecha_inicio` DATETIME NULL,
  `fecha_renovacion` DATETIME NULL,
  `forma_pago` ENUM('tarjeta', 'PayPal') NULL,
  `usuarios_idusuario` INT NOT NULL,
  PRIMARY KEY (`idsuscripcion`),
  INDEX `fk_suscripciones_usuarios1_idx` (`usuarios_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_suscripciones_usuarios1`
    FOREIGN KEY (`usuarios_idusuario`)
    REFERENCES `usuarios` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE  `metodos_pago` (
  `idmetodopago` INT NOT NULL AUTO_INCREMENT,
  `Numero_targeta` INT NULL,
  `mes_cad_targeta` SMALLINT NULL,
  `ano_cad_targeta` YEAR(4) NULL,
  `codigo_seg_targeta` SMALLINT NULL,
  `usuario_paypal` VARCHAR(45) NULL,
  `usuarios_idusuario` INT NOT NULL,
  PRIMARY KEY (`idmetodopago`),
  INDEX `fk_metodos_pago_usuarios_idx` (`usuarios_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_metodos_pago_usuarios`
    FOREIGN KEY (`usuarios_idusuario`)
    REFERENCES `usuarios` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE  `pagos` (
  `numero_pedido` INT NOT NULL,
  `fecha` DATETIME NULL,
  `pagoscol` VARCHAR(45) NULL,
  `total` DECIMAL NULL,
  `usuarios_idusuario` INT NOT NULL,
  `metodos_pago_idmetodopago` INT NOT NULL,
  `suscripciones_idsuscripcion` INT NOT NULL,
  PRIMARY KEY (`numero_pedido`, `suscripciones_idsuscripcion`),
  INDEX `fk_pagos_usuarios1_idx` (`usuarios_idusuario` ASC) VISIBLE,
  INDEX `fk_pagos_metodos_pago1_idx` (`metodos_pago_idmetodopago` ASC) VISIBLE,
  INDEX `fk_pagos_suscripciones1_idx` (`suscripciones_idsuscripcion` ASC) VISIBLE,
  CONSTRAINT `fk_pagos_usuarios1`
    FOREIGN KEY (`usuarios_idusuario`)
    REFERENCES `usuarios` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagos_metodos_pago1`
    FOREIGN KEY (`metodos_pago_idmetodopago`)
    REFERENCES `metodos_pago` (`idmetodopago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagos_suscripciones1`
    FOREIGN KEY (`suscripciones_idsuscripcion`)
    REFERENCES `suscripciones` (`idsuscripcion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE  `playlists` (
  `idplaylist` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NULL,
  `num_canciones` INT NULL,
  `fecha_creacion` DATETIME NULL,
  `fecha_eliminacion` DATETIME NULL,
  `estado` ENUM('Activa', 'Eliminada') NULL,
  PRIMARY KEY (`idplaylist`));

CREATE TABLE  `playlist_compartida` (
  `idplaylist_compartida` INT NOT NULL AUTO_INCREMENT,
  `playlists_idplaylist` INT NOT NULL,
  `usuarios_idusuario` INT NOT NULL,
  PRIMARY KEY (`idplaylist_compartida`),
  INDEX `fk_playlist_compartida_playlists1_idx` (`playlists_idplaylist` ASC) VISIBLE,
  INDEX `fk_playlist_compartida_usuarios1_idx` (`usuarios_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_compartida_playlists1`
    FOREIGN KEY (`playlists_idplaylist`)
    REFERENCES `playlists` (`idplaylist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_compartida_usuarios1`
    FOREIGN KEY (`usuarios_idusuario`)
    REFERENCES `usuarios` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE  `artistas` (
  `idArtista` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NULL,
  `imagen_url` VARCHAR(120) NULL,
  `lista artistas relacionados_id` INT NOT NULL,
  PRIMARY KEY (`idArtista`));

CREATE TABLE  `favs_albums` (
  `idfav_album` INT NOT NULL AUTO_INCREMENT,
  `usuarios_idusuario` INT NOT NULL,
  PRIMARY KEY (`idfav_album`),
  INDEX `fk_favs_albums_usuarios1_idx` (`usuarios_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_favs_albums_usuarios1`
    FOREIGN KEY (`usuarios_idusuario`)
    REFERENCES `usuarios` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE  `albums` (
  `idAlbum` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NULL,
  `ano_publicacion` YEAR(4) NULL,
  `imagen_url` VARCHAR(120) NULL,
  `artistas_idartista` INT NOT NULL,
  `favs_albums_idfav_album` INT NOT NULL,
  PRIMARY KEY (`idAlbum`),
  INDEX `fk_albums_artistas1_idx` (`artistas_idartista` ASC) VISIBLE,
  INDEX `fk_albums_favs_albums1_idx` (`favs_albums_idfav_album` ASC) VISIBLE,
  CONSTRAINT `fk_albums_artistas1`
    FOREIGN KEY (`artistas_idartista`)
    REFERENCES `artistas` (`idArtista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_albums_favs_albums1`
    FOREIGN KEY (`favs_albums_idfav_album`)
    REFERENCES `favs_albums` (`idfav_album`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE  `canciones` (
  `idcancion` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(60) NULL,
  `duracion` TIME NULL,
  `reproducciones` INT NULL,
  `albums_idAlbum` INT NOT NULL,
  PRIMARY KEY (`idcancion`),
  INDEX `fk_canciones_albums1_idx` (`albums_idAlbum` ASC) VISIBLE,
  CONSTRAINT `fk_canciones_albums1`
    FOREIGN KEY (`albums_idAlbum`)
    REFERENCES `albums` (`idAlbum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE  `items_playlist` (
  `iditem_lista` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NULL,
  `items_listacol` VARCHAR(45) NULL,
  `canciones_idcancion` INT NOT NULL,
  `playlists_idplaylist` INT NOT NULL,
  `usuarios_idusuario` INT NOT NULL,
  PRIMARY KEY (`iditem_lista`),
  INDEX `fk_items_playlist_canciones1_idx` (`canciones_idcancion` ASC) VISIBLE,
  INDEX `fk_items_playlist_playlists1_idx` (`playlists_idplaylist` ASC) VISIBLE,
  INDEX `fk_items_playlist_usuarios1_idx` (`usuarios_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_items_playlist_canciones1`
    FOREIGN KEY (`canciones_idcancion`)
    REFERENCES `canciones` (`idcancion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_items_playlist_playlists1`
    FOREIGN KEY (`playlists_idplaylist`)
    REFERENCES `playlists` (`idplaylist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_items_playlist_usuarios1`
    FOREIGN KEY (`usuarios_idusuario`)
    REFERENCES `usuarios` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE  `follows_artistas` (
  `idfollow_artista` INT NOT NULL AUTO_INCREMENT,
  `usuarios_idusuario` INT NOT NULL,
  `artistas_idartista` INT NOT NULL,
  PRIMARY KEY (`idfollow_artista`),
  INDEX `fk_follows_artistas_usuarios1_idx` (`usuarios_idusuario` ASC) VISIBLE,
  INDEX `fk_follows_artistas_artistas1_idx` (`artistas_idartista` ASC) VISIBLE,
  CONSTRAINT `fk_follows_artistas_usuarios1`
    FOREIGN KEY (`usuarios_idusuario`)
    REFERENCES `usuarios` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_follows_artistas_artistas1`
    FOREIGN KEY (`artistas_idartista`)
    REFERENCES `artistas` (`idArtista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE  `favs_canciones` (
  `idfav_cancion` INT NOT NULL AUTO_INCREMENT,
  `usuarios_idusuario` INT NOT NULL,
  `canciones_idcancion` INT NOT NULL,
  PRIMARY KEY (`idfav_cancion`),
  INDEX `fk_favs_canciones_usuarios1_idx` (`usuarios_idusuario` ASC) VISIBLE,
  INDEX `fk_favs_canciones_canciones1_idx` (`canciones_idcancion` ASC) VISIBLE,
  CONSTRAINT `fk_favs_canciones_usuarios1`
    FOREIGN KEY (`usuarios_idusuario`)
    REFERENCES `usuarios` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favs_canciones_canciones1`
    FOREIGN KEY (`canciones_idcancion`)
    REFERENCES `canciones` (`idcancion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE  `artistas_relacionados` (
  `idRelacion` INT NOT NULL,
  `artistas_idArtista_original` INT NOT NULL,
  `artistas_idArtista_relacionado` INT NOT NULL,
  PRIMARY KEY (`idRelacion`),
  INDEX `fk_artistas_relacionados_artistas1_idx` (`artistas_idArtista_original` ASC) VISIBLE,
  INDEX `fk_artistas_relacionados_artistas2_idx` (`artistas_idArtista_relacionado` ASC) VISIBLE,
  CONSTRAINT `fk_artistas_relacionados_artistas1`
    FOREIGN KEY (`artistas_idArtista_original`)
    REFERENCES `artistas` (`idArtista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artistas_relacionados_artistas2`
    FOREIGN KEY (`artistas_idArtista_relacionado`)
    REFERENCES `artistas` (`idArtista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

