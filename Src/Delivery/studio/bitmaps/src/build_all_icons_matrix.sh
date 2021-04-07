#!/bin/bash

./build_overlays.sh

./build_icons.sh
cd icons
../build_svg_matrix.sh . ./icons.svg 
../build_svg_matrix.sh . ./icons_16x16.svg ./icons_16x16.png
../build_svg_matrix.sh . ./icons_20x20.svg ./icons_20x20.png
../build_svg_matrix.sh . ./icons_24x24.svg ./icons_24x24.png
../build_svg_matrix.sh . ./icons_32x32.svg ./icons_32x32.png
cd ..
./inc/legacy_png_matrix_from_subpixmaps.sh icons icons/16x16.png
eiffel tools/build_html_index.ecf ../png/icons.ini icons icons.html --svg
eiffel tools/build_html_index.ecf ../png/icons.ini icons icons-png.html --png

./build_small_icons.sh
cd small
../build_svg_matrix.sh . ./small_icons.svg
../build_svg_matrix.sh . ./small_12x12.svg ./small_12x12.png
../build_svg_matrix.sh . ./small_15x15.svg ./small_15x15.png
../build_svg_matrix.sh . ./small_18x18.svg ./small_18x18.png
../build_svg_matrix.sh . ./small_24x24.svg ./small_24x24.png
cd ..
./inc/legacy_png_matrix_from_subpixmaps.sh small small/12x12.png
eiffel tools/build_html_index.ecf ../png/small.ini small small.html --svg
eiffel tools/build_html_index.ecf ../png/small.ini small small-png.html --png


./build_mini_icons.sh
cd mini
../build_svg_matrix.sh . ./mini_icons.svg
../build_svg_matrix.sh . ./mini_10x10.svg ./mini_10x10.png
../build_svg_matrix.sh . ./mini_12x12.svg ./mini_12x12.png
../build_svg_matrix.sh . ./mini_15x15.svg ./mini_15x15.png
../build_svg_matrix.sh . ./mini_20x20.svg ./mini_20x20.png
cd ..
./inc/legacy_png_matrix_from_subpixmaps.sh mini mini/10x10.png
eiffel tools/build_html_index.ecf ../png/mini.ini mini mini.html --svg
eiffel tools/build_html_index.ecf ../png/mini.ini mini mini-png.html --png

if [ -x "$(command -v "inkscape")" ]; then
	echo Completed using inkscape
else
	#./inc/matrix_from_subpixmaps.sh icons icons/16x16.png
	./inc/matrix_from_subpixmaps.sh icons icons/icons_16x16.png
	./inc/matrix_from_subpixmaps.sh icons icons/icons_20x20.png
	./inc/matrix_from_subpixmaps.sh icons icons/icons_24x24.png
	./inc/matrix_from_subpixmaps.sh icons icons/icons_32x32.png

	#./inc/matrix_from_subpixmaps.sh small small/12x12.png
	./inc/matrix_from_subpixmaps.sh small small/small_12x12.png
	./inc/matrix_from_subpixmaps.sh small small/small_15x15.png
	./inc/matrix_from_subpixmaps.sh small small/small_18x18.png
	./inc/matrix_from_subpixmaps.sh small small/small_24x24.png

	#./inc/matrix_from_subpixmaps.sh mini mini/10x10.png
	./inc/matrix_from_subpixmaps.sh mini mini/mini_10x10.png
	./inc/matrix_from_subpixmaps.sh mini mini/mini_12x12.png
	./inc/matrix_from_subpixmaps.sh mini mini/mini_15x15.png
	./inc/matrix_from_subpixmaps.sh mini mini/mini_20x20.png

fi
