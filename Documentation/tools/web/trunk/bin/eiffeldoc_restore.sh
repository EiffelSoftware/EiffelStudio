#!/bin/sh

safemkdir()
{
  if [ ! -e "$1" ]; then
    echo "Creating $1"
    mkdir $1
  fi
}

CWD=`pwd`
BACKUPDIR=$1
TARGETDIR=$2
TARGETDB=$3

DB_USER=root
DB_PASS=abc123
DB_NAME=eiffeldoc
DB_DOCUSER=eiffeldoc

exit_usage()
{
	echo Missing argument ...
	echo Usage: backup_folder target_folder target_database
	exit
}

if [ "$BACKUPDIR" = "" ]; then
	exit_usage "BACKUP_DIR"
	exit
fi
if [ "$TARGETDIR" = "" ]; then
	exit_usage "TARGETDIR"
	exit
fi
if [ "$TARGETDB" = "" ]; then
	exit_usage "TARGETDB"
	exit
fi

echo "Restore operation"
echo " - from          [$BACKUPDIR]"
echo " - into folder   [$TARGETDIR]"
echo " - into database [$TARGETDB]"
if [ "$TARGETDB" = "$DB_NAME" ]; then
	echo " !!! Warning: you are about to restore in live [$DB_NAME] database !!!"
fi
echo " -> Confirm? (y|n)"
read answer
if [ "$answer" != "y" ]; then
	echo ... Cancelled, bye bye
	exit
fi

if [ -e "$TARGETDIR" ]; then
	echo "Target directory will be overwritten, Continue (y|n)?"
	read answer
	if [ "$answer" != "y" ]; then
		echo "Cancelled by user"
		exit
	fi
	echo "Removing [$TARGETDIR]..."
	\rm -rf $TARGETDIR
fi
safemkdir $TARGETDIR
tar xzvf $BACKUPDIR/files.tar.gz -C $TARGETDIR

#replacethisin()
#{
#	$PART1=$1
#	$PART2=$2
#	$THEFILE=$3
#	echo $THEFILE
#	#sed -e 's|$PART1|$PART2|'< $THEFILE > $THEFILE.tmp 
#	#cat $THEFILE.tmp > $THEFILE
#	#rm $THEFILE.tmp
#}
#replacethisin "localhost/$DB_NAME" "localhost/$TARGETDB" "$TARGETDIR/drupal/sites/default/settings.php"

echo "Dropping DATABASE $TARGETDB (if exists)..."
echo "DROP DATABASE $TARGETDB;" | mysql -h localhost -u $DB_USER -p$DB_PASS

echo "Creating DATABASE $TARGETDB ..."
echo "CREATE DATABASE $TARGETDB;" | mysql -h localhost -u $DB_USER -p$DB_PASS

echo "Granting all privilege on DATABASE $TARGETDB for $DB_DOCUSER..."
echo "GRANT ALL PRIVILEGES ON $TARGETDB.* TO '$DB_DOCUSER'@localhost;" | mysql -h localhost -u $DB_USER -p$DB_PASS

echo "Load sql content into $TARGETDB"
mysql -h localhost -u $DB_USER -p$DB_PASS $TARGETDB < $BACKUPDIR/$DB_NAME.sql

echo "Backup ($BACKUPDIR) restored to ($TARGETDIR)"
echo ""
echo "Note: there are a few extra operations."

THEFILE=$TARGETDIR/drupal/sites/default/settings.php

if [ "$TARGETDB" != "$DB_NAME" ]; then
	echo " - $TARGETDIR/drupal/sites/default/settings.php  about the mysql database "
	echo " -> Do you want to let the script update the settings.php"
	echo "    to use [$TARGETDB] instead of [$DB_NAME] (y|n)?"
	read answer
	if [ "$answer" = "y" ]; then
		CMD="sed -e 's|localhost/$DB_NAME|localhost/$TARGETDB|' < $THEFILE > $THEFILE.tmp; cat $THEFILE.tmp > $THEFILE; rm $THEFILE.tmp"
		TMP=`eval "$CMD"`
	fi
fi


echo " - $TARGETDIR/drupal/sites/default/settings.php  about the site name "
echo " -> Do you want to set the site name with [$BACKUPDIR] (y|n)?"
read answer
if [ "$answer" = "y" ]; then
	echo "\$conf['site_name'] = '[$BACKUPDIR]';" >> $TARGETDIR/drupal/sites/default/settings.php
fi

echo " -> Don't forget to update the .htaccess file:"
echo " - $TARGETDIR/drupal/.htaccess  about RewriteBase if necessary"



