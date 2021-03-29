#!/bin/sh

./build_overlays.sh

./build_icons.sh

cd icons
../build_svg_matrix.sh . ./icons.svg
../build_svg_matrix.sh . ./icons_16x16.svg
../build_svg_matrix.sh . ./icons_20x20.svg
../build_svg_matrix.sh . ./icons_24x24.svg
../build_svg_matrix.sh . ./icons_32x32.svg
cd ..


#./inc/matrix_from_subpixmaps.sh icons icons/16x16.png
./inc/matrix_from_subpixmaps.sh icons icons/icons_16x16.png
./inc/matrix_from_subpixmaps.sh icons icons/icons_20x20.png
./inc/matrix_from_subpixmaps.sh icons icons/icons_24x24.png
./inc/matrix_from_subpixmaps.sh icons icons/icons_32x32.png


