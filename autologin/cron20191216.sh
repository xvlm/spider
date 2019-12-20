#!/bin/bash  
log=`date +%F`
count=15
for i in $(seq 15)
do
  sh /home/weblogic/shell/shelltask20191216.sh >> /home/weblogic/shell/$log
  sleep 2
done   
