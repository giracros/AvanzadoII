-- phpMyAdmin SQL Dump
-- version 4.5.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: May 24, 2016 at 02:19 AM
-- Server version: 5.5.42
-- PHP Version: 7.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `Final`
--

-- --------------------------------------------------------

--
-- Table structure for table `Nomina`
--

CREATE TABLE `Nomina` (
  `Cedula` char(20) NOT NULL COMMENT 'Cedula del Empleado',
  `Empleado` char(20) NOT NULL COMMENT 'Nombre del Empleado',
  `SalarioMensual` float NOT NULL,
  `DiasTrabajados` float NOT NULL,
  `Basico` float DEFAULT NULL COMMENT AS `básico = regla de 3 que se calcula según los días trabajados`,
  `AuxilioTransporte` float DEFAULT NULL COMMENT AS `auxiliotransporte = se pagan 77700 mensuales a los empleados que ganan menos de dos salarios minimos (un minimo es 689454), este pago es proporcional a los días trabajados`,
  `TotalDevengado` float DEFAULT NULL COMMENT AS `totaldevengado = básico + auxilio`,
  `Eps` float DEFAULT NULL COMMENT AS `eps = 4% del básico`,
  `Pension` float DEFAULT NULL COMMENT AS `pension = 5% del básico`,
  `NetoPagado` float DEFAULT NULL COMMENT AS `netopagado = totaldevengado - totaldeducido`,
  `TotalDeducido` float DEFAULT NULL COMMENT AS `totaldeducido = eps + pension`
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla de la nomina de los empleados de la universidad';

--
-- Dumping data for table `Nomina`
--

INSERT INTO `Nomina` (`Cedula`, `Empleado`, `SalarioMensual`, `DiasTrabajados`, `Basico`, `AuxilioTransporte`, `TotalDevengado`, `Eps`, `Pension`, `NetoPagado`, `TotalDeducido`) VALUES
('019283', 'Guillermina', 3450000, 30, 3450000, 0, NULL, 138000, 172500, NULL, 310500),
('1018436098', 'Daniel Fuentes', 5000000, 30, 5000000, 0, NULL, 200000, 250000, NULL, 450000),
('1018436197', 'Cesar Pineda', 2700000, 30, 2700000, 0, 2700000, 108000, 135000, 2457000, 243000),
('11289', 'Sebastian', 7500000, 0, 0, 0, NULL, 0, 0, NULL, 0),
('12312', 'Absurdo', 450000000000, 30, 450000000000, 0, 450000000000, 18000000000, 22500000000, 409500000000, 40500000000),
('12345', 'rolo', 5000000000, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('1239', 'MateoRuby', 700000, 30, 700000, 77700, 777700, 28000, 35000, 714700, 63000),
('12828', 'Poncho', 450000, 10, 150000, 0, NULL, 6000, 7500, NULL, 13500),
('1912', 'Sebastian', 7500000, 30, 7500000, 0, NULL, 300000, 375000, NULL, 675000),
('1922', 'Vannesa', 4500000, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('19288382', 'Camila', 800000, 30, 800000, 0, NULL, 32000, 40000, NULL, 72000),
('234', 'Ardemiro', 250000, 30, 250000, 77700, NULL, 10000, 12500, NULL, 22500),
('345', 'Camila', 450000, 25, 375000, 0, NULL, 15000, 18750, NULL, 33750),
('34894', 'Raul', 560000, 30, 560000, 77700, 637700, 22400, 28000, 587300, 50400),
('82398', 'Rosalba', 325000, 29, 314167, 0, NULL, 12566.7, 15708.3, NULL, 28275);

--
-- Triggers `Nomina`
--
DELIMITER $$
CREATE TRIGGER `Tr_Calculo` BEFORE INSERT ON `Nomina` FOR EACH ROW BEGIN
	
	declare  salarioMinimo INT;
	set salarioMinimo  = 689454;
   SET new.Basico = ((new.DiasTrabajados * new.SalarioMensual) / 30);
   SET new.TotalDevengado = (new.Basico + new.AuxilioTransporte);
   SET new.Eps = (new.Basico * 0.04);
   SET new.Pension = (new.Basico * 0.05);
   SET new.TotalDeducido = (new.Eps + new.Pension);


   IF (new.SalarioMensual < salarioMinimo*2)
   THEN
      SET new.AuxilioTransporte = ((77700 * new.DiasTrabajados) / 30);
   ELSE
      SET new.AuxilioTransporte = 0;
   END IF;
   
   SET new.TotalDevengado = (new.Basico + new.AuxilioTransporte);
   SET new.NetoPagado = (new.TotalDevengado - new.TotalDeducido);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Tr_CalculoUpdate` BEFORE UPDATE ON `Nomina` FOR EACH ROW BEGIN
   DECLARE salarioMinimo   INT;
   SET salarioMinimo = 689454;
   SET new.Basico = ((new.DiasTrabajados * new.SalarioMensual) / 30);
   SET new.TotalDevengado = (new.Basico + new.AuxilioTransporte);
   SET new.Eps = (new.Basico * 0.04);
   SET new.Pension = (new.Basico * 0.05);
   SET new.TotalDeducido = (new.Eps + new.Pension);


   IF (new.SalarioMensual < salarioMinimo * 2)
   THEN
      SET new.AuxilioTransporte = ((77700 * new.DiasTrabajados) / 30);
   ELSE
      SET new.AuxilioTransporte = 0;
   END IF;

   SET new.TotalDevengado = (new.Basico + new.AuxilioTransporte);
   SET new.NetoPagado = (new.TotalDevengado - new.TotalDeducido);
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Nomina`
--
ALTER TABLE `Nomina`
  ADD PRIMARY KEY (`Cedula`);
