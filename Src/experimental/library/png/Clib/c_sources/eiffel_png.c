#include <gd.h>
#include "eiffel_png.h"
#include <gdfontl.h>
#include <gdfonts.h>
#include <gdfontt.h>
#include <gdfontmb.h>
#include <gdfontg.h>

rt_public EIF_POINTER c_large_font ();
rt_public EIF_POINTER c_small_font ();
rt_public EIF_POINTER c_tiny_font ();
rt_public EIF_POINTER c_medium_bold_font ();
rt_public EIF_POINTER c_giant_font ();

rt_public EIF_POINTER c_large_font () {
	return (EIF_POINTER) gdFontLarge;
}
rt_public EIF_POINTER c_small_font () {
	return (EIF_POINTER) gdFontSmall;
}
rt_public EIF_POINTER c_tiny_font () {
	return (EIF_POINTER)  gdFontTiny;
}
rt_public EIF_POINTER c_medium_bold_font () {
	return (EIF_POINTER) gdFontMediumBold;
}
rt_public EIF_POINTER c_giant_font () {
	return (EIF_POINTER) gdFontGiant;
}
rt_public EIF_INTEGER c_get_red (gdImagePtr img,int _i_) {
	return (EIF_INTEGER) gdImageRed(img,_i_);
}
rt_public EIF_INTEGER c_get_blue (gdImagePtr img,int _i_) {
	return (EIF_INTEGER) gdImageBlue(img,_i_);
}
rt_public EIF_INTEGER c_get_green (gdImagePtr img,int _i_) {
	return (EIF_INTEGER) gdImageGreen(img,_i_);
}

