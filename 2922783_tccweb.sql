-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: fdb23.awardspace.net
-- Generation Time: 09-Jun-2019 às 00:41
-- Versão do servidor: 5.7.20-log
-- PHP Version: 5.5.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `2922783_tccweb`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `aux_fornecimento`
--

CREATE TABLE `aux_fornecimento` (
  `id` int(11) NOT NULL,
  `ultima_leitura` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tag` int(4) NOT NULL,
  `consumo_fornecimento` decimal(10,2) DEFAULT NULL,
  `obs` text,
  `link_enviar` varchar(30) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `aux_fornecimento`
--

INSERT INTO `aux_fornecimento` (`id`, `ultima_leitura`, `tag`, `consumo_fornecimento`, `obs`, `link_enviar`) VALUES
(1, '2019-05-20 00:23:45', 2265, 0.03, NULL, '77,0.03'),
(2, '2019-01-17 19:52:22', 36, 10.00, NULL, '2'),
(3, '2019-01-08 19:03:54', 30, 50.00, NULL, '0'),
(4, '2019-01-08 19:13:52', 41, 41.00, NULL, '0'),
(5, '2019-01-09 15:57:34', 53, 300.00, NULL, '0'),
(6, '2019-01-08 19:04:04', 60, 0.00, NULL, '0'),
(7, '2019-01-08 19:04:09', 70, 0.00, NULL, '0'),
(8, '2019-01-08 19:04:13', 80, 0.00, NULL, '0'),
(9, '2019-01-08 19:04:17', 90, 0.00, NULL, '0');

--
-- Acionadores `aux_fornecimento`
--
DELIMITER $$
CREATE TRIGGER `tr_aux_forn` AFTER UPDATE ON `aux_fornecimento` FOR EACH ROW BEGIN

set @var21 =0;
set @var22 =0;
set @var23=0;
set @var24 =0;
set @var25 =0;
set @var26 =0;
set @var27 =0;
set @var28 =0;
set @var29 =0;
set @var_c_30=0;
set @var_c_31=0;
set @var_c2_34=0;

set @var21 = (select fornecimento.id

from fornecimento inner join aux_fornecimento

on ((fornecimento.tag != aux_fornecimento.tag) && fornecimento.id = aux_fornecimento.id) GROUP BY id);



set @var22 =  (SELECT SUM(consumo_total) FROM pos where grupo=@var21);

set @var23 =  (SELECT SUM(consumo_total) FROM pre where grupo=@var21);

set @var24 = (select aux_fornecimento.consumo_fornecimento

from fornecimento inner join aux_fornecimento

on ((fornecimento.tag != aux_fornecimento.tag) && fornecimento.id = aux_fornecimento.id) GROUP BY consumo_fornecimento);

set @var_c_30 = (select fornecimento.consumo_fornecimento

from fornecimento inner join aux_fornecimento

on ((fornecimento.tag != aux_fornecimento.tag) && fornecimento.id = aux_fornecimento.id) GROUP BY consumo_fornecimento);

set @var_c_31 = @var_c_30 + @var24;


set @var25 = ( @var_c_31 - ( @var22 + @var23) );

set @var26 = (SELECT desvio_maximo FROM `fornecimento` WHERE id= @var21);

set @var27 = @var_c_31 * (@var26 /100);


if @var25 > @var27 then
		set @var28 ='desvio';
	
	else
		set  @var28 ='normal';

	end if;

set @var29 = (select aux_fornecimento.tag

from aux_fornecimento inner join fornecimento

on ((fornecimento.tag != aux_fornecimento.tag) && fornecimento.id = aux_fornecimento.id) GROUP BY tag);

set @var_c2_34= (select aux_fornecimento.link_enviar

from fornecimento inner join aux_fornecimento

on ((fornecimento.tag != aux_fornecimento.tag) && fornecimento.id = aux_fornecimento.id) GROUP BY link_enviar);




UPDATE fornecimento SET tag = @var29 , consumo_medido_pos = @var22 , consumo_medido_pre = @var23 , consumo_fornecimento = @var_c_31 , desvio_total = @var25 , estado_consumo = @var28 , link_enviar = @var_c2_34 WHERE (id = @var21);




end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `aux_pos`
--

CREATE TABLE `aux_pos` (
  `id` int(11) NOT NULL,
  `nome` varchar(30) DEFAULT NULL,
  `ultima_leitura` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pass_user` varchar(6) DEFAULT NULL,
  `obs` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `aux_pos`
--

INSERT INTO `aux_pos` (`id`, `nome`, `ultima_leitura`, `pass_user`, `obs`) VALUES
(1, 'user_pos1', '2019-01-03 00:31:50', '0101', NULL),
(2, 'user_pos1', '2019-01-03 00:31:50', '0202', NULL),
(3, 'user_pos1', '2019-01-03 00:31:50', '0303', NULL),
(4, 'user_pos1', '2019-01-03 00:31:50', '0404', NULL),
(5, 'user_pos1', '2019-01-03 00:31:50', '0505', NULL),
(6, 'user_pos1', '2019-01-03 00:31:50', '0606', NULL),
(7, 'user_pos1', '2019-01-03 00:31:50', '0707', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `aux_pre`
--

CREATE TABLE `aux_pre` (
  `id` int(11) NOT NULL,
  `tipo` varchar(5) NOT NULL,
  `ultima_leitura` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cre_key1` bigint(20) DEFAULT NULL,
  `consumo_kwh` decimal(10,0) DEFAULT NULL,
  `pass_user` varchar(6) DEFAULT NULL,
  `obs` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `aux_pre`
--

INSERT INTO `aux_pre` (`id`, `tipo`, `ultima_leitura`, `cre_key1`, `consumo_kwh`, `pass_user`, `obs`) VALUES
(1, 'pre', '2019-01-01 20:01:11', 4585, 0, '0101', NULL),
(2, 'pre', '2019-01-01 20:01:11', 20102, NULL, '0202', NULL),
(3, 'pre', '2019-01-01 20:01:11', 444444444444, NULL, '0303', NULL),
(4, 'pre', '2019-01-01 20:01:11', 0, NULL, '0404', NULL),
(5, 'pre', '2019-01-01 20:01:11', 55998866223345, NULL, '0505', NULL),
(6, 'pre', '2019-01-01 20:01:11', 813173976000400, NULL, '0606', NULL);

--
-- Acionadores `aux_pre`
--
DELIMITER $$
CREATE TRIGGER `tr_up_del` AFTER UPDATE ON `aux_pre` FOR EACH ROW BEGIN

set @var =0;
set @var2 =0;
set @var3=0;
set @var4 =0;
set @var5 =0;
set @var6 =0;


set @var =(select aux_pre.id

from controle_pre inner join aux_pre

on controle_pre.cre_key = aux_pre.cre_key1) ;





set @var2= (select controle_pre.inserir_c

from controle_pre inner join aux_pre

on controle_pre.cre_key = aux_pre.cre_key1) ;




set @var3 = (select pre.credito_atual from pre
where id = (select aux_pre.id

from controle_pre inner join aux_pre

on controle_pre.cre_key = aux_pre.cre_key1) ); 




set @var4 = @var3 + @var2;




set@var5 = (select controle_pre.id
from controle_pre inner join aux_pre
on controle_pre.cre_key = aux_pre.cre_key1) ;

set @var6 = (select aux_pre.cre_key1

from controle_pre inner join aux_pre

on controle_pre.cre_key = aux_pre.cre_key1) ;


UPDATE pre SET credito_atual = @var4 WHERE (id = @var);

UPDATE pre SET credito_in = @var6 WHERE pre.id = @var;

UPDATE controle_pre SET cre_key = null WHERE (id = @var5 );



end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `controle_pre`
--

CREATE TABLE `controle_pre` (
  `id` int(11) NOT NULL,
  `cre_key` bigint(20) DEFAULT NULL,
  `inserir_c` int(11) DEFAULT NULL,
  `obs` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `controle_pre`
--

INSERT INTO `controle_pre` (`id`, `cre_key`, `inserir_c`, `obs`) VALUES
(1, NULL, 100, ''),
(2, 22222222222, 200, ''),
(3, NULL, 300, ''),
(4, NULL, 400, ''),
(5, NULL, 500, ''),
(6, 44444444444, 1000, ''),
(7, NULL, 2500, ''),
(8, NULL, 5000, ''),
(9, 236901467610000, 10000, ''),
(10, NULL, 100, ''),
(11, 764332603500200, 200, ''),
(12, 211438797700300, 300, ''),
(13, 327302676800400, 400, ''),
(14, 578221004800500, 500, ''),
(15, 486159796701000, 1000, ''),
(16, 211847549502500, 2500, ''),
(17, 904347995405000, 5000, ''),
(18, 563799031710000, 10000, ''),
(19, NULL, 100, ''),
(20, NULL, 200, ''),
(21, 501069440300300, 300, ''),
(22, 579192390000400, 400, ''),
(23, 288646085500500, 500, ''),
(24, 137712729501000, 1000, ''),
(25, 243361312302500, 2500, ''),
(26, 883501067805000, 5000, ''),
(27, 515564384410000, 10000, ''),
(28, 437840735300100, 100, ''),
(29, 506651647500200, 200, ''),
(30, 803301753500300, 300, ''),
(31, 530817931300400, 400, ''),
(32, 625641271300500, 500, ''),
(33, 584909147101000, 1000, ''),
(34, 604656629602500, 2500, ''),
(35, 111627675305000, 5000, ''),
(36, 599615264410000, 10000, ''),
(37, 294034205300100, 100, ''),
(38, 599150094200200, 200, ''),
(39, 685269164300300, 300, ''),
(40, 160571402100400, 400, ''),
(41, 217718452200500, 500, ''),
(42, 428097045701000, 1000, ''),
(43, 963070984002500, 2500, ''),
(44, 786294635505000, 5000, ''),
(45, 518016743110000, 10000, ''),
(46, 105883034800100, 100, ''),
(47, 660440872200200, 200, ''),
(48, 769828025300300, 300, ''),
(49, 575161335700400, 400, ''),
(50, 593337483000500, 500, ''),
(51, 955388312601000, 1000, ''),
(52, 550911896802500, 2500, ''),
(53, 491557606205000, 5000, ''),
(54, 815108080610000, 10000, ''),
(55, 709985093200100, 100, ''),
(56, 477253185900200, 200, ''),
(57, 693436121800300, 300, ''),
(58, 931195551900400, 400, ''),
(59, 129303201600500, 500, ''),
(60, 542552012201000, 1000, ''),
(61, 990295966802500, 2500, ''),
(62, 622124544705000, 5000, ''),
(63, 660591615310000, 10000, ''),
(64, 961591042800100, 100, ''),
(65, 207059281600200, 200, ''),
(66, 849667759700300, 300, ''),
(67, 841801710800400, 400, ''),
(68, 559197690900500, 500, ''),
(69, 886767384701000, 1000, ''),
(70, 610606837402500, 2500, ''),
(71, 993043424005000, 5000, ''),
(72, 469517337910000, 10000, ''),
(73, 872683666300100, 100, ''),
(74, 409704841400200, 200, ''),
(75, 107151843100300, 300, ''),
(76, 364790383700400, 400, ''),
(77, 217828811200500, 500, ''),
(78, 539881848801000, 1000, ''),
(79, 436266777802500, 2500, ''),
(80, 758704417005000, 5000, ''),
(81, 437258978310000, 10000, ''),
(82, 272526235700100, 100, ''),
(83, 390175433600200, 200, ''),
(84, 658396865000300, 300, ''),
(85, 913808119400400, 400, ''),
(86, 728940833400500, 500, ''),
(87, 259141017801000, 1000, ''),
(88, 371312243402500, 2500, ''),
(89, 791549639505000, 5000, ''),
(90, 325114593010000, 10000, ''),
(91, 549037556900100, 100, ''),
(92, 908372305700200, 200, ''),
(93, 242894496800300, 300, ''),
(94, 356326599400400, 400, ''),
(95, 469834217100500, 500, ''),
(96, 763295969001000, 1000, ''),
(97, 375026172202500, 2500, ''),
(98, 615530857605000, 5000, ''),
(99, 849819644310000, 10000, ''),
(100, 889410142400100, 100, ''),
(101, NULL, 200, ''),
(102, 420036594500300, 300, ''),
(103, 357429999300400, 400, ''),
(104, 739920980000500, 500, ''),
(105, 423145365901000, 1000, ''),
(106, 354690403702500, 2500, ''),
(107, 400141487405000, 5000, ''),
(108, 385369761210000, 10000, ''),
(109, 988600752300100, 100, ''),
(110, 926582413500200, 200, ''),
(111, 735611275100300, 300, ''),
(112, 772875626400400, 400, ''),
(113, 873035110800500, 500, ''),
(114, 866241081801000, 1000, ''),
(115, 674098034802500, 2500, ''),
(116, 745772121405000, 5000, ''),
(117, 589096100810000, 10000, ''),
(118, 103346433800100, 100, ''),
(119, 973166394300200, 200, ''),
(120, 299372626500300, 300, ''),
(121, 668599258400400, 400, ''),
(122, 591183781700500, 500, ''),
(123, 225776499601000, 1000, ''),
(124, 508854450702500, 2500, ''),
(125, 892163209905000, 5000, ''),
(126, 953376300810000, 10000, ''),
(127, 321083629700100, 100, ''),
(128, 128629562800200, 200, ''),
(129, 331058316800300, 300, ''),
(130, 178875772300400, 400, ''),
(131, 113619354600500, 500, ''),
(132, 929074279001000, 1000, ''),
(133, 350660918702500, 2500, ''),
(134, 996757665205000, 5000, ''),
(135, 670999215910000, 10000, ''),
(136, 706119106700100, 100, ''),
(137, 385941655300200, 200, ''),
(138, 821057995500300, 300, ''),
(139, 182898995400400, 400, ''),
(140, 571953532000500, 500, ''),
(141, 888575503201000, 1000, ''),
(142, 667705874402500, 2500, ''),
(143, 904764865605000, 5000, ''),
(144, 710979795410000, 10000, ''),
(145, 262546644000100, 100, ''),
(146, 810546606700200, 200, ''),
(147, 778569548200300, 300, ''),
(148, 664153509400400, 400, ''),
(149, 850531837600500, 500, ''),
(150, 361517564501000, 1000, ''),
(151, 219900327702500, 2500, ''),
(152, 686977670705000, 5000, ''),
(153, 706880437710000, 10000, ''),
(154, NULL, 100, ''),
(155, 385761420300200, 200, ''),
(156, 811670978900300, 300, ''),
(157, 494669845900400, 400, ''),
(158, 450522042700500, 500, ''),
(159, 140696489901000, 1000, ''),
(160, 432409624302500, 2500, ''),
(161, 374100170305000, 5000, ''),
(162, 711007416610000, 10000, ''),
(163, NULL, 100, ''),
(164, NULL, 200, ''),
(165, NULL, 300, ''),
(166, NULL, 400, ''),
(167, NULL, 500, ''),
(168, NULL, 1000, ''),
(169, NULL, 2500, ''),
(170, NULL, 5000, '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `fornecimento`
--

CREATE TABLE `fornecimento` (
  `id` int(11) NOT NULL,
  `ultima_leitura` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tag` int(4) NOT NULL,
  `consumo_medido_pos` decimal(10,2) DEFAULT NULL,
  `consumo_medido_pre` decimal(10,2) DEFAULT NULL,
  `consumo_fornecimento` decimal(10,2) DEFAULT NULL,
  `desvio_total` decimal(10,2) DEFAULT '0.00',
  `desvio_maximo` tinyint(4) NOT NULL DEFAULT '30',
  `estado_consumo` char(10) DEFAULT NULL,
  `obs_geral` text,
  `grafico` text NOT NULL,
  `localizacao` text NOT NULL,
  `link_enviar` varchar(30) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `fornecimento`
--

INSERT INTO `fornecimento` (`id`, `ultima_leitura`, `tag`, `consumo_medido_pos`, `consumo_medido_pre`, `consumo_fornecimento`, `desvio_total`, `desvio_maximo`, `estado_consumo`, `obs_geral`, `grafico`, `localizacao`, `link_enviar`) VALUES
(1, '2019-05-20 00:23:45', 2265, 0.00, 412.25, 5190.22, 4777.97, 30, 'desvio', 'nenhuma', '<iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/679624/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15"></iframe>', '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d228.39208291327836!2d-46.53133079412272!3d-23.666181530750144!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x94ce42618c43f657%3A0xb4f6ec4c2965f22e!2zVGVsZWNvbXVuaWNhw6fDtWVzIGRlIFPDo28gUGF1bG8!5e0!3m2!1spt-BR!2sbr!4v1547920998904" width="400" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>', '77,0.03'),
(2, '2019-01-19 18:58:22', 36, 2.00, 2.00, 31123.00, 50.00, 30, 'normal', 'nenhuma', '<iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/679624/charts/2?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15"></iframe>', '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d456.77656805804355!2d-46.52834415435794!3d-23.66835594131514!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x94ce42637e16016b%3A0xa0b146e2b3d87e21!2sHospital+Santa+Helena!5e0!3m2!1spt-BR!2sbr!4v1547920814560" width="400" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>', '2'),
(3, '2019-01-19 18:57:40', 30, 500.00, 500.00, 0.00, 0.00, 30, 'normal', 'nenhuma', '<iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/679624/charts/3?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15"></iframe>', '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d913.5548788711632!2d-46.52664087080453!3d-23.66810657073991!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x94ce4264ac474ab9%3A0xa1013db6e9241886!2sAv.+Dr.+Erasmo%2C+39-13+-+Vila+Assun%C3%A7%C3%A3o%2C+Santo+Andr%C3%A9+-+SP%2C+09030-010!5e0!3m2!1spt-BR!2sbr!4v1547919235877" width="400" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>', '0');

-- --------------------------------------------------------

--
-- Estrutura da tabela `log_oper`
--

CREATE TABLE `log_oper` (
  `id` int(3) NOT NULL,
  `matricula_oper` int(3) NOT NULL,
  `id_user` int(3) NOT NULL,
  `data_oper` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obs` text CHARACTER SET utf8 NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `log_oper`
--

INSERT INTO `log_oper` (`id`, `matricula_oper`, `id_user`, `data_oper`, `obs`) VALUES
(61, 2, 1, '2019-04-29 15:05:28', 'manuntencao'),
(60, 2, 1, '2019-04-28 02:40:56', 'nada'),
(59, 5, 1, '2019-04-28 02:40:33', 'manuntencao'),
(58, 2, 1, '2019-04-28 02:39:44', 'manuntencao'),
(57, 6, 1, '2019-04-28 02:35:33', 'manuntencao'),
(56, 2, 1, '2019-04-28 02:25:44', 'manuntencao'),
(55, 5, 1, '2019-04-28 02:03:25', 'manuntencao'),
(54, 2, 1, '2019-04-28 02:00:38', 'manuntencao'),
(53, 3, 1, '2019-04-28 02:00:01', 'manuntencao'),
(52, 2, 1, '2019-04-28 01:52:03', 'nada'),
(51, 2, 1, '2019-04-28 01:50:23', 'manuntencao'),
(50, 1, 1, '2019-04-28 00:51:54', 'manuntencao'),
(49, 1, 1, '2019-04-28 00:11:44', 'manuntencao'),
(48, 1, 1, '2019-02-28 12:16:43', 'pagamento= nao'),
(47, 2, 3, '2019-02-18 15:41:17', 'pagamento= nao'),
(46, 6, 1, '2019-02-06 14:22:47', 'pagamento= desligado'),
(45, 2, 1, '2019-02-06 14:21:36', 'pagamento= sim'),
(44, 1, 2, '2019-01-26 22:18:06', 'nada'),
(62, 1, 1, '2019-05-04 18:31:48', 'x'),
(63, 1, 1, '2019-05-11 11:51:03', 'x'),
(64, 1, 1, '2019-05-11 11:52:05', 'x'),
(65, 1, 1, '2019-05-11 12:15:23', 'ligar'),
(66, 1, 1, '2019-05-11 12:23:16', 'ligar'),
(67, 1, 1, '2019-05-11 12:30:39', 'ligar'),
(68, 1, 1, '2019-05-11 12:41:25', 'ligar_usuario'),
(69, 1, 1, '2019-05-11 13:19:00', 'ligar'),
(70, 1, 1, '2019-05-11 13:19:31', 'ligar'),
(71, 1, 1, '2019-05-11 13:20:52', 'ligaleproso'),
(72, 1, 1, '2019-05-11 13:21:47', 'as'),
(73, 1, 1, '2019-05-11 13:34:57', 'liga'),
(74, 2, 1, '2019-05-11 13:43:40', 'ligar'),
(75, 1, 1, '2019-05-11 22:54:19', 'liga'),
(76, 1, 1, '2019-05-17 12:18:45', 'ligar'),
(77, 1, 1, '2019-05-17 12:23:15', 'manuntencao_finalizada'),
(78, 2, 1, '2019-05-17 12:39:41', 'ligar_1'),
(79, 1, 1, '2019-05-17 14:06:22', 'ligar'),
(80, 1, 1, '2019-05-17 14:07:18', 'ligar'),
(81, 1, 1, '2019-05-19 21:10:42', 'ligar'),
(82, 1, 1, '2019-05-19 21:15:03', 'ligar'),
(83, 1, 1, '2019-05-19 21:19:55', 'ligar');

-- --------------------------------------------------------

--
-- Estrutura da tabela `o&m`
--

CREATE TABLE `o&m` (
  `matricula` int(3) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `cargo` varchar(10) NOT NULL,
  `user_pass` varchar(6) NOT NULL,
  `obs` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `o&m`
--

INSERT INTO `o&m` (`matricula`, `nome`, `cargo`, `user_pass`, `obs`) VALUES
(1, 'tec_1', 'tecnico', '0101', NULL),
(2, 'tec_2', 'tecnico', '0202', NULL),
(3, 'tec_3', 'tecnico', '0303', NULL),
(4, 'tec_4', 'tecnico', '0404', NULL),
(5, 'oper_1', 'operador', '0505', NULL),
(6, 'oper_2', 'operador', '0606', NULL),
(7, 'oper_3', 'operador', '0707', NULL),
(8, 'oper_4', 'operador', '0808', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pos`
--

CREATE TABLE `pos` (
  `id` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `grupo` tinyint(4) NOT NULL DEFAULT '1',
  `ultima_leitura` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `consumo_total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `consumo_kwh` decimal(10,2) DEFAULT NULL,
  `pagamento` varchar(3) NOT NULL DEFAULT 'nao',
  `estado` varchar(10) DEFAULT 'ligado',
  `obs` text,
  `localizacao` text NOT NULL,
  `grafico` text NOT NULL,
  `link_enviar` varchar(30) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `pos`
--

INSERT INTO `pos` (`id`, `nome`, `grupo`, `ultima_leitura`, `consumo_total`, `consumo_kwh`, `pagamento`, `estado`, `obs`, `localizacao`, `grafico`, `link_enviar`) VALUES
(1, 'user_pos1', 1, '2019-01-03 00:27:21', 0.00, 0.00, 'nao', 'desligado', 'nada', '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3654.1849379100886!2d-46.5525013852042!3d-23.669343471473503!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x94ce42f8d3625d7b%3A0xa99932d2a8cdee12!2sR.+Tupi+-+Vila+Valparaiso%2C+Santo+Andr%C3%A9+-+SP%2C+09060-140!5e0!3m2!1spt-BR!2sbr!4v1547672922783" width="400" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>', '  <iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/679412/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15"></iframe>', '265,0.00'),
(2, 'user_pos1', 1, '2019-01-03 00:27:21', 0.00, 21.20, '0', '0', '0', '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3654.291332041822!2d-46.541840085204264!3d-23.665537371332316!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x94ce42f5cd942ccb%3A0xd1ba680ec4ce469b!2sR.+Mario+Barreto+-+Jardim+Bela+Vista%2C+Santo+Andr%C3%A9+-+SP%2C+09041-380!5e0!3m2!1spt-BR!2sbr!4v1547672097577" width="400" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>', '  <iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/679412/charts/2?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15"></iframe>', '0'),
(3, 'user_pos1', 1, '2019-01-03 00:27:21', 0.00, 30.31, 'nao', '0', '123 r', '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3654.283354648524!2d-46.539338985204225!3d-23.66582277134289!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x94ce42f56c957b4d%3A0xc78a85d93ecebbe5!2sR.+da+Fonte%2C+Santo+Andr%C3%A9+-+SP%2C+09040-270!5e0!3m2!1spt-BR!2sbr!4v1547672280382" width="400" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>', '  <iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/679412/charts/3?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15"></iframe>', '0'),
(4, 'user_pos1', 1, '2019-01-03 00:27:21', 0.00, 44.40, 'nao', '0', 'xx', '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3654.2141062828214!2d-46.54315438520423!3d-23.66830007143475!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x94ce42f602b0988d%3A0xf528911d2ead2777!2sR.+Tuiuti%2C+Santo+Andr%C3%A9+-+SP%2C+09041-420!5e0!3m2!1spt-BR!2sbr!4v1547672328483" width="400" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>', '  <iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/679412/charts/4?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15"></iframe>', '0'),
(5, 'user_pos1', 1, '2019-01-03 00:27:21', 0.00, 55.50, 'nao', '0', '0', '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3654.1717147388904!2d-46.55112008520406!3d-23.669816471491078!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x94ce42f8da4cf697%3A0xdba5469713307df4!2sR.+Rio+Preto%2C+S%C3%A3o+Paulo!5e0!3m2!1spt-BR!2sbr!4v1547672371494" width="400" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>', '  <iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/679412/charts/5?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15"></iframe>', '0');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pre`
--

CREATE TABLE `pre` (
  `id` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `grupo` tinyint(4) NOT NULL DEFAULT '1',
  `ultima_leitura` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `consumo_total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `consumo_kwh` decimal(10,2) DEFAULT NULL,
  `credito_atual` decimal(10,2) DEFAULT NULL,
  `cred_restante` decimal(10,0) GENERATED ALWAYS AS ((`credito_atual` - `consumo_total`)) STORED,
  `estado` varchar(10) DEFAULT 'ligado',
  `credito_in` bigint(20) DEFAULT NULL,
  `obs` text NOT NULL,
  `localizacao` text NOT NULL,
  `grafico` text NOT NULL,
  `link_enviar` varchar(30) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `pre`
--

INSERT INTO `pre` (`id`, `nome`, `grupo`, `ultima_leitura`, `consumo_total`, `consumo_kwh`, `credito_atual`, `cred_restante`, `estado`, `credito_in`, `obs`, `localizacao`, `grafico`, `link_enviar`) VALUES
(1, 'user_pre1', 1, '2019-05-20 19:02:33', 5.00, 0.00, 500.00, 495, 'desligado', 4585, 'porta_aberta', '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d913.6029159934367!2d-46.530727570804586!3d-23.661231970675527!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x94ce428969d35a6d%3A0x3db0c1884d864c21!2sSenac+Santo+Andr%C3%A9!5e0!3m2!1spt-BR!2sbr!4v1547655785054" width="400" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>', '<iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/595048/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15"></iframe>', '230,0.00'),
(2, 'user_pre2', 1, '2019-04-06 21:12:05', 0.00, 0.00, 200.00, 200, 'ligado', 20102, 'nada', '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d228.40239766965956!2d-46.52941261891258!3d-23.660276606473015!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x94ce42893ec77cff%3A0x3496b627efa7d48d!2sBar+E+Lanchonete+Hora+Extra!5e0!3m2!1spt-BR!2sbr!4v1547658047646" width="400" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>', '<iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/595048/charts/2?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15"></iframe>', ''),
(3, 'user_pre3', 1, '2019-05-14 14:16:21', 0.00, 0.00, 2500.00, 2500, 'ligado', 444444444444, 'nenhuma', '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d228.4018838256651!2d-46.52968620423216!3d-23.660570801394726!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x94ce42894042ba0b%3A0xd978f22c4b49707c!2sLava+Rapido+Dom!5e0!3m2!1spt-BR!2sbr!4v1547658147253" width="400" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>', '<iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/595048/charts/3?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15"></iframe>', ''),
(4, 'user_pre4', 1, '2019-02-19 23:38:55', 0.00, 0.00, 400.00, 400, 'ligado', 0, 'nenhuma', '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3654.333691207917!2d-46.53712248520431!3d-23.664021871276187!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x94ce428ada0bec0b%3A0x16827a7ef84c5d4c!2sR.+Santo+In%C3%A1cio+-+Vila+Bastos%2C+Santo+Andr%C3%A9+-+SP%2C+09040-240!5e0!3m2!1spt-BR!2sbr!4v1547658278104" width="600" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>', '<iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/595048/charts/4?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15"></iframe>', ''),
(5, 'user_pre5', 1, '2019-02-19 23:38:57', 0.00, 0.00, 0.00, 0, 'ligado', 55998866223345, 'testob5', '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3654.3103807063644!2d-46.54001108520439!3d-23.664855871307118!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x94ce42f506a2ba29%3A0xa96b84fa57a6311!2sR.+Bela+Vista+-+Jardim+Bela+Vista%2C+Santo+Andr%C3%A9+-+SP%2C+09041-360!5e0!3m2!1spt-BR!2sbr!4v1547658314863" width="400" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>', '<iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/595048/charts/5?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15"></iframe>', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aux_fornecimento`
--
ALTER TABLE `aux_fornecimento`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `aux_pos`
--
ALTER TABLE `aux_pos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `aux_pre`
--
ALTER TABLE `aux_pre`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `controle_pre`
--
ALTER TABLE `controle_pre`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cre_key` (`cre_key`);

--
-- Indexes for table `fornecimento`
--
ALTER TABLE `fornecimento`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_oper`
--
ALTER TABLE `log_oper`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `o&m`
--
ALTER TABLE `o&m`
  ADD PRIMARY KEY (`matricula`);

--
-- Indexes for table `pos`
--
ALTER TABLE `pos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pre`
--
ALTER TABLE `pre`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aux_fornecimento`
--
ALTER TABLE `aux_fornecimento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `aux_pos`
--
ALTER TABLE `aux_pos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `aux_pre`
--
ALTER TABLE `aux_pre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `controle_pre`
--
ALTER TABLE `controle_pre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=176;
--
-- AUTO_INCREMENT for table `fornecimento`
--
ALTER TABLE `fornecimento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `log_oper`
--
ALTER TABLE `log_oper`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;
--
-- AUTO_INCREMENT for table `o&m`
--
ALTER TABLE `o&m`
  MODIFY `matricula` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `pos`
--
ALTER TABLE `pos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `pre`
--
ALTER TABLE `pre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
