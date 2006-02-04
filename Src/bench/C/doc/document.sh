#!/bin/bash

# Usage:
# sh document.sh . documentation_output.xml
# If a third argument `False' is provided then no `<doc>' tag is inserted in
# documentation_output.xml

# To quickly extract documentation from C files of the runtime. Documentation is defined
# as below in C files:
#/*
#doc:<file name="" header="" version="$Id$" summary="">
#*/
#/*
#doc:	<routine name="" return_type="" export="">
#doc:	<attribute name="" return_type="" export="">
#doc:		<summary></summary>
#doc:		<access></access>
#doc:		<indexing></indexing>
#doc:		<thread_safety></thread_safety>
#doc:		<synchronization></synchronization>
#doc:		<eiffel_classes></eiffel_classes>
#doc:		<param name="" type=""></param>
#doc:		<return></return>
#doc:		<exception></exception>
#doc:		<fixme></fixme>
#doc:	</attribute>
#*/
#/*
#doc:</file>
#*/

if [ "$3" != "False" ]; then
		# Remove previous documentation output file if it exists
	rm -rf $2
		# First call to Current. We need to insert `<doc>' tag
	echo "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>" >> $2
	echo "<?xml-stylesheet href=\"c_code.xsl\" type=\"text/xsl\"?>" >> $2
	echo "<doc name=\"Runtime - C code\" css=\"c_code.css\">" >> $2
fi

	# Display progress
echo "Entering" $1

	# Process all .c and .h files to extract documentation
for file in `ls $1/*.[ch] 2> /dev/null`; do
	grep "^doc:" $file | sed -e "s/^doc:/	/" >> $2
done

	# Recursion to subdirectories
for directory in `ls $1`; do
	if [ -d $1/$directory ]; then
		if [ "$directory" != ".svn" ]; then
			. document.sh $1/$directory $2 False
		fi
	fi
done

if [ "$3" != "False" ]; then
	echo "</doc>" >> $2
fi
