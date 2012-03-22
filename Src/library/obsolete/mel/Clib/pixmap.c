/* mel/Clib/pixmap.c */
/* $Id$ */

#include "mel.h"

#ifdef EIF_VMS
#include <unistd.h>
#endif

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

#ifdef EIF_VMS
	/* workaround bug in VMS implementation of XReadBitmapFile - it may not work with VMS filespecs */
	if (pixmap_status == BitmapOpenFailed && !access(filename, R_OK)) {
	    char unix_filename[FILENAME_MAX +1];
	    const char* tmp = decc$translate_vms (filename);
	    int err = (int)tmp;
	    if (err != 0 && err != -1) {	/* if filename translated to unix successfully */
		strcpy (unix_filename, tmp);	/* save the translated filename */
		if ( strcmp (filename, unix_filename) )
		    /* this call should match the one above, except for the unix_filename argument */
		    pixmap_status = XReadBitmapFile (DisplayOfScreen((Screen *) a_screen), 
				    RootWindowOfScreen ((Screen *) a_screen),
				    unix_filename, &pixmap_width, &pixmap_height, 
				    &bitmap, &pixmap_x_hot,
				    &pixmap_y_hot);
	    }
	}
#endif /* EIF_VMS */

	*a_status = (EIF_INTEGER) pixmap_status;
	if (pixmap_status != BitmapSuccess) 
		return (EIF_POINTER) NULL;

	*a_width = (EIF_INTEGER) pixmap_width;
	*a_height = (EIF_INTEGER) pixmap_height;
	*x1 = (EIF_INTEGER) pixmap_x_hot;
	*y1 = (EIF_INTEGER) pixmap_y_hot;
	return (EIF_POINTER) bitmap;

}
