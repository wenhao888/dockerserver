#!/usr/bin/env bash
sudo docker run  -d --name  wlin2  -v /home/wlin/work/dockerserver/data2:/var/lib/mysql -p 3307:3306 -p 8081:8080  dockerserver
