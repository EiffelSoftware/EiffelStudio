#!/bin/bash

# Usage:
#
# build_svg_matrix.sh 16x16 32x32.svg
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
target=$2
if [ -z "$target" ]
then
	target=$1.svg
fi

if [[ $( basename $target | cut -d'.' -f 1 | cut -d'_' -f 2 ) =~ ^[0-9][0-9]*x[0-9][0-9]*$ ]]
then
	w=$( basename -- $target | cut -d '_' -f 2 | cut -d'x' -f 1)
	h=$( basename -- $target | cut -d'x' -f 2 | cut -d'.' -f1 | cut -d'_' -f 1)
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

if [ -z "$3" ] 
then
	cols=0
	rows=0
else
	cols=$( echo $3 | cut -d'x' -f 1)
	rows=$( echo $3 | cut -d'x' -f 2)
fi

# Main

wsep=$matrix_pixel_border
hsep=$matrix_pixel_border

echo from $rootdir to $target
mkdir -p $rootdir
if [ -e ${target} ] 
then
	rm ${target}
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

echo $target > ${target}.txt
echo rows=$rows cols=$cols >> ${target}.txt
echo svg_page_size=$svg_page_width x $svg_page_height >> ${target}.txt


function svg_to_png { # icons.svg icons.png width height
	echo " - SVG to ${2}"
	#convert -resize ${3}x${4} +antialias -background $background $1 $2
	echo "   > convert -resize ${3}x${4} -background $background $1 $2 "
	convert -resize ${3}x${4} -background $background $1 $2
	#Try with inkscape:
	#inkscape --without-gui --export-background-opacity=0  --export-width=$3 --export-height=$4 $1 --export-png=$2
}

echo "<svg height=\"$svg_page_height\" viewBox=\"0 0 $svg_page_width $svg_page_height\" width=\"$svg_page_width\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\">"  > $target

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
			echo "<image x=\"$x\" y=\"$y\" width=\"$svg_width\" height=\"$svg_height\" xlink:href=\"$d/$c.svg\" />" >> $target
		else
			if [ -e $d/$c.png ]
			then
				if [ ! -z "$background_png" ]
				then
					echo "<rect x=\"$x\" y=\"$y\" width=\"$svg_width\" height=\"$svg_height\" fill=\"$background_png\" />" >> $target
				fi
				echo "<image x=\"$x\" y=\"$y\" width=\"$svg_width\" height=\"$svg_height\" xlink:href=\"$d/$c.png\" />" >> $target
			fi
		fi

		let c++
	done
	let r++
done

echo '</svg>' >> $target

tgt=$(basename $target | cut -d'.' -f 1)
tgt=$(dirname $target)/${tgt}.png

if [ "$(( $w + $h ))" -eq "0" ]
then
	echo $target is a generic SVG file, without any border!
else
	echo $target is a specific SVG file to ${w}x${h} resolution, with a 1px border!
	svg_to_png $target ${tgt} $svg_page_width $svg_page_height
fi

# tgt=$(basename $target | cut -d'.' -f 1)
# tgt=$(dirname $target)/${tgt}_
# res=8
# svg_to_png $target ${tgt}${res}x${res}.png $(( $cols * $res )) $(( $rows * $res ))
# 
# res=16
# svg_to_png $target ${tgt}${res}x${res}.png $(( $cols * $res )) $(( $rows * $res ))
# 
# res=20
# svg_to_png $target ${tgt}${res}x${res}.png $(( $cols * $res )) $(( $rows * $res ))
# 
# res=32
# svg_to_png $target ${tgt}${res}x${res}.png $(( $cols * $res )) $(( $rows * $res ))
# 
# res=64
# svg_to_png $target ${tgt}${res}x${res}.png $(( $cols * $res )) $(( $rows * $res ))
# 
# res=128
# svg_to_png $target ${tgt}${res}x${res}.png $(( $cols * $res )) $(( $rows * $res ))
# 
