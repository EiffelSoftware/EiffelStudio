#! /bin/sh

# Creates directory structure for precompilation of all libraries for
# all platforms and copies the ace files to correct places.

create_one_platform()
{
    mkdir -p $1/$2/base
    mkdir -p $1/$2/lex
    mkdir -p $1/$2/mel
    mkdir -p $1/$2/net
    mkdir -p $1/$2/parse
    mkdir -p $1/$2/vision

    cp $1/template/base/Ace.ace $1/$2/base
    cp $1/template/lex/Ace.ace $1/$2/lex
    cp $1/template/mel/Ace.ace $1/$2/mel
    cp $1/template/net/Ace.ace $1/$2/net
    cp $1/template/parse/Ace.ace $1/$2/parse
    cp $1/template/vision/Ace.ace $1/$2/vision
}

if [ $# = 2 ]; then
	create_one_platform $1 $2
	exit 0
elif [ $# != 1 ]; then
        echo "Usage: $0 spec_directory or"
        echo "Usage: $0 spec_directory platform"
        exit 1
fi



create_one_platform $1 "linux"
create_one_platform $1 "hp9000"
create_one_platform $1 "sgi"
create_one_platform $1 "solaris"
create_one_platform $1 "sparc"
create_one_platform $1 "unixware"




    
