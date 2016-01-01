#!/usr/bin/env bash
if [ "$1" = "1" ]; then
  echo start to clear 1 server
  rm -rf ./dbStore/data

  docker rm -f wlin
  docker rmi -f dockerserver 

  echo clearing 1 server is finished

elif [ "$1" = "2" ]; then 
  echo start to clear 2 servers
  rm -rf ./dbStore/data1
  rm -rf ./dbStore/data2
  
  docker rm -f wlin1
  docker rm -f wlin2
  docker rmi -f dockerserver 

  echo clearing 2 servers is finished

else 
   echo usage:  clear 1 or clear 2 
fi	
