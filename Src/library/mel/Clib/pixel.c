/*
 *
 * MEL C functions to retrieve pixels.
 *
 * Constants are defined in pixel.h
 *
 */

#include "mel.h"
#include "pixel.h"

EIF_INTEGER last_color_alloc_status = 0; /* Global variable */

EIF_POINTER get_color_by_name (char *a_name, EIF_POINTER a_display, 
	EIF_POINTER a_colormap)
{
	/*
	 * This function tries to allocate a pixel according to a name.
	 */

	XColor exact_def;

	last_color_alloc_status = (EIF_INTEGER) 0;

	/*
	 * Parse the color name.
	 */

	if (!XParseColor ((Display *) a_display, 
				(Colormap) a_colormap, a_name, &exact_def))
	{
		last_color_alloc_status = (EIF_INTEGER) BAD_COLOR_NAME;
		return (EIF_POINTER) NULL;
	}

	/*
	 * Allocate the color.
	 */

	if (!XAllocColor ((Display *) a_display, 
				(Colormap) a_colormap, &exact_def))
	{
		last_color_alloc_status = (EIF_INTEGER) NO_FREE_CELL_AVAILABLE;
		return (EIF_POINTER) NULL;
	}
	else
		return (EIF_POINTER) exact_def.pixel;
}

EIF_POINTER get_color_by_rgb_value (EIF_INTEGER red, EIF_INTEGER green, 
	EIF_INTEGER blue, EIF_POINTER a_display, EIF_POINTER a_colormap)
{
	/*
	 * This function tries to allocate a pixel according to a rgb value.
	 */

	XColor exact_def;

	last_color_alloc_status = (EIF_INTEGER) 0;

	/*
	 * Set the values of the wished color.
	 */

	exact_def.red = (unsigned short) red;
	exact_def.green = (unsigned short) green;
	exact_def.blue = (unsigned short) blue;

	/*
	 * Allocate the color.
	 */

	if (!XAllocColor ((Display *) a_display, 	
				(Colormap) a_colormap, &exact_def))
	{
		last_color_alloc_status = (EIF_INTEGER) NO_FREE_CELL_AVAILABLE;
		return (EIF_POINTER) NULL;
	}
	else
		return (EIF_POINTER) exact_def.pixel;
}

EIF_INTEGER red_component (EIF_POINTER pixel, EIF_POINTER a_display,
	EIF_POINTER a_colormap)
{
	/*
	 * This functions returns the red component of a pixel.
	 */

	XColor colorcell_def;

	/*
	 * Set the pixel value of the XColor.
	 */

	colorcell_def.pixel = (Pixel) pixel;

	/*
	 * Retrieve the XColor structure from the server.
	 */

	XQueryColors ((Display *) a_display, 
			(Colormap) a_colormap, &colorcell_def, 1);

	return (EIF_INTEGER) colorcell_def.red;
}

EIF_INTEGER green_component (EIF_POINTER pixel, EIF_POINTER a_display,
	EIF_POINTER a_colormap)
{
	/*
	 * This functions returns the green component of a pixel.
	 */

	XColor colorcell_def;

	/*
	 * Set the pixel value of the XColor.
	 */

	colorcell_def.pixel = (Pixel) pixel;

	/*
	 * Retrieve the XColor structure from the server.
	 */

	XQueryColors ((Display *) a_display, 
			(Colormap) a_colormap, &colorcell_def, 1);

	return (EIF_INTEGER) colorcell_def.green;
}

EIF_INTEGER blue_component (EIF_POINTER pixel, EIF_POINTER a_display,
	EIF_POINTER a_colormap)
{
	/*
	 * This functions returns the blue component of a pixel.
	 */

	XColor colorcell_def;

	/*
	 * Set the pixel value of the XColor.
	 */

	colorcell_def.pixel = (Pixel) pixel;

	/*
	 * Retrieve the XColor structure from the server.
	 */

	XQueryColors ((Display *) a_display, 
			(Colormap) a_colormap, &colorcell_def, 1);

	return (EIF_INTEGER) colorcell_def.blue;
}

void x_free_color (EIF_POINTER display, EIF_POINTER colormap, EIF_POINTER num)
{
	XFreeColors ((Display *) display, (Colormap) colormap, (unsigned long *) &num, 1, 0);
}

EIF_POINTER x_create_pixmap_cursor (EIF_POINTER display, EIF_POINTER a_pixmap,
	EIF_POINTER a_mask, EIF_INTEGER fg_red, EIF_INTEGER fg_green, 
	EIF_INTEGER fg_blue, EIF_INTEGER bg_red, EIF_INTEGER bg_green, 
	EIF_INTEGER bg_blue, EIF_INTEGER x_hot, EIF_INTEGER y_hot)
{
	
	XColor fg, bg;

    bg.red = bg_red;
	bg.green = bg_green;
	bg.blue = bg_blue; 
    fg.red = fg_red;
	fg.green = fg_green;
	fg.blue = fg_blue; 

	return (EIF_POINTER) XCreatePixmapCursor ((Display *) display,
				(Pixmap) a_pixmap, (Pixmap) a_mask, &fg, &bg,
				x_hot, y_hot);

}
