-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: cdnexus
-- ------------------------------------------------------
-- Server version	5.1.73-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_setting`
--

DROP TABLE IF EXISTS `account_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_setting` (
  `contact_id` int(11) NOT NULL,
  `2fa_key` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activityLog`
--

DROP TABLE IF EXISTS `activityLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activityLog` (
  `activity_log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` timestamp NULL DEFAULT NULL,
  `description` text COMMENT 'description of action ',
  `customer_id` int(10) unsigned DEFAULT NULL,
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'indicates who made the change.',
  `cnc_request_id` int(11) DEFAULT NULL COMMENT 'id of corresponding CNC request, if any',
  PRIMARY KEY (`activity_log_id`),
  KEY `fk_customer_id_idx` (`customer_id`),
  CONSTRAINT `fk_activityLog_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='history of changes to the system.\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing`
--

DROP TABLE IF EXISTS `billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing` (
  `billing_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_added` timestamp NULL DEFAULT NULL COMMENT 'date_',
  `description` varchar(150) DEFAULT NULL,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `status` tinyint(3) unsigned DEFAULT NULL COMMENT '0 - unpaid, 1 paid, ',
  `date_due` timestamp NULL DEFAULT NULL COMMENT 'when the bill is due\n',
  `date_paid` timestamp NULL DEFAULT NULL,
  `invoice` mediumblob,
  `invoice_number` varchar(20) DEFAULT NULL,
  `quickbooks_transaction_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`billing_id`),
  KEY `id_customer_id_idx` (`customer_id`),
  KEY `invoicenumber_index` (`invoice_number`),
  CONSTRAINT `id_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `certificate`
--

DROP TABLE IF EXISTS `certificate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificate` (
  `certificate_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `certificate_name` varchar(128) DEFAULT NULL,
  `comment` varchar(1024) DEFAULT NULL,
  `algorithm` varchar(16) DEFAULT NULL,
  `ssl_certificate` text,
  `ssl_key` text,
  `certificate_chain` text,
  `cnc_certificate_id` varchar(16) DEFAULT NULL,
  `date_added` timestamp NULL DEFAULT NULL,
  `date_deleted` timestamp NULL DEFAULT NULL,
  `certificate_hash` varchar(32) DEFAULT NULL,
  `common_names` text,
  `expiration_date` timestamp NULL DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL COMMENT '0-shared, 1-private',
  `ssl_key_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`certificate_id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16720 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cnameLabelMapping`
--

DROP TABLE IF EXISTS `cnameLabelMapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cnameLabelMapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(256) NOT NULL,
  `cname_label` varchar(256) NOT NULL,
  `service_type` varchar(20) NOT NULL,
  `service_areas` varchar(50) NOT NULL,
  `customer_id` int(10) NOT NULL,
  `cnc_certificate_id` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cname_UNIQUE` (`cname`)
) ENGINE=InnoDB AUTO_INCREMENT=39158 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cname_status`
--

DROP TABLE IF EXISTS `cname_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cname_status` (
  `domain_id` int(10) unsigned NOT NULL,
  `quantil_cname_status` tinyint(1) DEFAULT '0',
  `date_added` timestamp NULL DEFAULT NULL,
  `date_updated` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `configurationTemplates`
--

DROP TABLE IF EXISTS `configurationTemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configurationTemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `template_name` varchar(100) DEFAULT NULL,
  `xml` text COMMENT 'setting content of the version',
  `description` varchar(256) DEFAULT NULL COMMENT 'description of version',
  `date_added` timestamp NULL DEFAULT NULL,
  `service_type` varchar(45) DEFAULT NULL,
  `date_updated` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7571 DEFAULT CHARSET=utf8 COMMENT='configuration templates for domain settings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `configureSettings`
--

DROP TABLE IF EXISTS `configureSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configureSettings` (
  `setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `xml` longtext NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`setting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4403 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contacts` (
  `contact_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id of the contact\n',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'refers to entry in the customer table\n',
  `contact_type` tinyint(3) unsigned DEFAULT NULL COMMENT '1 super admin, 2 sales, 3 customer admin, 4 billing, 5 other',
  `login_name` varchar(64) DEFAULT NULL,
  `login_password` varchar(64) DEFAULT NULL,
  `permissions` int(10) unsigned DEFAULT NULL COMMENT 'bitwise OR of privileges ',
  `first_name` varchar(64) DEFAULT NULL,
  `middle_name` varchar(64) DEFAULT NULL,
  `last_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `phone_cell` varchar(45) DEFAULT NULL,
  `phone_office` varchar(45) DEFAULT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL COMMENT 'street  number and street\n',
  `street2` varchar(255) DEFAULT NULL COMMENT 'part 2 of a physical street address\n',
  `city` varchar(64) DEFAULT NULL,
  `state` varchar(64) DEFAULT NULL COMMENT 'state or province\n',
  `country` varchar(64) DEFAULT NULL,
  `postal_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `title` varchar(64) DEFAULT NULL,
  `date_added` timestamp NULL DEFAULT NULL COMMENT 'when the entry was inserted\n',
  `status` tinyint(3) unsigned DEFAULT NULL COMMENT '1 active, 0 disabled',
  `date_last_login` timestamp NULL DEFAULT NULL,
  `date_deleted` timestamp NULL DEFAULT NULL,
  `comment` text,
  `date_reset_password_attempt` timestamp NULL DEFAULT NULL,
  `reset_password_count` tinyint(4) DEFAULT NULL,
  `attempt_2fa_count` tinyint(4) DEFAULT NULL,
  `ip_white_list` varchar(1024) DEFAULT NULL,
  `locked` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`contact_id`),
  UNIQUE KEY `login_name_UNIQUE` (`login_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5074 DEFAULT CHARSET=utf8 COMMENT='tracks anybody who can log in.\n\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `csr`
--

DROP TABLE IF EXISTS `csr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csr` (
  `csr_id` int(10) NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `country` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `company` varchar(45) DEFAULT NULL,
  `department` varchar(45) DEFAULT NULL,
  `common_names` varchar(45) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `date_deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`csr_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `csr_template`
--

DROP TABLE IF EXISTS `csr_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csr_template` (
  `template_id` int(10) NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(45) NOT NULL,
  `name` varchar(255) NOT NULL,
  `country` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `company` varchar(45) DEFAULT NULL,
  `department` varchar(45) DEFAULT NULL,
  `common_names` varchar(45) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `template_id_UNIQUE` (`template_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customerConfigForm`
--

DROP TABLE IF EXISTS `customerConfigForm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customerConfigForm` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) NOT NULL,
  `service_type` varchar(20) DEFAULT NULL,
  `config_form_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_configforms` (`customer_id`,`service_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_feature`
--

DROP TABLE IF EXISTS `customer_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_feature` (
  `customer_feature_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `feature_id` int(11) NOT NULL,
  `date_added` timestamp NULL DEFAULT NULL,
  `description` text CHARACTER SET latin1 COMMENT 'description of transaction\n',
  `sales_people_id` int(10) unsigned DEFAULT NULL,
  `pricing_id` int(10) unsigned DEFAULT NULL COMMENT 'indicates the pricing applied to this feature\n',
  `setting` text CHARACTER SET latin1 COMMENT 'setting for the feature. could be parsed as number, string, or even xml depending on the feature',
  `date_expires` timestamp NULL DEFAULT NULL COMMENT 'when a feature expires if it has an expiration',
  `date_deleted` timestamp NULL DEFAULT NULL COMMENT 'when a feature was turned off',
  PRIMARY KEY (`customer_feature_id`),
  UNIQUE KEY `unique_index` (`customer_id`,`feature_id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_feature_region`
--

DROP TABLE IF EXISTS `customer_feature_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_feature_region` (
  `customer_feature_id` int(11) NOT NULL,
  `region_id` int(11) NOT NULL,
  `cloud_id` int(11) DEFAULT NULL,
  `date_added` timestamp NULL DEFAULT NULL,
  `date_updated` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`customer_feature_id`,`region_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_region`
--

DROP TABLE IF EXISTS `customer_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_region` (
  `customer_id` int(11) NOT NULL,
  `region_id` int(11) NOT NULL,
  `date_deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`,`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `customer_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(80) NOT NULL COMMENT 'descriptive name of customer\n',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'id of customer which "owns" this entry.  For reseller scenarios.',
  `customer_type` int(10) unsigned NOT NULL COMMENT 'read-only superadmin (2)\nsuperadmin(1)\nregular customer (0)\n',
  `login_name` varchar(64) DEFAULT NULL COMMENT 'used to log into the portal\n',
  `api_key` varchar(64) DEFAULT NULL COMMENT 'for use with the api\n',
  `street` varchar(64) DEFAULT NULL COMMENT 'street  number and street\n',
  `street2` varchar(64) DEFAULT NULL COMMENT 'part 2 of a physical street address\n',
  `city` varchar(64) DEFAULT NULL,
  `state` varchar(64) DEFAULT NULL COMMENT 'state or province\n',
  `country` varchar(64) DEFAULT NULL,
  `postal_code` varchar(64) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL COMMENT 'phone number for the customer',
  `date_added` timestamp NULL DEFAULT NULL COMMENT 'when added to the database',
  `sales_people_id` int(10) unsigned DEFAULT NULL COMMENT ' sales person responsible for this customer.  ',
  `billing_cycle` int(10) unsigned DEFAULT NULL COMMENT 'number of days between bills\n',
  `billing_penalty` decimal(4,2) DEFAULT NULL COMMENT 'percentage penalty for overdue bills\n',
  `date_deleted` timestamp NULL DEFAULT NULL,
  `status` tinyint(3) unsigned DEFAULT NULL COMMENT 'active 1, 0 inactive',
  `comment` text,
  `max_domains` int(10) unsigned DEFAULT NULL,
  `date_trial_start` timestamp NULL DEFAULT NULL,
  `date_trial_end` timestamp NULL DEFAULT NULL,
  `date_service_start` timestamp NULL DEFAULT NULL,
  `date_contract_signed` timestamp NULL DEFAULT NULL,
  `salesperson` varchar(64) DEFAULT NULL,
  `date_contract_renewed` timestamp NULL DEFAULT NULL,
  `date_contract_end` timestamp NULL DEFAULT NULL,
  `billing_email` text,
  `enable2FA` tinyint(1) DEFAULT NULL,
  `purchase_order` varchar(30) DEFAULT NULL,
  `payment_term` tinyint(4) DEFAULT '30',
  PRIMARY KEY (`customer_id`,`customer_type`),
  UNIQUE KEY `login_name_UNIQUE` (`login_name`),
  KEY `customer_name_UNIQUE` (`customer_name`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `customers_BINS` BEFORE INSERT ON `customers` FOR EACH ROW
SET NEW.date_added=NOW() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `domainDeploymentHistory`
--

DROP TABLE IF EXISTS `domainDeploymentHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domainDeploymentHistory` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `record_id` int(10) unsigned NOT NULL,
  `domain_id` int(10) unsigned NOT NULL,
  `cnc_request_id` varchar(40) NOT NULL,
  `contact_id` int(10) unsigned DEFAULT NULL,
  `xml` text NOT NULL,
  `comment` varchar(1000) DEFAULT NULL,
  `status` varchar(4) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `customer_id` int(10) unsigned NOT NULL,
  `configuration_changed` bit(1) DEFAULT NULL,
  `cnc_deploy_version` varchar(16) DEFAULT NULL,
  `cloud_id` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=93497 DEFAULT CHARSET=latin1 COMMENT='For Domain Deployment History Function';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `domainRules`
--

DROP TABLE IF EXISTS `domainRules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domainRules` (
  `domainRules_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fieldType` varchar(45) DEFAULT NULL COMMENT 'cache behavior, visit control, streaming',
  `xml` text,
  `domain_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`domainRules_id`),
  KEY `domain_id_idx` (`domain_id`),
  CONSTRAINT `fk_domainRules_domain_id` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`domain_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=445761 DEFAULT CHARSET=utf8 COMMENT='cache behavior, visit control, streaming';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `domain_extended_configs`
--

DROP TABLE IF EXISTS `domain_extended_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain_extended_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) unsigned NOT NULL,
  `extended_configs` text NOT NULL,
  `cnc_deploy_version` varchar(20) NOT NULL,
  `date_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `domain_group_links`
--

DROP TABLE IF EXISTS `domain_group_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain_group_links` (
  `domain_group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`domain_group_id`,`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `domain_groups`
--

DROP TABLE IF EXISTS `domain_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain_groups` (
  `domain_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_group_name` char(100) NOT NULL,
  `service_type` char(10) NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`domain_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1687 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `domain_region`
--

DROP TABLE IF EXISTS `domain_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain_region` (
  `domain_id` int(11) NOT NULL,
  `region_id` int(11) NOT NULL,
  `cloud_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`domain_id`,`region_id`),
  KEY `region_id` (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `domain_slave`
--

DROP TABLE IF EXISTS `domain_slave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain_slave` (
  `domain_id` int(11) NOT NULL,
  `cname` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `date_updated` timestamp NULL DEFAULT NULL COMMENT 'domain id in CNC system',
  `date_added` timestamp NULL DEFAULT NULL COMMENT 'domain id in CNC system',
  `date_deleted` timestamp NULL DEFAULT NULL,
  `cloud_service_status` tinyint(1) DEFAULT NULL,
  `cloud_certificate_id` varchar(16) DEFAULT NULL,
  `cloud_id` int(11) DEFAULT NULL,
  `cloud_domain_id` int(11) DEFAULT NULL,
  `cloud_deploy_version` varchar(16) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `backup_only` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `domain_stagingStatus`
--

DROP TABLE IF EXISTS `domain_stagingStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain_stagingStatus` (
  `serial_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `domain_name` varchar(255) NOT NULL,
  `cncDomain_id` varchar(64) DEFAULT NULL,
  `lastDeployed_configureId` bigint(20) DEFAULT NULL,
  `lastDeployed_serviceType` varchar(64) DEFAULT NULL,
  `last_dateDeleted` datetime DEFAULT NULL,
  PRIMARY KEY (`serial_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1510 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `domains`
--

DROP TABLE IF EXISTS `domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domains` (
  `domain_id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT 'internal id\n',
  `domain_name` varchar(255) NOT NULL COMMENT 'domain name up to 255 characters.',
  `status` varchar(20) DEFAULT NULL COMMENT 'in progress or deployed',
  `cnc_domain_id` varchar(30) DEFAULT NULL COMMENT 'domain id in CNC system',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'refers to entry in customer table\n',
  `comment` varchar(1000) DEFAULT NULL,
  `service_type` varchar(20) DEFAULT NULL COMMENT 'web, wsa,mobile,streaming,download',
  `cname` varchar(256) DEFAULT NULL COMMENT 'customer should cname their domain to this value. ',
  `group_id` int(10) unsigned DEFAULT NULL,
  `date_added` timestamp NULL DEFAULT NULL,
  `date_deleted` timestamp NULL DEFAULT NULL,
  `advanced_visit_control` tinyint(3) unsigned DEFAULT NULL,
  `cdn_service_status` tinyint(1) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `ssl_status` tinyint(1) DEFAULT NULL,
  `cnc_certificate_id` varchar(16) DEFAULT NULL,
  `cnc_deploy_version` varchar(16) DEFAULT NULL,
  `date_updated` timestamp NULL DEFAULT NULL,
  `date_last_request` timestamp NULL DEFAULT NULL,
  `cloud_id` int(11) DEFAULT '0',
  PRIMARY KEY (`domain_id`),
  KEY `fk_customer_id_idx` (`customer_id`),
  CONSTRAINT `` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=71238 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `domains_view4cnc`
--

DROP TABLE IF EXISTS `domains_view4cnc`;
/*!50001 DROP VIEW IF EXISTS `domains_view4cnc`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `domains_view4cnc` (
 `domain_id` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `customer_id` tinyint NOT NULL,
  `service_type` tinyint NOT NULL,
  `service_areas` tinyint NOT NULL,
  `customer_name` tinyint NOT NULL,
  `log_options` tinyint NOT NULL,
  `date_deleted` tinyint NOT NULL,
  `enabled` tinyint NOT NULL,
  `status` tinyint NOT NULL,
  `ssl_status` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `featureSubscriptions`
--

DROP TABLE IF EXISTS `featureSubscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `featureSubscriptions` (
  `featureSubscriptions_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) unsigned DEFAULT NULL COMMENT 'a specifc domain associated with the feature subscription',
  `feature_id` int(10) unsigned DEFAULT NULL,
  `feature2_ids` varchar(100) DEFAULT NULL,
  `date_added` timestamp NULL DEFAULT NULL,
  `description` text COMMENT 'description of transaction\n',
  `sales_people_id` int(10) unsigned DEFAULT NULL,
  `pricing_id` int(10) unsigned DEFAULT NULL COMMENT 'indicates the pricing applied to this feature\n',
  `customer_id` int(10) unsigned DEFAULT NULL,
  `setting` text COMMENT 'setting for the feature. could be parsed as number, string, or even xml depending on the feature',
  `date_expires` timestamp NULL DEFAULT NULL COMMENT 'when a feature expires if it has an expiration',
  `status` int(11) DEFAULT NULL COMMENT 'active(1), inactive(0), expired (2)',
  `date_deleted` timestamp NULL DEFAULT NULL COMMENT 'when a feature was turned off',
  `mobileApps_id` int(10) unsigned DEFAULT NULL COMMENT 'a specific mobile application associated with the subscription',
  PRIMARY KEY (`featureSubscriptions_id`),
  KEY `fk_feature_id_idx` (`feature_id`),
  KEY `fk_customer_id_idx` (`customer_id`),
  KEY `fk_search_id_idx` (`domain_id`,`feature_id`,`customer_id`,`mobileApps_id`),
  CONSTRAINT `fk_featureSubscriptions_feature_id` FOREIGN KEY (`feature_id`) REFERENCES `features` (`feature_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_featureSubscriptionts_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=319 DEFAULT CHARSET=utf8 COMMENT='identifies features used';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `features`
--

DROP TABLE IF EXISTS `features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `features` (
  `feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'name of feature\n',
  `feature_name` varchar(255) DEFAULT NULL,
  `setting` varchar(45) DEFAULT NULL COMMENT 'default setting',
  `pricing_id` int(11) DEFAULT NULL COMMENT 'row in pricing which defines default price for this feature',
  `description` text COMMENT 'description of the feature',
  `billing_code` varchar(50) DEFAULT NULL,
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `feature_name_UNIQUE` (`feature_name`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='options';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groupUserRole`
--

DROP TABLE IF EXISTS `groupUserRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupUserRole` (
  `group_id` int(10) unsigned NOT NULL,
  `contact_id` int(10) unsigned NOT NULL,
  `role_type` tinyint(3) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1732 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `default_role` tinyint(4) DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `customer_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1675 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ipAccessList`
--

DROP TABLE IF EXISTS `ipAccessList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipAccessList` (
  `ipAccessList_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'refers to the entry in customer table',
  `white_list` varchar(1024) DEFAULT NULL,
  `black_list` varchar(256) DEFAULT NULL COMMENT 'the black list of ip, its priority is higher than the white list',
  `enabled` tinyint(1) unsigned DEFAULT NULL COMMENT '0-disabled, 1-enabled',
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'the date when a record is inserted',
  PRIMARY KEY (`ipAccessList_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `ipAccessList_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_tasks`
--

DROP TABLE IF EXISTS `job_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_tasks` (
  `serial_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `task_id` bigint(20) unsigned NOT NULL,
  `task_name` varchar(255) NOT NULL,
  `task_status` varchar(64) NOT NULL,
  `info` varchar(1024) DEFAULT NULL,
  `job_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`serial_id`),
  KEY `FK_job_id_idx` (`job_id`),
  CONSTRAINT `FK_task_jobId` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `job_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `job_name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_event`
--

DROP TABLE IF EXISTS `log_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_event` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` varchar(40) DEFAULT NULL,
  `message` varchar(110) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `account_name` varchar(64) DEFAULT NULL,
  `date_added` timestamp NULL DEFAULT NULL,
  `result` tinyint(1) DEFAULT NULL,
  `original_customer_loginName` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=MyISAM AUTO_INCREMENT=50812 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_variable`
--

DROP TABLE IF EXISTS `log_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_variable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) DEFAULT NULL,
  `variable_name` varchar(40) DEFAULT NULL,
  `variable_value` varchar(1050) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=76421 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `maa_view4cnc`
--

DROP TABLE IF EXISTS `maa_view4cnc`;
/*!50001 DROP VIEW IF EXISTS `maa_view4cnc`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `maa_view4cnc` (
 `domain_id` tinyint NOT NULL,
  `domain_name` tinyint NOT NULL,
  `customer_id` tinyint NOT NULL,
  `service_type` tinyint NOT NULL,
  `service_areas` tinyint NOT NULL,
  `customer_name` tinyint NOT NULL,
  `log_options` tinyint NOT NULL,
  `date_deleted` tinyint NOT NULL,
  `enable` tinyint NOT NULL,
  `status` tinyint NOT NULL,
  `ssl_status` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `to_email` varchar(45) DEFAULT NULL,
  `from_email` varchar(45) DEFAULT NULL,
  `content` varchar(3000) DEFAULT NULL,
  `contact_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=MyISAM AUTO_INCREMENT=140 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobileAppConfigs`
--

DROP TABLE IF EXISTS `mobileAppConfigs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobileAppConfigs` (
  `mobileAppConfigs_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `fieldType` varchar(45) DEFAULT NULL,
  `xml` text,
  `mobileApps_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`mobileAppConfigs_id`),
  KEY `fk_mobileAppConfigs_mobileAppId_idx` (`mobileApps_id`),
  CONSTRAINT `fk_mobileAppConfigs_mobileAppId` FOREIGN KEY (`mobileApps_id`) REFERENCES `mobileApps` (`mobileApps_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=239483 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobileApps`
--

DROP TABLE IF EXISTS `mobileApps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobileApps` (
  `mobileApps_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `app_name` varchar(200) DEFAULT NULL COMMENT 'human readable name of the application',
  `platform` varchar(15) DEFAULT NULL COMMENT 'ios or android',
  `status` tinyint(4) DEFAULT NULL COMMENT 'in progress, register, integration, testing, deployed',
  `server_type` tinyint(4) DEFAULT NULL,
  `date_added` timestamp NULL DEFAULT NULL COMMENT 'when the entry was inserted into the table',
  `date_deleted` timestamp NULL DEFAULT NULL,
  `start_period` timestamp NULL DEFAULT NULL,
  `end_period` timestamp NULL DEFAULT NULL COMMENT 'used to specify expiration',
  `description` text,
  `package_name` varchar(300) DEFAULT NULL COMMENT 'for android, this is the java package name',
  `customer_id` int(10) unsigned DEFAULT NULL,
  `type` int(10) unsigned DEFAULT NULL COMMENT '1  daily news 2 entertrainment 3 social 4 reading 5 ecommerce 6 chat 7 music/video/pics 8 system 9 games 10 other',
  `fingerprintList` text COMMENT 'fingerprints for IOS',
  `cnc_app_id` varchar(32) DEFAULT NULL,
  `pseudo_domain` varchar(255) DEFAULT NULL,
  `pseudo_domain_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`mobileApps_id`),
  KEY `idx_customer` (`customer_id`),
  CONSTRAINT `idx_mobileApps_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21947 DEFAULT CHARSET=utf8 COMMENT='for tracking Mobile applications';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobileDebugDevices`
--

DROP TABLE IF EXISTS `mobileDebugDevices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobileDebugDevices` (
  `mobileDebugDevices_id` bigint(20) unsigned NOT NULL,
  `mobileApps_id` int(10) unsigned DEFAULT NULL COMMENT 'refers to entry in mobileApps',
  `serial` varchar(255) DEFAULT NULL COMMENT 'serial number of the device.',
  `mobileDebugDevices_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`mobileDebugDevices_id`),
  KEY `fk_mobileDebugDevices_app_id_idx` (`mobileApps_id`),
  CONSTRAINT `fk_mobileDebugDevices_app_id` FOREIGN KEY (`mobileApps_id`) REFERENCES `mobileApps` (`mobileApps_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='10 debugging devices are allowed for each Android app.\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobileReportUrls`
--

DROP TABLE IF EXISTS `mobileReportUrls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobileReportUrls` (
  `mobileReportUrls_id` int(10) unsigned NOT NULL,
  `domain_name` varchar(255) DEFAULT NULL,
  `url` text,
  `mobileApps_id` int(10) unsigned DEFAULT NULL COMMENT 'refers to a mobile app',
  PRIMARY KEY (`mobileReportUrls_id`),
  KEY `fk_mobileReportUrls_app_id_idx` (`mobileApps_id`),
  CONSTRAINT `fk_mobileReportUrls_app_id` FOREIGN KEY (`mobileApps_id`) REFERENCES `mobileApps` (`mobileApps_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='controls what to report on';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prefetchOperations`
--

DROP TABLE IF EXISTS `prefetchOperations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prefetchOperations` (
  `prefetch_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `prefetch_path` varchar(512) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `success_rate` decimal(6,3) unsigned DEFAULT NULL,
  `date_added` timestamp NULL DEFAULT NULL,
  `cnc_prefetch_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`prefetch_id`),
  KEY `customer_id_index` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=381 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prefetchQuota`
--

DROP TABLE IF EXISTS `prefetchQuota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prefetchQuota` (
  `prefetchQuota_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `url_quota` int(11) DEFAULT NULL,
  `date_added` timestamp NULL DEFAULT NULL,
  `date_deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`prefetchQuota_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pricing`
--

DROP TABLE IF EXISTS `pricing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pricing` (
  `pricing_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `feature_id` int(10) unsigned DEFAULT NULL,
  `base_price` decimal(8,2) DEFAULT NULL,
  `threshold1` int(11) DEFAULT NULL,
  `threshold1_price` decimal(12,6) unsigned DEFAULT NULL,
  `threshold2` int(11) DEFAULT NULL,
  `threshold2_price` decimal(12,6) unsigned DEFAULT NULL,
  `threshold3` int(11) DEFAULT NULL,
  `threshold3_price` decimal(12,6) unsigned DEFAULT NULL,
  `threshold4` int(11) DEFAULT NULL,
  `threshold4_price` decimal(12,6) unsigned DEFAULT NULL,
  `threshold5` int(11) DEFAULT NULL,
  `threshold5_price` decimal(12,6) unsigned DEFAULT NULL,
  `threshold6` int(10) unsigned DEFAULT NULL,
  `threshold6_price` decimal(12,6) unsigned DEFAULT NULL,
  `threshold7` int(11) DEFAULT NULL,
  `threshold7_price` decimal(12,6) unsigned DEFAULT NULL,
  `date_added` timestamp NULL DEFAULT NULL COMMENT 'when this pricing was inserted\n',
  `status` tinyint(4) DEFAULT NULL COMMENT 'active 1, 0 disabled',
  `threshold8` int(11) DEFAULT NULL,
  `threshold8_price` decimal(12,6) unsigned DEFAULT NULL,
  `pricing_type` tinyint(3) unsigned DEFAULT NULL COMMENT '0 fixed, 1 bandwidth, 2 volume, 3 hits per sec',
  `platform_fee` decimal(8,2) DEFAULT NULL,
  `service_fee` decimal(8,2) DEFAULT NULL,
  `comment` text COMMENT 'arbitrary text about the pricing model',
  `pricing_unit` varchar(20) DEFAULT NULL,
  `threshold1_price_fixed` tinyint(1) DEFAULT '0',
  `per_units` int(10) unsigned DEFAULT NULL,
  `time_range_start` varchar(5) DEFAULT NULL,
  `time_range_end` varchar(5) DEFAULT NULL,
  `regions` varchar(16) DEFAULT NULL,
  `https` tinyint(1) DEFAULT NULL,
  `quickbooks_item` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`pricing_id`),
  KEY `fk_customer_id_idx` (`customer_id`),
  KEY `fk_feature_id_idx` (`feature_id`),
  KEY `fk_pricing_unit_idx` (`pricing_unit`),
  CONSTRAINT `fk_pricing_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pricing_feature_id` FOREIGN KEY (`feature_id`) REFERENCES `features` (`feature_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pricing_unit` FOREIGN KEY (`pricing_unit`) REFERENCES `pricingUnits` (`unit`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COMMENT='Lists the price paid by each customer for each feature';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pricingUnits`
--

DROP TABLE IF EXISTS `pricingUnits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pricingUnits` (
  `unit` varchar(20) NOT NULL COMMENT 'unit of measurement',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`unit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='lists units of measurement. Referenced in pricing table.\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purgeCloudIds`
--

DROP TABLE IF EXISTS `purgeCloudIds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purgeCloudIds` (
  `purge_id` varchar(80) NOT NULL,
  `cloud_id` int(11) NOT NULL,
  `cloud_purgeId` varchar(80) NOT NULL,
  PRIMARY KEY (`cloud_id`,`cloud_purgeId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purgeOperations`
--

DROP TABLE IF EXISTS `purgeOperations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purgeOperations` (
  `purgeOperations_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `purge_path` varchar(512) DEFAULT NULL COMMENT 'list of files or directories to purge. Must include domain. \n',
  `purge_type` tinyint(3) unsigned DEFAULT NULL COMMENT '0 - file, 1 - directory\n',
  `status` varchar(20) DEFAULT NULL COMMENT '0 - wait, 1 - run, 2 - success, 3 - failure',
  `success_rate` decimal(6,3) unsigned DEFAULT NULL COMMENT 'success rate of the purge operation among our servers\n',
  `date_added` timestamp NULL DEFAULT NULL,
  `cnc_purge_id` varchar(80) DEFAULT NULL COMMENT 'purge id from request to CNC server. Used to check status',
  PRIMARY KEY (`purgeOperations_id`),
  KEY `fk_customer_id_idx` (`customer_id`),
  CONSTRAINT `fk_purgeOperations_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21194 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purgeQuota`
--

DROP TABLE IF EXISTS `purgeQuota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purgeQuota` (
  `purgeQuota_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'refers to the entry in customers table',
  `file_quota` int(10) unsigned DEFAULT NULL COMMENT 'the quota of times to purge files',
  `dir_quota` int(10) unsigned DEFAULT NULL COMMENT 'the quota of times to purge directories',
  `date_added` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'the date when a record is inserted',
  `date_deleted` timestamp NULL DEFAULT NULL COMMENT 'the date when a record is deleted',
  PRIMARY KEY (`purgeQuota_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `purgeQuota_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `region` (
  `region_id` int(11) NOT NULL,
  `display_name` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `region` varchar(45) CHARACTER SET latin1 NOT NULL,
  `date_updated` timestamp NULL DEFAULT NULL COMMENT 'domain id in CNC system',
  `date_added` timestamp NULL DEFAULT NULL,
  `date_deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`region_id`),
  UNIQUE KEY `region_UNIQUE` (`region`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportLogs`
--

DROP TABLE IF EXISTS `reportLogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportLogs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned NOT NULL,
  `startTime` datetime NOT NULL,
  `usedTime` int(11) NOT NULL,
  `requestUrl` text NOT NULL,
  `resultXml` text,
  `evaluated` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=37978 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `requestlogs`
--

DROP TABLE IF EXISTS `requestlogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `requestlogs` (
  `requestLog_id` int(10) NOT NULL AUTO_INCREMENT,
  `cnc_request_id` varchar(40) DEFAULT NULL,
  `ori_request_id` int(10) DEFAULT NULL,
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0',
  `client_ip` varchar(20) DEFAULT NULL,
  `request_auth` varchar(100) DEFAULT NULL,
  `request_head` varchar(2048) DEFAULT NULL,
  `request_url` varchar(255) DEFAULT NULL,
  `request_date` varchar(40) DEFAULT NULL,
  `request_method` varchar(20) DEFAULT NULL,
  `request_content` text,
  `request_time` timestamp NULL DEFAULT NULL,
  `requester` enum('client','apiserver') DEFAULT NULL,
  `response_code` varchar(20) DEFAULT NULL,
  `response_head` varchar(2048) DEFAULT NULL,
  `response_content` text,
  `response_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`requestLog_id`),
  KEY `fk_requestlogs_customer_id_idx` (`customer_id`),
  KEY `cnc_request_id_idx` (`cnc_request_id`),
  KEY `ori_request_id_idx` (`ori_request_id`)
) ENGINE=MyISAM AUTO_INCREMENT=23979220 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesPeople`
--

DROP TABLE IF EXISTS `salesPeople`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesPeople` (
  `sales_people_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_added` timestamp NULL DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '1 active, 0 inactive',
  `salesperson` varchar(64) DEFAULT NULL,
  `initials` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`sales_people_id`),
  KEY `salesperson_index` (`salesperson`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sslCsr`
--

DROP TABLE IF EXISTS `sslCsr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sslCsr` (
  `ssl_key_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `comment` varchar(200) DEFAULT NULL,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `csr_file` text,
  `ssl_key` text,
  `date_added` timestamp NULL DEFAULT NULL,
  `date_deleted` timestamp NULL DEFAULT NULL,
  `csr_content` text,
  PRIMARY KEY (`ssl_key_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6447 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sslShared`
--

DROP TABLE IF EXISTS `sslShared`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sslShared` (
  `ssl_shared_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `certificate_id` int(10) unsigned DEFAULT NULL,
  `domain_id` int(10) unsigned DEFAULT NULL,
  `domain_name` varchar(255) DEFAULT NULL,
  `date_added` timestamp NULL DEFAULT NULL,
  `date_deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ssl_shared_id`)
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stagingConfigure_targetDomain_status`
--

DROP TABLE IF EXISTS `stagingConfigure_targetDomain_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stagingConfigure_targetDomain_status` (
  `serial_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `configure_id` bigint(20) unsigned NOT NULL,
  `domain_name` varchar(255) NOT NULL,
  `c_name` varchar(255) DEFAULT NULL,
  `cncStagingRequest_id` varchar(64) DEFAULT NULL,
  `lastStaging_status` varchar(64) DEFAULT NULL,
  `lastStaging_info` varchar(255) DEFAULT NULL,
  `lastDeploy_status` varchar(64) DEFAULT NULL,
  `lastDeploy_info` varchar(255) DEFAULT NULL,
  `cncDeployRequest_id` varchar(64) DEFAULT NULL,
  `resolved_cName` varchar(255) DEFAULT NULL,
  `prod_domain_id` int(11) DEFAULT NULL,
  `testing_active` bit(1) DEFAULT NULL,
  `prod_cloud_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`serial_id`),
  KEY `FK_configure_id_idx` (`configure_id`),
  CONSTRAINT `FK_targetDomains_configureId` FOREIGN KEY (`configure_id`) REFERENCES `stagingConfigures` (`configure_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4487 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stagingConfigure_targets`
--

DROP TABLE IF EXISTS `stagingConfigure_targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stagingConfigure_targets` (
  `serial_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `configure_id` bigint(20) unsigned NOT NULL,
  `target_type` varchar(64) NOT NULL,
  `target_name` varchar(255) DEFAULT NULL,
  `date_snapshot` timestamp NULL DEFAULT NULL,
  `snapshot_fingerprint` text,
  `target_id` bigint(20) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`serial_id`),
  KEY `FK_stagingtarget_configureId` (`configure_id`),
  CONSTRAINT `FK_stagingtarget_configureId` FOREIGN KEY (`configure_id`) REFERENCES `stagingConfigures` (`configure_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3543 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stagingConfigures`
--

DROP TABLE IF EXISTS `stagingConfigures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stagingConfigures` (
  `configure_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `configure_name` varchar(255) NOT NULL,
  `service_type` varchar(64) NOT NULL,
  `setting_id` bigint(20) unsigned NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_updated` timestamp NULL DEFAULT NULL,
  `date_deleted` timestamp NULL DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `date_lastStaging` timestamp NULL DEFAULT NULL,
  `lastStaging_info` varchar(255) DEFAULT NULL,
  `date_lastDeployed` timestamp NULL DEFAULT NULL,
  `lastDeploy_info` varchar(255) DEFAULT NULL,
  `configure_status` varchar(64) DEFAULT NULL,
  `status_info` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`configure_id`),
  UNIQUE KEY `id_UNIQUE` (`configure_id`),
  KEY `FK_customer_id_idx` (`customer_id`),
  KEY `FK_staggingConfigures_settingId` (`setting_id`),
  CONSTRAINT `FK_staggingConfigures_customerId` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_staggingConfigures_settingId` FOREIGN KEY (`setting_id`) REFERENCES `configureSettings` (`setting_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3972 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_settings`
--

DROP TABLE IF EXISTS `user_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_settings` (
  `contact_id` int(10) unsigned NOT NULL DEFAULT '0',
  `s_key` char(20) NOT NULL DEFAULT '',
  `s_value` char(200) DEFAULT NULL,
  `s_text` text,
  PRIMARY KEY (`contact_id`,`s_key`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `domains_view4cnc`
--

/*!50001 DROP TABLE IF EXISTS `domains_view4cnc`*/;
/*!50001 DROP VIEW IF EXISTS `domains_view4cnc`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`mileweb`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `domains_view4cnc` AS (select `domains`.`domain_id` AS `domain_id`,`domains`.`domain_name` AS `domain_name`,`domains`.`customer_id` AS `customer_id`,`domains`.`service_type` AS `service_type`,replace(replace((select `domainRules`.`xml` from `domainRules` where ((`domainRules`.`domain_id` = `domains`.`domain_id`) and (`domainRules`.`fieldType` = 'service-areas')) limit 1),'<service-areas>',''),'</service-areas>','') AS `service_areas`,(select `customers`.`customer_name` from `customers` where (`customers`.`customer_id` = `domains`.`customer_id`) limit 1) AS `customer_name`,(select `domainRules`.`xml` from `domainRules` where ((`domainRules`.`domain_id` = `domains`.`domain_id`) and (`domainRules`.`fieldType` = 'log-option')) limit 1) AS `log_options`,`domains`.`date_deleted` AS `date_deleted`,`domains`.`enabled` AS `enabled`,`domains`.`status` AS `status`,`domains`.`ssl_status` AS `ssl_status` from `domains`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `maa_view4cnc`
--

/*!50001 DROP TABLE IF EXISTS `maa_view4cnc`*/;
/*!50001 DROP VIEW IF EXISTS `maa_view4cnc`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`mileweb`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `maa_view4cnc` AS (select `m`.`pseudo_domain_id` AS `domain_id`,`m`.`pseudo_domain` AS `domain_name`,`m`.`customer_id` AS `customer_id`,'maasdk' AS `service_type`,'cn;hk;ov' AS `service_areas`,(select `customers`.`customer_name` from `customers` where (`customers`.`customer_id` = `m`.`customer_id`)) AS `customer_name`,'' AS `log_options`,`m`.`date_deleted` AS `date_deleted`,1 AS `enable`,`m`.`status` AS `status`,0 AS `ssl_status` from `mobileApps` `m`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-31 23:01:49
