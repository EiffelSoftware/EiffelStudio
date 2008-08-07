#!/bin/sh

safemkdir()
{
  if [ ! -e "$1" ]; then
    echo "Creating $1"
    mkdir $1
  fi
}

CWD=`pwd`
DATE=`eval date +%Y%m%d_%H-%M`
DB_USER=root
DB_PASS=abc123
DB_NAME=eiffeldoc

safemkdir backup
cd backup
safemkdir $DATE

/bin/tar -p -s -czvf $DATE/files.tar.gz $CWD/../drupal

mysqldump -h localhost -u $DB_USER -p$DB_PASS -r$DATE/$DB_NAME.sql $DB_NAME

echo "Backup completed (backup/$DATE/..)"
