#include <X11/Intrinsic.h>
#include <Xol/OpenLook.h>
#include "macros.h"

EIF_POINTER c_efb_get_pixmap (w)
EIF_POINTER w;
{
	int n;
	Arg wargs[10];
	XImage *pix;

	n = 0;
	XtSetArg (wargs[n], XtNlabelImage, &pix); n++;
	XtGetValues ((Widget) w, wargs, n);
	return ((EIF_POINTER) pix);
}

EIF_POINTER c_efb_get_font_list (w)
EIF_POINTER w;
{
	int n;
	Arg wargs[10];
	XFontStruct *fontlist;

	n = 0;
	XtSetArg (wargs[n], XtNfont, &fontlist); n++;
	XtGetValues ((Widget) w, wargs, n);
	return ((EIF_POINTER) fontlist);
}

void c_efb_set_pixmap (w, pix)
EIF_POINTER w;
EIF_POINTER pix;
{
	int n;
	Arg wargs[10];

	n = 0;
	XtSetArg (wargs[n], XtNlabelImage, (XImage *) pix); n++;
	XtSetValues ((Widget) w, wargs, n);
}

void c_efb_set_font_list (w, f)
EIF_POINTER w;
EIF_POINTER f;
{
	int n;
	Arg wargs[10];

	n = 0;
	XtSetArg (wargs[n], XtNfont, (XFontStruct *) f); n++;
	XtSetValues ((Widget) w, wargs, n);
}
