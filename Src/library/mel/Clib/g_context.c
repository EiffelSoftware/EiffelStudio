#include "mel.h"

void x_set_cap_style (display_pointer, graphic_context, style)
EIF_POINTER display_pointer;
EIF_POINTER graphic_context;
EIF_INTEGER style;
{
	unsigned long value_mask = GCCapStyle;
	XGCValues values;

	values.cap_style = (int) style;
	XChangeGC ((Display *) display_pointer, (GC) graphic_context,
				value_mask, &values);
}

void x_set_line_width (display_pointer, graphic_context, width)
EIF_POINTER display_pointer;
EIF_POINTER graphic_context;
EIF_INTEGER width;
{
	unsigned long value_mask = GCLineWidth;
	XGCValues values;

	values.line_width = (int) width;
	XChangeGC ((Display *) display_pointer, (GC) graphic_context,
				value_mask, &values);
}

void x_set_line_style (display_pointer, graphic_context, style)
EIF_POINTER display_pointer;
EIF_POINTER graphic_context;
EIF_INTEGER style;
{
	unsigned long value_mask = GCLineStyle;
	XGCValues values;

	values.line_style = (int) style;
	XChangeGC ((Display *) display_pointer, (GC) graphic_context,
				value_mask, &values);
}

void x_set_join_style (display_pointer, graphic_context, style)
EIF_POINTER display_pointer;
EIF_POINTER graphic_context;
EIF_INTEGER style;
{
	unsigned long value_mask = GCJoinStyle;
	XGCValues values;

	values.join_style = (int) style;
	XChangeGC ((Display *) display_pointer, (GC) graphic_context,
			value_mask, &values);
}

void x_set_clip_rectangles (display_pointer, graphic_context, x, y, width,
height)
EIF_POINTER display_pointer;
EIF_POINTER graphic_context;
EIF_INTEGER x, y;
EIF_INTEGER width, height;
{
	XRectangle rectangle;

	rectangle.x = (short) x;
	rectangle.y = (short) y;
	rectangle.width = (unsigned short) width;
	rectangle.height = (unsigned short) height;
	XSetClipRectangles ((Display *) display_pointer, (GC) graphic_context,
		0, 0, &rectangle, 1, Unsorted);
}
