#!/bin/bash

. ./inc/svgbuilder.sh


if [ ! -e res ]
then
	mkdir res
fi

SVGrotate 90 res/arrow_green_right.svg res/arrow_green_down.svg
SVGrotate 90 res/arrow_green_left.svg res/arrow_green_up.svg
