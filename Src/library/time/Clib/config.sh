#!/bin/sh
#
# Configuration time: Wed Feb 4 19:33:48 PST 1998
# Configured by: manuelt
# Target system: sunos 5.4  


############
# BINARIES #
############

sh='sh'
cc='cc'
cpp='/usr/ccs/lib/cpp'
ar='/usr/ccs/bin/ar'
ld='ld'
mv='/usr/5bin/mv'
rm='/usr/5bin/rm'
spitshell='cat'
ranlib=':'
rmdir=':'
mkdep=':'
eunicefix=':'


##############################
# STANDARD COMPILATION FLAGS #
##############################

ccflags=''
cppflags=''
ldflags=''
libs='-lsocket -lnsl -lm'

	#OPTIMIZATION FLAG 

optimize='-O'

	#SPECIAL FLAGS FOR MT-MODE

mtccflags='-D_REENTRANT -DEIF_THREADS -DSOLARIS_THREADS'
mtlibs='-lsocket -lnsl -lm -lthread'
mtldflags=''
mtcppflags=''

###############
# OTHER FLAGS #           
###############

prefix='lib'
mt_prefix='mt'
concurrent_prefix='c'
eiflib='finalized'
wkeiflib='wkbench'
suffix='.a'

large=''
CONFIG=true

###########################################################

