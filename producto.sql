-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-01-2020 a las 15:21:00
-- Versión del servidor: 10.1.32-MariaDB
-- Versión de PHP: 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `producto`
--
CREATE DATABASE IF NOT EXISTS `producto` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE `producto`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_editarProducto` (IN `pa_id_producto` INT, IN `pa_nombre_producto` VARCHAR(30), IN `pa_id_color` INT, IN `pa_id_talla` INT)  NO SQL
BEGIN
UPDATE producto SET
nombre_producto=pa_nombre_producto,
id_color=pa_id_color,
id_talla=pa_id_talla
WHERE id_producto=pa_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminarProducto` (IN `pa_id_producto` INT)  BEGIN 
DELETE FROM producto
WHERE id_producto=pa_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertarProducto` (IN `pa_nombre_producto` VARCHAR(30), IN `pa_id_color` INT, IN `pa_id_talla` INT)  NO SQL
BEGIN
INSERT INTO producto(nombre_producto,id_color,id_talla)
VALUES(pa_nombre_producto,pa_id_color,pa_id_talla);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_mostrarProductoId` (IN `pa_id_producto` INT)  BEGIN
SELECT*FROM producto
WHERE id_producto=pa_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_mostrarProductos` ()  BEGIN
SELECT p.id_producto,p.nombre_producto,c.nombre_color,t.nombre_talla
FROM producto p
INNER JOIN color c INNER JOIN talla t ON 
c.id_color=p.id_color AND t.id_talla=p.id_talla;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_mostrarProductos2` ()  BEGIN
SELECT p.id_producto,p.nomnre_producto,c.nombre_color,t.nombre_talla
FROM producto p
INNER JOIN color c INNER JOIN talla t ON
c.id_color=p.id_color AND t.id_talla=p.id_talla;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `color`
--

