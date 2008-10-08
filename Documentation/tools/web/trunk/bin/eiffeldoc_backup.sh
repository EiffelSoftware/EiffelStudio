#!/bin/sh

. `dirname $0`/etc/init_vars.sh

safemkdir()
{
  if [ ! -e "$1" ]; then
    echo "Creating $1"
    mkdir -p $1
  fi
}

DRUPALDIR=`pwd`/../drupal
if [ ! -e "$DRUPALDIR" ]; then
  echo "Folder to backup not found [$DRUPALDIR]"
  exit -1
fi

DT_YEAR=`eval date +%Y`
DT_WEEK=`eval date +%W`
DT_DATE=`eval date +%Y_%m_%d__%Hh%Mm`
DB_NAME=eiffeldoc

#BACKUP_FOLDER=`pwd`/backup
BACKUPDIR=$BACKUP_FOLDER/$DT_YEAR/week_$DT_WEEK/$DT_DATE
echo Backing up $DRUPALDIR into $BACKUPDIR

safemkdir $BACKUPDIR

/bin/tar -p -s -cjf $BACKUPDIR/files.tar.bz2 --exclude $DRUPALDIR/sites/default/files/isedoc/export $DRUPALDIR

DB_OPTIONS="-h localhost -u $DB_USER -p$DB_PASS"
(/usr/bin/mysqldump --flush-logs $DB_OPTIONS $DB_NAME | bzip2 -c) > $BACKUPDIR/$DB_NAME.sql.bz2

rm $BACKUP_FOLDER/latest
ln -f -s $BACKUPDIR $BACKUP_FOLDER/latest

echo "Backup completed ($BACKUPDIR/..)"
