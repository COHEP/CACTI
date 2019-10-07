# Scripts Zabbix

Coleção dos scripts utilizados no servidor zabbix.cat.cbpf.br

## Getting Started

Siga as instruções para ter os scrips rodando no servidor

### Prerequisites

Server com o Zabbix

### Installing
```
mkdir /root/scritps
cd /root/scritps
git clone ssh://git@gitlab.cern.ch:7999/esilvaju/CBPF-zabbix.git
```
## Scripts
```
backup-zabbix.sh
zabbix-mysql-dump.sh
```

### Backup Zabbix
Realiza o dump do banco e envia para focus19.

Está agendado na crontab da seguinte maneira:
```
0 0 */5 * * /root/scripts/backup-zabbix.sh >/dev/null 2>&1
```
### Restore mysql
Verificar o conteudo do script para maiores informações



## Authors

* **Eraldo Jr** - *Initial work* -