CREATE TABLE `color` (
  `id_color` int(11) NOT NULL,
  `nombre_color` varchar(20) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `color`
--

INSERT INTO `color` (`id_color`, `nombre_color`) VALUES
(1, 'morado'),
(2, 'Verde'),
(3, 'anaranjado'),
(4, 'amarillo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `nombre_producto` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `id_talla` int(11) NOT NULL,
  `id_color` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `nombre_producto`, `id_talla`, `id_color`) VALUES
(2, 'blusa', 5, 2),
(3, 'pantalon', 4, 2),
(11, 'ZZZZZZZZZ', 2, 2),
(12, 'ZZZZZZZZZ', 2, 2);

--
-- Disparadores `producto`
--
DELIMITER $$
CREATE TRIGGER `trigger_editarProducto` AFTER UPDATE ON `producto` FOR EACH ROW BEGIN
INSERT INTO trigger_producto(id_producto_trigger,nombre_producto_trigger,viejos_nombre_producto_trigger,id_color_trigger,viejos_id_color_trigger,id_talla_trigger,viejos_id_talla_trigger,usuario,fecha_hora,accion)
VALUES (new.id_producto,new.nombre_producto,old.nombre_producto,new.id_color,old.id_color,new.id_talla,old.id_talla,USER(),NOW(),'ACTUALIZAR');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_eliminarProducto` AFTER DELETE ON `producto` FOR EACH ROW BEGIN
INSERT INTO trigger_producto(id_producto_trigger,nombre_producto_trigger,id_color_trigger,id_talla_trigger,usuario,fecha_hora,accion)
VALUES (old.id_producto,old.nombre_producto,old.id_color,old.id_talla,USER(),NOW(),'ELIMINAR');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_insertarProducto` AFTER INSERT ON `producto` FOR EACH ROW BEGIN
INSERT INTO trigger_producto(id_producto_trigger,nombre_producto_trigger,id_color_trigger,id_talla_trigger,usuario,fecha_hora,accion)
VALUES (new.id_producto,new.nombre_producto,new.id_color,new.id_talla,USER(),NOW(),'INGRESAR');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `talla`
--

CREATE TABLE `talla` (
  `id_talla` int(11) NOT NULL,
  `nombre_talla` varchar(3) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `talla`
--

INSERT INTO `talla` (`id_talla`, `nombre_talla`) VALUES
(1, 'S'),
(2, 'M'),
(3, 'L'),
(4, 'XL'),
(5, 'XXL');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trigger_producto`
--

CREATE TABLE `trigger_producto` (
  `id_producto_trigger` int(11) NOT NULL,
  `nombre_producto_trigger` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `viejos_nombre_producto_trigger` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `id_color_trigger` int(11) NOT NULL,
  `viejos_id_color_trigger` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `id_talla_trigger` int(11) NOT NULL,
  `viejos_id_talla_trigger` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `usuario` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_hora` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `accion` varchar(15) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `trigger_producto`
--

INSERT INTO `trigger_producto` (`id_producto_trigger`, `nombre_producto_trigger`, `viejos_nombre_producto_trigger`, `id_color_trigger`, `viejos_id_color_trigger`, `id_talla_trigger`, `viejos_id_talla_trigger`, `usuario`, `fecha_hora`, `accion`) VALUES
(4, 'gorra', '', 1, '', 1, '', 'root@localhost', '2020-01-07 15:22:41', 'ELIMINAR'),
(1, 'camisa', '', 4, '', 1, '', 'root@localhost', '2020-01-07 15:23:38', 'ELIMINAR'),
(6, 'ffffff', '', 3, '', 2, '', 'root@localhost', '2020-01-07 16:23:04', 'INGRESAR'),
(8, 'ZZZZZZZZZ', '', 2, '', 2, '', 'root@localhost', '2020-01-07 16:23:22', 'INGRESAR'),
(9, 'ZZZZZZZZZ', '', 2, '', 2, '', 'root@localhost', '2020-01-07 16:23:23', 'INGRESAR'),
(10, 'ZZZZZZZZZ', '', 2, '', 2, '', 'root@localhost', '2020-01-07 16:23:23', 'INGRESAR'),
(11, 'ZZZZZZZZZ', '', 2, '', 2, '', 'root@localhost', '2020-01-07 16:23:24', 'INGRESAR'),
(12, 'ZZZZZZZZZ', '', 2, '', 2, '', 'root@localhost', '2020-01-07 16:23:24', 'INGRESAR'),
(13, 'ZZZZZZZZZ', '', 2, '', 2, '', 'root@localhost', '2020-01-07 16:23:24', 'INGRESAR'),
(14, 'ZZZZZZZZZ', '', 2, '', 2, '', 'root@localhost', '2020-01-07 16:23:24', 'INGRESAR'),
(14, 'ZZZZZZZZZ', '', 2, '', 2, '', 'root@localhost', '2020-01-07 16:24:22', 'ELIMINAR'),
(8, 'ZZZZZZZZZ', '', 2, '', 2, '', 'root@localhost', '2020-01-07 16:24:24', 'ELIMINAR'),
(6, 'ffffff', '', 3, '', 2, '', 'root@localhost', '2020-01-07 16:24:26', 'ELIMINAR'),
(15, 'ttttttk', '', 2, '', 2, '', 'root@localhost', '2020-01-07 16:24:38', 'INGRESAR'),
(16, 'ttttttk', '', 2, '', 3, '', 'root@localhost', '2020-01-07 16:25:13', 'INGRESAR'),
(13, 'ZZZZZZZZZ', '', 2, '', 2, '', 'root@localhost', '2020-01-07 16:25:31', 'ELIMINAR'),
(10, 'ZZZZZZZZZ', '', 2, '', 2, '', 'root@localhost', '2020-01-07 16:25:33', 'ELIMINAR'),
(9, 'ZZZZZZZZZ', '', 2, '', 2, '', 'root@localhost', '2020-01-07 16:25:35', 'ELIMINAR'),
(15, 'ttttttk', '', 2, '', 2, '', 'root@localhost', '2020-01-07 16:38:28', 'ELIMINAR'),
(17, 'prueba', '', 2, '', 3, '', 'root@localhost', '2020-01-07 16:38:38', 'INGRESAR'),
(17, 'prueba', 'prueba', 2, '2', 5, '3', 'root@localhost', '2020-01-07 16:41:28', 'ACTUALIZAR'),
(17, 'prueba', 'prueba', 2, '2', 2, '5', 'root@localhost', '2020-01-07 16:41:57', 'ACTUALIZAR'),
(17, 'prueba', '', 2, '', 2, '', 'root@localhost', '2020-01-08 08:09:07', 'ELIMINAR'),
(16, 'ttttttk', 'ttttttk', 2, '2', 5, '3', 'root@localhost', '2020-01-08 08:17:03', 'ACTUALIZAR'),
(16, 'ttttttk', '', 2, '', 5, '', 'root@localhost', '2020-01-08 08:17:57', 'ELIMINAR');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `color`
--
ALTER TABLE `color`
  ADD PRIMARY KEY (`id_color`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `producto_color` (`id_color`),
  ADD KEY `producto_talla` (`id_talla`);

--
-- Indices de la tabla `talla`
--
ALTER TABLE `talla`
  ADD PRIMARY KEY (`id_talla`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `color`
--
ALTER TABLE `color`
  MODIFY `id_color` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `talla`
--
ALTER TABLE `talla`
  MODIFY `id_talla` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_color` FOREIGN KEY (`id_color`) REFERENCES `color` (`id_color`),
  ADD CONSTRAINT `producto_talla` FOREIGN KEY (`id_talla`) REFERENCES `talla` (`id_talla`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
