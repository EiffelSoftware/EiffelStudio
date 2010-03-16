#include "mel.h"

void x_set_cap_style (EIF_POINTER display_pointer, EIF_POINTER graphic_context,
	EIF_INTEGER style)
{
	unsigned long value_mask = GCCapStyle;
	XGCValues values;

	values.cap_style = (int) style;
	XChangeGC ((Display *) display_pointer, (GC) graphic_context,
				value_mask, &values);
}

void x_set_line_width (EIF_POINTER display_pointer, EIF_POINTER graphic_context,
	EIF_INTEGER width)
{
	unsigned long value_mask = GCLineWidth;
	XGCValues values;

	values.line_width = (int) width;
	XChangeGC ((Display *) display_pointer, (GC) graphic_context,
				value_mask, &values);
}

void x_set_line_style (EIF_POINTER display_pointer, EIF_POINTER graphic_context,
	EIF_INTEGER style)
{
	unsigned long value_mask = GCLineStyle;
	XGCValues values;

	values.line_style = (int) style;
	XChangeGC ((Display *) display_pointer, (GC) graphic_context,
				value_mask, &values);
}

void x_set_join_style (EIF_POINTER display_pointer, EIF_POINTER graphic_context,
	EIF_INTEGER style)
{
	unsigned long value_mask = GCJoinStyle;
	XGCValues values;

	values.join_style = (int) style;
	XChangeGC ((Display *) display_pointer, (GC) graphic_context,
			value_mask, &values);
}

void x_set_clip_rectangles (EIF_POINTER display_pointer, EIF_POINTER graphic_context,
	EIF_INTEGER x, EIF_INTEGER y, EIF_INTEGER width, EIF_INTEGER height)
{
	XRectangle rectangle;

	rectangle.x = (short) x;
	rectangle.y = (short) y;
	rectangle.width = (unsigned short) width;
	rectangle.height = (unsigned short) height;
	XSetClipRectangles ((Display *) display_pointer, (GC) graphic_context,
		0, 0, &rectangle, 1, Unsorted);
}
