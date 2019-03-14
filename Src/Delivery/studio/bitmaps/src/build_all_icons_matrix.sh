#!/bin/sh

./build_overlays.sh

./build_icons.sh
./build_svg_matrix.sh icons icons/icons.svg
./build_svg_matrix.sh icons icons/icons_16x16.svg
./build_svg_matrix.sh icons icons/icons_20x20.svg
./build_svg_matrix.sh icons icons/icons_24x24.svg
./build_svg_matrix.sh icons icons/icons_32x32.svg

./build_small_icons.sh
./build_svg_matrix.sh small small/small_icons.svg
./build_svg_matrix.sh small small/small_12x12.svg
./build_svg_matrix.sh small small/small_15x15.svg
./build_svg_matrix.sh small small/small_18x18.svg
./build_svg_matrix.sh small small/small_24x24.svg

./build_mini_icons.sh
./build_svg_matrix.sh mini mini/mini_icons.svg
./build_svg_matrix.sh mini mini/mini_10x10.svg
./build_svg_matrix.sh mini mini/mini_12x12.svg
./build_svg_matrix.sh mini mini/mini_15x15.svg
./build_svg_matrix.sh mini mini/mini_20x20.svg


./inc/matrix_from_subpixmaps.sh icons icons/16x16.png
./inc/matrix_from_subpixmaps.sh small small/12x12.png
./inc/matrix_from_subpixmaps.sh mini mini/10x10.png
