#!/bin/sh

./build_overlays.sh

./build_icons.sh
./build_svg_matrix.sh icons icons/icons_16x16.svg
./build_svg_matrix.sh icons icons/icons_20x20.svg


