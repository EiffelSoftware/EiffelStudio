#!/bin/sh

./build_overlays.sh

./build_icons.sh
./build_svg_matrix.sh icons icons/icons_16x16.svg

./build_small_icons.sh
./build_svg_matrix.sh small small/small_12x12.svg

./build_mini_icons.sh
./build_svg_matrix.sh mini mini/mini_10x10.svg

if [ -x "$(command -v "inkscape")" ]; then
	echo Completed using inkscape
else
	#./inc/matrix_from_subpixmaps.sh icons icons/16x16.png
	./inc/matrix_from_subpixmaps.sh icons icons/icons_16x16.png
	./inc/matrix_from_subpixmaps.sh small small/small_12x12.png
	./inc/matrix_from_subpixmaps.sh mini mini/mini_10x10.png
fi

