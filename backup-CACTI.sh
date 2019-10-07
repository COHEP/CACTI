#!/bin/sh
#Backup cacti
BKPDIR=/root/bkp
DIA=`date +%Y-%m-%d`
HORA=`date +%H:%M`
LOGFILE=$BKPDIR/log/$DIA-cacti.log
MAILBODY=$BKPDIR/body.txt
MAILTO=gridlafex@cbpf.br
SENDER=gridlafex@cbpf.br


echo '*************************************************  ' > $LOGFILE
echo ' ' >> $LOGFILE
echo Script de backup iniciado `date` >> $LOGFILE
echo ' ' >> $LOGFILE
echo "*************************************  " >> $LOGFILE
echo "           $HOSTNAME                   " >> $LOGFILE
echo "         date:   $DIA                  " >> $LOGFILE
echo "*************************************  " >> $LOGFILE
echo "iniciando backup as $HORA do dia $DIA  " >> $LOGFILE

# Fazendo dump do banco
/usr/bin/mysqldump --defaults-extra-file=/root/Cacti-DoNotRemove/.my-root.cnf -u root --single-transaction --quick --lock-tables=false --all-databases > $BKPDIR/bkp-cacti.sql

# Compactando diretorio de HTML, RRD e dump do banco
/usr/bin/tar -cvzf $BKPDIR/$DIA-cacti.tar.gz /usr/share/cacti/ /var/lib/cacti/rra $BKPDIR/bkp-cacti.sql

# Apagando arquivo de dump
/bin/rm -rf $BKPDIR/bkp-cacti.sql

# Enviando arquivos de backup para Focus19
/usr/bin/rsync -avzP /root/bkp focus19::cacti

#mail -s "Backup CACTI em $DIA" $MAILTO -- -f $SENDER < $MAILBODY

echo '*************************************************' >> $LOGFILE
echo ' ' >> $LOGFILE
echo Script de backup finalizado em`date` >> $LOGFILE
echo ' ' >> $LOGFILE
echo '*************************************************' >> $LOGFILE

echo "Removendo backups mais antigos que 90 dias  ">> $LOGFILE
/bin/find $BKPDIR/ -mtime +90 -exec rm {} \;  >> $LOGFILE

echo '*************************************************' >> $LOGFILE
