#!/bin/bash

. /home/isewww/dev/etc/default.rc


TMP_DIR=$1
if [ -z "$TMP_DIR" ]; then
	echo "Error: please provide as argument the temporary folder (for EIFGENs and so on)"
	exit
fi
if [ ! -d "$TMP_DIR" ]; then
	echo Error: temporary folder [$TMP_DIR] does not exist
	exit
fi
TMP_DIR=$TMP_DIR/static_doc
SVN_BRANCH=trunk
SVN_BRANCH=branches/Eiffel_17.05

\rm -rf $TMP_DIR/library
\rm -rf $TMP_DIR/contrib
#svn co https://svn.eiffel.com/eiffelstudio/branches/Eiffel_14.05/Src/library $TMP_DIR/library
svn co https://svn.eiffel.com/eiffelstudio/$SVN_BRANCH/Src/C_library $TMP_DIR/C_library
svn co https://svn.eiffel.com/eiffelstudio/$SVN_BRANCH/Src/library $TMP_DIR/library
svn co https://svn.eiffel.com/eiffelstudio/$SVN_BRANCH/Src/contrib/library $TMP_DIR/contrib/library
cp docs.css $ISE_EIFFEL/studio/filters/docs.css
cp docs.fil $ISE_EIFFEL/studio/filters/docs.fil

export ISE_LIBRARY=$TMP_DIR
export ISE_FILTERNAME=docs

\rm -rf $TMP_DIR/Documentation
\rm -rf $TMP_DIR/Documentation-safe
\rm -rf $TMP_DIR/Documentation-nonsafe

# Void-safe Version
echo Void-Safe version
ecb -config all_libs-safe.ecf -project_path $TMP_DIR -clean
ecb -config all_libs-safe.ecf -project_path $TMP_DIR -flatshort -filter $ISE_FILTERNAME -all
mv $TMP_DIR/Documentation $TMP_DIR/Documentation-safe
cp *.css $TMP_DIR/Documentation-safe
cp -rf images $TMP_DIR/Documentation-safe/.

# Non Void-Safe version
echo NON Void-Safe version
ecb -config all_libs.ecf -project_path $TMP_DIR -clean
ecb -config all_libs.ecf -project_path $TMP_DIR -flatshort -filter $ISE_FILTERNAME -all
mv $TMP_DIR/Documentation $TMP_DIR/Documentation-nonsafe
cp -rf $TMP_DIR/Documentation-nonsafe/com $TMP_DIR/Documentation-safe/com
cp -rf $TMP_DIR/Documentation-nonsafe/gobo $TMP_DIR/Documentation-safe/gobo
cp -rf $TMP_DIR/Documentation-nonsafe/gobo_extension $TMP_DIR/Documentation-safe/gobo_extension
cp $TMP_DIR/Documentation-nonsafe/*.html $TMP_DIR/Documentation-safe/.

export ISE_FILTERNAME=html-stylesheet
ecb -config all_libs.ecf -project_path $TMP_DIR -flatshort -filter $ISE_FILTERNAME -all
cp $TMP_DIR/Documentation/goto.html $TMP_DIR/Documentation-safe/goto.html

function fix_goto_html {
	left=$1
	right=$2
	echo sed -i "s/\\"$left/\\"$right/g" $TMP_FILE
	sed -i "s/\\"$left/\\"$right/g" $TMP_FILE
}

TMP_FILE=$TMP_DIR/Documentation-safe/goto.html
cp $TMP_FILE $TMP_FILE.bak
fix_goto_html elks\\\/ base\\\/
fix_goto_html ise\\\/ base\\\/
fix_goto_html dbms.*\\\/ store\\\/
fix_goto_html transfer\\\/ net\\\/
fix_goto_html abstract\\\/ net\\\/
fix_goto_html .*\\\/wel wel\\\/wel
fix_goto_html .*\\\/ev_ vision2\\\/ev_
fix_goto_html .*\\\/eg_ graph\\\/eg_
fix_goto_html .*\\\/editor_ editor\\\/editor_
fix_goto_html .*\\\/ecom_ com\\\/ecom_
fix_goto_html .*\\\/db_ store\\\/db_
fix_goto_html .*\\\/database_ store\\\/database_
fix_goto_html .*\\\/preference_ preferences\\\/preference_
fix_goto_html docking\\\/.*\\\/ docking\\\/

rm -rf output/_lib_docs
mv $TMP_DIR/Documentation-safe output/_lib_docs
\rm -rf $TMP_DIR/Documentation
\rm -rf $TMP_DIR/Documentation-safe
\rm -rf $TMP_DIR/Documentation-nonsafe
\rm -rf $TMP_DIR/EIFGENs
