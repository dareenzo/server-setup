-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 08, 2014 at 05:33 PM
-- Server version: 5.5.32
-- PHP Version: 5.3.10-1ubuntu3.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mailserver`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Virtual Admins';

-- --------------------------------------------------------

--
-- Table structure for table `alias`
--

CREATE TABLE IF NOT EXISTS `alias` (
  `address` varchar(255) NOT NULL,
  `goto` text NOT NULL,
  `domain` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`address`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Virtual Aliases';

-- --------------------------------------------------------

--
-- Table structure for table `alias_domain`
--

CREATE TABLE IF NOT EXISTS `alias_domain` (
  `alias_domain` varchar(255) NOT NULL,
  `target_domain` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`alias_domain`),
  KEY `active` (`active`),
  KEY `target_domain` (`target_domain`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Domain Aliases';

-- --------------------------------------------------------

--
-- Table structure for table `config`
--

CREATE TABLE IF NOT EXISTS `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '',
  `value` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='PostfixAdmin settings' AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `domain`
--

CREATE TABLE IF NOT EXISTS `domain` (
  `domain` varchar(255) NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 NOT NULL,
  `aliases` int(10) NOT NULL DEFAULT '0',
  `mailboxes` int(10) NOT NULL DEFAULT '0',
  `maxquota` bigint(20) NOT NULL DEFAULT '0',
  `quota` bigint(20) NOT NULL DEFAULT '0',
  `transport` varchar(255) NOT NULL,
  `backupmx` tinyint(1) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`domain`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Virtual Domains';

-- --------------------------------------------------------

--
-- Table structure for table `domain_admins`
--

CREATE TABLE IF NOT EXISTS `domain_admins` (
  `username` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  KEY `username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Domain Admins';

-- --------------------------------------------------------

--
-- Table structure for table `fetchmail`
--

CREATE TABLE IF NOT EXISTS `fetchmail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mailbox` varchar(255) NOT NULL,
  `src_server` varchar(255) NOT NULL,
  `src_auth` enum('password','kerberos_v5','kerberos','kerberos_v4','gssapi','cram-md5','otp','ntlm','msn','ssh','any') DEFAULT NULL,
  `src_user` varchar(255) NOT NULL,
  `src_password` varchar(255) NOT NULL,
  `src_folder` varchar(255) NOT NULL,
  `poll_time` int(11) unsigned NOT NULL DEFAULT '10',
  `fetchall` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `keep` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `protocol` enum('POP3','IMAP','POP2','ETRN','AUTO') DEFAULT NULL,
  `usessl` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `extra_options` text,
  `returned_text` text,
  `mda` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE IF NOT EXISTS `log` (
  `timestamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `username` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `data` text NOT NULL,
  KEY `timestamp` (`timestamp`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Log';

-- --------------------------------------------------------

--
-- Table structure for table `mailbox`
--

CREATE TABLE IF NOT EXISTS `mailbox` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `maildir` varchar(255) NOT NULL,
  `quota` bigint(20) NOT NULL DEFAULT '0',
  `local_part` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Virtual Mailboxes';

-- --------------------------------------------------------

--
-- Table structure for table `quota`
--

CREATE TABLE IF NOT EXISTS `quota` (
  `username` varchar(255) NOT NULL,
  `path` varchar(100) NOT NULL,
  `current` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`username`,`path`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `quota2`
--

CREATE TABLE IF NOT EXISTS `quota2` (
  `username` varchar(100) NOT NULL,
  `bytes` bigint(20) NOT NULL DEFAULT '0',
  `messages` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vacation`
--

CREATE TABLE IF NOT EXISTS `vacation` (
  `email` varchar(255) NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8 NOT NULL,
  `body` text CHARACTER SET utf8 NOT NULL,
  `cache` text NOT NULL,
  `domain` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`email`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Postfix Admin - Virtual Vacation';

-- --------------------------------------------------------

--
-- Table structure for table `vacation_notification`
--

CREATE TABLE IF NOT EXISTS `vacation_notification` (
  `on_vacation` varchar(255) CHARACTER SET latin1 NOT NULL,
  `notified` varchar(255) CHARACTER SET latin1 NOT NULL,
  `notified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`on_vacation`,`notified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Postfix Admin - Virtual Vacation Notifications';

-- --------------------------------------------------------

--
-- Table structure for table `virtual_aliases`
--

CREATE TABLE IF NOT EXISTS `virtual_aliases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `source` varchar(100) NOT NULL,
  `destination` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `virtual_domains`
--

CREATE TABLE IF NOT EXISTS `virtual_domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Table structure for table `virtual_users`
--

CREATE TABLE IF NOT EXISTS `virtual_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `password` varchar(106) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `vacation_notification`
--
ALTER TABLE `vacation_notification`
  ADD CONSTRAINT `vacation_notification_pkey` FOREIGN KEY (`on_vacation`) REFERENCES `vacation` (`email`) ON DELETE CASCADE;

--
-- Constraints for table `virtual_aliases`
--
ALTER TABLE `virtual_aliases`
  ADD CONSTRAINT `virtual_aliases_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `virtual_domains` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `virtual_users`
--
ALTER TABLE `virtual_users`
  ADD CONSTRAINT `virtual_users_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `virtual_domains` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
