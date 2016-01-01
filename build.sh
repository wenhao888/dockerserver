#!/usr/bin/env bash
if [ "$1" = "1" ]; then
  echo start to build 1 server
  rm -rf ./dbStore/data
  mkdir ./dbStore/data
  docker build -t dockerserver .
  echo building 1 server is finished

elif [ "$1" = "2" ]; then 
  echo start to build 2 servers
  rm -rf ./dbStore/data1
  rm -rf ./dbStore/data2
  mkdir ./dbStore/data1
  mkdir ./dbStore/data2
  docker build -t dockerserver .
  echo building 2 servers is finished

else 
   echo usage:  build 1 or build 2 
fi	