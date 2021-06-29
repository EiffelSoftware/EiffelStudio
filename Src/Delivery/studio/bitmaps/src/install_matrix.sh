#!/bin/sh

case "$1" in
	src)
		PNG_DIR=$EIFFEL_SRC/Delivery/studio/bitmaps/png
		;;
	wb)
		PNG_DIR=$(ISE_EIFFEL)_workbench/studio/bitmaps/png
		;;
	*)
		PNG_DIR=$ISE_EIFFEL/studio/bitmaps/png
		;;
esac

echo PNG_DIR=$PNG_DIR

if [ -f "icons/16x16.png" ]; then
	cp icons/16x16.png $PNG_DIR/16x16.png
else
	cp icons/icons_16x16.png $PNG_DIR/16x16.png
fi
cp icons/icons_16x16.png $PNG_DIR/icons_16x16.png
cp icons/icons_20x20.png $PNG_DIR/icons_20x20.png
cp icons/icons_24x24.png $PNG_DIR/icons_24x24.png
cp icons/icons_32x32.png $PNG_DIR/icons_32x32.png


if [ -f "small/12x12.png" ]; then
	cp small/12x12.png $PNG_DIR/12x12.png
else
	cp small/small_12x12.png $PNG_DIR/12x12.png
fi
cp small/small_12x12.png $PNG_DIR/small_12x12.png
cp small/small_15x15.png $PNG_DIR/small_15x15.png
cp small/small_18x18.png $PNG_DIR/small_18x18.png
cp small/small_24x24.png $PNG_DIR/small_24x24.png


if [ -f "mini/10x10.png" ]; then
	cp mini/10x10.png $PNG_DIR/10x10.png
else
	cp small/mini_10x10.png $PNG_DIR/10x10.png
fi
cp mini/mini_10x10.png $PNG_DIR/mini_10x10.png
cp mini/mini_12x12.png $PNG_DIR/mini_12x12.png
cp mini/mini_15x15.png $PNG_DIR/mini_15x15.png
cp mini/mini_20x20.png $PNG_DIR/mini_20x20.png
