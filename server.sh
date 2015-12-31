#!/bin/bash
set -e

if [ ! -f "/var/lib/mysql/ibdata1" ]; then
    echo "mysql initialization start"

	usr/bin/mysql_install_db --user=mysql --defaults-file=/etc/my.cnf
	/usr/bin/mysqld_safe --defaults-file=/etc/my.cnf &

	sleep 3

	mysql -u root -e " \
  		SET PASSWORD = PASSWORD('mysql'); \
  		UPDATE mysql.user SET password = PASSWORD('mysql') WHERE user = 'root'; \
  		DELETE FROM mysql.user WHERE user = ''; \
  		GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'mysql' WITH GRANT OPTION; \
  		GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' IDENTIFIED BY 'repl'; \
  		GRANT ALL ON *.* TO 'fabric'@'%' IDENTIFIED BY 'fabric'; \
  		GRANT SELECT, SHOW DATABASES, SUPER, REPLICATION CLIENT, PROCESS ON *.* TO 'mem'@'%' IDENTIFIED BY 'mem'"

	/usr/bin/mysqladmin -u root -pmysql shutdown

	echo "mysql initialization finished"
fi	


exec ${CATALINA_HOME}/bin/catalina.sh run  &
exec mysqld_safe
