#include <gd.h>
#include "gif_library.h"
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

