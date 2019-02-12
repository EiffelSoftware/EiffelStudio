#!/bin/bash

# Usage:
#
# matrix_to_subpixmaps.sh ../png/16x16.png
#
# it will extract icons into 16x16 folder.

# requirement:
# - convert, identify from https://imagemagick.org/

src=$1

w=$( basename -- $src | cut -d'x' -f 1)
h=$( basename -- $src | cut -d'x' -f 2 | cut -d'.' -f 1)

echo w=$w h=$h

#w=16
#h=16
#src=${w}x${h}.png
#cols=33
#rows=25

rootdir=$2
if [ -z "$rootdir" ];
then
	rootdir=${w}x${h}
fi

# Save separators...
mkdir -p $rootdir/res
convert $src -crop $(( ${w} + 1 ))x1+0+0 $rootdir/res/h.png
convert $src -crop 1x$(( ${h} + 1 ))+0+0 $rootdir/res/v.png

src_width=$(identify -format "%[fx:w]" $src)
src_height=$(identify -format "%[fx:h]" $src)
cols=$(( ($src_width - 1) / ($w + 1) ))
rows=$(( ($src_height - 1) / ($h + 1) ))

echo w=$w h=$h cols=$cols rows=$rows

r=1
while ((r<=$rows))
do
	d=$rootdir/$r
	mkdir -p $d
	c=1
	while ((c<=$cols))
	do
		echo "Extract icon at position ${r},${c}"
		x=$(( 1 * $c + $c * $w - $w ))
		y=$(( 1 * $r + $r * $h - $h ))
		convert $src -crop ${w}x${h}+$x+$y $d/$c.png
		ii=$( identify -format "[%k]" $d/$c.png )
		if [ "$ii" == "[1]" ]
       	then
			#if [ ! -e $rootdir/empty.png ]
			#then
				#echo Empty image!
				#cp $d/$c.png $rootdir/res/empty.png
			#fi
			rm $d/$c.png
		fi
		let c++
	done
	let r++
done
