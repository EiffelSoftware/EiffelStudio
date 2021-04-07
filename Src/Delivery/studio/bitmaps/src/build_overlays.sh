#!/bin/bash

. ./inc/svgbuilder.sh


if [ ! -e res/overlay ]
then
	mkdir res/overlay
fi

SVGoverlays() {
	if [ "$#" == "1" ]
	then
		#echo nb_args=$#
		l_name=$1
		l_opt=
	else
		l_name=$1
		l_opt=$2
	fi
	SVGclean res/${l_name}.svg
	SVGoverlay sw ${l_opt} res/${l_name}.svg res/overlay/${l_name}_sw.svg
	SVGoverlay se ${l_opt} res/${l_name}.svg res/overlay/${l_name}_se.svg
	SVGoverlay ne ${l_opt} res/${l_name}.svg res/overlay/${l_name}_ne.svg
	SVGoverlay nw ${l_opt} res/${l_name}.svg res/overlay/${l_name}_nw.svg
	SVGoverlay w  ${l_opt} res/${l_name}.svg res/overlay/${l_name}_w.svg
	SVGoverlay e  ${l_opt} res/${l_name}.svg res/overlay/${l_name}_e.svg
	SVGoverlay n  ${l_opt} res/${l_name}.svg res/overlay/${l_name}_n.svg
	SVGoverlay s  ${l_opt} res/${l_name}.svg res/overlay/${l_name}_s.svg
	SVGoverlay c  ${l_opt} res/${l_name}.svg res/overlay/${l_name}_c.svg
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
SVGoverlays once  .4

SVGclean res/attribute.svg
SVGoverlay e .45 res/attribute.svg res/overlay/attribute_e.svg

SVGclean res/feature.svg
SVGoverlay e .60 res/feature.svg res/overlay/feature_e.svg

SVGclean res/arrow_green_right.svg
SVGoverlay s .60 res/arrow_green_right.svg res/overlay/arrow_green_right_s.svg

SVGclean res/arrow_green_left.svg
SVGoverlay s .60 res/arrow_green_left.svg res/overlay/arrow_green_left_s.svg

SVGclean res/pen.svg
SVGoverlay e .85 res/pen.svg res/overlay/pen_e.svg

SVGclean res/seal_contract.svg
SVGoverlay w .65 res/seal_contract.svg res/overlay/seal_contract_w.svg

SVGclean res/close.svg
SVGoverlay ne res/close.svg res/overlay/close_ne.svg

SVGclean res/green_mark.svg
SVGoverlay s res/green_mark.svg res/overlay/green_mark_s.svg
SVGoverlay n res/green_mark.svg res/overlay/green_mark_n.svg
SVGoverlay c res/green_mark.svg res/overlay/green_mark_c.svg

SVGclean res/red_cross.svg
SVGoverlay n res/red_cross.svg res/overlay/red_cross_n.svg
SVGoverlay c res/red_cross.svg res/overlay/red_cross_c.svg


