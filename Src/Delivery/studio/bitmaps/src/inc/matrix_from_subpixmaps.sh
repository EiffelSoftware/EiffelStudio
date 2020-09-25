#!/bin/bash

# Usage:
#
# matrix_from_subpixmaps.sh 16x16 32x32.png
#
# it will build an icons matrix of 32x32 into 32x32.png

# requirement:
# - convert, identify from https://imagemagick.org/
#
# notes:
# - for now, using imagemagick convert to generate PNG from SVG
#   but inkscape may produce nicer png.

rootdir=$1
#w=$( basename -- $rootdir | cut -d'x' -f 1)
#h=$( basename -- $rootdir | cut -d'x' -f 2)

target=$2
if [ -z "$target" ]
then
	target=$1.png
fi
w=$( basename -- $target | cut -d'x' -f 1 | cut -d'_' -f 2)
h=$( basename -- $target | cut -d'_' -f 2 | cut -d'x' -f 2 | cut -d'.' -f1 )

wsep=1
hsep=1
color="rgb(217,217,217)"
color="transparent"

tmpdir=/tmp/${w}x${h}
if [ ! -e $tmpdir ]
then
	mkdir -p $tmpdir
fi

echo from $rootdir to $target
mkdir -p $rootdir
if [ -e ${target} ] 
then
	rm ${target}
fi

echo Compute rows and cols
cols=0
rows=0
for d in $rootdir/*
do
	dn=$(basename -- $d)
	if [[ $dn =~ ^[0-9][0-9]*$ ]]
	then 
		if (( $dn > $rows ))
		then
			rows=$dn
		fi
		for f in `ls $rootdir/$dn/*.* | sort -V -r`
		do
			fn=$(basename -- $f)
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
echo rows=$rows
echo cols=$cols
echo icon size: ${w}x${h}

function svg_to_png {
	echo " - SVG to ${w}x${h} png"
	convert -resize ${w}x${h} -background transparent $1 $2
	#Try with inkscape:
	#inkscape -z -w $w -h $h $1 --export-png=$2
}

function append_icon {
	echo " - append icon"
	convert +append -gravity East -background transparent -geometry +0+0 $2 $1 $tmpdir/v.png $2
	#echo " - append vertical separator"
	#convert +append -gravity East -background transparent -geometry +0+0 $2 $tmpdir/v.png $2
}

function append_icons_row {
	echo " - append row $1"
	convert -append -gravity SouthWest -background transparent -geometry +0+0 $3 $2 $3
	echo " - crop to remove extra line"
	convert $3 -crop $(( $cols * $w + ($cols + 1) * $wsep ))x$(( $r * $h + $r * $hsep ))+0+0 $3
	echo " - append horizontal line"
	convert -append -gravity SouthWest -background transparent -geometry +0+0 $3 $tmpdir/h_line.png $3

}

convert -size ${w}x${h} xc:transparent -background transparent $tmpdir/empty.png
convert -size ${wsep}x$(( $w + $wsep )) -background transparent xc:$color $tmpdir/v.png
convert -size $(( $cols * ($w + $hsep) + $hsep ))x${hsep} -background transparent xc:$color $tmpdir/h_line.png
cp $tmpdir/h_line.png ${target}

r=1
while ((r<=$rows))
do
	d=$rootdir/$r
	#mkdir -p $d
	if [ -e $tmpdir/row$r.png ] 
	then
		echo Delete ?
		rm $tmpdir/row$r.png
	fi
	if [ ! -e $tmpdir/row$r.png ] 
	then
		echo Row $r
		cp $tmpdir/v.png $tmpdir/row$r.png
		c=1
		while ((c<=$cols))
		do
			icon=$tmpdir/$r-$c.png
			#echo "Append icon at position ${r},${c}"
#			if [ -e $d/$c.png ]
#			then
#				echo "($r,$c) resize to ${w}x${h}"
#				convert -resize ${w}x${h} $d/$c.png $icon
#				#cp $d/$c.png $icon
#				#identify $icon
#			else
#				if [ -e $d/$c.svg ] 
#				then
#					svg_to_png $d/$c.svg $icon
#				else
#					cp $tmpdir/empty.png $icon
#				fi
#			fi

			if [ -e $d/$c.svg ] 
			then
				svg_to_png $d/$c.svg $icon
			else
				if [ -e $d/$c.png ]
				then
					echo "($r,$c) resize to ${w}x${h}"
					convert -resize ${w}x${h} -background transparent $d/$c.png $icon
					#cp $d/$c.png $icon
					#identify $icon
				else
					cp $tmpdir/empty.png $icon
				fi
			fi

			echo "Icon ($r,$c)"
			if [ -e $icon ]
			then
				append_icon $icon $tmpdir/row$r.png
				rm $icon
			else
				echo ERROR: missing icon!
				exit
			fi

			let c++
		done
	fi

	if [ -e $tmpdir/row$r.png ]
	then
		echo "Row#$r append row $r"
		append_icons_row $r $tmpdir/row$r.png $target
		identify ${target}
		#cp ${target} $rootdir/matrix-$r.png
		rm $tmpdir/row$r.png
	fi
	let r++
done
rm $tmpdir/v.png
rm $tmpdir/h_line.png

