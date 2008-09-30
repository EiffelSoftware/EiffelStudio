#!/bin/sh

. `dirname $0`/etc/init_vars.sh

safemkdir()
{
  if [ ! -e "$1" ]; then
    echo "Creating $1"
    mkdir $1
  fi
}

CWD=`pwd`
DATE=`eval date +%Y%m%d_%H-%M`
DB_NAME=eiffeldoc

safemkdir backup
cd backup
safemkdir $DATE

/bin/tar -p -s -cjvf $DATE/files.tar.bz2 --exclude $CWD/../drupal/sites/default/files/isedoc/export $CWD/../drupal

mysqldump -h localhost -u $DB_USER -p$DB_PASS $DB_NAME | bzip2 -c > $DATE/$DB_NAME.sql.bz2

rm latest
ln -f -s $DATE latest

echo "Backup completed (backup/$DATE/..)"
