#!/bin/bash

. ./inc/svgbuilder.sh

PIXDIR=mini
RES=../../res
OVERLAY=$RES/overlay

EnterRow() {
	mkdir -p $PIXDIR/$1 > /dev/null
	pushd $PIXDIR/$1 > /dev/null
	echo Process $PIXDIR/$1
}
ExitRow() {
	popd > /dev/null
}

EnterRow 1
# ;
# ; General
# ;
# 
# [toolbar]
# close
# - 1.svg
# minimize
# - 2.svg
# maximize
# - 3.svg
# restore
# - 4.svg
# pinned
SVGadd $RES/pinned.svg 5.svg
# unpinned
SVGadd $RES/unpinned.svg 6.svg
# expand
# - 7.svg
# dropdown
# - 8.svg
# 
# [@sort]
# accending
# - 9.svg
# descending
# - 10.svg
# group
# - 11.svg
# 
ExitRow
EnterRow 2
# [general]
# blank
SVGadd $RES/_empty.svg 1.svg
# save
SVGadd $RES/floppy.svg 2.svg
# add
SVGadd $RES/3dots.svg 3.svg
# edit
SVGadd $RES/pen.svg 4.svg
# delete
SVGadd $RES/red_cross.svg 5.svg
# copy
SVGadd $RES/clipboard.svg 6.svg
# search
SVGadd $RES/search.svg 7.svg
# previous
SVGadd $RES/nav_previous.svg 8.svg
# next
SVGadd $RES/nav_next.svg 9.svg
# up
SVGadd $RES/nav_up.svg 10.svg
# down
SVGadd $RES/nav_down.svg 11.svg
# toogle
SVGadd $RES/toggle.svg 12.svg
# 
ExitRow
EnterRow 3
# [debugger]
# callstack depth
# - 1.svg
# error
SVGadd $RES/error.svg 2.svg
# expand info
SVGadd $RES/chat_balloon.svg 3.svg
# set sizes
# - 4.svg
# show hex value
# - 5.svg
# 
# [@breakpoints]
# enable
SVGadd $RES/green_mark.svg 6.svg
# disable
# - 7.svg
# 
# [@viewer]
# wrap
# expand
# lock
SVGadd $RES/lock.svg 10.svg
# formatting
# - 11.svg
# 
# [@watch]
# auto
SVGadd $RES/star.svg 12.svg
# 
ExitRow
EnterRow 4
# [@callstack]
# send to external editor
# is melted
# has rescue
# is non object call
SVGadd $RES/class.svg 4.svg
# 
# [@execution]
# record
# replay
# object storage
# 
# [@hidden]
# show in callstack
# hide in callstack
# 
# [@reserved]
# reserved 1
# reserved 2
# 
# [@evaluation]
# refresh
SVGadd $RES/refresh.svg 11.svg
# 
ExitRow
EnterRow 5
# [new]
# feature
SVGadd $RES/feature.svg $OVERLAY/new_nw.svg 1.svg
# class
SVGadd $RES/class.svg $OVERLAY/new_nw.svg 2.svg
# cluster
SVGadd $RES/folder.svg $OVERLAY/new_nw.svg 3.svg
# expression
# library
SVGadd $RES/library.svg $OVERLAY/new_nw.svg 5.svg
# assembly
# watch tool
# window
# tool edition
# 
ExitRow
EnterRow 6
# [completion]
# remember size
SVGadd ../3/4.svg 1.svg
# filter
# show disambiguants
# show signature
# show alias
# show return type
# show assigner
# show obsolete
# show target class
SVGadd $RES/class.svg 9.svg
# 
ExitRow
EnterRow 7
# [bon]
# persistent
# interfaces
# effective
# deferred
ExitRow
