#!/bin/bash

svgbin=`pwd`

echo svgbin=$svgbin
SVGclean()
{
	if [ -e $svgbin/svgcleaner ]
	then
		$svgbin/svgcleaner --quiet --copy-on-error $1 $1
	fi
}
SVGcli()
{
	echo $*
	python $svgbin/svg_cli.py $*
	l_out=${@: -1} 
	#l_out=${!#}
	SVGclean $l_out
}
SVGadd() 
{ 
	SVGcli add $* 
}
SVGfilter() 
{
	SVGcli filter $1 $2 $3
}
SVGgrey() 
{
	SVGfilter grey $1 $2
}
SVGlight() 
{
	SVGfilter light $1 $2
}
SVGfrozen() 
{ 
	SVGfilter frozen $1 $2
}
SVGoverlay() 
{ 
	SVGcli overlay $*
}
SVGrotate() 
{ 
	SVGcli rotate $*
}
