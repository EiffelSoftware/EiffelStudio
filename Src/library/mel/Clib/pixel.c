/*
 *
 * MEL C functions to retrieve pixels.
 *
 * Constants are defined in pixel.h
 *
 */

#include "mel.h"
#include "pixel.h"

EIF_INTEGER get_color_by_name (a_name, screen_ptr, error_ptr)
char *a_name;
Screen *screen_ptr;
EIF_INTEGER *error_ptr;
{
	/*
	 * This function tries to allocate a pixel according to a name.
	 */

	XColor exact_def;
	Colormap default_cmap;

	int screen_num;
	int i;

	/*
	 * Retrieve the number of the screen according to its address.
	 */

	i = 0;
	while ( (ScreenOfDisplay (DisplayOfScreen (screen_ptr), i) != screen_ptr)
		  &&
			(i < ScreenCount (DisplayOfScreen (screen_ptr)))
		  )
		i++;

	if (i == ScreenCount (DisplayOfScreen (screen_ptr)))
	{
		*error_ptr = BAD_SCREEN_REFERENCE;
		return 0;
	}
	else
		screen_num = i;

	/*
	 * Retrieve the colormap of the screen.
	 */

	default_cmap = DefaultColormapOfScreen (screen_ptr);

	/*
	 * Parse the color name.
	 */

	if (!XParseColor (DisplayOfScreen (screen_ptr), default_cmap, a_name, &exact_def))
	{
		*error_ptr = BAD_COLOR_NAME;
		return 0;
	}

	/*
	 * Allocate the color.
	 */

	if (!XAllocColor (DisplayOfScreen (screen_ptr), default_cmap, &exact_def))
	{
		*error_ptr = NO_FREE_CELL_AVAILABLE;
		return 0;
	}
	else
		return exact_def.pixel;
}

EIF_INTEGER get_color_by_rgb_value (red, green, blue, screen_ptr, error_ptr)
EIF_INTEGER red, green, blue;
Screen *screen_ptr;
EIF_INTEGER *error_ptr;
{
	/*
	 * This function tries to allocate a pixel according to a rgb value.
	 */

	XColor exact_def;
	Colormap default_cmap;

	int screen_num;
	int i;

	/*
	 * Retrieve the number of the screen according to its address.
	 */

	i = 0;
	while ( (ScreenOfDisplay (DisplayOfScreen (screen_ptr), i) != screen_ptr)
		  &&
			(i < ScreenCount (DisplayOfScreen (screen_ptr)))
		  )
		i++;

	if (i == ScreenCount (DisplayOfScreen (screen_ptr)))
	{
		*error_ptr = BAD_SCREEN_REFERENCE;
		return 0;
	}
	else
		screen_num = i;

	/*
	 * Retrieve the colormap of the screen.
	 */

	default_cmap = DefaultColormapOfScreen (screen_ptr);

	/*
	 * Set the values of the wished color.
	 */

	exact_def.red = (unsigned short) red;
	exact_def.green = (unsigned short) green;
	exact_def.blue = (unsigned short) blue;

	/*
	 * Allocate the color.
	 */

	if (!XAllocColor (DisplayOfScreen (screen_ptr), default_cmap, &exact_def))
	{
		*error_ptr = NO_FREE_CELL_AVAILABLE;
		return 0;
	}
	else
		return exact_def.pixel;
}

EIF_INTEGER red_component (pixel, screen_ptr)
Pixel pixel;
Screen *screen_ptr;
{
	/*
	 * This functions returns the red component of a pixel.
	 */

	Colormap default_cmap;
	XColor colorcell_def;

	/*
	 * Retrieve the colormap of the screen.
	 */

	default_cmap = DefaultColormapOfScreen (screen_ptr);

	/*
	 * Set the pixel value of the XColor.
	 */

	colorcell_def.pixel = pixel;

	/*
	 * Retrieve the XColor structure from the server.
	 */

	XQueryColors (DisplayOfScreen (screen_ptr), default_cmap, &colorcell_def, 1);

	return (EIF_INTEGER) colorcell_def.red;
}

EIF_INTEGER green_component (pixel, screen_ptr)
Pixel pixel;
Screen *screen_ptr;
{
	/*
	 * This functions returns the green component of a pixel.
	 */

	Colormap default_cmap;
	XColor colorcell_def;

	/*
	 * Retrieve the colormap of the screen.
	 */

	default_cmap = DefaultColormapOfScreen (screen_ptr);

	/*
	 * Set the pixel value of the XColor.
	 */

	colorcell_def.pixel = pixel;

	/*
	 * Retrieve the XColor structure from the server.
	 */

	XQueryColors (DisplayOfScreen (screen_ptr), default_cmap, &colorcell_def, 1);

	return (EIF_INTEGER) colorcell_def.green;
}

EIF_INTEGER blue_component (pixel, screen_ptr)
Pixel pixel;
Screen *screen_ptr;
{
	/*
	 * This functions returns the blue component of a pixel.
	 */

	Colormap default_cmap;
	XColor colorcell_def;

	/*
	 * Retrieve the colormap of the screen.
	 */

	default_cmap = DefaultColormapOfScreen (screen_ptr);

	/*
	 * Set the pixel value of the XColor.
	 */

	colorcell_def.pixel = pixel;

	/*
	 * Retrieve the XColor structure from the server.
	 */

	XQueryColors (DisplayOfScreen (screen_ptr), default_cmap, &colorcell_def, 1);

	return (EIF_INTEGER) colorcell_def.blue;
}
