#!/bin/sh

./build_overlays.sh

./build_icons.sh
./build_svg_matrix.sh icons icons/icons_16x16.svg

./build_small_icons.sh
./build_svg_matrix.sh small small/small_12x12.svg

./build_mini_icons.sh
./build_svg_matrix.sh mini mini/mini_10x10.svg

