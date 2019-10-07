# Scripts CACTI

Coleção dos scripts utilizados no servidor cacti.cat.cbpf.br

## Getting Started

Siga as instruções para ter os scrips rodando no servidor

### Prerequisites

Server com o CACTI

### Installing
```
mkdir /root/scritps
cd /root/scritps
git clone ssh://git@gitlab.cern.ch:7999/esilvaju/CBPF-SE.git
```
## Scripts
```
backup-cacti.sh
restore-mysql.sh
```

### Backup CACTI
Realiza o backup do diretorio de HTML, RRD e dump do banco.

Está agendado na crontab da seguinte maneira:
```
0 0 */5 * * /root/scripts/backup-cacti.sh >/dev/null 2>&1
```
### Restore mysql
Verificar o conteudo do script para maiores informações



## Authors

* **Eraldo Jr** - *Initial work* -
