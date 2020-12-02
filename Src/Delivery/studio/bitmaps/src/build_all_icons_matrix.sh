#!/bin/bash

./build_overlays.sh

./build_icons.sh
cd icons
../build_svg_matrix.sh . ./icons.svg
../build_svg_matrix.sh . ./icons_16x16.svg
../build_svg_matrix.sh . ./icons_20x20.svg
../build_svg_matrix.sh . ./icons_24x24.svg
../build_svg_matrix.sh . ./icons_32x32.svg
cd ..

./build_small_icons.sh
cd small
../build_svg_matrix.sh . ./small_icons.svg
../build_svg_matrix.sh . ./small_12x12.svg
../build_svg_matrix.sh . ./small_15x15.svg
../build_svg_matrix.sh . ./small_18x18.svg
../build_svg_matrix.sh . ./small_24x24.svg
cd ..

./build_mini_icons.sh
cd mini
../build_svg_matrix.sh . ./mini_icons.svg
../build_svg_matrix.sh . ./mini_10x10.svg
../build_svg_matrix.sh . ./mini_12x12.svg
../build_svg_matrix.sh . ./mini_15x15.svg
../build_svg_matrix.sh . ./mini_20x20.svg
cd ..

if [ -x "$(command -v "inkscape")" ]; then
	echo Completed using inkscape
else
	#./inc/matrix_from_subpixmaps.sh icons icons/16x16.png
	./inc/matrix_from_subpixmaps.sh icons icons/-icons_16x16.png
	./inc/matrix_from_subpixmaps.sh icons icons/-icons_20x20.png
	./inc/matrix_from_subpixmaps.sh icons icons/-icons_24x24.png
	./inc/matrix_from_subpixmaps.sh icons icons/-icons_32x32.png

	#./inc/matrix_from_subpixmaps.sh small small/12x12.png
	./inc/matrix_from_subpixmaps.sh small small/-small_12x12.png
	./inc/matrix_from_subpixmaps.sh small small/-small_15x15.png
	./inc/matrix_from_subpixmaps.sh small small/-small_18x18.png
	./inc/matrix_from_subpixmaps.sh small small/-small_24x24.png

	#./inc/matrix_from_subpixmaps.sh mini mini/10x10.png
	./inc/matrix_from_subpixmaps.sh mini mini/-mini_10x10.png
	./inc/matrix_from_subpixmaps.sh mini mini/-mini_12x12.png
	./inc/matrix_from_subpixmaps.sh mini mini/-mini_15x15.png
	./inc/matrix_from_subpixmaps.sh mini mini/-mini_20x20.png

fi
