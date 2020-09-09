#!/bin/bash

. ./inc/svgbuilder.sh

PIXDIR=small
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
# [bp]
# current line
SVGadd $RES/arrow_yellow.svg 1.svg
# slot
# 2.svg
# enabled
# 3.svg
# disabled
# 4.svg
# slot current line
SVGadd 2.svg 1.svg 5.svg
# enabled current line
SVGadd 3.svg 1.svg 6.svg
# disabled current line
SVGadd 4.svg 1.svg 7.svg
# slot other frame
SVGadd 2.svg $RES/triangle_green.svg 8.svg
# enabled other frame
SVGadd 3.svg $RES/triangle_green.svg 9.svg
# disabled other frame
SVGadd 4.svg $RES/triangle_green.svg 10.svg
# enabled conditional
SVGadd 3.svg $RES/question_mark_yellow.svg 11.svg
# disabled conditional
SVGadd 4.svg $RES/question_mark_yellow.svg 12.svg
ExitRow
