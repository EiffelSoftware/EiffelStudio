#include "mel.h"

EIF_POINTER x_read_bitmap_from_file (EIF_POINTER a_screen, char *filename, 
	EIF_INTEGER *a_status, EIF_INTEGER *a_width, EIF_INTEGER *a_height, 
	EIF_INTEGER *x1, EIF_INTEGER *y1)
{
	/*
	 * Read the bitmap from `file_name'
	 */
	Pixmap bitmap;
	int pixmap_status;
	unsigned int pixmap_width, pixmap_height;
	int pixmap_x_hot, pixmap_y_hot;


	pixmap_status = XReadBitmapFile (DisplayOfScreen((Screen *) a_screen), 
			RootWindowOfScreen ((Screen *) a_screen),
			filename, &pixmap_width, &pixmap_height, 
			&bitmap, &pixmap_x_hot,
			&pixmap_y_hot);

	*a_status = (EIF_INTEGER) pixmap_status;

	if (pixmap_status != BitmapSuccess) 
		return (EIF_POINTER) NULL;

	*a_width = (EIF_INTEGER) pixmap_width;
	*a_height = (EIF_INTEGER) pixmap_height;
	*x1 = (EIF_INTEGER) pixmap_x_hot;
	*y1 = (EIF_INTEGER) pixmap_y_hot;
	return (EIF_POINTER) bitmap;
			
}
