#include <X11/Intrinsic.h>
#include <Xm/Xm.h>
#include "macros.h"


EIF_POINTER c_efb_get_pixmap (w)
EIF_POINTER w;
{
	int n;
	Arg wargs[10];
	Pixmap pix;

	n = 0;
	XtSetArg (wargs[n], XmNlabelPixmap, &pix); n++;
	XtGetValues ((Widget) w, wargs, n);
	return ((EIF_POINTER) pix);
}

EIF_POINTER c_efb_get_icon_pixmap (w)
EIF_POINTER w;
{
	int n;
	Arg wargs[10];
	Pixmap pix;

	n = 0;
	XtSetArg (wargs[n], XmNiconPixmap, &pix); n++;
	XtGetValues ((Widget) w, wargs, n);
	return ((EIF_POINTER) pix);
}

EIF_POINTER c_efb_get_font_list (w)
EIF_POINTER w;
{
	int n;
	Arg wargs[10];
	XmFontList  fontlist;

	n = 0;
	XtSetArg (wargs[n], XmNfontList, &fontlist); n++;
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
	XtSetArg (wargs[n], XmNlabelPixmap, (Pixmap) pix); n++;
	XtSetValues ((Widget) w, wargs, n);
}

void c_efb_set_icon_pixmap (w, pix)
EIF_POINTER w;
EIF_POINTER pix;
{
	int n;
	Arg wargs[10];

	n = 0;
	XtSetArg (wargs[n], XmNiconPixmap, (Pixmap) pix); n++;
	XtSetValues ((Widget) w, wargs, n);
}

void c_efb_set_font_list (w, f)
EIF_POINTER w;
EIF_POINTER f;
{
	int n;
	Arg wargs[10];

	n = 0;
	XtSetArg (wargs[n], XmNfontList, (XmFontList) f); n++;
	XtSetValues ((Widget) w, wargs, n);
}
