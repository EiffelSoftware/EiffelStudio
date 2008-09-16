#!/bin/sh

CWD=`pwd`
. `dirname $0`/common.sh

#Get 3rd party
getsf3rd()
{
	MOD3RD=$1
	NAME3RD=$2
	ZIP3RD=$3
	UNZIPPED3RD=$4
	UNZIPCMD=$5

	DIR3RD=$EDOC_DRUPALDIR/sites/all/modules/$MOD3RD/$NAME3RD
	if [ ! -e "$ZIP3RD" ]; then
		echo "Downloading $ZIP3RD"
		wget http://downloads.sourceforge.net/$NAME3RD/$ZIP3RD?big_mirror=0
	fi
	echo Check existence of $DIR3RD ...
	if [ ! -e "$DIR3RD" ]; then
		echo Install $NAME3RD in module $MOD3RD ...
		echo unzipping: $UNZIPCMD $ZIP3RD  to  $UNZIPPED3RD ...
		$UNZIPCMD $ZIP3RD
		mv $UNZIPPED3RD $DIR3RD
	fi
}

safemkdir $EDOC_TMPDIR
cd $EDOC_TMPDIR
safemkdir modules
cd modules
safemkdir 3rd
cd 3rd

getsf3rd geshifilter geshi geshi-1.0.7.21.tar.gz geshi "tar xzvf"
getsf3rd fckeditor fckeditor FCKeditor_2.6.3.tar.gz fckeditor "tar xzvf"
getsf3rd print dompdf dompdf-0.5.1.tar.gz dompdf-0.5.1 "tar xzvf"
getsf3rd print tcpdf tcpdf_4_0_024.zip tcpdf "unzip"

cd $CWD
