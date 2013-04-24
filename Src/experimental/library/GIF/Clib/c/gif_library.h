#ifndef _gif_library_h_
#define _gif_library_h_

#define c_get_width(_ptr_) ((EIF_INTEGER) ((gdImagePtr)_ptr_)->sx)
#define c_get_height(_ptr_) ((EIF_INTEGER) ((gdImagePtr)_ptr_)->sy)
#define c_point_get_y(_ptr_) ((EIF_INTEGER) ((gdPointPtr)_ptr_)->y)
#define c_point_get_x(_ptr_) ((EIF_INTEGER) ((gdPointPtr)_ptr_)->x)
#define c_get_colors_total(_ptr_) ((EIF_INTEGER) ((gdImagePtr)_ptr_)->colorsTotal)
#define c_point_set_y(_ptr_,_i_) ((((gdPointPtr)_ptr_)->y)=(int)_i_)
#define c_point_set_x(_ptr_,_i_) ((((gdPointPtr)_ptr_)->x)=(int)_i_)

#include "eif_eiffel.h"

extern EIF_POINTER c_large_font ();
extern EIF_POINTER c_small_font ();
extern EIF_POINTER c_medium_bold_font ();
extern EIF_POINTER c_giant_font ();
extern EIF_POINTER c_tiny_font ();

#endif /* _gif_library_h_ */

#include <gd.h>
