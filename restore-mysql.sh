#!/bin/sh
# Script de restore do banco de dados do CACTI
DIA=`date +%Y-%m-%d`
HORA=`date +%H:%M`
DIRRESTORE=/tmp/$DIA-restore
MYSQLDIR=/var/lib/mysql
LOGFILE=$DIRRESTORE/$DIA-restore.log

echo " Criando diretorio de restore"
mkdir $DIRRESTORE/

echo "Parando Mysql"
/bin/systemctl stop mariadb

echo " Copiando diretorio do banco para o /tmp"
/bin/cp -rp /var/lib/mysql/ $DIRRESTORE/

echo "Agora vc vai editar o arquivo /etc/my.cnf.d/server.cnf"
echo "Descomente as linhas:"
echo "#innodb_force_recovery = 1"
echo "#innodb_purge_threads = 0" 
echo "Pressione <Enter> para continuar "
read
/bin/vim /etc/my.cnf.d/server.cnf

 echo "Start no banco"
/bin/systemctl start mariadb 

echo "Fazendo um dump do BD"
/usr/bin/mysqldump --defaults-extra-file=/root/Cacti-DoNotRemove/.my-root.cnf -u root --single-transaction --quick --lock-tables=false --all-databases > $DIRRESTORE/bkp-cacti.sql

echo "Stop no banco"
/bin/systemctl stop mariadb

echo "Movendo REDOlog, INNODB e diretório CACTI para o diretorio temp por precaucao"
/bin/mv $MYSQLDIR/ibdata1 /tmp/ 
/bin/mv $MYSQLDIR/ib_logfile0 /tmp/ 
/bin/mv $MYSQLDIR/ib_logfile1 /tmp/ 
/bin/mv $MYSQLDIR/cacti /tmp/

echo "Agora vc vai editar o arquivo /etc/my.cnf.d/server.cnf"
echo "Comente as linhas:"
echo "#innodb_force_recovery = 2"
echo "#innodb_purge_threads = 0" 
echo "Pressione  <ENTER> para continuar..."
read
/bin/vim /etc/my.cnf.d/server.cnf

# Start no banco
/bin/systemctl start mariadb 

`/usr/bin cat  $DIRRESTORE/bkp-cacti.sql`
echo "/usr/bin/mysql  --defaults-extra-file=/root/Cacti-DoNotRemove/.my-root.cnf -u root < /root/bkp/root/bkp/bkp-cacti.sql"
