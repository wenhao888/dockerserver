#!/usr/bin/env bash
current_dir=$(pwd)

if [ "$1" = "1" ]; then
  echo start to start 1 server
  sudo docker run  -d --name  wlin -v $current_dir/dbStore/data:/var/lib/mysql -p 3306:3306 -p 8080:8080  dockerserver  
  echo starting 1 server is finished

elif [ "$1" = "2" ]; then 
  echo start to start 2 servers
  sudo docker run  -d --name  wlin1 -v $current_dir/dbStore/data1:/var/lib/mysql -p 3306:3306 -p 8080:8080  dockerserver  
  sudo docker run  -d --name  wlin2 -v $current_dir/dbStore/data2:/var/lib/mysql -p 3307:3306 -p 8081:8080  dockerserver  
  echo starting 2 servers is finished

else 
   echo usage:  start 1 or start 2 
fi	