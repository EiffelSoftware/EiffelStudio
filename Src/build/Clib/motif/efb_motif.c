#include <X11/Intrinsic.h>
#include <Xm/Xm.h>
#include <macros.h>


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

/*
 * Text character position within a scrolled text area
 */
EIF_INTEGER x_pos (widget, cursor_position, text_x, text_y)
Widget widget;
int text_x, text_y;
XmTextPosition cursor_position;
{
    Position x0, y0;

    XmTextPosToXY (widget, cursor_position, &x0, &y0);
    return (EIF_INTEGER) x0 + text_x;
}

EIF_INTEGER y_pos (widget, cursor_position, text_x, text_y)
Widget widget;
Position text_x, text_y;
XmTextPosition cursor_position;
{
    Position x0, y0;

    XmTextPosToXY (widget, cursor_position, &x0, &y0);
    return (EIF_INTEGER) y0 + text_y;
}

EIF_INTEGER cur_pos (widget, cursor_x, cursor_y)
Widget widget;
Position cursor_x, cursor_y;
{
    return (EIF_INTEGER) XmTextXYToPos (widget, cursor_x, cursor_y);
}


