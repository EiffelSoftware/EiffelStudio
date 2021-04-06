#!/bin/bash

# Usage:
#
# build_svg_matrix.sh rootdir src.svg tgt.png
#
# it will build a 32x32.svg icons matrix from 16x16/*/*.svg 
# and also render as 32x32.png with a 1pixel matrix border!
#
#
# build_svg_matrix.sh 16x16 icons.svg
#
# it will build a generic icons.svg icons matrix from 16x16/*/*.svg 
# and WITHOUT any matrix border!

# Settings
background="transparent"
#background="rgb(0,255,0)"

background_png="transparent"
#comment following line, to have transparent background, instead of green background, for remaining PNG icons!
#background_png="#0f0"

# Arguments
rootdir=$1
svg_target=$2
if [ -z "$svg_target" ]
then
	svg_target=$1.svg
fi

png_target=$3

if [[ $( basename $svg_target | cut -d'.' -f 1 | cut -d'_' -f 2 ) =~ ^[0-9][0-9]*x[0-9][0-9]*$ ]]
then
	w=$( basename -- $svg_target | cut -d '_' -f 2 | cut -d'x' -f 1)
	h=$( basename -- $svg_target | cut -d'x' -f 2 | cut -d'.' -f1 | cut -d'_' -f 1)
	svg_width=$w
	svg_height=$h
	matrix_pixel_border=1
else
	w=0
	h=0
	svg_width=100
	svg_height=100
	matrix_pixel_border=0
fi

if [ -z "$4" ] 
then
	cols=0
	rows=0
else
	cols=$( echo $4 | cut -d'x' -f 1)
	rows=$( echo $4 | cut -d'x' -f 2)
fi

# Main

wsep=$matrix_pixel_border
hsep=$matrix_pixel_border

echo from directory $rootdir to $svg_target
mkdir -p $rootdir
if [ -e ${svg_target} ] 
then
	rm ${svg_target}
fi

if [ "$(( $cols + $rows ))" -eq "0" ]
then
	echo Compute rows and cols
	for d in $rootdir/*
	do
		dn=$(basename -- $d)
		if [[ $dn =~ ^[0-9][0-9]*$ ]]
		then 
			if (( $dn > $rows ))
			then
				rows=$dn
			fi
			#for f in $rootdir/$dn/*.*
			for f in `ls $rootdir/$dn/*.* | sort -V -r`
			do
				fn=$(basename -- $f)
				# Sort by natural reverse order
				if [[ $fn =~ ^[0-9][0-9]*.(png|svg)$ ]]
				then
					nb=$(echo $fn | cut -d'.' -f 1)
					if (( $nb > $cols ))
					then
						cols=$nb
					else
						break
					fi
				fi
			done
		fi
	done
fi
echo cols=$cols
echo rows=$rows

svg_page_width=$(( $cols * $svg_width + $cols * $wsep + $wsep ))
svg_page_height=$(( $rows * $svg_height + $rows * $hsep + $hsep ))

echo $svg_target > ${svg_target}.txt
echo rows=$rows cols=$cols >> ${svg_target}.txt
echo svg_page_size=$svg_page_width x $svg_page_height >> ${svg_target}.txt


function svg_to_png { # icons.svg icons.png width height
	echo " - SVG to ${2}"
	if [ -x "$(command -v "inkscape")" ]; then
		#Try with inkscape:
		echo inkscape --export-background-opacity=0 -w ${3} -h ${4}  $1 --export-filename $2
		inkscape --export-background-opacity=0 -w ${3} -h ${4}  $1 --export-filename $2 > /dev/null 2>&1
	else
		#convert -resize ${3}x${4} +antialias -background $background $1 $2
		echo "   > convert -resize ${3}x${4} -background $background $1 $2 "
		convert -resize ${3}x${4} -background $background $1 $2 
	fi
}

echo "<svg height=\"$svg_page_height\" viewBox=\"0 0 $svg_page_width $svg_page_height\" width=\"$svg_page_width\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\">"  > $svg_target

r=1
y=-$svg_height
while ((r<=$rows))
do
	y=$(( $y + $hsep+$svg_height ))
	x=-$svg_width
	d=$rootdir/$r
	echo Row $r
	c=1
	while ((c<=$cols))
	do
		x=$(( $x + $wsep + $svg_width ))
		if [ -e $d/$c.svg ] 
		then
			echo "<image x=\"$x\" y=\"$y\" width=\"$svg_width\" height=\"$svg_height\" xlink:href=\"./$r/$c.svg\" fill=\"transparent\" style=\"fill:none\" />" >> $svg_target
		else
			if [ -e $d/$c.png ]
			then
				if [ ! -z "$background_png" ]
				then
					if [ "$background_png" == "transparent" ]; then
						echo "<rect x=\"$x\" y=\"$y\" width=\"$svg_width\" height=\"$svg_height\" fill=\"transparent\" style=\"fill:none\" />" >> $svg_target
					else
						echo "<rect x=\"$x\" y=\"$y\" width=\"$svg_width\" height=\"$svg_height\" fill=\"$background_png\" />" >> $svg_target
					fi
				fi
				echo "<image x=\"$x\" y=\"$y\" width=\"$svg_width\" height=\"$svg_height\" xlink:href=\"./$r/$c.png\" fill=\"transparent\" style=\"fill:none\" />" >> $svg_target
			fi
		fi

		let c++
	done
	let r++
done

echo '</svg>' >> $svg_target


if [ -z "$png_target" ]
then
	png_target=$(basename $svg_target | cut -d'.' -f 1)
	png_target=$(dirname $svg_target)/${png_target}.png
fi

echo "from SVG $svg_target to $png_target"


if [ "$(( $w + $h ))" -eq "0" ]
then
	echo $svg_target is a generic SVG file, without any border!
else
	echo $svg_target is a specific SVG file to ${w}x${h} resolution, with a 1px border!

	abs_svg_target=$(cd "$(dirname "$svg_target")"; pwd)/$(basename "$svg_target")
	abs_png_target=$(cd "$(dirname "$png_target")"; pwd)/$(basename "$png_target")

	pushd $(dirname $abs_svg_target)
	svg_to_png $(basename $abs_svg_target) ${abs_png_target} $svg_page_width $svg_page_height
	popd
fi

# tgt=$(basename $abs_png_target | cut -d'.' -f 1)
# tgt=$(dirname $abs_png_target)/${tgt}_
# res=8
# svg_to_png $svg_target ${tgt}${res}x${res}.png $(( $cols * $res )) $(( $rows * $res ))
# 
# res=16
# svg_to_png $svg_target ${tgt}${res}x${res}.png $(( $cols * $res )) $(( $rows * $res ))
# 
# res=20
# svg_to_png $svg_target ${tgt}${res}x${res}.png $(( $cols * $res )) $(( $rows * $res ))
# 
# res=32
# svg_to_png $svg_target ${tgt}${res}x${res}.png $(( $cols * $res )) $(( $rows * $res ))
# 
# res=64
# svg_to_png $svg_target ${tgt}${res}x${res}.png $(( $cols * $res )) $(( $rows * $res ))
# 
# res=128
# svg_to_png $svg_target ${tgt}${res}x${res}.png $(( $cols * $res )) $(( $rows * $res ))
# 
