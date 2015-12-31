#!/bin/bash
exec ${CATALINA_HOME}/bin/catalina.sh run  &
exec mysqld_safe
