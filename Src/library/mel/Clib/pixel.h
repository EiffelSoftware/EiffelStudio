#include "xpm.h"

/*
 * Constants used to code errors when allocating colors.
 */

#define BAD_SCREEN_REFERENCE	-1
#define BAD_COLOR_NAME			-2
#define NO_FREE_CELL_AVAILABLE  -3

/*
 * Variable used to store error status
 */

extern EIF_INTEGER last_color_alloc_status;

/*
 * Macros to access/set values in XpmAttributes structures.
 */
#define set_xpm_attributes_valuemask(_ptr_, _valuemask_) \
		(((XpmAttributes *)_ptr_)->valuemask = _valuemask_)

#define xpm_attributes_value_mask(_ptr_) (_ptr_)->valuemask
#define xpm_attributes_height(_ptr_) (_ptr_)->height
#define xpm_attributes_width(_ptr_) (_ptr_)->width
#define xpm_attributes_x_hotspot(_ptr_) (_ptr_)->x_hotspot
#define xpm_attributes_y_hotspot(_ptr_) (_ptr_)->y_hotspot
#define xpm_attributes_colormap(_ptr_) (_ptr_)->colormap
#define xpm_attributes_ncolors(_ptr_) (_ptr_)->ncolors

