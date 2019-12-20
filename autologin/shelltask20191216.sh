#!/bin/bash

#for line in `cat 11961.csv`
#do
#    echo $line
#done
myfile='/home/weblogic/shell/nofile.txt'
no=0
if [ ! -f $myfile ]; then
    echo $myfile" is not exist"
    #touch $myfiled
    echo $no > $myfile
else
    no=`cat $myfile`
fi
no=$(($no+1))
if [ $no -gt 11961 ]; then
  no=1
fi
echo `date +%F" "%T`
echo -n "No.${no} "
#line=`sed -n '100p' ./11961.csv`
#readLine $line

readLine(){
  line=$1
  array=(${line//,/ })
  index='0'
  comp=''
  pass=''
  ip='111.11.11.11'
  for var in ${array[@]}
  do
  #echo $index
    if [ $index == '1' ];then
      comp=$var
    fi
    if [ $index == '2' ];then
      pass=`echo $var|tr -d '/r'|tr -d ''`
      pass='abc123'
    fi
    if [ $index == '3' ];then
      ip=$var
    fi

    index=$(($index+1))
  done
  
  echo -n "${comp}/${pass}"
  #param="{\"loginType\": \"1\",\"loginIp\": \"111.111.111.111\", \"loginName\": \"\",\"userPassword\":\"\",\"source\": \"0\"}'"
 # para={"loginType": "1","loginIp": "11.11.1.1","loginName": "'$comp'","userPassword":"'$pass'","source": "0"}'
 #echo $para
  #curl -X POST -H 'Content-Type: application/json' -i 'http://192.168.40.149:7003/fta-sys-webapp/rest/v1/fta/system/public/login/userLoginOther' --data $para
  #echo "curl -X POST 'http://192.168.40.149:7003/fta-sys-webapp/rest/v1/fta/system/public/login/userLoginOther' -H 'Content-Type: application/json' -d ${param}"
  echo "curl -X POST 'http://192.168.101.20:7003/fta-sys-webapp/rest/v1/fta/system/public/login/userLoginOther' -H 'Content-Type: application/json' -d \"{\"loginType\": \"1\", \"loginIp\": \"${ip}\", \"loginName\": \"${comp}\", \"userPassword\": \"${pass}\", \"source\": \"0\" }\""
  curl -X POST 'http://192.168.101.20:7003/fta-sys-webapp/rest/v1/fta/system/public/login/userLoginOther' -H 'Content-Type: application/json' -d "{\"loginType\": \"1\", \"loginIp\": \"${ip}\", \"loginName\": \"${comp}\", \"userPassword\": \"${pass}\", \"source\": \"0\" }"
}

readFile(){
while read line
do
    #echo $line
    array=(${line//,/ })  
    index='0'
    for var in ${array[@]}
    do
      #echo $index
      if [ $index == '2' ];then
        comp=$var
      fi
      if [ $index == '3' ];then
        pass=$var
        pass='abc123'
      fi
      echo -n "${comp}\\{pass}"
      index=$(($index+1))
    done 
done < ./spider.csv
}

line=`sed -n "${no}p" /home/weblogic/shell/11961.csv`
echo -n 'line:'$line' --- '
readLine $line
echo $no> $myfile
