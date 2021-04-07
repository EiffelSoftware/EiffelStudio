#!/bin/bash

. ./inc/svgbuilder.sh


if [ ! -e res/overlay ]
then
	mkdir res/overlay
fi

SVGoverlays() {
	if [ "$#" == "1" ]
	then
		echo nb_args=$#
		l_name=$1
		l_opt=
	else
		l_name=$1
		l_opt=$2
	fi
	rm res/overlay/${l_name}_sw.svg
	rm res/overlay/${l_name}_se.svg
	rm res/overlay/${l_name}_ne.svg
	rm res/overlay/${l_name}_nw.svg
	rm res/overlay/${l_name}_w.svg
	rm res/overlay/${l_name}_e.svg
}

SVGoverlays class
SVGoverlays editor
SVGoverlays error
SVGoverlays packaged
SVGoverlays library
SVGoverlays folder
SVGoverlays folders
SVGoverlays target
SVGoverlays search
SVGoverlays refresh
SVGoverlays lock
SVGoverlays override
SVGoverlays overridden
SVGoverlays info
SVGoverlays warning
SVGoverlays new
SVGoverlays verify
SVGoverlays flag
SVGoverlays microscope
SVGoverlays water_drop
SVGoverlays flash
SVGoverlays eiffelstudio .7
SVGoverlays feature

rm res/overlay/attribute_e.svg

rm res/overlay/feature_e.svg

rm res/overlay/arrow_green_right_s.svg

rm res/overlay/arrow_green_left_s.svg

rm res/overlay/pen_e.svg

rm res/overlay/seal_contract_w.svg

rm res/overlay/close_ne.svg

rm res/overlay/green_mark_s.svg


