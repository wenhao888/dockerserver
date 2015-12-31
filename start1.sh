#!/usr/bin/env bash
sudo docker run  -d --name  wlin1  -v /home/wlin/work/dockerserver/data1:/var/lib/mysql -p 3306:3306 -p 8080:8080  dockerserver