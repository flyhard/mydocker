#!/bin/bash

# if you want to change the container name.
CONTAINERNAME=mariadbpersist

if ! $(sudo docker images $CONTAINERNAME | grep $CONTAINERNAME) ;
then
 echo "# Change group/user for mysql"
 MYSQLID=$(id -u mysql)
 MYSQLGRP=$(id -g mysql)
 echo "find / -group mysql -exec chgrp -h $MYSQLGRP {} \;" > chown.sh
 echo "find / -user mysql -exec chown -h $MYSQLID {} \;" >> chown.sh
 echo usermod -u $MYSQLID mysql >> chown.sh
 echo groupmod -g $MYSQLGRP mysql >> chown.sh
 echo usermod -g $MYSQLGRP mysql >> chown.sh
 # Ok, c'est moche, je ne comprends pas prkoi, mais bon..
 echo "mv /var/log/mysql /var/log/mysqlold" >> chown.sh
 echo "mv /var/log/mysqlold /var/log/mysql" >> chown.sh

 sudo docker build -t $CONTAINERNAME . || exit
 rm chown.sh
fi

CONTAINER_ID=$(sudo docker run -v=/var/lib/mysql:/var/lib/mysql -p=3306:3306 -d $CONTAINERNAME) || exit
PORT=$(sudo docker port $CONTAINER_ID 3306) || exit

echo
echo
echo "Runing on port $PORT"
echo "mysql -u root --port=$PORT"
echo
echo "Stop with :"
echo "sudo docker stop $CONTAINER_ID"
